package com.suteam.html.wechatpay.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.HttpUtil2;
import com.suteam.html.common.util.PropertiesUtil;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.wechatpay.config.WeiChatConfig;
import com.suteam.html.wechatpay.utils.CommonUtil;
import com.suteam.html.wechatpay.utils.GetWxOrderno;
import com.suteam.html.wechatpay.utils.RequestHandler;
import com.suteam.html.wechatpay.utils.Sha1Util;
import com.suteam.html.wechatpay.utils.TenpayUtil;
import com.suteam.html.wechatpay.utils.WeNotifyVerify;
import com.suteam.html.wechatpay.utils.XmlParseUtil;

/**
 * 微信
 * 
 * @author qi
 *
 */
@Controller
public class WeiChatAction {
	private Logger log = Logger.getLogger(this.getClass());

	/**
	 * 获取微信扫码支付二维码连接
	 * 
	 * @author qi
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/v1/pay/wechatPay/query/getCodeUrl")
	@ResponseBody
	public String getCodeUrl(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {

			Properties properties = PropertiesUtil.getUtilProperty("aliwxpay.properties");

			// 参数
			// 获取shopAdmin域名
			String domainName = request.getParameter("domainName");
			// 总金额以分为单位，不带小数点
			String totalFee2 = request.getParameter("totalFee");
			//将实付金额去除"，"
			String totalFee1 = totalFee2.replace(",", "");
			if (totalFee1 == null || "".equals(totalFee1)) {
				totalFee1 = "0";
			}
			int totalFee = (int) ((Double.parseDouble(totalFee1)) * 100);
			// 订单号
			// 商户订单号
			String out_trade_no = request.getParameter("out_trade_no");

			// 附加数据 原样返回 存储shopAdmin的域名
			String attach = domainName;

			// 订单生成的机器 IP
			String spbill_create_ip = properties.getProperty("weichat_create_ip");
			// 这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
			String notify_url = request.getScheme()+"://"+request.getServerName()+request.getContextPath();
			notify_url = notify_url + "/v1/pay/weChatPay/query/weChatNotifyUrl.do";
			// 原生扫码支付
			String trade_type = "NATIVE";
			// 商户号
			String mch_id = WeiChatConfig.partner;
			// 随机字符串
			String nonce_str = TenpayUtil.getNonceStr();
			// 商品描述根据情况修改
			String body = "商品服务";

			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", WeiChatConfig.appid);
			packageParams.put("mch_id", mch_id);
			packageParams.put("nonce_str", nonce_str);
			packageParams.put("body", body);
			packageParams.put("attach", attach);
			packageParams.put("out_trade_no", out_trade_no);

			// 这里写的金额为1 分到时修改
			packageParams.put("total_fee", String.valueOf(totalFee));
			packageParams.put("spbill_create_ip", spbill_create_ip);
			packageParams.put("notify_url", notify_url);

			packageParams.put("trade_type", trade_type);
			RequestHandler reqHandler = new RequestHandler(null, null);
			reqHandler.init(WeiChatConfig.appid, WeiChatConfig.appsecret, WeiChatConfig.partnerkey);
			String sign = reqHandler.createSign(packageParams);
			String xml = "<xml>" + "<appid>" + WeiChatConfig.appid + "</appid>" + "<mch_id>" + mch_id + "</mch_id>"
					+ "<nonce_str>" + nonce_str + "</nonce_str>" + "<sign>" + sign + "</sign>" + "<body><![CDATA["
					+ body + "]]></body>" + "<out_trade_no>" + out_trade_no + "</out_trade_no>" + "<attach>" + attach
					+ "</attach>" + "<total_fee>" + totalFee + "</total_fee>" + "<spbill_create_ip>" + spbill_create_ip
					+ "</spbill_create_ip>" + "<notify_url>" + notify_url + "</notify_url>" + "<trade_type>"
					+ trade_type + "</trade_type>" + "</xml>";
			String code_url = "";
			String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			code_url = new GetWxOrderno().getCodeUrl(createOrderURL, xml);
			log.info("获取微信扫码支付二维码连接code_url----------------" + code_url);
			map.put("result", "ok");
			map.put("values", code_url);
			map.put("out_trade_no", out_trade_no);
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			log.error("微信支付获取二维码发生错误");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 微信支付回调函数
	 * 
	 * @author qi
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/v1/pay/weChatPay/query/weChatNotifyUrl")
	public synchronized void notifyByWechat(HttpServletRequest request, HttpServletResponse response) {
		try {
			Properties properties = PropertiesUtil.getUtilProperty("aliwxpay.properties");
			System.out.print("微信支付回调数据开始");
			// 示例报文
			// String notityXml =
			// "<xml><appid><![CDATA[wx1010dd18bc702a7b]]></appid><attach><![CDATA[b88001]]></attach><bank_type><![CDATA[ICBC_DEBIT]]></bank_type><cash_fee><![CDATA[1]]></cash_fee><fee_type><![CDATA[CNY]]></fee_type><is_subscribe><![CDATA[N]]></is_subscribe><mch_id><![CDATA[1266038501]]></mch_id><nonce_str><![CDATA[0920472092]]></nonce_str><openid><![CDATA[o-sqAuKIVbl8M5A_zbZVrPHXiFt8]]></openid><out_trade_no><![CDATA[wx1469150446477]]></out_trade_no><result_code><![CDATA[SUCCESS]]></result_code><return_code><![CDATA[SUCCESS]]></return_code><sign><![CDATA[D98CB7B92318FF49D7D5A5424865389D]]></sign><time_end><![CDATA[20160722092103]]></time_end><total_fee>1</total_fee><trade_type><![CDATA[JSAPI]]></trade_type><transaction_id><![CDATA[4003792001201607229500310463]]></transaction_id></xml>";

			log.info("进入微信支付回调函数");
			String inputLine;
			String notityXml = "";
			String resXml = "";
			try {
				while ((inputLine = request.getReader().readLine()) != null) {
					notityXml += inputLine;
				}
				request.getReader().close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			log.info("接收到的报文：" + notityXml);

			Map m = XmlParseUtil.parseXmlToList2(notityXml);
			// 获取到shopAdmin域名
			String shopAdmin = (String) m.get("attach");
			String url = properties.getProperty("w_shopAdmin_notify_url");
			url = shopAdmin + url;
			boolean isVerify = WeNotifyVerify.verifyApi(m);

			log.info("处理业务");
			// 安全校验
			if (!isVerify) {
				resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
						+ "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
				log.error("微信支付回调数据失败结束");
				response.getWriter().write(resXml);
			}
			double total_fee = Double.parseDouble(String.valueOf(m.get("total_fee")));

			Map<String, String> mapXml = new HashMap<>();
			mapXml.put("notityXml", notityXml);
			// 调用shopAdmin中微信后台回调接口
			String str = HttpUtil2.doPost(url, mapXml);
			if (str == null) {
				log.error("未能成功调用shopAdmin微信后台回调");
			}

		} catch (Exception e) {
			log.error("微信支付回调异常");
		}
	}

	/**
	 * 微信扫码支付获取支付状态
	 * 
	 * @author qi
	 */
	@RequestMapping(value = "/v1/pay/wechatPay/query/getWechatStatus")
	@ResponseBody
	public String getWechatStatus(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Properties properties = PropertiesUtil.getUtilProperty("aliwxpay.properties");
			String out_trade_no = request.getParameter("out_trade_no");
			String domainName = request.getParameter("domainName");
			if (out_trade_no != null && !"".equals(out_trade_no)) {
				// 调用shopAdmin中查询扫码支付状态的接口
				String wechatStatus = properties.getProperty("w_shopAdmin_status_url");
				String url = domainName + wechatStatus;
				Map<String, String> temp = new HashMap<>();
				temp.put("out_trade_no", out_trade_no);
				String str = HttpUtil2.doPost(url, temp);
				// 获取接口返回结果
				Map<String, String> mapResult3 = (Map<String, String>) JSON.parse(str);
				map.put("values", mapResult3.get("values"));
			}
			map.put("result", "ok");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			log.error("微信扫码支付获取支付状态发生错误");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 获取微信客户端支付预支付报文
	 * 
	 * @author qi
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/v1/pay/weChatPay/getWechatPackage")
	public String getWechatPackage(HttpServletRequest request, HttpServletResponse response) {
		try {
			Properties properties = PropertiesUtil.getUtilProperty("aliwxpay.properties");
			// 参数
			// 获取shopAdmin域名
			String domainName = request.getParameter("domainName");
			// 网页授权后获取传递的参数
			String code = request.getParameter("code");
			if ("".equals(code) || null == code) {
				return null;
			}
			String orderNo = request.getParameter("orderNo");
			log.info("code : " + code);
			// 商户相关资料
			String appid = WeiChatConfig.appid;
			String appsecret = WeiChatConfig.appsecret;
			// 商户号
			String mch_id = WeiChatConfig.partner;
			String partnerkey = WeiChatConfig.partnerkey;
			// 参数
			String openId = "";
			String URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret=" + appsecret
					+ "&code=" + code + "&grant_type=authorization_code";
			JSONObject jsonObject = CommonUtil.httpsRequest(URL, "GET", null);
			log.info("jsonObject : " + jsonObject);
			if (null != jsonObject) {
				openId = jsonObject.getString("openid");
			}
			log.info("openId : " + openId);
			// 总金额以分为单位，不带小数点
			String totalFee1 = request.getParameter("money");
			if (totalFee1 == null || "".equals(totalFee1)) {
				totalFee1 = "0";
			}
			int totalFee = (int) ((Double.parseDouble(totalFee1)) * 100);

			// 订单号
			String orderId = orderNo;
			// 附加数据 原样返回 存储shopAdmin域名
			String attach = domainName;

			// 订单生成的机器 IP
			String spbill_create_ip = properties.getProperty("weichat_create_ip");
			// 这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
			String notify_url = request.getScheme()+"://"+request.getServerName()+request.getContextPath();
			notify_url = notify_url + "/v1/pay/weChatPay/query/weChatNotifyUrl.do";
			String return_url = properties.getProperty("w_shopAdmin_return_url");
			String url = domainName + return_url;
			String trade_type = "JSAPI";
			// 以下为必须参数
			// 随机字符串
			String nonce_str = TenpayUtil.getNonceStr();
			// 商品描述根据情况修改
			String body = "商品服务";
			// 商户订单号
			String out_trade_no = orderId;

			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", appid);
			packageParams.put("mch_id", mch_id);
			packageParams.put("nonce_str", nonce_str);
			packageParams.put("body", body);
			packageParams.put("attach", attach);
			packageParams.put("out_trade_no", out_trade_no);

			// 这里写的金额为1 分到时修改
			packageParams.put("total_fee", String.valueOf(totalFee));
			packageParams.put("spbill_create_ip", spbill_create_ip);
			packageParams.put("notify_url", notify_url);
			packageParams.put("trade_type", trade_type);
			packageParams.put("openid", openId);
			RequestHandler reqHandler = new RequestHandler(null, null);
			reqHandler.init(appid, appsecret, partnerkey);
			String sign = reqHandler.createSign(packageParams);
			String xml = "<xml>" + "<appid>" + appid + "</appid>" + "<mch_id>" + mch_id + "</mch_id>" + "<nonce_str>"
					+ nonce_str + "</nonce_str>" + "<sign>" + sign + "</sign>" + "<body><![CDATA[" + body + "]]></body>"
					+ "<out_trade_no>" + out_trade_no + "</out_trade_no>" + "<attach>" + attach + "</attach>"
					+ "<total_fee>" + totalFee + "</total_fee>" + "<spbill_create_ip>" + spbill_create_ip
					+ "</spbill_create_ip>" + "<notify_url>" + notify_url + "</notify_url>" + "<trade_type>"
					+ trade_type + "</trade_type>" + "<openid>" + openId + "</openid>" + "</xml>";
			log.info("获取到xml：  " + xml);
			String prepay_id = "";
			String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
			prepay_id = new GetWxOrderno().getPayNo(createOrderURL, xml);
			log.info("获取到的预支付ID： : " + prepay_id);
			// 获取prepay_id后，拼接最后请求支付所需要的package
			SortedMap<String, String> finalpackage = new TreeMap<String, String>();
			String appid2 = appid;
			String timestamp = Sha1Util.getTimeStamp();

			String nonceStr2 = nonce_str;
			String prepay_id2 = "prepay_id=" + prepay_id;
			String packages = prepay_id2;
			finalpackage.put("appId", appid2);
			finalpackage.put("timeStamp", timestamp);
			finalpackage.put("nonceStr", nonceStr2);
			finalpackage.put("package", packages);
			finalpackage.put("signType", "MD5");
			String finalsign = reqHandler.createSign(finalpackage);
			log.info("appid=" + appid2 + "&timeStamp=" + timestamp + "&nonceStr=" + nonceStr2 + "&package=" + packages
					+ "&sign=" + finalsign);
			request.setAttribute("appid", appid2);
			request.setAttribute("timeStamp", timestamp);
			request.setAttribute("nonceStr", nonceStr2);
			request.setAttribute("packageValue", packages);
			request.setAttribute("sign", finalsign);
			request.setAttribute("platform", "1");
			request.setAttribute("payType", "2");
			request.setAttribute("out_trade_no", out_trade_no);
			request.setAttribute("totalFee", totalFee1);
			request.setAttribute("url", url);
		} catch (Exception e) {
			log.error("获取微信客户端与支付报文发生错误");
		}
		return "order/pay_wechat";
	}

	/**
	 * 微信公众号网页授权获取用户信息
	 * 
	 * @author qi
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/v1/pay/wechatPay/query/goWechatAuthorize")
	public void goWechatAuthorize(HttpServletRequest request, HttpServletResponse response) {
		try {
			Properties properties = PropertiesUtil.getUtilProperty("aliwxpay.properties");
			// 获取shopAdmin域名
			String domainName = request.getParameter("domainName");
			String totalFee1 = request.getParameter("money");
			
			if (totalFee1 == null || "".equals(totalFee1)) {
				totalFee1 = "0";
			}
			// 共账号及商户相关参数
			String appid = WeiChatConfig.appid;
			String backUri = request.getScheme()+"://"+request.getServerName()+request.getContextPath();
			backUri = backUri + "/v1/pay/weChatPay/getWechatPackage.do";
			// String
			// backUri="http://192.168.0.28/UCenter/v1/pay/weiChatPay/getWXPackage.do";
			// 授权后要跳转的链接所需的参数一般有会员号，金额，订单号之类，最好自己带上一个加密字符串将金额加上一个自定义的key用MD5签名或者自己写的签名,比如
			// Sign = %3D%2F%CS%
			// String orderNo="wx"+String.valueOf(new Date().getTime());
			String orderNo = request.getParameter("out_trade_no");
			backUri = backUri + "?orderNo=" + orderNo + "&describe=test&money=" + totalFee1 + "&domainName="
					+ domainName;
			// URLEncoder.encode 后可以在backUri 的url里面获取传递的所有参数
			backUri = URLEncoder.encode(backUri);
			// scope 参数视各自需求而定，这里用scope=snsapi_base
			// 不弹出授权页面直接授权目的只获取统一支付接口的openid
			String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + "appid=" + appid + "&redirect_uri="
					+ backUri + "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
			response.sendRedirect(url);
		} catch (Exception e) {
			log.error("微信网页授权发生错误");
		}

	}

}

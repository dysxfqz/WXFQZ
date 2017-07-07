package com.suteam.html.wechatpay.utils;

import java.util.Iterator;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.log4j.Logger;

import com.suteam.html.wechatpay.config.WeiChatConfig;

public class WeNotifyVerify {
	private static Logger log = Logger.getLogger(WeNotifyVerify.class);
	
	 /**
     * 验证消息是否是微信发出的合法消息
	 * @param m 
     * @param params 通知返回来的参数数组
     * @return 验证结果
     */
	public static boolean verifyApi(Map map) {
		try {
			// 商户相关资料
			String appid = WeiChatConfig.appid;
			String appsecret = WeiChatConfig.appsecret;
			// 商户号
			String mch_id = WeiChatConfig.partner;
			String partnerkey = WeiChatConfig.partnerkey;
			//定义签名map
			SortedMap<String, String> signParams = new TreeMap<String, String>();
			//转换参数map 准备签名参数
			Iterator it=map.keySet().iterator();    
			while(it.hasNext()){    
			     String key;    
			     String value;    
			     key=it.next().toString();    
			     value=(String) map.get(key);    
			     signParams.put(key, value);
			}  
			//签名验证
			RequestHandler reqHandler = new RequestHandler(null, null);
			reqHandler.init(appid, appsecret, partnerkey);
			String sign = reqHandler.createSign(signParams);
			String sign2 = (String) map.get("sign");
			//签名验证
			log.info("***微信安全校验****sign = " + sign);
			log.info("***微信安全校验****sign2 = " + sign2);
			if (!sign.equals(sign2)) {
				return false;
			}
			// 随机字符串
			String nonce_str = TenpayUtil.getNonceStr();
			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", appid);
			packageParams.put("mch_id", mch_id);
			packageParams.put("nonce_str", nonce_str);
			packageParams.put("transaction_id", map.get("transaction_id").toString());
			String sign3 = reqHandler.createSign(packageParams);
			String xml = "<xml>" + "<appid>" + appid + "</appid>" + "<mch_id>" + mch_id + "</mch_id>"
					+ "<nonce_str>" + nonce_str + "</nonce_str>" + "<sign>" + sign3 + "</sign>"
					+ "<transaction_id>" + map.get("transaction_id").toString() + "</transaction_id>" + "</xml>";
			String createOrderURL = "https://api.mch.weixin.qq.com/pay/orderquery";
			Map<String, String> map2 = new GetWxOrderno().getPayMap(createOrderURL, xml);
			//查询订单验证
			log.info("***微信安全校验****map result_code" +map.get("result_code"));
			log.info("***微信安全校验****map2  result_code" +map2.get("result_code"));
			if (  !map.get("return_code").equals(map2.get("return_code")) || !map.get("result_code").equals(map2.get("result_code"))  ) {
				return false;
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	
}

package com.suteam.html.common.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.alibaba.fastjson.JSON;
import com.suteam.html.system.service.SystemConfigMgr;

public class HttpAuthUtil {

	private static SystemConfigMgr systemConfigMgr;

	public static String doAuthPost(String url, Map<String, String> map) {
		// 自动授权拼组参数
		Map<String, Object> map0 = new HashMap<String, Object>();
		String charset = HTTP.UTF_8;
		HttpClient httpClient = null;
		HttpPost httpPost = null;
		String result = null;
		try {
			// 调用授权机制
			map0 = autoToAuth();
			map.put("AccessToken", String.valueOf(map0.get("u_AccessToken")));
			map.put("code", String.valueOf(map0.get("u_code")));
			map.put("sign", String.valueOf(map0.get("u_cSign")));
			map.put("RequestTime", String.valueOf(map0.get("u_zsServiceAuthServerTime_2")));
			map.put("serverUserNumber", String.valueOf(map0.get("u_serverUserNumber")));
			httpClient = new SSLClient();
			httpPost = new HttpPost(url);
			// 设置参数
			List<NameValuePair> list = new ArrayList<NameValuePair>();
			Iterator iterator = map.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, String> elem = (Entry<String, String>) iterator.next();
				list.add(new BasicNameValuePair(elem.getKey(), elem.getValue()));
			}
			if (list.size() > 0) {
				UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);
				httpPost.setEntity(entity);
			}
			HttpResponse response = httpClient.execute(httpPost);
			if (response != null) {
				HttpEntity resEntity = response.getEntity();
				if (resEntity != null) {
					result = EntityUtils.toString(resEntity, charset);
				}
			}
		} catch (Exception ex) {
			// ex.printStackTrace();
			return null;
		}
		return result;
	}

	/**
	 * 携带传输流http
	 * 
	 * @param url
	 * @param list
	 * @param text
	 * @return
	 */
	public static String httpAuthReqStream(String url, String text) {
		// 自动授权拼组参数
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map0 = new HashMap<String, Object>();
		HttpClient client = new DefaultHttpClient();
		client.getParams().setParameter(CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
		HttpEntity httpEntity;
		String out = null;
		try {
			// 调用授权机制
			map0 = autoToAuth();
			map.put("AccessToken", String.valueOf(map0.get("u_AccessToken")));
			map.put("code", String.valueOf(map0.get("u_code")));
			map.put("sign", String.valueOf(map0.get("u_cSign")));
			map.put("RequestTime", String.valueOf(map0.get("u_zsServiceAuthServerTime_2")));
			map.put("serverUserNumber", String.valueOf(map0.get("u_serverUserNumber")));
			url = url + "?AccessToken=" + map.get("AccessToken") + "&code=" + map.get("code") + "&sign="
					+ map.get("sign") + "&RequestTime=" + map.get("RequestTime") + "&serverUserNumber="
					+ map.get("serverUserNumber");
			HttpPost httpPost = new HttpPost(url);
			// httpEntity = new UrlEncodedFormEntity(list);
			// httpPost.setEntity(httpEntity);
			// 设置参数
			if (text != null) {
				// String str = new String(text.getBytes("ISO-8859-1"),"utf-8");
				InputStream in = new ByteArrayInputStream(text.getBytes("utf-8"));
				HttpEntity https = new InputStreamEntity(in, text.getBytes("utf-8").length);
				httpPost.setEntity(https);
			}
			HttpResponse httpResponse;
			httpResponse = client.execute(httpPost);
			HttpEntity httpEntitys = httpResponse.getEntity();
			out = EntityUtils.toString(httpEntitys);
		} catch (Exception e) {
			// e.printStackTrace();
			return null;
		}
		return out;
	}

	/**
	 * 自动授权，获取token
	 * 
	 * @return
	 */
	public static Map<String, Object> autoToAuth() {
		// 获取内存
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		Map<String, Object> map = new HashMap<String, Object>();
		// 从内存中读取参数
		String accessToken = (String) servletContext.getAttribute("u_AccessToken");// 令牌
		Long exPeriod = (Long) servletContext.getAttribute("u_LifeTime");// 有效时长
		Long zsServiceAuthServerTime = (Long) servletContext.getAttribute("u_zsServiceAuthServerTime");// 接收时OAuth端时间
		Long RequestAccessTokenTime = (Long) servletContext.getAttribute("u_RequestAccessTokenTime");// 接收到OAuth端时间时本地时间
		String code = (String) servletContext.getAttribute("u_code");// 令牌
		String key = (String) servletContext.getAttribute("u_key");// 令牌
		String serverUserNumber = (String) servletContext.getAttribute("u_serverUserNumber");// 令牌
		// 判断code等系统同参数是否为空
		if (code == null || key == null || serverUserNumber == null) {
			// 调用保存内存方法
			saveToServletContext(servletContext);
			code = (String) servletContext.getAttribute("u_code");// 令牌
			key = (String) servletContext.getAttribute("u_key");// 令牌
			serverUserNumber = (String) servletContext.getAttribute("u_serverUserNumber");// 令牌
		}
		if (accessToken == null || exPeriod == null || zsServiceAuthServerTime == null
				|| RequestAccessTokenTime == null) {
			// 重新获取token
			getAccessToken(code, key, serverUserNumber, 1, servletContext);
			accessToken = (String) servletContext.getAttribute("u_AccessToken");// 令牌
			exPeriod = (Long) servletContext.getAttribute("u_LifeTime");// 有效时长
			zsServiceAuthServerTime = (Long) servletContext.getAttribute("u_zsServiceAuthServerTime");// 接收时OAuth端时间
			RequestAccessTokenTime = (Long) servletContext.getAttribute("u_RequestAccessTokenTime");// 接收到OAuth端时间时本地时间
			// 客户端当前时间
			long CurrentLocalTime = new Date().getTime();
			// OAuth端当前时间
			long zsServiceAuthServerTime2 = (CurrentLocalTime - RequestAccessTokenTime) + zsServiceAuthServerTime;
			// 有效
			String cSign = getAuthSign(zsServiceAuthServerTime2, accessToken);
			map.put("u_AccessToken", accessToken);
			map.put("u_code", code);
			map.put("u_cSign", cSign);
			map.put("u_zsServiceAuthServerTime_2", zsServiceAuthServerTime2);
			map.put("u_serverUserNumber", serverUserNumber);
			return map;
		} else {
			// 内存中存在
			// 验证是否过期
			long CurrentLocalTime = new Date().getTime();// 客户端当前时间
			long zsServiceAuthServerTime2 = (CurrentLocalTime - RequestAccessTokenTime) + zsServiceAuthServerTime;// OAuth端当前时间
			// token剩余的有效时长(类型Long, 单位ms)
			Long timeFlag = exPeriod - (CurrentLocalTime - RequestAccessTokenTime);
			// 判断本地token是否过期
			if (timeFlag > 0) {
				// 有效
				String cSign = getAuthSign(zsServiceAuthServerTime2, accessToken);
				map.put("u_AccessToken", accessToken);
				map.put("u_code", code);
				map.put("u_cSign", cSign);
				map.put("u_zsServiceAuthServerTime_2", zsServiceAuthServerTime2);
				map.put("u_serverUserNumber", serverUserNumber);
				return map;
			} else {
				// 重新获取token
				getAccessToken(code, key, serverUserNumber, 1, servletContext);
				accessToken = (String) servletContext.getAttribute("u_AccessToken");// 令牌
				exPeriod = (Long) servletContext.getAttribute("u_LifeTime");// 有效时长
				zsServiceAuthServerTime = (Long) servletContext.getAttribute("u_zsServiceAuthServerTime");// 接收时OAuth端时间
				RequestAccessTokenTime = (Long) servletContext.getAttribute("u_RequestAccessTokenTime");// 接收到OAuth端时间时本地时间
				// 客户端当前时间
				CurrentLocalTime = new Date().getTime();
				// OAuth端当前时间
				zsServiceAuthServerTime2 = (CurrentLocalTime - RequestAccessTokenTime) + zsServiceAuthServerTime;
				// 有效
				String cSign = getAuthSign(zsServiceAuthServerTime2, accessToken);
				map.put("u_AccessToken", accessToken);
				map.put("u_code", code);
				map.put("u_cSign", cSign);
				map.put("u_zsServiceAuthServerTime_2", zsServiceAuthServerTime2);
				map.put("u_serverUserNumber", serverUserNumber);
				return map;
			}
		}
	}

	/**
	 * 
	 * 获取签名信息
	 * 
	 */
	private static String getAuthSign(long zsServiceAuthServerTime2, String accessToken) {
		String sign1 = zsServiceAuthServerTime2 + accessToken;
		String sign = MD5Util.GetMD5Code(sign1);
		return sign;
	}

	/**
	 * 向OAuth端发送请求
	 * 
	 * @author mzl
	 * @param
	 * @return token
	 */
	public static void getAccessToken(String code, String key, String serverUserNumber, Integer count,
			ServletContext servletContext) {
		// 从数据库里获取auth_server
		String OAuthIp = (String) servletContext.getAttribute("oauthIp");
		// 发送的地址
		String url = OAuthIp + "/v1/token/common/app/getAccessToken.do?count=" + count;
		// post参数
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("code", code);
		map2.put("key", key);
		// 返回验证结果
		String result = HttpUtil2.doPost(url, map2);

		Map<String, Object> mapResult = (Map<String, Object>) JSON.parse(result);
		String string = mapResult.get("values").toString();
		Map<String, Object> mapResult2 = (Map<String, Object>) JSON.parse(string);
		// 将值存入内存中
		servletContext.setAttribute("u_AccessToken", String.valueOf(mapResult2.get("AccessToken")));// 令牌
		servletContext.setAttribute("u_LifeTime", Long.parseLong(mapResult2.get("LifeTime").toString()));// 有效时长
		servletContext.setAttribute("u_zsServiceAuthServerTime",
				Long.parseLong(mapResult2.get("zsServiceAuthServerTime").toString()));// 接收时OAuth端时间
		servletContext.setAttribute("u_RequestAccessTokenTime", new Date().getTime());// 接收到OAuth端时间时本地时间

	}

	/**
	 * 将数据存入内存 mzl
	 */
	private static void saveToServletContext(ServletContext servletContext) {
		// filter中注入service
		XmlWebApplicationContext cxt = (XmlWebApplicationContext) WebApplicationContextUtils
				.getWebApplicationContext(servletContext);
		systemConfigMgr = (SystemConfigMgr) cxt.getBean(SystemConfigMgr.class);
		// 从数据库读取参数
		String code = systemConfigMgr.getValueByName("app_code");
		String key = systemConfigMgr.getValueByName("app_key");
		String serverUserNumber = systemConfigMgr.getValueByName("user_number");
		servletContext.setAttribute("u_code", code);//
		servletContext.setAttribute("u_key", key);//
		servletContext.setAttribute("u_serverUserNumber", serverUserNumber);// 用户号
		servletContext.setAttribute("oauthIp", systemConfigMgr.getValueByName("auth_server"));//授权服务号
	}

}
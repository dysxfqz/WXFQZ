package com.suteam.html.common.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.eclipse.core.runtime.Platform;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.fastjson.JSON;

public class WeChatShareUtil {
	/**
	 * 获取当前时间 yyyyMMddHHmmss
	 * 
	 * @return String
	 */
	public static String getCurrTime() {
		Date now = new Date();
		SimpleDateFormat outFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String s = outFormat.format(now);
		return s;
	}

	/**
	 * 取出一个指定长度大小的随机正整数.
	 * 
	 * @param length
	 *            int 设定所取出随机数的长度。length小于11
	 * @return int 返回生成的随机数。
	 */
	public static int buildRandom(int length) {
		int num = 1;
		double random = Math.random();
		if (random < 0.1) {
			random = random + 0.1;
		}
		for (int i = 0; i < length; i++) {
			num = num * 10;
		}
		return (int) ((random * num));
	}

	public static String getToken(String appid, String secret) {

		NameValuePair param1 = new BasicNameValuePair("grant_type", "client_credential");
		NameValuePair param2 = new BasicNameValuePair("appid", appid);
		NameValuePair param3 = new BasicNameValuePair("secret", secret);
		List list = new ArrayList();
		list.add(param1);
		list.add(param2);
		list.add(param3);
		String str = HttpUtil1.httpRequest("https://api.weixin.qq.com/cgi-bin/token", list);
		Map<String, String> map1 = (Map<String, String>) JSON.parse(str);
		if (map1.get("access_token") != null && !"".equals(map1.get("access_token"))) {
			return map1.get("access_token");
		} else {
			return "获取token失败";
		}

	}

	public static String getTicket(String access_token,String urlMd5) {
		// 获取servletContext
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		NameValuePair param1 = new BasicNameValuePair("access_token", access_token);
		NameValuePair param2 = new BasicNameValuePair("type", "jsapi");
		List list = new ArrayList();
		list.add(param1);
		list.add(param2);
		String str = HttpUtil1.httpRequest("https://api.weixin.qq.com/cgi-bin/ticket/getticket", list);
		Map<String, String> map1 = (Map<String, String>) JSON.parse(str);
		Long TotalTime = new Date().getTime() + 6600 * 1000;
		servletContext.setAttribute(urlMd5, TotalTime + "#" + map1.get("ticket"));
		return map1.get("ticket");
	}
	
	public static String byteToHex(final byte[] hash) {
	        Formatter formatter = new Formatter();
	        for (byte b : hash)
	        {
	            formatter.format("%02x", b);
	        }
	        String result = formatter.toString();
	        formatter.close();
	        return result;
	    }

}

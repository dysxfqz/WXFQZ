package com.suteam.html.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;

/**
 * HttpServletResponse帮助类
 * 
 * @company suteam
 * @author liubin
 * @since Feb 14, 2011
 * @version 1.0
 */
public final class ResponseUtils {
	public static final Logger logger = LoggerFactory.getLogger(ResponseUtils.class);

	/**
	 * 发送文本。使用UTF-8编码。
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param text
	 *            发送的字符串
	 */
	public static void renderText(HttpServletResponse response, String text) {
		render(response, "text/plain;charset=UTF-8", text);
	}

	/**
	 * 发送json。使用UTF-8编码。
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param text
	 *            发送的字符串
	 */
	public static void renderJson(HttpServletResponse response, String text) {
		render(response, "application/json;charset=UTF-8", text);
	}

	/**
	 * 发送json。使用UTF-8编码。 解决文件上传在IE下json保存的问题
	 * 
	 * @author zyz
	 * @param response
	 *            HttpServletResponse
	 * @param text
	 *            发送的字符串
	 */
	public static void renderJsonAjax(HttpServletResponse response, String text) {
		renderAjax(response, "application/json;charset=UTF-8", text);
	}

	/**
	 * 发送json。使用UTF-8编码。
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param text
	 *            发送的字符串
	 */
	public static void renderJsJson(HttpServletResponse response, String text, String callback) {
		if (callback == null || "".equals(callback)) {
			render(response, "application/json;charset=UTF-8", text);
		} else {
			render(response, "application/json;charset=UTF-8", callback + "(" + text + ")");
		}
	}

	/**
	 * 发送xml。使用UTF-8编码。
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @param text
	 *            发送的字符串
	 */
	public static void renderXml(HttpServletResponse response, String text) {
		render(response, "text/xml;charset=UTF-8", text);
	}

	/**
	 * 发送内容。使用UTF-8编码。
	 * 
	 * @param response
	 * @param contentType
	 * @param text
	 */
	public static void render(HttpServletResponse response, String contentType, String text) {
		response.setContentType(contentType);
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		try {
			PrintWriter writer = response.getWriter();
			writer.write(text);
			writer.close();
			
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 发送内容。使用UTF-8编码。 解决文件上传在IE下json保存的问题
	 * 
	 * @author zyz
	 * @param response
	 * @param contentType
	 * @param text
	 */
	public static void renderAjax(HttpServletResponse response, String contentType, String text) {
		// response.setContentType(contentType);
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain");
		response.setDateHeader("Expires", 0);
		try {
			response.getWriter().print(text);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 获取接口返回结果参数值
	 * 
	 * @param response
	 * @return
	 */
	public static String getResult(ServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		PrintWriter pw = null;
		Object result = null;
		try {
			pw = response.getWriter();
			Object ob = ReflectUtil.getFieldValue(pw, "ob");
			result = ReflectUtil.getFieldValue(ob, "cb");
			if (result == null) {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000477.msg);
				map.put("errorcode", EnumErrorCode.CODE_000477.code);
				return JSON.toJSONString(map);
			}
			return result.toString();
		} catch (IOException e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000477.msg);
			map.put("errorcode", EnumErrorCode.CODE_000477.code);
			return JSON.toJSONString(map);
		} finally {
			if (pw != null) {
				pw.close();
				pw.flush();
			}
		}
	}
}

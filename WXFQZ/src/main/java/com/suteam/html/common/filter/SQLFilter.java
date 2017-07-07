package com.suteam.html.common.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.ResponseUtils;

/**
 * SQL注入拦截
 * 
 * @author fqz
 *
 */
public class SQLFilter implements Filter {
	public static Logger log = Logger.getLogger(SQLFilter.class);
	private String inj_str = "'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|; |or|-|+|,";
	private static Pattern SCRIPT_PATTERN = Pattern.compile("<script.*>.*<\\/script\\s*>");
	private static Pattern HTML_PATTERN = Pattern.compile("<[^>]+>");

	public void destroy() {

	}

	/**
	 * 拦截(当url包含.do时,检测链接是否包含anon,不包含则检查内存中是否存在用户)
	 * 
	 * @author zyz
	 */
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = ((HttpServletResponse) response);
		Iterator<String[]> values = req.getParameterMap().values().iterator();// 获取所有的表单参数
		Map<String, Object> mapReturn = new HashMap<String, Object>();
		while (values.hasNext()) {
			String[] value = (String[]) values.next();
			for (int i = 0; i < value.length; i++) {
				if (sql_inj(value[i])) {
					mapReturn.put("result", "error");
					mapReturn.put("values", "");
					mapReturn.put("errormsg", EnumErrorCode.CODE_000476.msg);
					mapReturn.put("errorcode", EnumErrorCode.CODE_000476.code);
					ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
					// 需要向es告警，并记录日志
					return;
				}
				// 过滤html标签
				Matcher mHtml = HTML_PATTERN.matcher(value[i]);
				if (mHtml.find()) {
					mapReturn.put("result", "error");
					mapReturn.put("values", "");
					mapReturn.put("errormsg", EnumErrorCode.CODE_000479.msg);
					mapReturn.put("errorcode", EnumErrorCode.CODE_000479.code);
					ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
					// 需要向es告警，并记录日志
					return;
				}
				// 过滤script脚本
				Matcher m = SCRIPT_PATTERN.matcher(value[i]);
				if (m.find()) {
					mapReturn.put("result", "error");
					mapReturn.put("values", "");
					mapReturn.put("errormsg", EnumErrorCode.CODE_000480.msg);
					mapReturn.put("errorcode", EnumErrorCode.CODE_000480.code);
					ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
					// 需要向es告警，并记录日志
					return;
				}

			}
		}
		chain.doFilter(request, response);
	}

	public boolean sql_inj(String str) {
		String[] inj_stra = inj_str.split("\\|");
		for (int i = 0; i < inj_stra.length; i++) {
			if (str.toLowerCase().indexOf(" " + inj_stra[i] + " ") >= 0) {
				return true;
			}
		}
		return false;
	}

	public void init(FilterConfig arg0) throws ServletException {
	}
}

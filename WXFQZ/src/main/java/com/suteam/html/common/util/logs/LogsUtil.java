package com.suteam.html.common.util.logs;

import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
/**
 * 记录日志工具类
 * @author wjl
 *
 */
public class LogsUtil {

	private static final Logger logger = LoggerFactory.getLogger(LogsUtil.class);
	/**
	 * 封装记录日志
	 * @author wjl
	 * @param request        请求
	 * @param logCode        日志号
	 * @param result   		   结果
	 */
	@SuppressWarnings("unchecked")
	public static Logs recordLog(HttpServletRequest request, Logs logs) {
		//开始访问时间
		String beginTime = DateUtil.formatDatetimes(new Date());
		//获取请求体
		String url = request.getRequestURI();
		//获取请求IP
		String sourceIP = IPUtil.getIpAddr(request);
		//请求来源
		String requstSource = "";
		//定义空字符串，用于拼接所有请求参数
		String param = "";
		//得到参数名称
		Enumeration<String> paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();
			String[] paramValues = request.getParameterValues(paramName);
			if (paramValues.length == 1) {
				String paramValue = paramValues[0];
				if (paramValue.length() != 0) {
					param = param + paramName + "=" + paramValue + ",";
					if (paramName.equals("requstSource")) {
						requstSource = paramValue;
					}
				}
			}
		}
		//去除最后一个参数的','后所得到的字符串
		String paramString = "";
		if (!"".equals(param)) {
			paramString = param.substring(0, param.length() - 1);
		}
		
		//赋值
		logs.setBeginTime(beginTime);
		logs.setRequstBody(url);
		logs.setLogCode(logs.getLogCode());
		logs.setRequstParam(paramString);
		logs.setRequstSource(requstSource);
		logs.setSourceIP(sourceIP);
		
		//记录日志实体类中的部分信息
		logger.info(JSON.toJSONString(logs));
		return logs;
	}
	
	public static void log(Logs logs) {
		if (logs != null) {
			logs.setValues(logs.getValues());
			//结束时间
			String endTime = DateUtil.formatDatetimes(new Date());
			logs.setEndTime(endTime);
		}
		//记录日志实体类中的所有信息
		logger.info(JSON.toJSONString(logs));
	}
}

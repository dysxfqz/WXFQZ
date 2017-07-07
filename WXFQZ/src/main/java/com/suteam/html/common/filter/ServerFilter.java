package com.suteam.html.common.filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.HttpUtil2;
import com.suteam.html.common.util.MD5Util;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.system.service.SystemConfigMgr;
import com.suteam.html.user.model.App;

public class ServerFilter implements Filter {

	private SystemConfigMgr systemConfigMgr;
	static SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss:SSS");

	public void destroy() {

	}

	public synchronized void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = ((HttpServletRequest) request);
		HttpServletResponse resp = ((HttpServletResponse) response);
		String count = "1";
		Map<String, Object> mapReturn = new HashMap<String, Object>();
		try {
			// 获取内存
			ServletContext servletContext = req.getSession().getServletContext();
			// 服务号
			String serviceNumber = (String) servletContext.getAttribute("auth_service_number");
			String oauthIp = (String) servletContext.getAttribute("oauthIp");
			Long timeDifference = (Long) servletContext.getAttribute("timeDifference");
			// 判断内存中数据是否存在
			if (oauthIp == null || "".equals(oauthIp) || serviceNumber == null || "".equals(serviceNumber)
					|| timeDifference == null) {
				// 调用保存数据到内存的方法
				saveToServletContext(servletContext);
				oauthIp = (String) servletContext.getAttribute("oauthIp");
				timeDifference = (Long) servletContext.getAttribute("timeDifference");
				serviceNumber = (String) servletContext.getAttribute("auth_service_number");
			}
			String url = req.getRequestURI();// 请求地址
			// 判断当前访问ip是否受限
			boolean ipCheck = true;
			if (!ipCheck) {
				mapReturn.put("result", "error");
				mapReturn.put("values", "");
				mapReturn.put("errormsg", EnumErrorCode.CODE_000474.msg);
				mapReturn.put("errorcode", EnumErrorCode.CODE_000474.code);
				ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
			} else {
				// ServletContext servletContext =
				// req.getSession().getServletContext();
				String strDo = "";
				if (url.contains("/port/")) {
					String appId = null;
					String accessToken = null;
					// 签名-->zyz
					String cSign = null;
					String RequestTimeStr = null;
					String sSign = null;
					Long RequestTime = null;
					Long zsServiceAuthServerTime = null;
					Long sTime_2 = null;
					Long sTime_1 = null;
					Map map = req.getParameterMap();
					String[] appIdList = (String[]) map.get("code");
					String[] accessTokenList = (String[]) map.get("AccessToken");
					String[] cSignList = (String[]) map.get("sign");
					String[] RequestTimeList = (String[]) map.get("RequestTime");
					appId = appIdList == null ? "" : appIdList[0];
					accessToken = accessTokenList == null ? "" : accessTokenList[0];
					cSign = cSignList == null ? "" : cSignList[0];
					RequestTimeStr = RequestTimeList == null ? "" : RequestTimeList[0];
					RequestTime = Long.parseLong(RequestTimeStr);
					strDo = url.substring(url.length() - 3, url.length());
					// sever端生成签名
					sSign = MD5Util.GetMD5Code(RequestTimeStr + accessToken);
					// MD5Util.GetMD5Code
					if (sSign.equals(cSign)) { // 判断签名是否相同
						App app = (App) servletContext.getAttribute(appId);
						if (!"".equals(strDo) && !".do".equals(strDo)) {
							mapReturn.put("result", "error");
							mapReturn.put("values", "");
							mapReturn.put("errormsg", EnumErrorCode.CODE_000082.msg);
							mapReturn.put("errorcode", EnumErrorCode.CODE_000082.code);
							ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
						} else if (app == null) {// 如果app在session不存在则发送请求
							System.out.println("->第" + count + "次--->Filter:session中不存在Application信息");
							// 发送请求
							sendToOAuth(request, response, chain, servletContext, resp, oauthIp, appId, accessToken,
									sTime_1, zsServiceAuthServerTime, app, count, serviceNumber);
						} else { // session中存在Application信息
							System.out.println("->第" + count + "次--->Filter:session中存在Application信息");

							System.out.println("->第" + count + "次--->Filter第 1 层判断时间：" + formatter.format(new Date()));

							System.out.println("->第" + count + "次---->Filter第 2 层判断时间：" + formatter.format(new Date()));
							sTime_2 = new Date().getTime();
							System.out.println("sTime_2:" + formatter.format(sTime_2));
							sTime_1 = (Long) servletContext.getAttribute("sTime_1");
							System.out.println("sTime_1:" + formatter.format(sTime_1));
							Long OATime = (Long) (servletContext.getAttribute("zsServiceAuthServerTime"));
							System.out.println("OATime:" + formatter.format(OATime));
							Long SOATime = (sTime_2 - sTime_1) + OATime;

							System.out.println(
									"->第" + count + "次---->Filter：SOA&COA时间差：" + Math.abs(SOATime - RequestTime));

							System.out.println("SOATime:" + formatter.format(SOATime));
							System.out.println("RequestTime:" + formatter.format(RequestTime));

							if (Math.abs(SOATime - RequestTime) <= timeDifference) { // 判断server,
								// client两端时间差是否小于200ms
								System.out.println(
										"->第" + count + "次---->Filter第 3 层判断时间：" + formatter.format(new Date()));
								// token剩余的有效时长(类型Long, 单位ms)
								Long timeFlag = app.getExpirationDate() - (sTime_2 - sTime_1);
								System.out.println("->第" + count + "次-->!!!S端剩余有效时间:" + timeFlag);

								if (accessToken.equals(app.getAccessToken()) && timeFlag > 0) {
									System.out.println(
											"->第" + count + "次---->Filter第 4 层判断时间：" + formatter.format(new Date()));
									// 如果token相同，并且没有到期
									System.out.println("->第" + count + "次---->Filter：token相同，并且没有到期");
									System.out.println("->第" + count + "次->Filter结束时间：" + formatter.format(new Date()));
									chain.doFilter(request, response);
								} else if (accessToken.equals(app.getAccessToken()) && timeFlag <= 0) {
									// 如果token相同，并且到期,返回token过期
									System.out.println("->第" + count + "次---->Filter：token相同，并且到期,返回token过期");
									System.out.println("->第" + count + "次->Filter结束时间：" + formatter.format(new Date()));
									mapReturn.put("result", "error");
									mapReturn.put("values", "");
									mapReturn.put("errormsg", EnumErrorCode.CODE_000477.msg);
									mapReturn.put("errorcode", EnumErrorCode.CODE_000477.code);
									ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
								} else if (!accessToken.equals(app.getAccessToken())) {
									// 如果token不相同，发送请求
									sendToOAuth(request, response, chain, servletContext, resp, oauthIp, appId,
											accessToken, sTime_1, zsServiceAuthServerTime, app, count, serviceNumber);
								}
							} else {
								System.out.println("->第" + count + "次SOA&COA时间差大于2s啦~~~~！！！！");
								mapReturn.put("result", "error");
								mapReturn.put("values", "");
								mapReturn.put("errormsg", EnumErrorCode.CODE_000477.msg);
								mapReturn.put("errorcode", EnumErrorCode.CODE_000477.code);
								ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
							}
						}
					} else {
						mapReturn.put("result", "error");
						mapReturn.put("values", "");
						mapReturn.put("errormsg", EnumErrorCode.CODE_000478.msg);
						mapReturn.put("errorcode", EnumErrorCode.CODE_000478.code);
						ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
					}
				} else {
					chain.doFilter(request, response);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			mapReturn.put("result", "error");
			mapReturn.put("values", "");
			mapReturn.put("errormsg", EnumErrorCode.CODE_000478.msg);
			mapReturn.put("errorcode", EnumErrorCode.CODE_000478.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(mapReturn));
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
	}

	/**
	 * 向OAuth端发送请求
	 * 
	 * @author zyz
	 * @param request
	 * @param response
	 * @param chain
	 * @param servletContext
	 * @param resp
	 * @param oauthIp:OAuth端Ip
	 * @param appId
	 * @param accessToken
	 * @param sTime_1
	 * @param zsServiceAuthServerTime
	 * @param app
	 * @throws IOException
	 * @throws ServletException
	 */
	public void sendToOAuth(ServletRequest request, ServletResponse response, FilterChain chain,
			ServletContext servletContext, HttpServletResponse resp, String oauthIp, String appId, String accessToken,
			Long sTime_1, Long zsServiceAuthServerTime, App app, String count, String serviceNumber)
					throws IOException, ServletException {

		// 发送请求
		String url = oauthIp + "/v1/token/common/app/verifyAccessToken.do?count=" + count;
		Map<String, String> sendMap = new HashMap<String, String>();// 将参数放入map中发送
		sendMap.put("AccessToken", accessToken);
		sendMap.put("code", appId);
		sendMap.put("serverServiceNumber", serviceNumber);
		System.out.println("->第" + count + "次---->Filter:向AuthServer端发送时间:" + formatter.format(new Date()));
		String result = HttpUtil2.doPost(url, sendMap);
		if (null == result || ("").equals(result)) {
			sendToOAuth(request, response, chain, servletContext, resp, oauthIp, appId, accessToken, sTime_1,
					zsServiceAuthServerTime, app, count, serviceNumber);
		}
		System.out.println("->第" + count + "次---->Filter:接收到AuthServer端返回时间:" + formatter.format(new Date()));
		Map<String, Object> mapResult = (Map<String, Object>) JSON.parse(result);

		// 如果App对象为空,则说明内存session中没有app对象, 重新new app对象放入内存session中
		if (app == null) {
			app = new App();
		}

		if ("ok".equals(mapResult.get("result"))) {
			servletContext.removeAttribute(appId);
			app.setAccessToken(accessToken);
			Long LifeTime = Long.parseLong(mapResult.get("LifeTime").toString());
			app.setExpirationDate(LifeTime);
			servletContext.setAttribute(appId, app);

			sTime_1 = new Date().getTime();
			servletContext.setAttribute("sTime_1", sTime_1);
			zsServiceAuthServerTime = (Long) mapResult.get("zsServiceAuthServerTime");
			servletContext.setAttribute("zsServiceAuthServerTime", zsServiceAuthServerTime);
			System.out.println("->第" + count + "次->获取OA短时间：" + formatter.format(zsServiceAuthServerTime));
			System.out.println("->第" + count + "次与OA验证token相同");
			System.out.println("->第" + count + "次->Filter结束时间：" + formatter.format(new Date()));

			chain.doFilter(request, response);
		} else {
			System.out.println("->第" + count + "次与OA验证token不同");
			System.out.println("->第" + count + "次->Filter结束时间：" + formatter.format(new Date()));
			ResponseUtils.renderJson(resp, result);
		}
	}

	/**
	 * 将数据存入内存
	 *
	 */
	public String saveToServletContext(ServletContext servletContext) {
		try {
			// filter中注入service
			XmlWebApplicationContext cxt = (XmlWebApplicationContext) WebApplicationContextUtils
					.getWebApplicationContext(servletContext);
			// 依次获取到service
			systemConfigMgr = (SystemConfigMgr) cxt.getBean(SystemConfigMgr.class);

			servletContext.setAttribute("auth_service_number", systemConfigMgr.getValueByName("service_number"));
			servletContext.setAttribute("oauthIp", systemConfigMgr.getValueByName("auth_server"));
			servletContext.setAttribute("timeDifference",
					Long.parseLong(systemConfigMgr.getValueByName("service_life_time")));
			return "ok";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

}

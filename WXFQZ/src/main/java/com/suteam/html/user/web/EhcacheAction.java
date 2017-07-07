package com.suteam.html.user.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EHCaCheUtil;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.logs.RandomUtil;
import com.suteam.html.user.model.User;
import com.suteam.html.user.service.UserMgr;

@Controller
public class EhcacheAction {

	@Autowired
	private UserMgr userMgr;

	/**
	 * 非注解缓存（自定义缓存）
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/test/customCaching")
	@ResponseBody
	public String customCaching(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			User user = null;
			Object object = EHCaCheUtil.getCache("userCache", id);
			if (object == null) {
				System.out.println("非注解缓存--从数据库中获取");
				user = userMgr.findById(id);
				EHCaCheUtil.putCache("userCache", id, user);
			} else {
				System.out.println("非注解缓存--从缓存中获取");
				user = (User) object;
			}

			map.put("result", "ok");
			map.put("values", user);
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 非注解清理缓存（自定义缓存）
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/test/clearCaching")
	@ResponseBody
	public String clearCaching(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			EHCaCheUtil.removeCache("userCache", id);
			System.out.println("非注解缓存--清除缓存");
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 注解获取缓存数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/test/annotationCaching")
	@ResponseBody
	public String annotationCaching(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			System.out.println("注解获取缓存数据--根据ID=" + id + "查询数据开始");
			User user = userMgr.findByIdTest(id);
			System.out.println("注解获取缓存数据--根据ID=" + id + "查询数据结束");
			map.put("result", "ok");
			map.put("values", user);
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 注解更新缓存数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/test/annotationUpdateCaching")
	@ResponseBody
	public String annotationUpdateCaching(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			User user = userMgr.findByIdTest(id);
			String userName="test" + RandomUtil.getRandom(4);
			System.out.println("注解更新缓存数据--将ID=" + id + "对应数据字段UserName修改为"+userName+" 开始");
			user.setUserName(userName);
			userMgr.saveUserTest(user);
			System.out.println("注解更新缓存数据--将ID=" + id + "对应数据字段UserName修改为"+userName+" 结束");
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 注解清理缓存数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/test/annotationClearCaching")
	@ResponseBody
	public String annotationClearCaching(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			System.out.println("注解清理缓存数据--根据ID=" + id + "清理缓存数据开始");
			userMgr.evictUserTest(id);
			System.out.println("注解清理缓存数据--根据ID=" + id + "清理缓存数据结束");
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}
}

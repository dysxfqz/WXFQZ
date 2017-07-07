package com.suteam.html.permission.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.FontImageUtil;
import com.suteam.html.common.util.RandomUtil;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.logs.Logs;
import com.suteam.html.common.util.logs.LogsUtil;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.service.MenuMgr;
import com.suteam.html.system.model.SystemConfig;
import com.suteam.html.system.service.SystemConfigMgr;

@Controller
public class ModuleAction {

	@Autowired
	private ModuleMgr moduleMgr;
	@Autowired
	private MenuMgr menuMgr;
	@Autowired
	private SystemConfigMgr systemConfigMgr;

	/**
	 * 显示模块列表
	 * 
	 * @param req
	 * @return
	 */
	@RequestMapping("/v1/html/manage/moduleManage/query/moduleList")
	public String moduleList(HttpServletRequest req) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			//获取所有的模块
			List<Module> moduleList = moduleMgr.findAll();
			//将模块集合存入request作用域中
			req.setAttribute("moduleList", moduleList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "module/module_list";
		} catch (Exception e) {
			//服务器异常
			map.put("result", "error");
			map.put("values", e.getMessage());
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/error/404";
		}
	}

	/**
	 * 跳转添加模块页面
	 * 
	 * @return
	 */
	@RequestMapping("/v1/html/manage/moduleManage/create/toModule")
	public String toModule(HttpServletRequest req) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			//获取所有的菜单
			List<Menu> menuList = menuMgr.findAll();
			//将菜单集合存入request作用域中
			req.setAttribute("menuList", menuList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "module/module_addModule";
		} catch (Exception e) {
			//服务器异常
			map.put("result", "error");
			map.put("values", e.getMessage());
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/error/404";
		}
	}

	/**
	 * 添加模块
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/moduleManage/create/createModule")
	@ResponseBody
	public String createModule(HttpServletRequest req, HttpServletResponse resp) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			//1、获取请求参数
			//获取模块名称
			String name = req.getParameter("name");
			//获取模块描述
			String description = req.getParameter("description");
			//获取菜单编号
			String menuId = req.getParameter("menuId");
			//2、根据菜单编号和模块名称查询，获取模块集合
			List<Module> moduleList = moduleMgr.findByNameAndMenuId(name,menuId);
			if(moduleList != null && moduleList.size() >0){
				//记录日志，该模块已经存在，不能重复添加
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000208.msg);
				map.put("errorcode", EnumErrorCode.CODE_000208.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
			//3、获取已添加的模块记录个数，+1后设为新加模块排序和级联代码
			Integer size = moduleMgr.findSize();
			Integer sum = size + 1;
			//4、创建模块对象，注入数据
			Module module = new Module();
			//注入数据
			//根据菜单编号获取菜单对象
			Menu menu = menuMgr.findMenuByMenuId(menuId);
			//获取菜单的父级菜单的编号
			String pid = menu.getPid();
			//获取模块的主菜单对象
			while(pid != null && !"".equals(pid)){
				//获取菜单的父级菜单对象
				menu = menuMgr.findMenuByMenuId(pid);
				//获取父级菜单的编号
				pid = menu.getPid();
			}
			//获取主菜单的权限编号
			String mainMenuPermissionId = menu.getPermissionId();
			//判断主菜单权限编号是否为空，为空时提示错误，主菜单没有分配权限，不能添加模块
			if(mainMenuPermissionId == null || "".equals(mainMenuPermissionId)){
				//记录日志，主菜单没有分配权限，不能添加模块
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000207.msg);
				map.put("errorcode", EnumErrorCode.CODE_000207.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
			//注入主菜单权限编号
			module.setMainMenuPermissionId(mainMenuPermissionId);
			//注入模块名称
			module.setName(name);
			//注入模块描述
			module.setDescription(description);
			//注入菜单编号
			module.setMenuId(menuId);
			//注入排序
			module.setSort(sum);
			//注入级联代码
			module.setCode(sum);
			//4、保存模块对象
			moduleMgr.save(module);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			//服务器异常
			map.put("result", "error");
			map.put("values", e.getMessage());
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 删除模块
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/moduleManage/delete/deleteModule")
	@ResponseBody
	public String deleteModule(HttpServletRequest req, HttpServletResponse resp) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			//1、获取请求参数
			//获取模块编号
			String moduleId = req.getParameter("moduleId");
			//根据模块编号获取模块对象
			Module module = moduleMgr.findModuleById(moduleId);
			//调用service层方法删除模块对象、释放该模块下的权限对象、删除该模块下的权限角色关系
			moduleMgr.deleteModule(module);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 跳转添加模块页面
	 * 
	 * @return
	 */
	@RequestMapping("/v1/html/manage/systemManage/update/system")
	public String system(HttpServletRequest req) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			//获取logo名称
			String system_logo = systemConfigMgr.getValueByName("system_logo");
			//存入request作用域中
			req.setAttribute("system_logo", system_logo);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "module/system";
		} catch (Exception e) {
			//服务器异常
			map.put("result", "error");
			map.put("values", e.getMessage());
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/error/404";
		}
	}

	/**
	 * 保存系統參數并生成圖片
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/anon/manage/systemManage/update/saveSystem")
	@ResponseBody
	public String saveSystem(HttpServletRequest req, HttpServletResponse resp) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(req, logs);
			// 获取新旧logo值
			String system_logo_name = req.getParameter("system_logo_name");
			String system_logo_new = req.getParameter("system_logo_new");
			if (system_logo_new == null || "".equals(system_logo_new)) {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000001.msg);
				map.put("errorcode", EnumErrorCode.CODE_000001.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
			// 保存系统参数logo
			SystemConfig systemConfig = systemConfigMgr.findValueByName(system_logo_name);
			systemConfig.setValue(system_logo_new);
			systemConfigMgr.save(systemConfig);
			//	获取项目路径
			String requsetPath = req.getSession().getServletContext().getRealPath("/");
			requsetPath = requsetPath.replace("\\", "/");
			String ttf =requsetPath+"static/ace/fonts/方正吕建德字体简体.TTF";
			// 生成图片logo
			FontImageUtil.createImageWordS(system_logo_new, requsetPath+"static/source/img/logo.png",ttf,100f);
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", e.getMessage());
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}
}

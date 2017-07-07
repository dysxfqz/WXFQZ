package com.suteam.html.role.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.RandomUtil;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.logs.Logs;
import com.suteam.html.common.util.logs.LogsUtil;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.service.MenuMgr;

@Controller
public class MenuAction {
	
	@Autowired
	private MenuMgr menuMgr;
	@Autowired
	private UserPermissionMgr userPermissionMgr;
	@Autowired
	private ModuleMgr moduleMgr;
	/**
	 * 显示菜单列表
	 * @param req
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/query/menuList")
	public String menuList(HttpServletRequest req) {
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
			//获得所有菜单
			List<Menu> menuList = menuMgr.findAll();
			if(menuList != null && menuList.size() >0){
				//为菜单设置父菜单对象
				for (int i = 0; i < menuList.size(); i++) {
					//获取菜单对象
					Menu menu = menuList.get(i);
					//获取父级菜单编号
					String pid = menu.getPid();
					if(pid != null && !"".equals(pid)){
						//获取父级菜单对象
						Menu fatherMenu = menuMgr.findMenuByPid(pid);
						//为菜单设置父级菜单对象
						menu.setFather(fatherMenu);
					}
				}
			}
			//将菜单集合存入request作用域
			req.setAttribute("menu", menuList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "menu/menu_list";
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
	 * 跳转到添加菜单页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/create/toMenu")
	public String toAddMenu(HttpServletRequest req) {
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
			//获取所有的权限
			List<UserPermission> userPermissionList = userPermissionMgr.findAll();
			//将菜单集合存入request作用域中
			req.setAttribute("fatherMenuList", menuList);
			//将权限集合存入request作用域中
			req.setAttribute("userPermissionList", userPermissionList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "menu/menu_addMenu";
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
	 * 添加菜单
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/create/createMenu")
//	public String addMenu(Menu menu) {
	@ResponseBody
	public String createMenu(HttpServletRequest req, HttpServletResponse resp) {
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
			//获取菜单名称
			String name = req.getParameter("name");
			//获取菜单权限编号
			String permissionId = req.getParameter("permission_id");
			//获取父级菜单编号
			String pid = req.getParameter("pid");
			//获取标识
			String htmlId = req.getParameter("htmlId");
			//获取类名
			String htmlClass = req.getParameter("htmlClass");
			//2、判断父级菜单下有没有重名的菜单
			List<Menu> menus = null;
			if("0".equals(pid)){
				menus = menuMgr.findByRankAndName(0,name);
			}else {
				menus = menuMgr.findByPidAndName(pid,name);
			}
			if(menus != null && menus.size() >0 ){
				//记录日志，父级菜单下已存在同名菜单，不能重复添加
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000209.msg);
				map.put("errorcode", EnumErrorCode.CODE_000209.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
			//3、判断权限是否已经分配给了其他菜单
			if(!"0".equals(permissionId)){
				List<Menu> menus2 = menuMgr.findByPermissionId(permissionId);
				if(menus2 != null && menus2.size() >0){
					//记录日志，权限已经分配给了其他菜单，不能再次分配
					map.put("result", "error");
					map.put("values", "");
					map.put("errormsg", EnumErrorCode.CODE_000210.msg);
					map.put("errorcode", EnumErrorCode.CODE_000210.code);
					// 记录日志信息
					logs.setValues(JSON.toJSONString(map));
					LogsUtil.log(logs);
					ResponseUtils.renderJson(resp, JSON.toJSONString(map));
					return null;
				}
			}
			//4、保存菜单对象
			//统计菜单的数据量
			Integer sum = menuMgr.findSize();
			sum += 1;
			Integer rank = null;
			//判断是一级菜单还是二级菜单
			if ("0".equals(pid)) {
				rank = 0;
				pid = null;
			}  else {
				//根据pid获取父级菜单
				Menu menu = menuMgr.findMenuByMenuId(pid);
				rank = menu.getRank() + 1;
			}
			Menu menu = new Menu();
			menu.setName(name);
			if ("0".equals(permissionId)) {
				menu.setPermissionId(null);
			} else {
				menu.setPermissionId(permissionId);
			}
			menu.setPid(pid);
			menu.setSort(sum);
			menu.setRank(rank);
			menu.setHtmlId(htmlId);
			menu.setHtmlClass(htmlClass);
			//保存
			menuMgr.saveMenu(menu);
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
	
	/**
	 * 根据菜单ID删除菜单
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/delete/deleteMenu")
	@ResponseBody
	public String deleteMenu(HttpServletRequest req, HttpServletResponse resp) {
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
			//获取菜单编号
			String menuId = req.getParameter("id");
			Menu menu = menuMgr.findMenuByMenuId(menuId);
			//2、判断菜单是否存在
			if (menu == null) {
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
			//获取菜单等级(0一级菜单，1二级菜单，2三级菜单)
			Integer rank = menu.getRank();
			if(rank == 0){
				//菜单为一级菜单时
				//（1）判断是否有二级菜单
				//获取一级菜单的子菜单集合
				List<Menu> childMenuList = menuMgr.findChildrenByMenuId(menuId); 
				//判断是否有二级菜单
				if(childMenuList != null && childMenuList.size() > 0){
					//创建HashSet存储要删除的菜单和模块集合
					Set<Menu> menuSet = new HashSet<Menu>();
					menuSet.add(menu);
					menuSet.addAll(childMenuList);
					Set<Module> moduleSet = new HashSet<Module>();
					for (int i = 0; i < childMenuList.size(); i++) {
						//获取二级菜单对象
						Menu childMenu = childMenuList.get(i);
						//菜单为二级菜单时
						menuSet.add(childMenu);
						//（1）判断是否有三级菜单存在
						List<Menu> threeMenuList = menuMgr.findByPid(childMenu.getId());
						if(threeMenuList != null && threeMenuList.size() > 0){
							menuSet.addAll(threeMenuList);
						}
						//（2）获取二级菜单下的模块集合
						List<Module> moduleList = moduleMgr.findByMenuId(childMenu.getId());
						if(moduleList != null && moduleList.size() > 0){
							moduleSet.addAll(moduleList);
						}
					}
					//调用service层的方法删除菜单和模块
					menuMgr.deleteMenuAndModule(menuSet,moduleSet);
				}else{
					//(2)判断是否有模块
					//根据菜单编号获取模块集合
					List<Module> moduleList = moduleMgr.findByMenuId(menuId);
					//判断是否有模块
					if (moduleList != null && moduleList.size() > 0) {
						//创建HashSet存储要删除的菜单和模块集合
						Set<Menu> menuSet = new HashSet<Menu>();
						menuSet.add(menu);
						Set<Module> moduleSet = new HashSet<Module>();
						moduleSet.addAll(moduleList);
						//调用service层的方法删除菜单和模块
						menuMgr.deleteMenuAndModule(menuSet,moduleSet);
					}else {
						//菜单下不存在模块时，直接删除该菜单
						menuMgr.deleteMenu(menu);
					}
				}
			}else if(rank == 1){
				//菜单为二级菜单时
				//创建HashSet存储要删除的菜单和模块集合
				Set<Menu> menuSet = new HashSet<Menu>();
				menuSet.add(menu);
				Set<Module> moduleSet = new HashSet<Module>();
				//（1）判断是否有三级菜单存在
				List<Menu> threeMenuList = menuMgr.findByPid(menuId);
				if(threeMenuList != null && threeMenuList.size() > 0){
					menuSet.addAll(threeMenuList);
				}
				//（2）获取二级菜单下的模块集合
				List<Module> moduleList = moduleMgr.findByMenuId(menuId);
				if(moduleList != null && moduleList.size() > 0){
					moduleSet.addAll(moduleList);
				}
				//调用service层的方法删除菜单和模块
				menuMgr.deleteMenuAndModule(menuSet,moduleSet);
			}else {
				//菜单为三级菜单时
				//获取菜单的权限对象
				UserPermission userPermission = userPermissionMgr.findById(menu.getPermissionId());
				List<Module> moduleList = new ArrayList<Module>();
				if(userPermission != null){
					//获取权限对应的模块编号
					String moduleId = userPermission.getModuleId();
					//获取模块对象
					Module module = moduleMgr.findModuleById(moduleId);
					if(module != null){
						moduleList.add(module);
					}
				}
				//创建HashSet存储要删除的菜单和模块集合
				Set<Menu> menuSet = new HashSet<Menu>();
				menuSet.add(menu);
				Set<Module> moduleSet = new HashSet<Module>();
				moduleSet.addAll(moduleList);
				//调用service层的方法删除菜单和模块
				menuMgr.deleteMenuAndModule(menuSet,moduleSet);
			}
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
	 * 跳转到编辑菜单页面
	 * @param menuId
	 * @param req
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/update/toUpdateMenu")
	public String toUpdateMenu(HttpServletRequest req) {
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
			//获取菜单编号
			String menuId = req.getParameter("menuId");
			Menu menu = menuMgr.findMenuByMenuId(menuId);
			//设置父类菜单列表
			List<Menu> fatherMenuList = menuMgr.findAll();
			//设置权限列表
			List<UserPermission> permissionList = userPermissionMgr.findAll();
			req.setAttribute("fatherMenuList", fatherMenuList);
			req.setAttribute("permissions", permissionList);
			req.setAttribute("menu", menu);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "menu/menu_updateMenu";
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
	 * 编辑菜单
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/menuManage/update/updateMenu")
	@ResponseBody
	public String updateMenu(HttpServletRequest req, HttpServletResponse resp) {
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
			//获取菜单名称
			String name = req.getParameter("name");
			//获取菜单权限编号
			String permissionId = req.getParameter("permission_id");
			//获取父级菜单编号
			String pid = req.getParameter("pid");
			//获取标识
			String htmlId = req.getParameter("htmlId");
			//获取类名
			String htmlClass = req.getParameter("htmlClass");
			//获取菜单编号
			String menuId = req.getParameter("id");
			//根据菜单编号获取菜单对象
			Menu menu = menuMgr.findMenuByMenuId(menuId);
			//2、判断父级菜单下有没有重名的菜单
			List<Menu> menus = null;
			//根据菜单的父级菜单有没有改变，判断是否存在重名的菜单
			if("0".equals(pid)){
				//父级菜单改为一级菜单时
				//判断父级菜单有无变化
				if(menu.getPid() != null && !"".equals(menu.getPid())){
					menus = menuMgr.findByPidAndName(pid,name);
				}
			}else{
				//父级菜单改为非一级菜单时
				//判断父级菜单有无变化
				if(menu.getPid() == null || "".equals(menu.getPid())){
					menus = menuMgr.findByPidAndName(pid,name);
				}else if(!menu.getPid().equals(pid)){
					menus = menuMgr.findByPidAndName(pid,name);
				}
			}
			if(menus != null && menus.size() >0 ){
				//记录日志，父级菜单下已存在同名菜单，不能重复添加
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000209.msg);
				map.put("errorcode", EnumErrorCode.CODE_000209.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
			//3、判断权限是否已经分配给了其他菜单
			if(!"0".equals(permissionId)){
				List<Menu> menus2 = menuMgr.findByPermissionId(permissionId);
				if(menus2 != null && menus2.size() >0){
					Menu menu2 = menus2.get(0);//正常情况只能存在一个
					//判断是否为同一个菜单
					if(!menu.getId().equals(menu2.getId())){
						//记录日志，权限已经分配给了其他菜单，不能再次分配
						map.put("result", "error");
						map.put("values", "");
						map.put("errormsg", EnumErrorCode.CODE_000210.msg);
						map.put("errorcode", EnumErrorCode.CODE_000210.code);
						// 记录日志信息
						logs.setValues(JSON.toJSONString(map));
						LogsUtil.log(logs);
						ResponseUtils.renderJson(resp, JSON.toJSONString(map));
						return null;
					}
				}
			}
			//4、保存菜单对象
			//统计菜单的数据量
			Integer rank = null;
			//判断是一级菜单还是二级菜单
			if ("0".equals(pid)) {
				rank = 0;
				pid = null;
			}  else {
				//根据pid获取父级菜单
				Menu menuPer = menuMgr.findMenuByMenuId(pid);
				rank = menuPer.getRank() + 1;
			}
			menu.setName(name);
			if ("0".equals(permissionId)) {
				menu.setPermissionId(null);
			} else {
				menu.setPermissionId(permissionId);
			}
			menu.setPid(pid);
			menu.setRank(rank);
			menu.setHtmlId(htmlId);
			menu.setHtmlClass(htmlClass);
			//保存
			menuMgr.saveMenu(menu);
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (NumberFormatException e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}
}

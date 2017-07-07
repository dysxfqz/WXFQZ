package com.suteam.html.permission.web;

import java.util.Collections;
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
import com.suteam.html.common.util.RandomUtil;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.logs.Logs;
import com.suteam.html.common.util.logs.LogsUtil;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.model.RelRolePermission;
import com.suteam.html.role.model.RelUserRole;
import com.suteam.html.role.model.UserRole;
import com.suteam.html.role.service.MenuMgr;
import com.suteam.html.role.service.RelRolePermissionMgr;
import com.suteam.html.role.service.RelUserRoleMgr;
import com.suteam.html.role.service.UserRoleMgr;

@Controller
public class PermissionAction {

	@Autowired
	private RelUserRoleMgr relUserRoleMgr;
	@Autowired
	private UserRoleMgr userRoleMgr;
	@Autowired
	private RelRolePermissionMgr relRolePermissionMgr;
	@Autowired
	private UserPermissionMgr userPermissionMgr;
	@Autowired
	private MenuMgr menuMgr;
	@Autowired
	private ModuleMgr moduleMgr;

	/**
	 * 添加用户权限接口
	 * 
	 * @param request
	 * @author fqz，ltl
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/permissionManage/create/createUserPermission")
	@ResponseBody
	public String createUserPermission(HttpServletRequest request, HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取请求参数
			//获取权限名称
			String name = request.getParameter("name");
			//获取权限URL
			String url = request.getParameter("url");
			//获取权限类型
			String type = request.getParameter("type");
			//获取描述
			String description = request.getParameter("description");
			//获取模块编号
			String moduleId = request.getParameter("module_id");
			//2、判断要添加的权限是否已经存在
			UserPermission userPermission = userPermissionMgr.findByUrl(url);
			if(userPermission != null){
				//记录日志，权限已经存在，不能重复添加
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000202.msg);
				map.put("errorcode", EnumErrorCode.CODE_000202.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
			//3、创建权限对象，注入数据，保存到数据库中
			UserPermission up = new UserPermission();
			//注入moduleType和moduleId
			if("anon".equals(type)){
				//匿名权限
				up.setModuleId(null);
				up.setModuleType(3);
			}else {
				if("0".equals(moduleId)){
					//一级菜单权限
					up.setModuleId(null);
					up.setModuleType(1);
				}else{
					//普通权限（包括二级菜单和三级菜单权限，包括部分一级菜单（首页））
					up.setModuleId(moduleId);
					up.setModuleType(2);
				}
			}
			up.setName(name);
			up.setUrl(url);
			up.setType(type);
			up.setDescription(description);
			//4、保存(保存权限表和角色权限表)
			userPermissionMgr.createUserPermission(up,moduleId);
			//添加成功
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
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
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 添加角色权限关系接口
	 * 
	 * @param request
	 * @author fqz,ltl
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/roleManage/create/createRolePermission")
	@ResponseBody
	public String createRolePermission(HttpServletRequest request, HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1.获取请求参数
			//获取角色编号
			String roleId=request.getParameter("roleId");
			//获取模块编号组
			String mids=request.getParameter("mids");
			//2、调用service层的添加角色权限关系的方法
			relRolePermissionMgr.createRolePermission(roleId,mids);
			//添加成功
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}
	
	/**
	 *跳转到权限列表
	 * 
	 * @param request
	 * @author fqz,ltl
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/permissionManage/query/permissionList")
	public String permissionList(HttpServletRequest request,HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取权限集合（所有）
			List<UserPermission> userPermissionList=userPermissionMgr.findAll();
			//给对应的userPermission里面添加module
			for (UserPermission i : userPermissionList) {
				String moduleId = i.getModuleId();
				Module module = moduleMgr.findModuleById(moduleId);
				i.setModule(module);
			}
			//存入request作用域中
			request.setAttribute("userPermissionList", userPermissionList);
			//2、获取模块集合（所有）
			List<Module> moduleList = moduleMgr.findAll();
			//存入request作用域中
			request.setAttribute("moduleList", moduleList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/permission/permission_list";
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
	 *跳转到角色列表
	 * 
	 * @param request
	 * @author fqz,ltl
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/roleManage/query/roleList")
	public String roleList(HttpServletRequest request,HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//获取所有的角色集合，存入request作用域中
			List<UserRole> userRoleList=userRoleMgr.findAll();
			request.setAttribute("userRoleList", userRoleList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/permission/role_list";
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
	 * 添加角色
	 *
	 * @author zyz,ltl
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/roleManage/create/createRole")
	public String createRole(HttpServletRequest request, HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取参数
			//获取角色名称
			String name = request.getParameter("name");
			//获取角色描述
			String description = request.getParameter("description");
			//2、判断角色是否已经存在
			//根据角色名称获取角色对象
			UserRole role = userRoleMgr.findByName(name);
			if(role != null){
				//记录日志，角色已经存在，不能重复添加
				map.put("result", "error");
				map.put("values","");
				map.put("errormsg", EnumErrorCode.CODE_000203.msg);
				map.put("errorcode", EnumErrorCode.CODE_000203.code);
				// 记录日志信息
				logs.setValues(JSON.toJSONString(map));
				LogsUtil.log(logs);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
			//3、创建角色对象，注入数据，保存到数据库中
			UserRole userRole = new UserRole();
			userRole.setName(name);
			userRole.setDescription(description);
			// 系统默认角色(0非, 1真),注意：系统默认的角色不能删除
			userRole.setDefaultRole(0);
			this.userRoleMgr.saveUserRole(userRole);
			//添加成功
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
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
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}
	
	/**
	 * 删除角色
	 *
	 * @author zyz,ltl
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/roleManage/delete/deleteRole")
	public String deleteRole(HttpServletRequest request, HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取请求参数
			//获取角色编号组字符串
			String str = request.getParameter("userRoleIdList");
			//解析角色编号组字符串，获取要删除的角色编号集合
			String[] userRoleIds = str.split(",");
			//2、遍历删除角色
			for (int i = 0; i < userRoleIds.length; i++) {
				String userRoleId = userRoleIds[i];
				//根据角色编号获取角色对象
				UserRole userRole = userRoleMgr.findById(userRoleId);
				if(userRole == null){
					//记录日志，角色不存在
					map.put("result", "error");
					map.put("values", "");
					map.put("errormsg", EnumErrorCode.CODE_000205.msg);
					map.put("errorcode", EnumErrorCode.CODE_000205.code);
					LogsUtil.log(logs);
					ResponseUtils.renderJson(response, JSON.toJSONString(map));
					return null;
				}
				//判断是否有用户拥有该角色
				List<RelUserRole> relUserRoleList = relUserRoleMgr.getByRoleId(userRoleId);
				if (relUserRoleList != null && relUserRoleList.size() > 0) {
					//有用户已经分配该角色，不能删除
					map.put("result", "error");
					map.put("values", "");
					map.put("errormsg", EnumErrorCode.CODE_000204.msg);
					map.put("errorcode", EnumErrorCode.CODE_000204.code);
					LogsUtil.log(logs);
					ResponseUtils.renderJson(response, JSON.toJSONString(map));
					return null;
				} else {
					//获取角色的系统默认(0非, 1真)
					Integer defaultRole = userRole.getDefaultRole();
					//判断该角色是否为系统默认角色
					if(defaultRole == 1){
						//系统默认角色不能删除
						map.put("result", "error");
						map.put("values", "");
						map.put("errormsg", EnumErrorCode.CODE_000206.msg);
						map.put("errorcode", EnumErrorCode.CODE_000206.code);
						LogsUtil.log(logs);
						ResponseUtils.renderJson(response, JSON.toJSONString(map));
						return null;
					}
					//调用service层的删除角色的方法（删除角色和角色权限关系）
					userRoleMgr.deleteRoleAndPermission(userRole);
				}
			}
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
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
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}
	/**
	 *去添加权限和角色关系页面
	 * 
	 * @param request
	 * @author fqz,ltl
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/roleManage/create/toRolePermission")
	public String toRolePermission(HttpServletRequest request) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取请求参数
			//获取角色编号
			String roleId=request.getParameter("id");
			//根据角色编号获取角色对象
			UserRole userRole = userRoleMgr.findById(roleId);
			//获取角色名称
			String roleName = userRole.getName();
			//2、获取全部菜单
			List<Menu> menuList = menuMgr.findAll();
			//对菜单进行排序
			Collections.sort(menuList);
			//为菜单设置模块集合
			for (int i = 0; i < menuList.size(); i++) {
				//获取菜单对象
				Menu menu = menuList.get(i);
				//获取菜单编号
				String menuId = menu.getId();
				//获取该菜单下的模块集合
				List<Module> moduleList = moduleMgr.findByMenuId(menuId);
				//为菜单设置模块集合
				if(moduleList != null && moduleList.size() >0){
					for (int j = 0; j < moduleList.size(); j++) {
						//获取模块对象
						Module module = moduleList.get(j);
						//获取该模块的编号
						String moduleId = module.getId();
						//获取该模块下的任一权限编号
						List<String> perIds = userPermissionMgr.findPerIdsByPage(moduleId,0,1);
						if(perIds != null && perIds.size() >0){
							//获取第一个权限编号
							String perId = perIds.get(0);
							//根据角色编号和权限编号获取角色权限对象
							List<RelRolePermission> relRolePermissions = relRolePermissionMgr.findByRoleIdAndPerId(roleId,perId);
							if(relRolePermissions != null && relRolePermissions.size() >0){
								//角色权限关系存在时说明该角色拥有该模块，设置状态为1（当前用户是否已有权限的状态 1.有  2没有）
								module.setStatus("1");
							}else{
								module.setStatus("2");
							}
						}
					}
					//对模块集合排序
					Collections.sort(moduleList);
				}
				//为菜单设置模块集合
				menu.setModuleList(moduleList);
			}
			//4、将菜单集合、角色编号和角色名称存入request作用域中
			request.setAttribute("menuList", menuList);
			request.setAttribute("roleId", roleId);
			request.setAttribute("roleName", roleName);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "/permission/add_role_permission";
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
	 *删除权限
	 * 
	 * @param request
	 * @author mzl, zyz,ltl-->支持多选删除
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/v1/html/manage/permissionManage/delete/deletePermission")
	@ResponseBody
	public String removePermission(HttpServletRequest request , HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取请求参数
			//获取要删除的权限编号组
			String str = request.getParameter("persIdList");
			//解析权限编号组获取权限编号数组
			String[] persIdList = str.split(",");
			for (int i = 0; i < persIdList.length; i++) {
				//获取权限编号
				String perId = persIdList[i];
				//2、判断是否有菜单使用该权限,若存在则不许删除
				List<Menu> menuList = menuMgr.findByPermissionId(perId);
				if (menuList != null && menuList.size() > 0) {
					map.put("result", "error");
					map.put("values", "");
					map.put("errormsg", EnumErrorCode.CODE_000001.msg);
					map.put("errorcode", EnumErrorCode.CODE_000001.code);
					// 记录日志信息
					logs.setValues(JSON.toJSONString(map));
					LogsUtil.log(logs);
					ResponseUtils.renderJson(response, JSON.toJSONString(map));
					return null;
				} else {
					//3、根据权限编号获取权限对象
					UserPermission userPermission=userPermissionMgr.findById(perId);
					//调用service层的方法删除权限（删除权限和角色权限关系）
					userPermissionMgr.deletePermissionAndRolePermission(userPermission);
				}
				/*//删除权限对应的菜单
				List<Menu> menuList = menuMgr.findByPermissionId(perId);
				if (menuList != null && menuList.size() > 0) {
					for (Menu k : menuList) {
						//判断是否是一级菜单
						if (k.getPid() == null) {
							List<Menu> childMenuList = menuMgr.findChildrenByMenuId(k.getId());
							//判断是否有二级菜单
							if (childMenuList != null && childMenuList.size() > 0) {
								for (Menu j : childMenuList) {
									menuMgr.dropById(j.getId());
								}
							}
						}
						//根据ID删除菜单
						menuMgr.dropById(k.getId());
					}
				}
				
				UserPermission userPermission=userPermissionMgr.findById(perId);
				List<RelRolePermission> rrpList=relRolePermissionMgr.findByPermissionId(perId);
				if(rrpList != null && rrpList.size()>0){
					for (int j = 0; j < rrpList.size(); j++) {
						relRolePermissionMgr.deleteRelRolePermission(rrpList.get(i));
					}
				}	
				userPermissionMgr.deleteUserPermission(userPermission);*/
			}
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
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
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
		
	}
	
	/**
	 * 跳转到编辑权限页面
	 * @param permissionId
	 * @author ltl
	 * @param req
	 * @return
	 */
	@RequestMapping("/v1/html/manage/permissionManage/update/toUpdatePermission")
	public String toUpdatePermission(HttpServletRequest request, HttpServletResponse response) {
		//创建实体类Logs
		Logs logs = new Logs();
		//获取日志号
		String logCode = RandomUtil.getRandomCharAndNumr(20);
		logs.setLogCode(logCode);
		//创建map集合，存储日志
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//生成日志
			logs = LogsUtil.recordLog(request, logs);
			//1、获取请求参数
			//获取权限编号
			String permissionId = request.getParameter("permissionId");
			//根据权限编号获取权限对象
			UserPermission userPermission = userPermissionMgr.findById(permissionId); 
			//存入request作用域中
			request.setAttribute("userPermission", userPermission);
			//获取所有模块
			List<Module> moduleList = moduleMgr.findAll();
			//存入request作用域中
			request.setAttribute("moduleList", moduleList);
			//一切正常
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			// 记录日志信息
			logs.setValues(JSON.toJSONString(map));
			LogsUtil.log(logs);
			return "permission/permission_updatePermission";
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
	 * 编辑权限
	 * @author ltl
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/v1/html/manage/permissionManage/update/updatePermission")
	@ResponseBody
	public String updatePermission(HttpServletRequest req, HttpServletResponse resp) {
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
			//获取权限编号
			String id = req.getParameter("id");
			// 权限URL
			String url = req.getParameter("url");
			//获取权限类型
			String type = req.getParameter("type");
			//获取权限描述
			String description = req.getParameter("description");
			//获取模块编号
			String moduleId = req.getParameter("module_id");
			//获取权限名称
			String name = req.getParameter("name");
			//通过权限编号获取权限对象
			UserPermission userPermission = userPermissionMgr.findById(id);
			//注入数据
			userPermission.setUrl(url);
			userPermission.setType(type);
			userPermission.setDescription(description);
			userPermission.setName(name);
			//注入moduleType和moduleId
			if("anon".equals(type)){
				//匿名权限
				userPermission.setModuleId(null);
				userPermission.setModuleType(3);
			}else {
				if("1".equals(moduleId)){
					//一级菜单权限
					userPermission.setModuleId(null);
					userPermission.setModuleType(1);
				}else{
					//普通权限（包括二级菜单和三级菜单权限，包括部分一级菜单（首页））
					userPermission.setModuleId(moduleId);
					userPermission.setModuleType(2);
				}
			}
			//更新权限对象和角色权限关系表
			userPermissionMgr.updatePermission(userPermission,moduleId);
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
	
}

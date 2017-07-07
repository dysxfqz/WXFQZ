package com.suteam.html.common.interceptor;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.suteam.html.common.util.ShiroUtil;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.service.MenuMgr;
import com.suteam.html.system.service.SystemConfigMgr;
import com.suteam.html.user.model.User;
import com.suteam.html.user.model.UserInfo;
import com.suteam.html.user.service.UserInfoMgr;

/**
 * 菜单监听器
 * 
 * @author zsyun_Fangqingzhu
 *
 */
public class MenuDispatchInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MenuMgr menuMgr;
	@Autowired
	private UserPermissionMgr userPermissionMgr;
	@Autowired
	private UserInfoMgr userInfoMgr;
	@Autowired
	private SystemConfigMgr systemConfigMgr;
	@Autowired
	private ModuleMgr moduleMgr;

	public static Logger log = Logger.getLogger(MenuDispatchInterceptor.class);

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 获取内存
		ServletContext servletContext = request.getSession().getServletContext();
		//1、在内存中存入菜单
		List<Menu> menu = (List<Menu>) servletContext.getAttribute("systemMenuList");
		// 如果获取到的菜单为空，则调用菜单初始化方法，将菜单存入内存中
		if (menu == null) {
			menuToServlectContext(servletContext);
		}
		//2、显示用户名+头像（存入request作用域中）
		//获取当前用户
		User user = ShiroUtil.getShiroUser();
		if (user != null) {
			String userName2 = "";
			//获取用户信息对象（为了取用户姓名（或者手机号）在页面做显示）
			UserInfo userInfo = userInfoMgr.findByUserId(user.getId());
			if (userInfo == null) {
				log.error("用户编号为"+user.getId()+"的用户信息不存在");
				throw new Exception("用户信息不存在");
			}
			if (userInfo.getName() != null && !"".equals(userInfo.getName())) {
				//用户姓名存在时，显示用户姓名
				userName2 = userInfo.getName();
			} else {
				//用户姓名不存在时，显示手机号
				userName2 = userInfo.getPhone();
			}
			//存入用户名
			request.setAttribute("showUserName", userName2);
			//存入头像地址
			request.setAttribute("showHeadUrl", userInfo.getHeadUrl());
		}
		//3、在内存中存放文件服务器地址和上传文件路径
		String headUrl = "";
		String headFullUrl = "";
		if (servletContext.getAttribute("systemHeadUrl") == null || servletContext.getAttribute("systemHeadFullUrl") == null) {
			log.info("----将文件服务器地址和上传文件路径存入内存开始----");
			headUrl = systemConfigMgr.getValueByName("file_server");
			headFullUrl = systemConfigMgr.getValueByName("upload_file_path");
			servletContext.setAttribute("systemHeadUrl", headUrl);
			servletContext.setAttribute("systemHeadFullUrl", headFullUrl);
			log.info("----将文件服务器地址和上传文件路径存入内存结束----");
		}
		//4、菜单点亮显示
		// 请求地址
		String reqUrl = request.getServletPath();
		if (reqUrl != null && ! "".equals(reqUrl)) {
			//从内存中获取菜单点亮URL
			Map<String, String> map = (Map<String, String>) servletContext.getAttribute("menuStar");
			//菜单点亮URL为空时，调用menuStarToServletContext方法，将菜单点亮URL存入内存
			if(map == null){
				menuStarToServletContext(servletContext);
			}
			//将需要点亮的菜单URL（htmlId）存入request作用域中
			request.setAttribute("fatherMenuId", map.get("menuStar"+reqUrl));
		}
		return true;
		
	}
	
	/**
	 * @description 将菜单存入内存
	 * @author ltl
	 */
	public void menuToServlectContext(ServletContext servletContext) {
		log.info("----将菜单存入内存开始----");
		//1、获取一级菜单
		List<Menu> menuList = menuMgr.findByRank(0);
		//2、为一级菜单设置子菜单（包括二级菜单和三级菜单）
		for (Menu i : menuList) {
			//（1）为一级菜单设置权限
			//根据权限编号获取权限对象
			UserPermission userPermission = userPermissionMgr.findById(i.getPermissionId());
			//设置一级菜单的权限
			i.setUserPermission(userPermission);
			// （2）获取一级菜单的子菜单（二级菜单）
			List<Menu> childMenuList = menuMgr.findByPid(i.getId());
			if (childMenuList != null) {
				for (Menu j : childMenuList) {
					//【1】为二级菜单设置权限
					UserPermission childUserPermission = userPermissionMgr.findById(j.getPermissionId());
					j.setUserPermission(childUserPermission);
					//【2】获取二级菜单的子菜单（三级菜单）
					List<Menu> childMenuList2 = menuMgr.findByPid(j.getId());
					if (childMenuList2 != null) {
						for (Menu z : childMenuList2) {
							//为三级菜单设置权限
							UserPermission childUserPermission2 = userPermissionMgr.findById(z.getPermissionId());
							z.setUserPermission(childUserPermission2);
						}
						// 对三级菜单排序
						Collections.sort(childMenuList2);
						j.setChildren(childMenuList2);
					}
				}
				// 对二级菜单排序
				Collections.sort(childMenuList);
				i.setChildren(childMenuList);
			}
		}
		// 对一级菜单排序
		Collections.sort(menuList);
		//将菜单存入内存
		servletContext.setAttribute("systemMenuList", menuList);
		log.info("----将菜单存入内存结束----");
	}
	/**
	 * @description 菜单点亮URL
	 * @author ltl
	 */
	public void menuStarToServletContext(ServletContext servletContext){
		
		log.info("----将菜单点亮URL存入内存开始----");
		//创建map集合，存储菜单点亮URL
		Map<String, String> map = new HashMap<String, String>();
		//获取所有的权限集合
		List<UserPermission> upList = userPermissionMgr.findAll();
		for (int i = 0; i < upList.size(); i++) {
			//获取权限的模块编号
			String moduleId = upList.get(i).getModuleId();
			//判断模块编号是否为空（为空：1、部分一级菜单的权限（没有页面）2、匿名权限；这两种情况不需要点亮菜单）
			if (moduleId != null && !"".equals(moduleId)) {
				//根据模块编号获取模块对象
				Module module = moduleMgr.findModuleById(moduleId);
				//判断模块对象是否为空（为空时是异常情况，需要记录日志告警）
				if (module != null) {
					//获取模块所属的菜单（一、直属一级菜单；二、属二级菜单；三、三级菜单下的权限所属模块直属二级菜单（注意：不属与三级菜单））
					Menu menuChild = menuMgr.findMenuByMenuId(module.getMenuId());
					//判断菜单的等级（rank:0、一级菜单；1、二级菜单；2、三级菜单）
					//二级菜单时
					if (menuChild.getRank() == 1) {
						//获取二级菜单的父菜单（一级菜单）
						Menu menuFather = menuMgr.findMenuByMenuId(menuChild.getPid());
						//判断是否为一级菜单（容错）
						if (null == menuFather.getPid() || "".equals(menuFather.getPid())) {
							//存入点亮 菜单URL(级联的思想)
							map.put("menuStar" + upList.get(i).getUrl(),
									menuFather.getHtmlId() + "|" + menuChild.getHtmlId());
						}
						//获取菜单的子菜单（三级菜单，部分二级菜单才有）
						List<Menu> menuListS = menuMgr.findByPid(menuChild.getId());
						//判断三级菜单是否存在
						if (menuListS != null && menuListS.size() > 0) {
							for (Menu menu : menuListS) {
								//获取三级菜单的权限
								UserPermission up = userPermissionMgr.findById(menu.getPermissionId());
								//三级菜单的特殊性处理
								//通过当前三级菜单权限所属的模块编号和moduleId是否相等，来判断upList.get(i)权限是否属于当前三级菜单
								if (moduleId.equals(up.getModuleId())) {
									map.put("menuStar" + upList.get(i).getUrl(), menuFather.getHtmlId() + "|"
											+ menuChild.getHtmlId() + "|" + menu.getHtmlId());
								}
							}
						}
					} else if (menuChild.getRank() == 0) { //有页面的一级菜单（如首页）
						//这种一级菜单比较特殊，它的权限是跳转到一个页面（如首页）
						//模块直属一级菜单时，只需点亮一级菜单即可（存入一级菜单的htmlId）
						map.put("menuStar" + upList.get(i).getUrl(), menuChild.getHtmlId());
					}
				}else {
					log.error("权限编号为"+upList.get(i).getId()+"的权限所属模块不存在");
				}
			}
		}
		//在内存中存放菜单点亮URL
		servletContext.setAttribute("menuStar", map);
		log.info("----将菜单点亮URL存入内存结束----");
	}
}

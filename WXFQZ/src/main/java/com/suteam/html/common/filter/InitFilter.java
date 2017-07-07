package com.suteam.html.common.filter;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.service.MenuMgr;
import com.suteam.html.system.service.SystemConfigMgr;

/**
 * 系统启动初始化
 * 
 * @author zsyun_Fangqingzhu
 *
 */
@Component
public class InitFilter implements ServletContextAware {

	@Autowired
	private MenuMgr menuMgr;
	@Autowired
	private UserPermissionMgr userPermissionMgr;
	@Autowired
	private SystemConfigMgr systemConfigMgr;
	@Autowired
	private ModuleMgr moduleMgr;

	public static Logger log = Logger.getLogger(InitFilter.class);
	private static boolean isStart = false;

	@Override
	public void setServletContext(ServletContext sc) {
		if (!isStart) {// 这个可以解决项目启动加载两次的问题
			log.info("----系统初始化开始----");
			isStart = true;
			
			//1、将菜单存入内存
			log.info("----将菜单存入内存开始----");
			//获取一级菜单
			List<Menu> menuList = menuMgr.findByRank(0);
			//为一级菜单设置子菜单（包括二级菜单和三级菜单）
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
			sc.setAttribute("systemMenuList", menuList);
			log.info("----将菜单存入内存结束----");
			
			//2、在内存中存放文件服务器地址和上传文件路径
			log.info("----将文件服务器地址和上传文件路径存入内存开始----");
			String headUrl = "";
			String headFullUrl = "";
			if (sc.getAttribute("systemHeadUrl") == null || sc.getAttribute("systemHeadFullUrl") == null) {
				headUrl = systemConfigMgr.getValueByName("file_server");
				headFullUrl = systemConfigMgr.getValueByName("upload_file_path");
				sc.setAttribute("systemHeadUrl", headUrl);
				sc.setAttribute("systemHeadFullUrl", headFullUrl);
			}
			log.info("----将文件服务器地址和上传文件路径存入内存结束----");
			
			//3、在内存中存放菜单点亮URL
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
			sc.setAttribute("menuStar", map);
			log.info("----将菜单点亮URL存入内存结束----");
//			// 获取项目路径
//			String realPath = sc.getRealPath("/");
//			// 获取项目名
//			String projectName = sc.getContextPath();
//			if (null != projectName && !(("").equals(projectName))) {
//				projectName = projectName.replace("\\", "");
//				projectName = projectName.replace("/", "");
//				realPath = realPath.replace(projectName, "");
//			}
//			if (realPath.contains("ROOT")) {
//				realPath = realPath.substring(0, realPath.indexOf("ROOT"));
//			}
//			// 获取本机哈希值
//			String hash = BasicJobUtil.executeTask(sc.getRealPath("/"));
//			//
//			Properties properties = PropertiesUtil.getFileProperty(realPath + "config.ini");
//			// 获取agent hash
//			String agentHash = properties.getProperty("hash");
//			log.info("----hash1----" + hash);
//			log.info("----hash2----" + agentHash);
//			if (hash == null || agentHash == null || "".equals(agentHash) || "".equals(hash)
//					|| !agentHash.equals(hash)) {
//				int i = 1 / 0;
//			}
			log.info("----系统初始化结束----");
		}

	}
}
package com.suteam.html.permission.dao;

import java.util.List;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.permission.model.Module;

public interface ModuleDao extends GenericDao<Module> {

	/**
	 * 获取所有功能模块
	 * @return
	 */
	public List<Module> findAll();
	
	/**
	 * 通过ID获取模块
	 * @param moduleId
	 * @return
	 */
	public Module findModuleById(String moduleId);
	
	/**
	 * 通过主菜单ID查询权限
	 * @param mainMenuPermissionId
	 * @return
	 */
	public Module findByMainMenuId(String mainMenuPermissionId);
	
	/**
	 * 通过菜单ID查询出模块集合
	 * @param menuId
	 * @return
	 */
	public List<Module> findByMenuId(String menuId);
	
	/**
	 * 通过菜单ID查询出模块集合
	 * @param menuId
	 * @return
	 */
	public List<Module> findModuleByMenuId(String menuId);

	/**
	 * @description 获取所有模块的记录个数
	 * @author ltl
	 */
	public Integer findSize();

	/**
	 * @description 根据模块名称和菜单编号获取模块集合
	 * @author ltl
	 */
	public List<Module> findByNameAndMenuId(String name, String menuId);
}

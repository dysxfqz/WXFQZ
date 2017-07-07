package com.suteam.html.permission.service;

import java.util.List;

import com.suteam.html.permission.model.Module;

public interface ModuleMgr {

	/**
	 * 获取所有功能模块
	 * @return
	 */
	public List<Module> findAll();
	
	/**
	 * 保存模块
	 * @param module
	 */
	public void save(Module module);
	
	/**
	 * 删除
	 * @param moduleId
	 */
	public void dropById(String moduleId);
	
	/**
	 * 根据ID查询出模块
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
	 * @description 删除模块对象、释放该模块下的权限对象、删除该模块下权限角色关系
	 * @author ltl
	 */
	public void deleteModule(Module module);

	/**
	 * @description 根据模块名称和菜单编号获取模块集合
	 * @author ltl
	 */
	public List<Module> findByNameAndMenuId(String name, String menuId);
}

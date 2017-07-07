package com.suteam.html.role.service;

import java.util.List;
import java.util.Set;

import com.suteam.html.permission.model.Module;
import com.suteam.html.role.model.Menu;

public interface MenuMgr {

	/**
	 * 保存对象
	 * @param menu
	 */
	public void saveMenu(Menu menu);
	
	/**
	 * 获取全部菜单
	 * @return
	 */
	public List<Menu> findAll();
	
	/**
	 * 通过等级获取菜单
	 * @param rank
	 * @return
	 */
	public List<Menu> findByRank(Integer rank);
	
	/**
	 * 通过父类Id获取菜单
	 * @param id
	 * @return
	 */
	public List<Menu> findByPid(String pid);
	
	/**
	 * 通过pid获取父类菜单
	 * @param pid
	 * @return
	 */
	public Menu findMenuByPid(String pid);
	
	/**
	 * 通过菜单ID删除菜单
	 * @param menuId
	 */
	public void dropById(String menuId);
	
	/**
	 * 通过menuId获取菜单
	 * @param menuId
	 * @return
	 */
	public Menu findMenuByMenuId(String menuId);
	
	/**
	 * 通过menuId获取子类菜单集合
	 * @param menuId
	 * @return
	 */
	public List<Menu> findChildrenByMenuId(String menuId);
	
	/**
	 * 通过权限ID获取菜单集合
	 * @param permissionId
	 * @return
	 */
	public List<Menu> findByPermissionId(String permissionId);

	/**
	 * @description 通过父级菜单编号和菜单名称获取菜单集合
	 * @author ltl
	 */
	public List<Menu> findByPidAndName(String pid, String name);
	/**
	 * @description 获取所有菜单的记录个数
	 * @author ltl
	 */
	public Integer findSize();

	/**
	 * @description 根据菜单等级和菜单名称获取菜单集合
	 * @author ltl
	 */
	public List<Menu> findByRankAndName(int rank, String name);

	/**
	 * @description 删除菜单
	 * @author ltl
	 */
	public void deleteMenu(Menu menu);

	/**
	 * @description 删除菜单和模块
	 * @author ltl
	 */
	public void deleteMenuAndModule(Set<Menu> menuSet, Set<Module> moduleSet);
}

package com.suteam.html.role.dao;

import java.util.List;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.role.model.Menu;

public interface MenuDao extends GenericDao<Menu> {

	/**
	 * 根据等级查询菜单
	 * @param rank
	 * @return
	 */
	public List<Menu> findByRank(Integer rank);
	
	/**
	 * 根据父类ID查询菜单，即子类菜单
	 * @param pid
	 * @return
	 */
	public List<Menu> findByPid(String pid);
	
	/**
	 * 通过pid获取菜单
	 * @param pid
	 * @return
	 */
	public Menu findMenuByPid(String pid);
	
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
	 * @description 根据菜单等级和菜单编号获取菜单集合
	 * @author ltl
	 */
	public List<Menu> findByRankAndName(int rank, String name);
	
}

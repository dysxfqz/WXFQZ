package com.suteam.html.role.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.permission.dao.ModuleDao;
import com.suteam.html.permission.dao.UserPermissionDao;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.role.dao.MenuDao;
import com.suteam.html.role.dao.RelRolePermissionDao;
import com.suteam.html.role.model.Menu;
import com.suteam.html.role.service.MenuMgr;

@Service
@SuppressWarnings("unchecked")
public class MenuMgrImpl implements MenuMgr {

	@Autowired
	private MenuDao menuDao; 
	@Autowired
	private ModuleDao moduleDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private RelRolePermissionDao relRolePermissionDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveMenu(Menu menu) {
		menuDao.save(menu);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findAll() {
		return menuDao.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findByRank(Integer rank) {
		return menuDao.findByRank(rank);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findByPid(String pid) {
		return menuDao.findByPid(pid);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Menu findMenuByPid(String pid) {
		return menuDao.findMenuByPid(pid);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void dropById(String menuId) {
		menuDao.delete(menuId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Menu findMenuByMenuId(String menuId) {
		return menuDao.findMenuByMenuId(menuId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findChildrenByMenuId(String menuId) {
		return menuDao.findChildrenByMenuId(menuId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findByPermissionId(String permissionId) {
		return menuDao.findByPermissionId(permissionId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findByPidAndName(String pid, String name) {
		List<Menu> menuList = menuDao.findByPidAndName(pid,name);
		return menuList;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Integer findSize() {
		Integer size = menuDao.findSize();
		return size;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Menu> findByRankAndName(int rank, String name) {
		List<Menu> menuList = menuDao.findByRankAndName(rank,name);
		return menuList;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteMenu(Menu menu) {
		menuDao.delete(menu);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteMenuAndModule(Set<Menu> menuSet, Set<Module> moduleSet) {
		//1、删除菜单
		if(menuSet != null && menuSet.size() > 0){
			for (Menu menu : menuSet) {
				menuDao.delete(menu);
			}
		}
		//2、删除该菜单下的所有模块
		if(moduleSet != null && moduleSet.size() > 0){
			for (Module module : moduleSet) {
				//1、删除模块对象
				moduleDao.delete(module);
				//2、释放该模块下的权限对象、删除该模块下的权限角色关系
				//获取模块编号
				String moduleId = module.getId();
				//根据模块编号获取权限集合
				List<UserPermission> userPermissionList = userPermissionDao.findByModuleId(moduleId);
				if (userPermissionList != null && userPermissionList.size() > 0) {
					for (int j = 0; j < userPermissionList.size(); j++) {
						//获取权限对象
						UserPermission userPermission = userPermissionList.get(j);
						//将模块编号置为空
						userPermission.setModuleId(null);
						//将模块类型置为空
						userPermission.setModuleType(null);
						//（1）保存
						userPermissionDao.save(userPermission);
						//获取权限编号
						String perId = userPermission.getId();
						//根据权限编号获取角色权限记录个数
						Integer size = relRolePermissionDao.findSizeByPerId(perId);
						//（2）根据权限编号删除角色权限关系
						if(size > 0){
							relRolePermissionDao.deleteByPerId(perId);
						}
					}
				}
			}
		}
	}
}

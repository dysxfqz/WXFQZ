package com.suteam.html.permission.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.permission.dao.ModuleDao;
import com.suteam.html.permission.dao.UserPermissionDao;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.ModuleMgr;
import com.suteam.html.role.dao.RelRolePermissionDao;

@Service
public class ModuleMgrImpl implements ModuleMgr {
	
	@Autowired
	private ModuleDao moduleDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private RelRolePermissionDao relRolePermissionDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Module> findAll() {
		return moduleDao.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void save(Module module) {
		moduleDao.save(module);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void dropById(String moduleId) {
		moduleDao.delete(moduleId);;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Module findModuleById(String moduleId) {
		return moduleDao.findModuleById(moduleId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Module findByMainMenuId(String mainMenuPermissionId) {
		return moduleDao.findByMainMenuId(mainMenuPermissionId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Module> findByMenuId(String menuId) {
		return moduleDao.findByMenuId(menuId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Module> findModuleByMenuId(String menuId) {
		return moduleDao.findModuleByMenuId(menuId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Integer findSize() {
		Integer size = moduleDao.findSize();
		return size;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteModule(Module module) {
		//1、删除模块对象
		moduleDao.delete(module);
		//2、释放该模块下的权限对象、删除该模块下的权限角色关系
		//获取模块编号
		String moduleId = module.getId();
		//根据模块编号获取权限集合
		List<UserPermission> userPermissionList = userPermissionDao.findByModuleId(moduleId);
		if (userPermissionList != null && userPermissionList.size() > 0) {
			for (int i = 0; i < userPermissionList.size(); i++) {
				//获取权限对象
				UserPermission userPermission = userPermissionList.get(i);
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

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<Module> findByNameAndMenuId(String name, String menuId) {
		List<Module> moduleList = moduleDao.findByNameAndMenuId(name,menuId);
		return moduleList;
	}
}

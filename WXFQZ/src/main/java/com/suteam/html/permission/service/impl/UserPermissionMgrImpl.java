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
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.dao.RelRolePermissionDao;
import com.suteam.html.role.model.RelRolePermission;

@Service
@SuppressWarnings("unchecked")
public class UserPermissionMgrImpl implements UserPermissionMgr {

	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private ModuleDao moduleDao;
	@Autowired
	private RelRolePermissionDao relRolePermissionDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveUserPermission(UserPermission userPermission) {
		userPermissionDao.save(userPermission);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserPermission findByUrl(String url) {
		return userPermissionDao.findByUrl(url);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<UserPermission> findAll() {
		return userPermissionDao.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserPermission findById(String id) {
		return userPermissionDao.get(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<UserPermission> findAllByType(String type) {
		return userPermissionDao.findAllByType(type);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteUserPermission(UserPermission userPermission) {
		userPermissionDao.delete(userPermission);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<UserPermission> findByModuleId(String moduleId) {
		return userPermissionDao.findByModuleId(moduleId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<UserPermission> findByModuleTypeModuleId(int moduleType, String moduleId) {
		return userPermissionDao.findByModuleTypeModuleId(moduleType, moduleId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void createUserPermission(UserPermission userPermission, String moduleId) throws Exception {
		//1、保存权限表
		userPermissionDao.save(userPermission);
		//2、当添加新权限到已有模块中时，需把该权限对应的角色权限关系添加到角色权限表中
		if (!"0".equals(moduleId)) {
			//根据模块编号获取模块对象
			Module module = moduleDao.findModuleById(moduleId);
			if(module != null){
				//根据模块编号获取权限集合
				List<UserPermission> userPermissions = userPermissionDao.findByModuleId(moduleId);
				if(userPermissions != null && userPermissions.size() > 0){
					//获取模块下的某一权限编号
					String permissionId = userPermissions.get(0).getId();
					//根据权限编号获取角色编号集合
					List<String> roleIdList = relRolePermissionDao.findRoleIdsByPermissionId(permissionId);
					if(roleIdList != null && roleIdList.size() >0){
						//遍历角色编号，保存角色权限关系表
						for (int i = 0; i < roleIdList.size(); i++) {
							//创建角色权限关系对象
							RelRolePermission relRolePermissionAdd = new RelRolePermission();
							//注入权限编号
							String perId = userPermission.getId();
							relRolePermissionAdd.setPermissionId(perId);
							//注入角色编号
							String roleId = roleIdList.get(i);
							relRolePermissionAdd.setRoleId(roleId);
							//保存
							relRolePermissionDao.save(relRolePermissionAdd);
						}
					}
				}
			}else{
				throw new Exception("权限所属模块不存在");
			}
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<String> findPerIdsByPage(String moduleId, int index, int size) {
		List<String> perIds = userPermissionDao.findPerIdsByPage(moduleId,index,size);
		return perIds;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deletePermissionAndRolePermission(UserPermission userPermission) {
		//1、删除权限对象
		userPermissionDao.delete(userPermission);
		//获取权限编号
		String perId = userPermission.getId();
		//2、删除角色权限关系
		//根据权限编号获取角色权限记录
		Integer size = relRolePermissionDao.findSizeByPerId(perId);
		if(size > 0){
			//根据权限编号删除角色权限关系
			relRolePermissionDao.deleteByPerId(perId);
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void updatePermission(UserPermission userPermission,String moduleId) throws Exception {
		//1、保存权限表
		userPermissionDao.save(userPermission);
		//2、改变权限的模块时，需要删除旧的该权限对应的角色权限关系，保存新的该权限对应的角色权限关系
		if("1".equals(moduleId)){
			//改为一级菜单权限或者匿名权限时，只需要删除旧的角色权限关系
			//获取权限编号
			String perId = userPermission.getId();
			//根据权限编号获取角色与权限关系记录个数
			Integer size = relRolePermissionDao.findSizeByPerId(perId);
			if(size > 0){
				//角色权限关系记录个数不为时，删除
				relRolePermissionDao.deleteByPerId(perId);
			}
		}else{
			//普通权限（包括二级菜单和三级菜单权限，包括部分一级菜单（首页））时，先删除旧的角色权限关系，再保存新的角色权限关系
			//（1）删除旧的角色权限关系
			//获取权限编号
			String perId = userPermission.getId();
			//根据权限编号获取角色与权限关系记录个数
			Integer size = relRolePermissionDao.findSizeByPerId(perId);
			if(size > 0){
				//角色权限关系记录个数不为时，删除
				relRolePermissionDao.deleteByPerId(perId);
			}
			//（2）保存新的角色权限关系
			//根据模块编号获取模块对象
			Module module = moduleDao.findModuleById(moduleId);
			if(module != null){
				//根据模块编号获取权限集合
				List<UserPermission> userPermissions = userPermissionDao.findByModuleId(moduleId);
				if(userPermissions != null && userPermissions.size() > 0){
					//获取模块下的某一权限编号
					String permissionId = userPermissions.get(0).getId();
					//根据权限编号获取角色编号集合
					List<String> roleIdList = relRolePermissionDao.findRoleIdsByPermissionId(permissionId);
					if(roleIdList != null && roleIdList.size() >0){
						//遍历角色编号，保存角色权限关系表
						for (int i = 0; i < roleIdList.size(); i++) {
							//创建角色权限关系对象
							RelRolePermission relRolePermissionAdd = new RelRolePermission();
							//注入权限编号
							relRolePermissionAdd.setPermissionId(perId);
							//注入角色编号
							String roleId = roleIdList.get(i);
							relRolePermissionAdd.setRoleId(roleId);
							//保存
							relRolePermissionDao.save(relRolePermissionAdd);
						}
					}
				}
			}else{
				throw new Exception("权限所属模块不存在");
			}
		}
	}
}

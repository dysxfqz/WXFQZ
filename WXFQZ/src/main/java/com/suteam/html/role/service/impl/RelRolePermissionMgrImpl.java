package com.suteam.html.role.service.impl;

import java.util.HashSet;
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
import com.suteam.html.role.model.RelRolePermission;
import com.suteam.html.role.service.RelRolePermissionMgr;

@Service
public class RelRolePermissionMgrImpl implements RelRolePermissionMgr {

	@Autowired
	private RelRolePermissionDao relRolePermissionDao;
	@Autowired
	private ModuleDao moduleDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private MenuDao menuDao;
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveRelRolePermission(RelRolePermission relRolePermission) {
		relRolePermissionDao.save(relRolePermission);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RelRolePermission> findByRoleId(String roleId) {
		return relRolePermissionDao.findByRoleId(roleId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteRelRolePermission(RelRolePermission relRolePermission) {
		relRolePermissionDao.delete(relRolePermission);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RelRolePermission> findByPermissionId(String perId) {
		return relRolePermissionDao.findByPermissionId(perId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void createRolePermission(String roleId, String mids) throws Exception {
		//校验参数
		if(roleId == null || "".equals(roleId.trim()) || mids == null || "".equals(mids.trim())){
			throw new Exception("参数为空");
		}
		//1、根据roleId查询出这个角色的全部角色权限关系 ，然后删除
		List<RelRolePermission> rrpList=relRolePermissionDao.findByRoleId(roleId);
		if(rrpList != null && rrpList.size() > 0){
			//根据角色编号删除角色权限关系
			relRolePermissionDao.deleteByRoleId(roleId);
		}
		//2、保存新的角色权限关系
		if(mids !=null && !"".equals(mids)){
			//创建HashSet集合，存储权限编号（防止重复添加，所以用HashSet存储）
			Set<String> permissions = new HashSet<>();
			//解析模块编号组，获取模块编号集合
			String[] mids1=mids.split(",");
			for(int i=0;i<mids1.length;i++){
				//（1）添加一级菜单的权限与该角色的关系
				//根据模块编号获取模块对象
				Module module = moduleDao.findModuleById(mids1[i]);
				//获取该模块的主菜单权限编号
				String permissionId = module.getMainMenuPermissionId();
				permissions.add(permissionId);
				
				//（2）添加所有模块下的权限与角色关系
				//通过获取来的模块ID查询出对应的权限集合（普通权限、二级菜单和三级菜单）
				List<UserPermission> listPermission = userPermissionDao.findByModuleId(mids1[i]);
				if(listPermission != null && listPermission.size() > 0){
					for (UserPermission u : listPermission) {
						//添加菜单权限（二级菜单），注：三级菜单权限不用添加，因为包含在通过模块编号查出的权限集合中
						//根据权限编号获取菜单对象（如果菜单对象存在，并且是三级菜单，则添加其父菜单的权限）
						List<Menu> menuList = menuDao.findByPermissionId(u.getId());
						if(menuList != null && menuList.size() > 0){
							Menu menu = menuList.get(0);
							//判断菜单是否为三级菜单（rank：0，一级菜单；1，二级菜单；2，三级菜单）
							if(menu.getRank() == 2){
								//获取二级菜单
								Menu menuF = menuDao.findMenuByMenuId(menu.getPid());
								if(menuF == null){
									throw new Exception("编号为"+menu.getPid()+"的二级菜单不存在");
								}
								String permissionIdF = menuF.getPermissionId();
								//添加二级菜单的权限
								permissions.add(permissionIdF);
							}
						}
						//添加该权限
						permissions.add(u.getId());
					}
				}
			}
			//3、遍历权限集合，保存权限角色关系
			for (String i : permissions) {
				if(i == null || "".equals(i)){
					throw new Exception("权限编号为空");
				}
				RelRolePermission rrp = new RelRolePermission();
				rrp.setRoleId(roleId);
				rrp.setPermissionId(i);
				relRolePermissionDao.save(rrp);
			}
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RelRolePermission> findByRoleIdAndPerId(String roleId, String perId) {
		List<RelRolePermission> relRolePermissions = relRolePermissionDao.findByRoleIdAndPerId(roleId,perId);
		return relRolePermissions;
	}
}

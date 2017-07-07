package com.suteam.html.permission.service;

import java.util.List;
import com.suteam.html.permission.model.UserPermission;

public interface UserPermissionMgr {
	/**
	 * 保存对象
	 * 
	 * @param userPermission
	 */
	public void saveUserPermission(UserPermission userPermission);

	/**
	 * 根据url查询对象
	 * 
	 * @param url
	 * @return
	 */
	public UserPermission findByUrl(String url);

	/**
	 * 查询所有
	 * 
	 * @return
	 */
	public List<UserPermission> findAll();
	
	/**
	 * 根据编号查询对象
	 * 
	 * @param id
	 * @return
	 */
	public UserPermission findById(String id);
	
	/**
	 * 根据类型查询集合
	 * @return
	 */
	public List<UserPermission> findAllByType(String type);
	
	/**
	 * 删除
	 * 
	 * @param userPermission
	 */
	public void deleteUserPermission(UserPermission userPermission);
	
	/**
	 * 通过功能模块ID查询集合
	 * @param moduleId
	 * @return
	 */
	public List<UserPermission> findByModuleId(String moduleId);
	
	/**
	 * 通过模块类型，模块编号查询权限集合
	 * @param moduleType
	 * @param moduleId
	 * @return
	 */
	public List<UserPermission> findByModuleTypeModuleId(int moduleType, String moduleId);
	/**
	 * @description 添加用户权限(保存权限表，角色权限表)
	 * @param userPermission,moduleId
	 * @return
	 * @throws Exception 
	 */
	public void createUserPermission(UserPermission userPermission,String moduleId) throws Exception;

	/**
	 * @description 根据模块编号分页查询权限编号集合
	 * ltl
	 * @param moduleId:权限编号；index:分页首条数据的索引；size：每页的数据个数
	 * @return
	 */
	public List<String> findPerIdsByPage(String moduleId, int index, int size);

	/**
	 * @description 删除权限和角色权限关系
	 * ltl
	 * @param
	 * @return
	 */
	public void deletePermissionAndRolePermission(UserPermission userPermission);

	/**
	 * @description 更新权限表和角色权限关系表
	 * @author ltl
	 * @throws Exception 
	 */
	public void updatePermission(UserPermission userPermission,String moduleId) throws Exception;

}

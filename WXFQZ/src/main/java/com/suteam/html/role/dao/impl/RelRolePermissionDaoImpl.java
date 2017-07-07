package com.suteam.html.role.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.role.dao.RelRolePermissionDao;
import com.suteam.html.role.model.RelRolePermission;

@Repository
@SuppressWarnings("unchecked")
public class RelRolePermissionDaoImpl extends GenericDaoDefault<RelRolePermission>implements RelRolePermissionDao {

	@Override
	public List<RelRolePermission> findByRoleId(String roleId) {
		String hqlString = "from RelRolePermission where roleId='" + roleId + "'";
		List<RelRolePermission> list = super.query(hqlString);
		return list;
	}

	@Override
	public List<RelRolePermission> findByPermissionId(String perId) {
		String hqlString = "from RelRolePermission where permissionId='" + perId + "'";
		List<RelRolePermission> rrpList = super.query(hqlString);
		if (rrpList != null && rrpList.size() > 0) {
			return rrpList;
		}
		return null;
	}

	@Override
	public List<String> findRoleIdsByPermissionId(String permissionId) {
		String hqlString = "select roleId from RelRolePermission r where r.permissionId='" + permissionId + "' group by r.roleId";
		List<String> roleIdList = super.query(hqlString);
		if (roleIdList != null && roleIdList.size() > 0) {
			return roleIdList;
		}
		return null;
	}

	@Override
	public void deleteByRoleId(String roleId) {
		String hql = "delete from RelRolePermission r where r.roleId = '" + roleId + "'";
		Query query = super.getSession().createQuery(hql);
		query.executeUpdate();
	}

	@Override
	public List<RelRolePermission> findByRoleIdAndPerId(String roleId, String perId) {
		StringBuilder sb = new StringBuilder("from RelRolePermission r where 1=1");
		sb.append("and r.permissionId='").append(perId).append("' and r.roleId = '").append(roleId).append("'");
		List<RelRolePermission> rrpList = super.query(sb.toString());
		if (rrpList != null && rrpList.size() > 0) {
			return rrpList;
		}
		return null;
	}

	@Override
	public Integer findSizeByRoleId(String roleId) {
		StringBuilder sb = new StringBuilder("from RelRolePermission r where 1=1");
		sb.append("and r.roleId = '").append(roleId).append("'");
		Integer size = super.query(sb.toString()).size();
		return size;
	}

	@Override
	public Integer findSizeByPerId(String perId) {
		StringBuilder sb = new StringBuilder("from RelRolePermission r where 1=1");
		sb.append("and r.permissionId = '").append(perId).append("'");
		Integer size = super.query(sb.toString()).size();
		return size;
	}

	@Override
	public void deleteByPerId(String perId) {
		String hql = "delete from RelRolePermission r where r.permissionId = '" + perId + "'";
		Query query = super.getSession().createQuery(hql);
		query.executeUpdate();
	}
}

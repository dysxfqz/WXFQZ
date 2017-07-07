package com.suteam.html.permission.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.permission.dao.UserPermissionDao;
import com.suteam.html.permission.model.UserPermission;

@Repository
@SuppressWarnings("unchecked")
public class UserPermissionDaoImpl extends GenericDaoDefault<UserPermission>implements UserPermissionDao {

	@Override
	public UserPermission findByUrl(String url) {
		String hqlString = "from UserPermission where url='" + url + "'";
		List<UserPermission> userPermissionList = super.query(hqlString);
		if (userPermissionList != null && userPermissionList.size() > 0) {
			return userPermissionList.get(0);
		}
		return null;
	}

	@Override
	public List<UserPermission> findAllByType(String type) {
		String hqlString="from UserPermission where type!='"+type+"'";
		List<UserPermission> userPermissionList = super.query(hqlString);
		if (userPermissionList != null && userPermissionList.size() > 0) {
			return userPermissionList;
		}
		return null;
	}

	@Override
	public List<UserPermission> findByModuleId(String moduleId) {
		String hqlString = "from UserPermission where moduleId = '" + moduleId + "'";
		List<UserPermission> userPermissionList = super.query(hqlString);
		if (userPermissionList != null && userPermissionList.size() > 0) {
			return userPermissionList;
		}
		return null;
	}

	@Override
	public List<UserPermission> findByModuleTypeModuleId(int moduleType, String moduleId) {
		String hqlString = "from UserPermission where moduleType = '" + moduleType + "' and moduleId = '" + moduleId + "'";
		List<UserPermission> userPermissionList = super.query(hqlString);
		if (userPermissionList != null && userPermissionList.size() > 0) {
			return userPermissionList;
		}
		return null;
	}

	@Override
	public List<String> findPerIdsByPage(String moduleId, int index, int size) {
		String hql = "select u.id from UserPermission u where u.moduleId = '" + moduleId + "'";
		Query query = super.getSession().createQuery(hql);
		query.setFirstResult(index);
		query.setMaxResults(size);
		List<String> perIds = query.list();
		if(perIds != null && perIds.size() >0){
			return perIds;
		}
		return null;
	}
}

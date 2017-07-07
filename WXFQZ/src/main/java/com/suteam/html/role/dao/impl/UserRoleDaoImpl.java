package com.suteam.html.role.dao.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.role.dao.UserRoleDao;
import com.suteam.html.role.model.UserRole;

@Repository
@SuppressWarnings("unchecked")
public class UserRoleDaoImpl extends GenericDaoDefault<UserRole>implements UserRoleDao {

	@Override
	public UserRole findByName(String name) {
		String hqlString = "from UserRole where name='" + name + "'";
		List<UserRole> userRoleList = super.query(hqlString);
		if (userRoleList != null && userRoleList.size() > 0) {
			return userRoleList.get(0);
		}
		return null;
	}
}

package com.suteam.html.role.dao.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.role.dao.RelUserRoleDao;
import com.suteam.html.role.model.RelUserRole;

@Repository
@SuppressWarnings("unchecked")
public class RelUserRoleDaoImpl extends GenericDaoDefault<RelUserRole>implements RelUserRoleDao {

	@Override
	public List<RelUserRole> findByUserId(String userId) {
		String hqlString = "from RelUserRole where userId='" + userId + "'";
		List<RelUserRole> list = super.query(hqlString);
		return list;
	}

	/**
	 * 根据角色获取角色关系列表
	 * 
	 * @author zyz
	 * @param userRoleId
	 * @return
	 */
	@Override
	public List<RelUserRole> findByRoleId(String userRoleId) {
		String hql = "from RelUserRole where roleId='" + userRoleId + "'";
		List<RelUserRole> list = this.query(hql);
		return list;
	}

}

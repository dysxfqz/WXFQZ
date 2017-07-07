package com.suteam.html.system.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.system.dao.SystemConfigDao;
import com.suteam.html.system.model.SystemConfig;

@Repository
@SuppressWarnings("unchecked")
public class SystemConfigDaoImpl extends GenericDaoDefault<SystemConfig> implements SystemConfigDao{

	@Override
	public String getValueByName(String string) {
		String hqlString = "from SystemConfig where name='" + string + "'";
		List<SystemConfig> sysList = super.query(hqlString);
		if (sysList != null && sysList.size() > 0) {
			return sysList.get(0).getValue();
		}
		return null;
	}

	@Override
	public SystemConfig findValueByName(String name) {
		String hqlString = "from SystemConfig where name='" + name + "'";
		List<SystemConfig> sysList = super.query(hqlString);
		if (sysList != null && sysList.size() > 0) {
			return sysList.get(0);
		}
		return null;
	}

}

package com.suteam.html.system.dao;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.system.model.SystemConfig;

public interface SystemConfigDao extends GenericDao<SystemConfig>{
	/**
	 * 根据参数名称查询value值
	 * @param string
	 * @return
	 */
	String getValueByName(String string);

	SystemConfig findValueByName(String name);

}

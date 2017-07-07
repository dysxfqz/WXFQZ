package com.suteam.html.permission.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.permission.dao.ModuleDao;
import com.suteam.html.permission.model.Module;

@Repository
@SuppressWarnings("unchecked")
public class ModuleDaoImpl extends GenericDaoDefault<Module> implements ModuleDao {

	@Override
	public Module findModuleById(String moduleId) {
		String hqlString = "from Module where id = '" + moduleId + "'";
		List<Module> moduleList = super.query(hqlString);
		if (moduleList != null && moduleList.size() > 0) {
			return moduleList.get(0);
		}
		return null;
	}

	@Override
	public Module findByMainMenuId(String mainMenuPermissionId) {
		String hqlString = "from Module where mainMenuPermissionId = '" + mainMenuPermissionId + "'";
		List<Module> moduleList = super.query(hqlString);
		if (moduleList != null && moduleList.size() > 0) {
			return moduleList.get(0);
		}
		return null;
	}

	@Override
	public List<Module> findByMenuId(String menuId) {
		String hqlString = "from Module where menuId = '" + menuId + "'";
		List<Module> moduleList = super.query(hqlString);
		if (moduleList != null && moduleList.size() > 0) {
			return moduleList;
		}
		return null;
	}

	@Override
	public List<Module> findModuleByMenuId(String menuId) {
		String hqlString = "from Module where menuId = '" + menuId + "'";
		List<Module> moduleList = super.query(hqlString);
		if (moduleList != null && moduleList.size() > 0) {
			return moduleList;
		}
		return null;
	}

	@Override
	public Integer findSize() {
		String hqlString = "from Module";
		Integer size = super.query(hqlString).size();
		return size;
	}

	@Override
	public List<Module> findByNameAndMenuId(String name, String menuId) {
		StringBuilder sb = new StringBuilder("from Module m where 1=1");
		sb.append("and m.name = '").append(name).append("' and m.menuId = '")
		.append(menuId).append("'");
		List<Module> moduleList = super.query(sb.toString());
		if (moduleList != null && moduleList.size() > 0) {
			return moduleList;
		}
		return null;
	}
}

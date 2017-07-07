package com.suteam.html.role.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.role.dao.MenuDao;
import com.suteam.html.role.model.Menu;

@Repository
@SuppressWarnings("unchecked")
public class MenuDaoImpl extends GenericDaoDefault<Menu> implements MenuDao {

	@Override
	public List<Menu> findByRank(Integer rank) {
		String hqlString = "from Menu where rank = '" + rank + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}

	@Override
	public List<Menu> findByPid(String pid) {
		String hqlString = "from Menu where pid = '" + pid + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}

	@Override
	public Menu findMenuByPid(String pid) {
		String hqlString = "from Menu where id = '" + pid + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList.get(0);
		}
		return null;
	}

	@Override
	public Menu findMenuByMenuId(String menuId) {
		String hqlString = "from Menu where id = '" + menuId + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList.get(0);
		}
		return null;
	}

	@Override
	public List<Menu> findChildrenByMenuId(String menuId) {
		String hqlString = "from Menu where pid = '" + menuId + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}

	@Override
	public List<Menu> findByPermissionId(String permissionId) {
		String hqlString = "from Menu m where m.permissionId = '" + permissionId + "'";
		List<Menu> menuList = super.query(hqlString);
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}

	@Override
	public List<Menu> findByPidAndName(String pid, String name) {
		StringBuilder sb = new StringBuilder("from Menu m where 1 = 1");
		sb.append("and m.pid = '").append(pid).append("' and m.name = '").append(name).append("'");
		List<Menu> menuList = super.query(sb.toString());
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}

	@Override
	public Integer findSize() {
		String hql = "from Menu";
		Integer size = super.query(hql).size();
		return size;
	}

	@Override
	public List<Menu> findByRankAndName(int rank, String name) {
		StringBuilder sb = new StringBuilder("from Menu m where 1 = 1");
		sb.append("and m.rank = '").append(rank).append("' and m.name = '").append(name).append("'");
		List<Menu> menuList = super.query(sb.toString());
		if (menuList != null && menuList.size() > 0) {
			return menuList;
		}
		return null;
	}
}

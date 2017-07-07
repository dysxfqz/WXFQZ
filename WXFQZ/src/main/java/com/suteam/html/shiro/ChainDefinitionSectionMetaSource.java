package com.suteam.html.shiro;

import java.util.List;

import org.apache.shiro.config.Ini;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Autowired;

import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.UserPermissionMgr;

/**
 * 初始化访问权限
 *
 */
public class ChainDefinitionSectionMetaSource implements FactoryBean<Ini.Section> {
	@Autowired
	private UserPermissionMgr userPermissionMgr;
	// 静态资源访问权限
	private String filterChainDefinitions = "/static/*=anon";

	@Override
	public Ini.Section getObject() throws Exception {
		// 获取所有权限进行初始化
		List<UserPermission> userPermissionList = userPermissionMgr.findAll();
		Ini ini = new Ini();
		// //加载默认的url
		ini.load(filterChainDefinitions);
		Ini.Section section = ini.getSection(Ini.DEFAULT_SECTION_NAME);
		// 循环userPermissionList的url,逐个添加到section中。section就是filterChainDefinitionMap,
		for (UserPermission up : userPermissionList) {
			String permission = "";
			switch (up.getType()) {
			case "anon":
				permission = "anon";
				break;
			case "perms":
				permission = "perms[" + up.getName() + "]";
				break;
			case "roles":
				permission = "roles[" + up.getName() + "]";
				break;
			default:
				break;
			}
			section.put(up.getUrl(), permission);
		}
		// 不拦截首页地址
		// section.put("/", "anon");
		// section.put("/v1/html/welcome.do", "anon");

		// 所有资源的访问权限，必须放在最后
		section.put("/**", "authc");
		return section;
	}

	@Override
	public Class<?> getObjectType() {
		return this.getClass();
	}

	@Override
	public boolean isSingleton() {
		return false;
	}
}


package com.suteam.html.shiro;

import java.util.ArrayList;
import java.util.List;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import com.suteam.html.permission.model.UserPermission;
import com.suteam.html.permission.service.UserPermissionMgr;
import com.suteam.html.role.model.RelRolePermission;
import com.suteam.html.role.model.RelUserRole;
import com.suteam.html.role.model.UserRole;
import com.suteam.html.role.service.RelRolePermissionMgr;
import com.suteam.html.role.service.RelUserRoleMgr;
import com.suteam.html.role.service.UserRoleMgr;
import com.suteam.html.user.model.User;
import com.suteam.html.user.service.UserMgr;

/**
 * 自定义的指定Shiro验证用户登录的类
 */
public class MyRealm extends AuthorizingRealm {
	@Autowired
	private UserMgr userMgr;
	@Autowired
	private RelUserRoleMgr relUserRoleMgr;
	@Autowired
	private UserRoleMgr userRoleMgr;
	@Autowired
	private RelRolePermissionMgr relRolePermissionMgr;
	@Autowired
	private UserPermissionMgr userPermissionMgr;

	/**
	 * 为当前登录的用户授予角色和权限
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// 获取当前登录的用户名
		String currentUsername = (String) super.getAvailablePrincipal(principals);

		List<String> roleList = new ArrayList<String>();
		List<String> permissionList = new ArrayList<String>();
		// 从数据库中获取当前登录用户的详细信息
		User user = userMgr.findByUserName(currentUsername);
		if (user == null) {
			user = userMgr.findUserByPhone(currentUsername);
		}
		if (user == null) {
			user = userMgr.findByUemail(currentUsername);
		}
		if (null != user) {
			// 根据用户编号获取用户角色
			List<RelUserRole> relUserRoles = relUserRoleMgr.findByUserId(user.getId());
			if (null != relUserRoles && relUserRoles.size() > 0) {
				// 获取当前登录用户的角色
				for (RelUserRole relUserRole : relUserRoles) {
					UserRole userRole = userRoleMgr.findById(relUserRole.getRoleId());
					roleList.add(userRole.getName());
					// 根据角色查询权限集合
					List<RelRolePermission> relRolePermissions = relRolePermissionMgr.findByRoleId(userRole.getId());
					if (null != relRolePermissions && relRolePermissions.size() > 0) {
						// 循环权限
						for (RelRolePermission relRolePermission : relRolePermissions) {
							UserPermission userPermission = userPermissionMgr
									.findById(relRolePermission.getPermissionId());
							// 将权限放入集合
							if (!permissionList.contains(userPermission.getName())) {
								permissionList.add(userPermission.getName());
							}
						}
					}
				}
			}
			// 解决跨系统无法登录问题
			else {
				// 目前只有普通用户涉及该问题（后续需写活）
				RelUserRole rur = new RelUserRole();
				rur.setRoleId("402880b551f1f0d80151f1f21a0a0004");
				rur.setUserId(user.getId());
				relUserRoleMgr.saveRelUserRole(rur);
				UserRole userRole = userRoleMgr.findById(rur.getRoleId());
				roleList.add(userRole.getName());
				// 根据角色查询权限集合
				List<RelRolePermission> relRolePermissions = relRolePermissionMgr.findByRoleId(userRole.getId());
				if (null != relRolePermissions && relRolePermissions.size() > 0) {
					// 循环权限
					for (RelRolePermission relRolePermission : relRolePermissions) {
						UserPermission userPermission = userPermissionMgr.findById(relRolePermission.getPermissionId());
						// 将权限放入集合
						if (!permissionList.contains(userPermission.getName())) {
							permissionList.add(userPermission.getName());
						}
					}
				}
			}
		} else {
			throw new AuthorizationException();
		}
		// 为当前用户设置角色和权限
		SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
		// simpleAuthorInfo.addRoles(roleList);
		simpleAuthorInfo.addStringPermissions(permissionList);
		return simpleAuthorInfo;
	}

	/**
	 * 验证当前登录的用户
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {

		// 获取基于用户名和密码的令牌
		// 实际上这个authcToken是从LoginController里面currentUser.login(token)传过来的
		// 两个token的引用都是一样的,本例中是org.apache.shiro.authc.UsernamePasswordToken@33799a1e
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// System.out.println("验证当前Subject时获取到token为" +
		// ReflectionToStringBuilder.toString(token,
		// ToStringStyle.MULTI_LINE_STYLE));
		User user = userMgr.findByUserName(token.getUsername());
		if (user == null) {
			user = userMgr.findUserByPhone(token.getUsername());
		}
		if (user == null) {
			user = userMgr.findByUemail(token.getUsername());
		}
		if (null != user) {
			AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(token.getUsername(), user.getPassword(),
					getName());
			this.setSession("currentUser", user);
			return authcInfo;
		} else {
			// 没有返回登录用户名对应的SimpleAuthenticationInfo对象时,就会在LoginController中抛出UnknownAccountException异常
			return null;
		}
	}

	/**
	 * 将一些数据放到ShiroSession中,以便于其它地方使用
	 * 
	 * @see 比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到
	 */
	private void setSession(Object key, Object value) {
		Subject currentUser = SecurityUtils.getSubject();
		if (null != currentUser) {
			Session session = currentUser.getSession();
			// System.out.println("Session默认超时时间为[" + session.getTimeout() +
			// "]毫秒");
			if (null != session) {
				session.setAttribute(key, value);
			}
		}
	}
}
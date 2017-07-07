package com.suteam.html.common.util;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import com.suteam.html.user.model.User;

/**
 * shiro 工具类
 * 
 * @author zsyun_Fangqingzhu
 *
 */
public class ShiroUtil {
	/**
	 * 获取shiro session中的用户对象
	 * 
	 * @return
	 */
	public static User getShiroUser() {
		Subject currentUser = SecurityUtils.getSubject();
		if (null != currentUser) {
			Session session = currentUser.getSession();
			// System.out.println("Session默认超时时间为[" + session.getTimeout() +
			// "]毫秒");
			if (null != session) {
				User user = (User) session.getAttribute("currentUser");
				return user;
			}
		}
		return null;
	}
	
	/**
	 * 将一些数据放到ShiroSession中,以便于其它地方使用
	 * 
	 * @see 比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到
	 */
	public static void setSession(Object key, Object value) {
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

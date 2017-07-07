package com.suteam.html.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.suteam.html.common.util.ShiroUtil;
import com.suteam.html.user.model.User;

public class LoginFilter implements Filter {

	public void destroy() {

	}

	/**
	 * 拦截(当url包含.do时,检测链接是否包含anon,不包含则检查内存中是否存在用户)
	 * 
	 * @author zyz
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = ((HttpServletRequest) request);
		HttpServletResponse resp = ((HttpServletResponse) response);
		String base = req.getContextPath();
		String url = req.getServletPath();// req.getRequestURI();//请求地址
		req.getServletPath();
		if (url.contains(".do")) {
			if (url.contains("/anon/")) {
				chain.doFilter(request, response);
			} else if (url.contains("/port/")) {
				chain.doFilter(request, response);
			} else if (url.contains("/pay/")) {
				chain.doFilter(request, response);
			} else {
				User user = ShiroUtil.getShiroUser();
				if (user == null) {
					resp.sendRedirect(base + "/v1/anon/user/login/goLogin.do");
				} else {
					chain.doFilter(request, response);
				}
			}
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
	}
}

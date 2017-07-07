package com.suteam.html.user.web;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.DateUtil;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.PropertiesUtil;
import com.suteam.html.common.util.RandomUtil;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.SHA1Util;
import com.suteam.html.common.util.ShiroUtil;
import com.suteam.html.common.util.sms.EnumSMSTemplate;
import com.suteam.html.common.util.sms.EnumSMSType;
import com.suteam.html.common.util.sms.SMSUtil;
import com.suteam.html.role.model.RelUserRole;
import com.suteam.html.role.model.UserRole;
import com.suteam.html.role.service.RelUserRoleMgr;
import com.suteam.html.role.service.UserRoleMgr;
import com.suteam.html.system.service.SystemConfigMgr;
import com.suteam.html.user.model.IdentifyingCode;
import com.suteam.html.user.model.OrganizationInfo;
import com.suteam.html.user.model.User;
import com.suteam.html.user.model.UserInfo;
import com.suteam.html.user.service.OrganizationInfoMgr;
import com.suteam.html.user.service.UserInfoMgr;
import com.suteam.html.user.service.UserMgr;

@Controller
public class UserAction {
	private static final Logger logger = LoggerFactory.getLogger(UserAction.class);
	@Autowired
	private UserMgr userMgr;
	@Autowired
	private UserRoleMgr userRoleMgr;
	@Autowired
	private RelUserRoleMgr relUserRoleMgr;
	@Autowired
	private UserInfoMgr userInfoMgr;
	@Autowired
	private OrganizationInfoMgr organizationInfoMgr;
	// 发送邮件
	@Autowired
	private SystemConfigMgr systemConfigMgr;
	@Autowired
	private SessionDAO sessionDAO;

	/**
	 * 跳转页面
	 */
	@RequestMapping(value = "/v1/html/manage/userManage/update/auditUserInfo")
	public String auditUserInfo(HttpServletRequest req) {
		String id = req.getParameter("id");
		User user = userMgr.findById(id);
		Integer userType = user.getQualificationType();
		// 用户存在，并且用户的认证类型是个人
		if (null != user && userType == 0) {
			UserInfo userInfo = userInfoMgr.findByUserId(id);
			req.setAttribute("user", user);
			req.setAttribute("userInfo", userInfo);
			return "user/user_msg";
		} else if (null != user && userType == 1) {
			OrganizationInfo oi = organizationInfoMgr.findByUserId(id);
			req.setAttribute("user", user);
			req.setAttribute("oi", oi);
			return "user/user_orgMsg";
		} else {
			return null;
		}
	}

	/**
	 * 启用用户
	 */
	@RequestMapping(value = "/v1/html/manage/userManage/userManage/update/openUser")
	@ResponseBody
	public String openUser(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = req.getParameter("el");
		User user = userMgr.findById(id);
		if (null != user) {
			// 启用用户
			user.setStatus(1);
			userMgr.saveUser(user);
			map.put("result", "ok");
			map.put("values", "认证成功！");
			map.put("errormsg", EnumErrorCode.CODE_000036.msg);// 认证成功！
			map.put("errorcode", EnumErrorCode.CODE_000036.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "禁用失败！");
			map.put("errormsg", EnumErrorCode.CODE_000037.msg);// 认证失败
			map.put("errorcode", EnumErrorCode.CODE_000037.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 关闭用户
	 */
	@RequestMapping(value = "/v1/html/manage/userManage/update/disableUser")
	@ResponseBody
	public String disableUser(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = req.getParameter("el");
		User user = userMgr.findById(id);
		if (null != user) {
			// 启用用户
			user.setStatus(0);
			userMgr.saveUser(user);
			map.put("result", "ok");
			map.put("values", "认证成功！");
			map.put("errormsg", EnumErrorCode.CODE_000036.msg);// 认证成功！
			map.put("errorcode", EnumErrorCode.CODE_000036.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "禁用失败！");
			map.put("errormsg", EnumErrorCode.CODE_000037.msg);// 认证失败
			map.put("errorcode", EnumErrorCode.CODE_000037.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 给用户通过认证
	 */
	@RequestMapping(value = "/v1/html/manage/userManage/update/passAudit")
	@ResponseBody
	public String passAudit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = req.getParameter("el");
		User user = userMgr.findById(id);
		if (null != user) {
			user.setQualificationStatus(2);
			userMgr.saveUser(user);
			map.put("result", "ok");
			map.put("values", "认证成功！");
			map.put("errormsg", EnumErrorCode.CODE_000036.msg);// 认证成功！
			map.put("errorcode", EnumErrorCode.CODE_000036.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			// user.setQualificationStatus(3);
			// userMgr.saveUser(user);
			map.put("result", "error");
			map.put("values", "认证失败！");
			map.put("errormsg", EnumErrorCode.CODE_000037.msg);// 认证失败
			map.put("errorcode", EnumErrorCode.CODE_000037.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	@RequestMapping(value = "/v1/html/manage/userManage/update/refuseAudit")
	@ResponseBody
	public String refuseAudit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = req.getParameter("el");
		String noPassReason = req.getParameter("noPassReason");
		User user = userMgr.findById(id);
		if (null != user) {
			user.setQualificationStatus(3);
			user.setNoPassReason(noPassReason);
			// user.setQualificationType(null);//公司
			user.setApplyTime(null);
			userMgr.saveUser(user);
			// UserInfo表（个人）
			UserInfo ui = userInfoMgr.findByUserId(id);
			ui.setIdCardName(null);
			ui.setDocumentType(null);// 身份证
			ui.setDocumentId(null);
			ui.setIdCardUrl(null);
			ui.setUpdateTime(null);
			userInfoMgr.saveUserInfo(ui);
			// 删除OrganizationInfo表
			OrganizationInfo oi = organizationInfoMgr.findByUserId(user.getId());
			if (oi != null) {
				organizationInfoMgr.deleteByUserId(oi);
			}

			map.put("result", "ok");
			map.put("values", "认证成功！");
			map.put("errormsg", EnumErrorCode.CODE_000036.msg);// 认证成功！
			map.put("errorcode", EnumErrorCode.CODE_000036.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			// user.setQualificationStatus(3);
			// userMgr.saveUser(user);
			map.put("result", "error");
			map.put("values", "认证失败！");
			map.put("errormsg", EnumErrorCode.CODE_000037.msg);// 认证失败
			map.put("errorcode", EnumErrorCode.CODE_000037.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 查找所有的user
	 */
	@RequestMapping(value = "/v1/html/manage/userManage/query/userList")
	public String userList(HttpServletRequest req) {
		List<User> userList = userMgr.findAllUser();
		if (null != userList && userList.size() > 0) {
			req.setAttribute("userList", userList);
		}
		return "user/user_list";
	}

	/**
	 * 校验手机号是否存在 wd
	 */
	@RequestMapping(value = "/v1/anon/user/query/checkPhone")
	@ResponseBody
	public String checkPhone(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String phone = req.getParameter("phone");
		User user = userMgr.findUserByPhone(phone);
		if (null != user) {
			map.put("result", "error");
			map.put("values", "手机号已注册！");
			map.put("errormsg", EnumErrorCode.CODE_000033.msg);// 手机号已注册！
			map.put("errorcode", EnumErrorCode.CODE_000033.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "ok");
			map.put("values", "手机号不存在");
			map.put("errormsg", EnumErrorCode.CODE_000032.msg);// 手机号不存在
			map.put("errorcode", EnumErrorCode.CODE_000032.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 获取手机验证码 wd
	 */
	@RequestMapping(value = "/v1/anon/user/query/getIdCode")
	@ResponseBody
	public String getIdCode(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String phone = req.getParameter("phone");
		User user = null;
		String id = req.getParameter("id");
		String veryCode = req.getParameter("veryCode");
		if ("spanre".equals(id)) {// 当重置密码时，用户名不存在，直接返回，不发送短信
			user = userMgr.findUserByPhone(phone);
			if (null == user) {
				map.put("result", "error");
				map.put("values", "用户不存在!");
				map.put("errormsg", EnumErrorCode.CODE_000028.msg);
				map.put("errorcode", EnumErrorCode.CODE_000028.code);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
		} else if ("spanP".equals(id)) {
			user = userMgr.findUserByPhone(phone);
			if (null != user) {
				map.put("result", "error");
				map.put("values", "此手机号已经注册，请登录或者重置密码！");
				map.put("errormsg", EnumErrorCode.CODE_000029.msg);// 此手机号已经注册，请登录或者重置密码！
				map.put("errorcode", EnumErrorCode.CODE_000029.code);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
		}
		// 否则属于更改手机号发送验证码场景
		else {
			user = userMgr.findUserByPhone(phone);
			if (null != user) {
				map.put("result", "error");
				map.put("values", "此手机号已经注册，请更换手机号！");
				map.put("errormsg", EnumErrorCode.CODE_000047.msg);
				map.put("errorcode", EnumErrorCode.CODE_000047.code);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}
		}

		String validateC = (String) req.getSession().getAttribute("validateCode");
		// 校验图形验证码
		if (null == veryCode || "".equals(veryCode)) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000048.msg);// 验证码不能为空
			map.put("errorcode", EnumErrorCode.CODE_000048.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
		if (!veryCode.equalsIgnoreCase(validateC)) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000008.msg);// 验证码不正确
			map.put("errorcode", EnumErrorCode.CODE_000008.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}

		IdentifyingCode i = SMSUtil.sendSMSVerificationCode(phone, EnumSMSTemplate.CODE_117373.time,
				EnumSMSTemplate.CODE_117373.code, EnumSMSType.CODE_Production.code);
		if (i.getStateCode().equals("000000")) {
			map.put("result", "ok");
			map.put("values", "");
			req.getSession().setAttribute(phone, i.getIdentifyingCode());
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else if (i.getStateCode().endsWith("40")) {
			map.put("result", "error");
			map.put("values", "今日的短信次数达到上限");
			map.put("errormsg", EnumErrorCode.CODE_000030.msg);// 今日的短信次数达到上限
			map.put("errorcode", EnumErrorCode.CODE_000030.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "验证码获取失败");
			map.put("errormsg", EnumErrorCode.CODE_000031.msg);// 验证码获取失败
			map.put("errorcode", EnumErrorCode.CODE_000031.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 用户注册 wd
	 */
	@RequestMapping(value = "/v1/anon/user/create/regUser")
	@ResponseBody
	public String regUser(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String phone = req.getParameter("phone");
		String pwd = req.getParameter("pwd");
		String code = req.getParameter("code");
		String sCode = (String) req.getSession().getAttribute(phone);

		Date date = new Date();
		if (code.equals(sCode)) {
			// 保存User表
			User user = new User();
			user.setUserName(RandomUtil.getRandomCharAndNumr(6).toLowerCase());
			user.setUserNumber(RandomUtil.returnIdentifyingCode());
			user.setPhone(phone);
			user.setPassword(SHA1Util.getSha1(pwd));
			user.setStatus(1);// 使用中
			user.setCreateTime(date);
			user.setRoleType(2);// 普通用户
			user.setQualificationType(0);// 个人
			user.setQualificationStatus(0);// 未认证
			userMgr.saveUser(user);
			String userId = user.getId();
			// 查找权限表中‘普通用户’的角色Id
			UserRole ur = userRoleMgr.findByName("普通用户");
			// 保存rel_user_role表
			RelUserRole rur = new RelUserRole();
			rur.setRoleId(ur.getId());
			rur.setUserId(user.getId());
			relUserRoleMgr.saveRelUserRole(rur);

			// 保存userInfo表
			UserInfo ui = new UserInfo();
			ui.setUserId(userId);
			ui.setPhone(phone);
			ui.setCreateTime(date);
			userInfoMgr.saveUserInfo(ui);
			// 保存成功后，将验证码从session中移出去
			req.getSession().removeAttribute(phone);
			map.put("result", "ok");
			map.put("values", "注册成功!");
			map.put("errormsg", EnumErrorCode.CODE_000034.msg);// 注册成功!
			map.put("errorcode", EnumErrorCode.CODE_000034.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "验证码输入错误");
			map.put("errormsg", EnumErrorCode.CODE_000035.msg);// 验证码输入错误
			map.put("errorcode", EnumErrorCode.CODE_000035.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 登录页面，重置密码 wd
	 */
	@RequestMapping(value = "/v1/anon/user/creat/resetPassword")
	@ResponseBody
	public String resetPassword(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		String phone = req.getParameter("phone");
		String code = req.getParameter("code");

		User user = userMgr.findUserByPhone(phone);
		if (null == user) {
			map.put("result", "error");
			map.put("values", "输入的手机号有误");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
		// 从session中获取验证码
		String sCode = (String) req.getSession().getAttribute(phone);
		if (!code.equals(sCode)) {
			map.put("result", "error");
			map.put("values", "手机验证码输入错误");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
		IdentifyingCode i = SMSUtil.sendSMSInform(phone, EnumSMSTemplate.CODE_116902.code,
				EnumSMSType.CODE_Production.code);
		if ((i.getStateCode()).equals("000000")) {
			String newPwd = i.getIdentifyingCode();
			user.setPassword(SHA1Util.getSha1(newPwd));
			userMgr.saveUser(user);
			// 将session中的验证码移出去
			req.getSession().removeAttribute(phone);
			map.put("result", "ok");
			map.put("values", "密码重置成功，系统已将新密码发送到您的手机上，请及时查收。");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
		}
		return null;
	}

	/**
	 * 跳转修改用户密码页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/passwordSettings/update/toUpdatePassword")
	public String toUpdatePassword(HttpServletRequest req) {
		// 获取当前用户编号
		User user = ShiroUtil.getShiroUser();
		req.setAttribute("user", user);
		return "/user/update_password";
	}

	/**
	 * 修改用户密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/passwordSettings/update/updatePassword")
	@ResponseBody
	public String updatePassword(HttpServletRequest req, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();

		String oldPassword = req.getParameter("oldPassword");
		String newPassword = req.getParameter("newPassword");

		User user = ShiroUtil.getShiroUser();

		if (!user.getPassword().equals(SHA1Util.getSha1(oldPassword))) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000009.msg);// 原密码输入错误
			map.put("errorcode", EnumErrorCode.CODE_000009.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
		user.setPassword(SHA1Util.getSha1(newPassword));
		user.setUpdateTime(new Date());
		userMgr.saveUser(user);
		map.put("result", "ok");
		map.put("values", "");
		map.put("errormsg", EnumErrorCode.CODE_000010.msg);// 密码修改成功
		map.put("errorcode", EnumErrorCode.CODE_000010.code);
		ResponseUtils.renderJson(response, JSON.toJSONString(map));
		return null;
	}

	/**
	 * 根目录访问
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/login/welcome")
	public String welcome(HttpServletRequest request) {
		//return "redirect:/v1/anon/welcome.do";
		return "redirect:/v1/anon/user/login/goLogin.do";
	}

	/**
	 * 跳转登录页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/login/goLogin")
	public String goLogin(HttpServletRequest request) {
		return "/login";
	}

	/**
	 * 验证登录 -1登录成功 0验证码不正确 1 用户未激活 2未知账户 3密码不正确 4账户已锁定 5用户名或密码错误次数过多 6用户名或密码不正确
	 * 7 登录失败 8 用户不存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/query/login")
	@ResponseBody
	public String login(HttpServletRequest request, HttpServletResponse response) {
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String veryCode = request.getParameter("veryCode");

		Map<String, Object> map = new HashMap<String, Object>();
		String validateC = (String) request.getSession().getAttribute("validateCode");
		// 校验验证码
		if (null == veryCode || "".equals(veryCode) || !veryCode.equalsIgnoreCase(validateC)) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000008.msg);// 验证码不正确
			map.put("errorcode", EnumErrorCode.CODE_000008.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
		// 用户名 电话 邮箱
		User user = userMgr.findByUserName(userName);
		if (user == null) {
			user = userMgr.findUserByPhone(userName);
		}
		if (user == null) {
			user = userMgr.findByUemail(userName);
		}
		if (user != null) {
			// 状态 0 禁用（若禁用相关授权都禁用） 1 使用
			if (user.getStatus() == 0) {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000014.msg);// 用户已禁用
				map.put("errorcode", EnumErrorCode.CODE_000014.code);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
		} else {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000004.msg);// 用户不存在
			map.put("errorcode", EnumErrorCode.CODE_000004.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
		UsernamePasswordToken token = new UsernamePasswordToken(userName, SHA1Util.getSha1(password));
		token.setRememberMe(true);
		// 获取当前的Subject
		Subject currentUser = SecurityUtils.getSubject();
		try {
			// 在调用了login方法后,SecurityManager会收到AuthenticationToken,并将其发送给已配置的Realm执行必须的认证检查
			// 每个Realm都能在必要时对提交的AuthenticationTokens作出反应
			// 所以这一步在调用login(token)方法时,它会走到MyRealm.doGetAuthenticationInfo()方法中,具体验证方式详见此方法
			System.out.println("对用户[" + userName + "]进行登录验证..验证开始");
			currentUser.login(token);
			System.out.println("对用户[" + userName + "]进行登录验证..验证通过");
		} catch (UnknownAccountException uae) {
			System.out.println("对用户[" + userName + "]进行登录验证..验证未通过,未知账户");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000015.msg);// 未知账户
			map.put("errorcode", EnumErrorCode.CODE_000015.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (IncorrectCredentialsException ice) {
			System.out.println("对用户[" + userName + "]进行登录验证..验证未通过,错误的凭证");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000005.msg);// 密码不正确
			map.put("errorcode", EnumErrorCode.CODE_000005.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (LockedAccountException lae) {
			System.out.println("对用户[" + userName + "]进行登录验证..验证未通过,账户已锁定");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000016.msg);// 账户已锁定
			map.put("errorcode", EnumErrorCode.CODE_000016.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (ExcessiveAttemptsException eae) {
			System.out.println("对用户[" + userName + "]进行登录验证..验证未通过,错误次数过多");// 用户名或密码错误次数过多
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000017.msg);
			map.put("errorcode", EnumErrorCode.CODE_000017.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (AuthenticationException ae) {
			// 通过处理Shiro的运行时AuthenticationException就可以控制用户登录失败或密码错误时的情景
			System.out.println("对用户[" + userName + "]进行登录验证..验证未通过,堆栈轨迹如下");
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000018.msg);// 用户名或密码不正确
			map.put("errorcode", EnumErrorCode.CODE_000018.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
		// 验证是否登录成功
		if (currentUser.isAuthenticated()) {
			// 获取当前sessionID
			String sessionId = (String) currentUser.getSession().getId();
			// apache shiro获取所有在线用户
			Collection<Session> sessions = sessionDAO.getActiveSessions();
			//用户大于200
			if (sessions.size() > 200) {
				logger.info("当前用户：" + userName + ";当前sessionID：" + sessionId + ";清除sessionID：" +sessionId);
				currentUser.getSession().setTimeout(0); // 这里就把session清除，
				token.clear();
				// 登录失败
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000101.msg);// 登录失败
				map.put("errorcode", EnumErrorCode.CODE_000101.code);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
//			for (Session session : sessions) {
//				String loginUsername = String
//						.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY));// 获得session中已经登录用户的名字
//				if (userName.equals(loginUsername) && !sessionId.equals(session.getId())) { // 这里的username也就是当前登录的username
//					logger.info("当前用户：" + userName + ";当前sessionID：" + sessionId + ";清除sessionID：" + session.getId());
//					session.setTimeout(0); // 这里就把session清除，
//				}
//			}
			String url = "";
			// if ("admin".equals(user.getUserName()) ||
			// "13800000000".equals(user.getPhone()) ||
			// "admin@zsyun.com".equals(user.getEmail())) {
			if (2 == user.getRoleType()) {
				url = "/v1/html/fxhome.do";
			} else {
				url = "/v1/html/user/basicData/query/userInfo.do";
			}
			map.put("result", "ok");
			map.put("values", url);
			map.put("errormsg", EnumErrorCode.CODE_000006.msg);// 登录成功
			map.put("errorcode", EnumErrorCode.CODE_000006.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} else {
			token.clear();
			// 登录失败
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000019.msg);// 登录失败
			map.put("errorcode", EnumErrorCode.CODE_000019.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 登出
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/query/logout")
	public String logout(HttpServletRequest req) {
		return "redirect:/v1/anon/user/login/goLogin.do";
	}

	/**
	 * 登出记录接口
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/query/logoutRecord")
	@ResponseBody
	public String logoutRecord(HttpServletRequest req, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String sessionId = req.getParameter("sessionId");
			String userName = req.getParameter("userName");
			// 获取内存
			ServletContext servletContext = req.getSession().getServletContext();
			servletContext.setAttribute(userName + "Session", sessionId);
			map.put("result", "ok");
			map.put("values", sessionId);
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 页面跳转用户注册
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/register/goRegistUser")
	public String registUser(HttpServletRequest req) {
		return "/register";
	}

	/**
	 * 校验用户名是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/query/checkUserName")
	@ResponseBody
	public String checkUserName(HttpServletRequest req, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String userName = req.getParameter("userName");
			User user = userMgr.findByUserName(userName);
			if (user != null) {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000002.msg);
				map.put("errorcode", EnumErrorCode.CODE_000002.code);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
			map.put("result", "ok");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 发送绑定邮件
	 * 
	 * @author zyz
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/update/sendBoundEmail")
	@ResponseBody
	public String sendBoundEmail(HttpServletRequest req, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			UserInfo userInfo = null;
			User user = ShiroUtil.getShiroUser();
			String email = req.getParameter("email");// 要激活的邮箱
			// 校验邮箱是否被占用，需要去user表中查找
			User u = userMgr.findByUemail(email);
			if (u == null) {
				// userInfo =
				// this.userInfoMgr.getByEmail(email);//根据邮箱查找userInfo
				userInfo = this.userInfoMgr.findByUserId(user.getId());
				String userName = "用户";// 用户姓名
				if (null != userInfo.getName() && (!("").equals(userInfo.getName()))) {
					userName = userInfo.getName();
				}

				userInfo.setEmail(email);
				// 邮箱绑定状态为未绑定
				userInfo.setEmailStartDate(new Date());
				this.userInfoMgr.saveUserInfo(userInfo);

				// 发邮件()
				// 1.发送参选人注册邮件
				Properties properties = PropertiesUtil.getUtilProperty("mail.properties");
				String mailServer = properties.getProperty("mailServer");
				String paramtitle = systemConfigMgr.getValueByName("mail_sender");// 获得邮件系统参数
				String scopeName = systemConfigMgr.getValueByName("scopeName");
				systemConfigMgr.sendBoundEmail(mailServer, paramtitle, userName, email, scopeName);// 发送邮件

				map.put("result", "ok");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000000.msg);
				map.put("errorcode", EnumErrorCode.CODE_000000.code);
			} else {
				map.put("result", "error");
				map.put("values", "此邮箱已被绑定");
				map.put("errormsg", EnumErrorCode.CODE_000046.msg);
				map.put("errorcode", EnumErrorCode.CODE_000046.code);
			}
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			// e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 去绑定邮箱
	 * 
	 * @author zyz
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/update/toBoundEmail")
	public String toBoundEmail(HttpServletRequest req, HttpServletResponse resp) {
		String msg = null;
		String email = req.getParameter("email");
		UserInfo userInfo = this.userInfoMgr.getByEmail(email);
		if (userInfo == null) {
			msg = "绑定邮箱链接已失效！<br>请重新绑定邮箱！";
			req.setAttribute("msg", msg);
			return "/user/user_bandEmail";
		}
		Date startDate = userInfo.getEmailStartDate();
		Long BandTime = DateUtil.getSecond(new Date(), startDate);
		Integer LoserHour = Integer.parseInt(this.systemConfigMgr.getValueByName("mail_life_time"));// 失效时长
		if (BandTime < (LoserHour * 60 * 60L)) {// 校验点击时间
			User user = this.userMgr.findById(userInfo.getUserId());
			// 如果绑定邮箱和用户信息表中邮箱不相等，则失效
			if (!email.equals(userInfo.getEmail())) {
				msg = "绑定邮箱链接已失效！<br>请重新绑定邮箱！";
				req.setAttribute("msg", msg);
				return "/user/user_bandEmail";
			}
			// 否则如果绑定邮箱和用户表中邮箱相等，表明绑定完成，也失效
			else if (email.equals(user.getEmail())) {
				msg = "绑定邮箱链接已失效！<br>请重新绑定邮箱！";
				req.setAttribute("msg", msg);
				return "/user/user_bandEmail";
			} else {
				// 邮箱绑定状态改为已绑定
				user.setEmail(email);
				user.setUpdateTime(new Date());
				this.userMgr.saveUser(user);
				// 替换session中的用户
				// ShiroUtil.setSession("currentUser", user);
				String[] e1 = email.split("@");
				String userNameEmail = e1[0].substring(0, 4) + "***" + e1[1];
				msg = "绑定邮箱成功！<br>您可以用 “" + userNameEmail + "”为登录账号！";
				req.setAttribute("msg", msg);
				return "/user/user_bandEmail";
			}
		} else {
			msg = "绑定邮箱链接已超时！<br>请重新绑定邮箱！";
			req.setAttribute("msg", msg);
			return "/user/user_bandEmail";
		}
	}

	/**
	 * 绑定手机
	 * 
	 * @author zyz
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/update/boundPhone")
	public String boundPhone(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = ShiroUtil.getShiroUser();
			String phone = req.getParameter("phone");
			String code = req.getParameter("code");
			String sCode = (String) req.getSession().getAttribute(phone);

			String veryCode = req.getParameter("veryCode");
			String validateC = (String) req.getSession().getAttribute("validateCode");
			// 校验验证码
			if (null == veryCode || "".equals(veryCode) || !veryCode.equalsIgnoreCase(validateC)) {
				map.put("result", "error");
				map.put("values", "验证码错误");
				map.put("errormsg", EnumErrorCode.CODE_000008.msg);// 验证码不正确
				map.put("errorcode", EnumErrorCode.CODE_000008.code);
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			}

			if (code.equals(sCode)) {// 比较验证码

				User oldUser = this.userMgr.findUserByPhone(phone);
				if (null == oldUser) {// 验证手机号是否被注册过
					UserInfo userInfo = this.userInfoMgr.findByUserId(user.getId());
					// 保存User表
					userInfo.setPhone(phone);
					this.userInfoMgr.saveUserInfo(userInfo);
					// 保存userInfo表
					user.setPhone(phone);
					user.setUpdateTime(new Date());
					this.userMgr.saveUser(user);
					// 保存成功后，将验证码从session中移出去
					req.getSession().removeAttribute(phone);
					// 替换session中的用户
					ShiroUtil.setSession("currentUser", user);
					map.put("result", "ok");
					map.put("values", "");
					map.put("errormsg", EnumErrorCode.CODE_000000.msg);
					map.put("errorcode", EnumErrorCode.CODE_000000.code);
				} else {
					map.put("result", "error");
					map.put("values", "此手机已被绑定");
					map.put("errormsg", EnumErrorCode.CODE_000033.msg);
					map.put("errorcode", EnumErrorCode.CODE_000033.code);
				}
				ResponseUtils.renderJson(resp, JSON.toJSONString(map));
				return null;
			} else {
				map.put("result", "error");
				map.put("values", "验证码输入错误");
				map.put("errormsg", EnumErrorCode.CODE_000035.msg);// 验证码输入错误
				map.put("errorcode", EnumErrorCode.CODE_000035.code);
			}
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			// e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 跳转用户基本信息界面 mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/basicData/query/userInfo")
	public String userInfo(HttpServletRequest req) {
		User user = ShiroUtil.getShiroUser();
		// 获取当前的操作类型
		if (null != user) {
			user = userMgr.findById(user.getId());
			req.setAttribute("user", user);
			UserInfo userInfo = userInfoMgr.findByUserId(user.getId());
			if (userInfo != null) {
				req.setAttribute("userInfo", userInfo);
			}
			return "/user/user_info";
		}
		return "redirect:/v1/anon/user/login/goLogin.do";
	}

	/**
	 * 保存用户基本信息 mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/basicData/update/updateUserInfo")
	@ResponseBody
	public String updateUserInfo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 获取页面的参数
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String area = request.getParameter("area");
		String address = request.getParameter("address");
		String postCode = request.getParameter("postCode");
		String headUrl = request.getParameter("headUrl");
		User user = ShiroUtil.getShiroUser();
		if (null != user) {
			// 保存userinfo表
			UserInfo ui = userInfoMgr.findByUserId(user.getId());
			if (ui == null) {
				ui = new UserInfo();
				ui.setUserId(user.getId());
			}
			ui.setName(name);
			if (null != sex && !"".equals(sex)) {
				ui.setSex(Integer.parseInt(sex));
			}
			ui.setProvince(province);
			ui.setCity(city);
			ui.setArea(area);
			ui.setAddress(address);
			ui.setPostCode(postCode);
			ui.setHeadUrl(headUrl);
			ui.setUpdateTime(new Date());
			userInfoMgr.saveUserInfo(ui);

			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000011.msg);// 提交成功
			map.put("errorcode", EnumErrorCode.CODE_000011.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000012.msg);// 提交失败
			map.put("errorcode", EnumErrorCode.CODE_000012.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 跳转用户信息认证界面 mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/authenticationInfo/update/toUserAudit")
	public String toUserAudit(HttpServletRequest req) {
		// 获取登录用户
		User user2 = ShiroUtil.getShiroUser();
		User user = userMgr.findById(user2.getId());
		req.setAttribute("user", user);
		if (null != user) {
			// 认证状态 0 未认证 1 认证中 2 认证通过 3 认证失败
			if (user.getQualificationStatus() == 1 || user.getQualificationStatus() == 2) {
				// 认证类型 0 个人 1 企业
				if (user.getQualificationType() == 0) {
					UserInfo ui = userInfoMgr.findByUserId(user.getId());
					req.setAttribute("ui", ui);
					return "/application/authentication_perAudit";
				} else {
					OrganizationInfo oi = organizationInfoMgr.findByUserId(user.getId());
					req.setAttribute("oi", oi);
					return "/application/authentication_capAudit";
				}
			}
			// 未审核
			return "/application/authentication_list";
		}
		return "redirect:/v1/anon/user/login/goLogin.do";

	}

	/**
	 * 保存用户认证信息(个人) mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/authenticationInfo/update/createPersonalInfo")
	@ResponseBody
	public String createPersonalInfo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String name = request.getParameter("name");
		String documentId = request.getParameter("documentId");
		String IdCardUrl = request.getParameter("IdCardUrl");

		User user = ShiroUtil.getShiroUser();
		if (null != user) {
			user.setQualificationStatus(1);
			user.setQualificationType(0);
			user.setApplyTime(new Date());
			userMgr.saveUser(user);
			// 保存userinfo表
			UserInfo ui = userInfoMgr.findByUserId(user.getId());
			if (ui == null) {
				ui = new UserInfo();
				ui.setUserId(user.getId());
			}
			ui.setIdCardName(name);
			ui.setDocumentType(0);// 身份证
			ui.setDocumentId(documentId);
			ui.setIdCardUrl(IdCardUrl);
			ui.setUpdateTime(new Date());
			userInfoMgr.saveUserInfo(ui);
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000011.msg);// 提交成功
			map.put("errorcode", EnumErrorCode.CODE_000011.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000012.msg);// 提交失败
			map.put("errorcode", EnumErrorCode.CODE_000012.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 保存用户认证信息(公司) mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/authenticationInfo/update/createCompanyInfo")
	@ResponseBody
	public String createCompanyInfo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String cName = request.getParameter("cName");
		String cAddress = request.getParameter("cAddress");
		String jobType = request.getParameter("jobType");
		String CerType = request.getParameter("CerType");// codeByOne ThreeInOne
															// ThreeSeparation
		// 三证合一(一照一码)
		String regNo01 = request.getParameter("regNo01");
		String regUrl01 = request.getParameter("regUrl01");
		// 三证合一
		String regNo02 = request.getParameter("regNo02");
		String taxNo02 = request.getParameter("taxNo02");
		String regUrl02 = request.getParameter("regUrl02");
		// 三证分离
		String taxNo03 = request.getParameter("taxNo03");
		String taxUrl03 = request.getParameter("taxUrl03");
		String regNo04 = request.getParameter("regNo04");
		String regUrl04 = request.getParameter("regUrl04");

		User user = ShiroUtil.getShiroUser();
		if (null != user) {
			user.setQualificationStatus(1);
			user.setQualificationType(1);// 公司
			user.setApplyTime(new Date());
			userMgr.saveUser(user);
			// 保存OrganizationInfo表
			OrganizationInfo oi = organizationInfoMgr.findByUserId(user.getId());
			if (oi == null) {
				oi = new OrganizationInfo();
				oi.setUserId(user.getId());
			}
			oi.setName(cName);
			oi.setAddress(cAddress);
			if (null != jobType && !"".equals(jobType)) {
				oi.setJobType(Integer.parseInt(jobType));
			}
			if ("codeByOne".equals(CerType)) {// 三证合一(一照一码)
				oi.setDocumentType(0);
				oi.setRegNo(regNo01);
				oi.setRegUrl(regUrl01);
			} else if ("ThreeInOne".equals(CerType)) {// 三证合一
				oi.setDocumentType(1);
				oi.setTaxNo(taxNo02);
				oi.setRegNo(regNo02);
				oi.setRegUrl(regUrl02);
			} else if ("ThreeSeparation".equals(CerType)) {// 三证分离
				oi.setDocumentType(2);
				oi.setTaxNo(taxNo03);
				oi.setTaxUrl(taxUrl03);
				oi.setRegNo(regNo04);
				oi.setRegUrl(regUrl04);
			} else {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000012.msg);// 提交失败
				map.put("errorcode", EnumErrorCode.CODE_000012.code);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
			oi.setUpdateTime(new Date());
			organizationInfoMgr.saveOrganizationInfo(oi);
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000011.msg);// 提交成功
			map.put("errorcode", EnumErrorCode.CODE_000011.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} else {
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000012.msg);// 提交失败
			map.put("errorcode", EnumErrorCode.CODE_000012.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}
	}

	/**
	 * 取消审核 mzl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/html/user/authenticationInfo/delete/deleteAudit")
	@ResponseBody
	public String deleteAudit(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String userId = request.getParameter("userId");
			// user表
			User user = userMgr.findById(userId);
			user.setQualificationStatus(0);
			user.setQualificationType(1);// 公司
			user.setApplyTime(null);
			userMgr.saveUser(user);
			// UserInfo表（个人）
			UserInfo ui = userInfoMgr.findByUserId(userId);
			ui.setIdCardName(null);
			ui.setDocumentType(null);// 身份证
			ui.setDocumentId(null);
			ui.setIdCardUrl(null);
			ui.setUpdateTime(null);
			userInfoMgr.saveUserInfo(ui);
			// 删除OrganizationInfo表
			OrganizationInfo oi = organizationInfoMgr.findByUserId(user.getId());
			if (oi != null) {
				organizationInfoMgr.deleteByUserId(oi);
			}
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	/**
	 * 校验密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/v1/anon/user/query/checkUserPswd")
	@ResponseBody
	public String checkUserPswd(HttpServletRequest req, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String password1 = req.getParameter("password");
			String password = SHA1Util.getSha1(password1);
			// 从shiro里取出对象
			User user = ShiroUtil.getShiroUser();
			if (!password.equals(user.getPassword())) {
				map.put("result", "error");
				map.put("values", "");
				map.put("errormsg", EnumErrorCode.CODE_000001.msg);
				map.put("errorcode", EnumErrorCode.CODE_000001.code);
				ResponseUtils.renderJson(response, JSON.toJSONString(map));
				return null;
			}
			map.put("result", "ok");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000000.msg);
			map.put("errorcode", EnumErrorCode.CODE_000000.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(response, JSON.toJSONString(map));
			return null;
		}

	}

	@RequestMapping(value = "/v1/anon/welcome")
	public String welcome(HttpServletRequest request, HttpServletResponse response) {
		return "/index";
	}

	/**
	 * 用户注册 管理员注册普通用户
	 */
	@RequestMapping(value = "/v1/anon/user/create/regUserAdmin")
	@ResponseBody
	public String regUserAdmin(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String phone = req.getParameter("phone");
			String username = req.getParameter("userName");
			String pwd = req.getParameter("pwd");
			Date date = new Date();
			// 保存User表
			User user = new User();
			user.setUserName(username);
			user.setUserNumber(RandomUtil.returnIdentifyingCode());
			user.setPhone(phone);
			user.setPassword(SHA1Util.getSha1(pwd));
			user.setStatus(1);// 使用中
			user.setCreateTime(date);
			user.setRoleType(2);// 普通用户
			user.setQualificationType(0);// 个人
			user.setQualificationStatus(2);// 认证通过
			userMgr.saveUser(user);
			String userId = user.getId();
			// 查找权限表中‘普通用户’的角色Id
			UserRole ur = userRoleMgr.findByName("普通用户");
			// 保存rel_user_role表
			RelUserRole rur = new RelUserRole();
			rur.setRoleId(ur.getId());
			rur.setUserId(user.getId());
			relUserRoleMgr.saveRelUserRole(rur);
			// 保存userInfo表
			UserInfo ui = new UserInfo();
			ui.setUserId(userId);
			ui.setPhone(phone);
			ui.setCreateTime(date);
			userInfoMgr.saveUserInfo(ui);
			map.put("result", "ok");
			map.put("values", "注册成功!");
			map.put("errormsg", EnumErrorCode.CODE_000034.msg);// 注册成功!
			map.put("errorcode", EnumErrorCode.CODE_000034.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "error");
			map.put("values", "");
			map.put("errormsg", EnumErrorCode.CODE_000001.msg);
			map.put("errorcode", EnumErrorCode.CODE_000001.code);
			ResponseUtils.renderJson(resp, JSON.toJSONString(map));
			return null;
		}
	}

}

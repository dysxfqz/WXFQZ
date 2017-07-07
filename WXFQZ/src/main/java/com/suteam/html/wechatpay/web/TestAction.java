package com.suteam.html.wechatpay.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.ResponseUtils;

@Controller
public class TestAction {
	private Logger log = Logger.getLogger(TestAction.class);

	@RequestMapping(value = "/v1/anon/wechat/getMessage")
	@ResponseBody
	public String test(HttpServletRequest request, HttpServletResponse response) {
		try {
			String signature = request.getParameter("signature");
			String timestamp = request.getParameter("timestamp");
			String nonce = request.getParameter("nonce");
			String echostr = request.getParameter("echostr");

			log.info(signature + "," + timestamp + "," + nonce + "," + echostr);
			ResponseUtils.renderJson(response, echostr);
			return null;
		} catch (Exception e) {
			return null;
		}

	}
}

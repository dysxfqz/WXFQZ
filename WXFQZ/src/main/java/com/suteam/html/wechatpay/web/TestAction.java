package com.suteam.html.wechatpay.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.EnumErrorCode;
import com.suteam.html.common.util.ResponseUtils;

@Controller
public class TestAction {
	
	@RequestMapping(value = "/v1/pay/test/test")
	@ResponseBody
	public String test(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
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
}

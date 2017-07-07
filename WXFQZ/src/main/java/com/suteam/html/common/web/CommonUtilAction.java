package com.suteam.html.common.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.suteam.html.common.util.FileUtils;
import com.suteam.html.common.util.ResponseUtils;
import com.suteam.html.common.util.ShiroUtil;
import com.suteam.html.user.model.User;

@Controller
public class CommonUtilAction {

	/**
	 * 文件(图片)上传异步接口 (path1,path2 代表页面上存储的路径名称, 可以拼接到文件路径前)
	 * 
	 * @author zyz
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/v1/html/common/util/uploadImg")
	public String uploadImg(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 页面接值
		User user = ShiroUtil.getShiroUser();
		String userName =user.getUserName(); // 用户名
		String[] filePath = {};
		String path = FileUtils.filePath(req, filePath);
		// (path1,path2 代表页面上存储的路径名称, 可以拼接到文件路径前)
		Map<String, String> reviceMap = FileUtils.uploadTimeNameFile(req, path, userName, "path1", "path2");
		
		try {
			String file1Name = reviceMap.get("file1");

			String path1 = reviceMap.get("path1");
			String path2 = reviceMap.get("path2");
			// 判断是否上传文件1和2,如果上传就保存路径到数据库中
			
			if (null != file1Name && !"".equals(file1Name)) {
				StringBuilder attchUrlUp1 = new StringBuilder("\\");
				/*
				 * for (int i = 0; i < filePath.length; i++) {
				 * attchUrlUp1.append(filePath[i] + "\\"); }
				 */
				if (null != path1 && !("").equals(path1)) {
					attchUrlUp1.append(path1 + "\\");
				}
				if (null != path2 && !("").equals(path2)) {
					attchUrlUp1.append(path2 + "\\");
				}
				attchUrlUp1.append(userName + "\\");
				attchUrlUp1.append(file1Name);
				map.put("attchUrlUp1", attchUrlUp1.toString());
			}
			System.out.println("休眠开始");
//			Thread.sleep(30000);
			System.out.println("休眠结束");
			map.put("result", "ok");
			map.put("values", "Saved Successfully");
			map.put("errormsg", "");
			map.put("errorcode", "");
			
			ResponseUtils.renderJsonAjax(resp, JSON.toJSONString(map));
			return null;
		} catch (Exception e) {
			map.put("result", "error");
			map.put("values", "Save failed submission information!");
			map.put("errormsg", "");
			map.put("errorcode", "");
			ResponseUtils.renderJsonAjax(resp, JSON.toJSONString(map));
			return null;
		}
	}



}

package com.suteam.html.common.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

/**
 * 读取配置文件
 * 
 * @author mzl
 * @version 20160617
 */

public class PropertiesUtil {
	public static Properties getUtilProperty(String propertiesName) {
		try {
			InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(propertiesName);
			BufferedReader bf;
			bf = new BufferedReader(new InputStreamReader(in, "utf-8"));
			Properties properties = new Properties();
			properties.load(bf);
			return properties;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 读取文件
	 * 
	 * @param propertiesName
	 * @return
	 */
	public static Properties getFileProperty(String path) {
		FileInputStream fis = null; // 读
		Properties pp;
		try {
			pp = new Properties();
			fis = new FileInputStream(path);
			pp.load(fis);
			return pp;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

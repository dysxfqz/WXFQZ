package com.suteam.html.common.util;

import java.io.InputStream;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

/**
 * velocity助手类
 * @company suteam
 * @author lxx
 * @since Jun 24, 2011
 * @version 1.0
 */
public class VelocityHelper {
	
	private static Properties props = new Properties();
	private static VelocityEngine engine = null;
	//初始化并取得Velocity引擎
	private Template template = null;
	private VelocityContext context = null;
	
	static {
		try {
			InputStream is = Thread.currentThread().getContextClassLoader()
								.getResourceAsStream("velocity.properties");
			props.load(is);
			engine = new VelocityEngine(props);
		} catch (Exception e) {
			throw new RuntimeException("velocity配置文件读取错误!", e);
		}
		
	}
	
	private VelocityHelper() {}
	
	public static VelocityHelper getInstance(String filePath) {
		try {
			VelocityHelper velocity = new VelocityHelper();
			velocity.setTemplate(engine.getTemplate(filePath));
			velocity.initContext();
			return velocity;
		} catch (Exception e) {
			throw new RuntimeException("模板文件读取失败!", e);
		}
	}
	
	private void initContext() {
		context = new VelocityContext();
		//初始化日期输出格式
		context.put("dateFormat", new SimpleDateFormat(props.getProperty("dateFormat")));
	}

	public void put(String key, Object value) {
		context.put(key, value);
	}

	public String getResult() {
		try {
			StringWriter writer = new StringWriter();
			template.merge(context, writer);
			return writer.toString();
		} catch (Exception e) {
			throw new RuntimeException("模板文件初始化失败!", e);
		}
	}

	/**
	 * 设置日期格式
	 * @param string
	 */
	public void setDateFormat(String string) {
		context.put("dateFormat", new SimpleDateFormat(string));
	}

	public static void setProps(Properties props) {
		VelocityHelper.props = props;
	}

	public void setTemplate(Template template) {
		this.template = template;
	}

	public void setContext(VelocityContext context) {
		this.context = context;
	}
}

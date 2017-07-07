package com.suteam.html.common.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 反射工具类
 * 
 * @author fqz
 *
 */
public class ReflectUtil {
	private static final Log logger = LogFactory.getLog(ReflectUtil.class);

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Object getFieldValue(Object target, String fname) {
		if (target == null || fname == null || "".equals(fname)) {
			return null;
		}
		Class clazz = target.getClass();
		try { // 先通过getXxx()方法获取类属性值
			String methodname = "get" + Character.toUpperCase(fname.charAt(0)) + fname.substring(1);
			Method method = clazz.getDeclaredMethod(methodname); // 获取定义的方法
			if (!Modifier.isPublic(method.getModifiers())) { // 设置非共有方法权限
				method.setAccessible(true);
			}
			return method.invoke(target); // 方法回调，返回值
		} catch (Exception me) {// 如果get方法不存在，则直接获取类属性值
			if (logger.isDebugEnabled()) {
				logger.debug(me);
			}
			try {
				Field field = clazz.getDeclaredField(fname); // 获取定义的类属性
				if (!Modifier.isPublic(field.getModifiers())) { // 设置非共有类属性权限
					field.setAccessible(true);
				}
				return field.get(target);// 返回类属性值
			} catch (Exception fe) {
				if (logger.isDebugEnabled()) {
					logger.debug(fe);
				}
			}
		}
		return null;
	}
}
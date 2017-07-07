package com.suteam.html.common.util;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * EHCaChe工具类
 * 
 * @author fqz
 *
 */
public class EHCaCheUtil {
	/**
	 * 根据缓存池名称及key获取缓存数据
	 * 
	 * @param cacheName
	 *            缓存池名称
	 * @param cacheKey
	 *            缓存key
	 * @return
	 */
	public static Object getCache(String cacheName, String cacheKey) {
		try {
			CacheManager cacheManager = CacheManager.create();
			Cache cache = cacheManager.getCache(cacheName);
			Element element = cache.get(cacheKey);
			if (element != null) {
				return element.getValue();
			}

		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * 根据缓存池名称及key添加缓存数据
	 * 
	 * @param cacheName
	 *            缓存池名称
	 * @param cacheKey
	 *            缓存key
	 * @param object
	 *            缓存数据
	 */
	public static void putCache(String cacheName, String cacheKey, Object object) {
		try {
			CacheManager cacheManager = CacheManager.create();
			Cache cache = cacheManager.getCache(cacheName);
			cache.put(new Element(cacheKey, object));
		} catch (Exception e) {
		}
	}

	/**
	 * 根据缓存池名称及key清空缓存数据
	 * 
	 * @param cacheName
	 *            缓存池名称
	 * @param cacheKey
	 *            缓存key
	 */
	public static void removeCache(String cacheName, String cacheKey) {
		try {
			CacheManager cacheManager = CacheManager.create();
			Cache cache = cacheManager.getCache(cacheName);
			cache.remove(cacheKey);
		} catch (Exception e) {
		}
	}
}

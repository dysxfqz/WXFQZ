package com.suteam.html.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

/**
 * 解析eia json字符串工具类
 * 
 * @author mzl
 * @version 20161117
 */
public class ESJsonUtils {
	/**
	 * 根据es返回数据 提取对象集合
	 * 
	 * @param es返回信息
	 * @version 20161117
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> getEIAJsonObj(String esResult) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Map<String, Object> mapResult = (Map<String, Object>) JSON.parse(esResult);
			String hits = String.valueOf(mapResult.get("hits"));
			Map<String, Object> mapResult2 = (Map<String, Object>) JSON.parse(hits);
			String hits2 = String.valueOf(mapResult2.get("hits"));
			List<Object> hitsList = JSONArray.parseArray(hits2, Object.class);
			String total = String.valueOf(mapResult2.get("total"));
			map.put("hits", hitsList);
			map.put("total", total);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据es_map返回数据 提取列集合
	 * 
	 * @param es返回信息
	 * @version 20161229
	 */
	@SuppressWarnings("unchecked")
	public static List<String> getEsMapCol(String esResult) {
		List<String> colList = new ArrayList<String>();
		try {
			// 解析请求
			Map<String, Object> mapResult = (Map<String, Object>) JSON.parse(esResult);
			Iterator indexNameIt = mapResult.entrySet().iterator();
			while (indexNameIt.hasNext()) {
				Entry indexNameEntry = (Entry) indexNameIt.next();
				String index = String.valueOf(indexNameEntry.getValue());
				Map<String, Object> mapResult2 = (Map<String, Object>) JSON.parse(index);
				Map<String, Object> mapResult3 = (Map<String, Object>) JSON
						.parse(String.valueOf(mapResult2.get("mappings")));
				Iterator it = mapResult3.entrySet().iterator();
				while (it.hasNext()) {
					Entry entry = (Entry) it.next();
					String type = (String) entry.getKey();
					Map<String, Object> mapResult4 = (Map<String, Object>) JSON
							.parse(String.valueOf(mapResult3.get(type)));
					Map<String, Object> mapResult5 = (Map<String, Object>) JSON
							.parse(String.valueOf(mapResult4.get("properties")));
					Iterator it5 = mapResult5.entrySet().iterator();
					while (it5.hasNext()) {
						Entry entry5 = (Entry) it5.next();
						colList.add((String) entry5.getKey());
					}
				}
			}
			return colList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据es_map返回数据 提取map集合 mapSend.put("index_type", ); mapSend.put("colName",
	 * ); mapSend.put("data_type",);
	 * 
	 * @param es返回信息
	 * @version 20170111 mzl
	 */
	@SuppressWarnings("unchecked")
	public static List<Object> getIndexColObj(String esResult) {
		List<Object> colList = new ArrayList<Object>();
		try {
			// 解析请求
			Map<String, Object> mapResult = (Map<String, Object>) JSON.parse(esResult);
			Iterator indexNameIt = mapResult.entrySet().iterator();
			while (indexNameIt.hasNext()) {
				Entry indexNameEntry = (Entry) indexNameIt.next();
				String index = String.valueOf(indexNameEntry.getValue());
				Map<String, Object> mapResult2 = (Map<String, Object>) JSON.parse(index);
				Map<String, Object> mapResult3 = (Map<String, Object>) JSON
						.parse(String.valueOf(mapResult2.get("mappings")));
				Iterator it = mapResult3.entrySet().iterator();
				while (it.hasNext()) {
					Entry entry = (Entry) it.next();
					String type = (String) entry.getKey();
					Map<String, Object> mapResult4 = (Map<String, Object>) JSON
							.parse(String.valueOf(mapResult3.get(type)));
					Map<String, Object> mapResult5 = (Map<String, Object>) JSON
							.parse(String.valueOf(mapResult4.get("properties")));
					Iterator it5 = mapResult5.entrySet().iterator();
					while (it5.hasNext()) {
						Entry entry5 = (Entry) it5.next();
						Map<String, Object> mapResult6 = (Map<String, Object>) entry5.getValue();

						Map<String, Object> mapSend = new HashMap<String, Object>();
						mapSend.put("index_type", type);
						mapSend.put("col_name", entry5.getKey());
						mapSend.put("data_type", mapResult6.get("type"));
						colList.add(mapSend);
					}
				}
			}
			return colList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

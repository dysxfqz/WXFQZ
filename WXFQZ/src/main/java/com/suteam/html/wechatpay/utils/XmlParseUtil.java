package com.suteam.html.wechatpay.utils;

import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;



/**
 * 通用工具类
 * 
 * @author mzl
 * @date 160719
 */
public class XmlParseUtil {

	/**
	 * description: 解析微信通知xml
	 * 
	 * @param xml
	 * @return
	 * @author 
	 * @see
	 */
	@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
	public static Map parseXmlToList2(String xml) {
		Map retMap = new HashMap();
		try {
			StringReader read = new StringReader(xml);
			// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
			InputSource source = new InputSource(read);
			// 创建一个新的SAXBuilder
			SAXBuilder sb = new SAXBuilder();
			// 通过输入源构造一个Document
			Document doc = (Document) sb.build(source);
			Element root = doc.getRootElement();// 指向根节点
			List<Element> es = root.getChildren();
			if (es != null && es.size() != 0) {
				for (Element element : es) {
					retMap.put(element.getName(), element.getValue());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}
	
	
	/**
	 * description: 解析支付宝通知xml
	 * 
	 * @param xml
	 * @return
	 * @author 
	 * @see
	 */
	@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
	public static Map parseXmlToList(String xml) {
		Map retMap = new HashMap();
		try {
			StringReader read = new StringReader(xml);
			// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
			InputSource source = new InputSource(read);
			// 创建一个新的SAXBuilder
			SAXBuilder sb = new SAXBuilder();
			// 通过输入源构造一个Document
			Document doc = (Document) sb.build(source);
			Element root = doc.getRootElement();// 指向根节点
			
			List<Element> es0 = root.getChildren("response");
		
			Element root0 = es0.get(0);// 指向子节点
			
			List<Element> es1 = root0.getChildren();
			
			Element root1 = es1.get(0);// 指向子节点
			
			List<Element> es = root1.getChildren();
			
			if (es != null && es.size() != 0) {
				for (Element element : es) {
					retMap.put(element.getName(), element.getValue());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}
}
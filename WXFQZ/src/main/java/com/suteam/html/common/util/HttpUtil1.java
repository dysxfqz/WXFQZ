package com.suteam.html.common.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;



public class HttpUtil1 {
	public static String httpRequest(String url, List list) {
		HttpClient client = new DefaultHttpClient();
		client.getParams().setParameter(CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
		HttpPost httpPost = new HttpPost(url);
		HttpEntity httpEntity;
		String out = null;
		try {
			httpEntity = new UrlEncodedFormEntity(list, HTTP.UTF_8);
			httpPost.setEntity(httpEntity);
			// if(text!=null){
			// InputStream in=new ByteArrayInputStream(text.getBytes());
			// HttpEntity https = new InputStreamEntity(in,text.length());
			// httpPost.setEntity(https);
			// }
			HttpResponse httpResponse;
			httpResponse = client.execute(httpPost);
			HttpEntity httpEntitys = httpResponse.getEntity();
			out = EntityUtils.toString(httpEntitys);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return out;

	}

	public static String[] params(String domain, String action, Map<String, String> map) {
		// url
		String url = domain + "/" + action;
		String ACT_NAME = action;
		// 时间戳
		Date date = new Date();
		String TIMESTAMP = date.getTime() / 1000 + "";
		String s = action + TIMESTAMP + "huazhiyouapp";
		// 签名
		String sign = MD5Util.GetMD5Code(s);
		NameValuePair param1 = new BasicNameValuePair("ACT_NAME", ACT_NAME);
		NameValuePair param2 = new BasicNameValuePair("TIMESTAMP", TIMESTAMP);
		NameValuePair param3 = new BasicNameValuePair("SIGN", sign);
		List list = new ArrayList();
		list.add(param1);
		list.add(param2);
		list.add(param3);
		if (map != null) {
			Set set = map.entrySet();
			Iterator it = set.iterator();
			while (it.hasNext()) {
				Entry entry = (Entry) it.next();
				String key = (String) entry.getKey();
				String value = (String) entry.getValue();
				NameValuePair param = new BasicNameValuePair(key, value);
				list.add(param);
			}
		}
		String str = httpRequest(url, list);
		// System.out.println(str);
		String string = parseXml(str);
		// 数组
		String string1 = string.replace("|", "#");
		String[] strings = string1.split("#");

		return strings;
	}

	// public static void main(String[] args) {
	// String url="http://59.151.39.72/Aupres_WebService.asmx";
	// String action="AupresUserLogin_type";
	// Map<String, String> map=new HashMap<String,String>();
	// map.put("Username", "test162");
	// map.put("Password", "123456");
	// map.put("logtype", "2");
	// String[] string=params(url,action,map);
	// System.out.println(string);
	// }

	/**
	 * 携带传输流http
	 * 
	 * @param url
	 * @param list
	 * @param text
	 * @return
	 */
	public static String httpRequestStream(String url, List list, String text) {
		HttpClient client = new DefaultHttpClient();
		client.getParams().setParameter(CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
		HttpPost httpPost = new HttpPost(url);
		HttpEntity httpEntity;
		String out = null;
		try {
			// httpEntity = new UrlEncodedFormEntity(list);
			// httpPost.setEntity(httpEntity);
			if (text != null) {
				// String str = new String(text.getBytes("ISO-8859-1"),"utf-8");
				InputStream in = new ByteArrayInputStream(text.getBytes("utf-8"));
				HttpEntity https = new InputStreamEntity(in, text.getBytes("utf-8").length);
				httpPost.setEntity(https);
			}
			HttpResponse httpResponse;
			httpResponse = client.execute(httpPost);
			HttpEntity httpEntitys = httpResponse.getEntity();
			out = EntityUtils.toString(httpEntitys);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return out;

	}

	/**
	 * 读取文件为一个内存字符串
	 * 
	 * @param inputStream
	 * @return
	 */
	public static String fileToString(InputStream inputStream) {
		StringBuffer sb = new StringBuffer();

		LineNumberReader reader = null;
		try {
			reader = new LineNumberReader(new BufferedReader(new InputStreamReader(inputStream, "utf-8")));
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return sb.toString();
	}

	/**
	 * 解析xml 得到数据
	 * 
	 * @param s
	 * @return
	 */
	public static String parseXml(String s) {
		SAXBuilder sb = new SAXBuilder();
		StringReader read = new StringReader(s);
		InputSource is = new InputSource(read);
		Document doc;
		String string = "";
		try {
			doc = sb.build(is);
			Element root = doc.getRootElement();
			string = root.getText();
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return string;
	}

	//static long j=13000000001L;
	
	public static void main(String[] args) {
		ExecutorService exec = Executors.newCachedThreadPool();
		Runnable run = new Runnable() {
			public synchronized void run() {
				String url = "http://" + "192.168.0.11:8080" + "/UCenter/v1/anon/user/query/findAllUser.do";
				//NameValuePair param1 = new BasicNameValuePair("phone", ""+j	);
			//	NameValuePair param2 = new BasicNameValuePair("password", "111111");
				//System.out.println(j);
				List list = new ArrayList();
				//list.add(param1);
				//list.add(param2);
				String str=HttpUtil1.httpRequest(url, list);
				System.out.println(str);
				//j++;
			}
		};

		for (int i = 0; i < 20000; i++) {
			exec.execute(run);
			System.out.println(i + "++++" + new Date().getTime());
		}
	}
}

package com.suteam.html.common.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.UnsupportedEncodingException;
import java.util.List;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

public class HttpUtil {
  public static String httpRequest(String url, List list) {
    HttpClient client = new DefaultHttpClient();
    client.getParams().setParameter(CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
    HttpPost httpPost = new HttpPost(url);
    HttpEntity httpEntity;
    String out = null;
    try {
      httpEntity = new UrlEncodedFormEntity(list, HTTP.UTF_8);
      httpPost.setEntity(httpEntity);
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
      if (text != null) {
        InputStream in = new ByteArrayInputStream(text.getBytes());
        HttpEntity https = new InputStreamEntity(in, text.length());
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
      reader = new LineNumberReader(
          new BufferedReader(new InputStreamReader(inputStream, "utf-8")));
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
   * 把输入流转化成字符串
   * 
   * @param is
   * @return
   */
  public static String convertStreamToString(InputStream is) {
    BufferedReader reader;
    StringBuilder sb = new StringBuilder();

    String line = null;
    try {
      reader = new BufferedReader(new InputStreamReader(is,"utf-8"));
      while ((line = reader.readLine()) != null) {
        sb.append(line + "\n");
      }
    } catch (UnsupportedEncodingException e1) {
      e1.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }finally {
      try {
        is.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
    return sb.toString();
  }
}
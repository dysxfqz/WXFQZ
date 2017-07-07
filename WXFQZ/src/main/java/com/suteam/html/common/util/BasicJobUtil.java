package com.suteam.html.common.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.hyperic.sigar.CpuInfo;
import org.hyperic.sigar.NetInterfaceConfig;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;

/**
 * agent校验hash任务
 * 
 * @author zsyun_gsa
 *
 */
public class BasicJobUtil {

	public static String executeTask(String requsetPath) {
		try {

			// 获取所有拼接后的mac地址
//			String macAddress = getmac();
			String macAddress = getNetIfList( requsetPath);
			
			// 读取config配置文件
			String key = "zsyun";
			
			// 获取CPU信息
			String cpuStr = getCpuInfo( requsetPath);
			
			// 将mac、计算机名、key做hash加密
			String hash = MD5Util.GetMD5Code(macAddress + key + cpuStr);
			return hash;

		} catch (Exception e) {
			return "";
		}
	}



	/**
	 * 修改配置文件hash值
	 * 
	 * @param fileName
	 * @param hash
	 */
	public static void writeConfig(String fileName, String hash) {
		try {
			// 将hash写入配置文件中
			FileInputStream fis = null;
			OutputStream fos;
			Properties pp;
			pp = new Properties();
			fis = new FileInputStream(fileName);
			pp.load(fis);
			fos = new FileOutputStream(fileName);// 加载读取文件流
			// 将agentUuid与userId写入ini文件
			pp.setProperty("hash", hash);
			pp.store(fos, null);
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取mac
	 * @return
	 */
	public static String getmac() {
		String command = "/bin/sh -c ifconfig -a";
		StringBuffer macStr = new StringBuffer();
		String address = "";
		Process p;
		try {
			p = Runtime.getRuntime().exec(command);
			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;
			while ((line = br.readLine()) != null) {
				if (line.indexOf("HWaddr") > 0 && line.contains("eth")) {
					int index = line.indexOf("HWaddr") + "HWaddr".length();
					address = line.substring(index);
					macStr.append(address);
				}
				if (line.indexOf("ether") > 0 ) {
					int index = line.indexOf("ether")+"ether".length()+1;
					address = line.substring(index,index+17);
					macStr.append(address);
				}
			}
			br.close();
		} catch (IOException e) {
		}
		return macStr.toString();
	}
	
	/***
	 * CPU的基本信息
	 * 
	 * @return
	 */
	public static String getCpuInfo(String requsetPath) {
		String cpuStr = "";
		CpuInfo[] infos;
		try {
			Sigar sigar = SigarUtils.initSigar(requsetPath);
			infos = sigar.getCpuInfoList();
			// CPU厂商：
			String vendor = infos[0].getVendor();
			cpuStr = cpuStr+vendor;
			// CPU型号：
			String model = infos[0].getModel();
			cpuStr = cpuStr+model;
		} catch (SigarException e) {
			e.printStackTrace();
		}
		return cpuStr;
	}
	
	/***
	 * 获取网络流量,网卡等信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getNetIfList(String requsetPath) throws Exception {
		StringBuffer strBuffer = new StringBuffer();
		Sigar sigar = SigarUtils.initSigar(requsetPath);
		List<String> list = new ArrayList<String>();
		String[] ifNames = sigar.getNetInterfaceList();
		for (int i = 0; i < ifNames.length; i++) {
			String name = ifNames[i];
			if(name.contains("eth")){
				list.add(name);
			}
		}
		for (int i = 0; i < list.size(); i++) {
			String name = (String) list.get(i);
			// 如果网卡名不包含virbro，不包含网桥名称，并且不包含回环地址，则为物理机网卡信息
			NetInterfaceConfig ifconfig = sigar.getNetInterfaceConfig(name);
			strBuffer.append(ifconfig.getHwaddr());
		}
		return strBuffer.toString();
	} 
}

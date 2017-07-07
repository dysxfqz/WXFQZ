package com.suteam.html.common.dao;

import java.util.Random;

import org.apache.commons.lang.RandomStringUtils;
import java.math.BigDecimal;
/**
 * @company suteam
 * @author liubin
 * @since Apr 16, 2011
 * @version 1.0
 */
public class RandomUtils {

	private RandomUtils() {}

	/**
	 * 生成随机整数
	 * @return
	 */
	public static int nextInt() {
		Random random = new Random();
		return random.nextInt();
	}
	
	/**
	 * 生成随机浮点数
	 * @return
	 */
	public static double nextDouble() {
		Random random = new Random();
		return random.nextDouble();
	}
	
	/**
	 * 生成小于num的随机整数
	 * @param num
	 * @return
	 */
	public static int nextInt(int num) {
		Random random = new Random();
		return random.nextInt(num);
	}
	
	/**
	 * 生成小于num的随机浮点数
	 * @param num
	 * @return
	 */
	public static double nextDouble(double num) {
		Random random = new Random();
		//return random.nextDouble() * num;
		return BigDecimal.valueOf(random.nextDouble()).multiply(BigDecimal.valueOf(num)).doubleValue();
	}

	
	/**
	 * 生成随机字符串
	 * @param count 字符串长度
	 * @return
	 */
	public static String randomString(int count) {
		return RandomStringUtils.randomAlphanumeric(count);
	}
	
	/**
	 * 生成随机的mac地址
	 */
	public static String randomMac() {
		String mac = Integer.toHexString((int)(Math.random()*16777215)); 
		if(mac.length() < 6){
			int macLength = mac.length();
			for(int i=0; i< 6-macLength; i++){
				mac = "0" + mac;
			}
		}
		else {
			mac=mac.substring(0,6);
		}
		String macAddress = "";
		for(int i=0;i<mac.length();i=i+2){
		   String tmp=mac.substring(i,i+2);
		   macAddress += tmp + ":";
		}
		macAddress = "00:16:3e:" + macAddress.substring(0, macAddress.length()-1);
		return macAddress;
	}
}

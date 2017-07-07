package com.suteam.html.common.util;

import java.util.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RandomUtil {
	public static String getRandomCharAndNumr(Integer length) {  
	    String str = "";  
	    Random random = new Random();  
	    for (int i = 0; i < length; i++) {  
	        boolean b = random.nextBoolean();  
	        if (b) { // 字符串  
	            // int choice = random.nextBoolean() ? 65 : 97; 取得65大写字母还是97小写字母  
	            str += (char) (65 + random.nextInt(26));// 取得大写字母  
	        } else { // 数字  
	            str += String.valueOf(random.nextInt(10));  
	        }  
	    }  
	    return str;  
	}  
	
	/**
	 * 随机生成特定位数的数字
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandom(Integer length) {
		String str = "";
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			// 数字
			str += String.valueOf(random.nextInt(10));
		}
		return str;
	}
	
	/**
	 * 随机生成特定位数的字符串
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandomKey(Integer length) {
		String str = "";
		//如果长度大于17，补位随机数字
		if(length>=17){
			String dateStr=DateUtil.formatDatetimeStr(new Date());
			str=str+dateStr+getRandom(length-17) ;
		}
		//否则，全部随机字符+数字
		else{
			str=getRandomCharAndNumr(length);
		}
		return str;
	}
	
	/**
	 * 随机生成8位数字验证码
	 */
	public static String returnIdentifyingCode() {
		StringBuffer sb = new StringBuffer();
		// 生成6位数字验证码 每位 0-9
		Random random = new Random();
		int count = 0;
		while (true) {
			if (count == 8) {
				break;
			}
			int s = random.nextInt(9) % (9 - 0 + 1) + 0;
			sb.append(s);
			count++;
		}
		return sb.toString();
	}
	
	
	
	
	
	
	
	
	
	/** 
	 * 验证随机字母数字组合是否纯数字与纯字母 
	 *  
	 * @param str 
	 * @return true 是 ， false 否 
	 */  
	public static boolean isRandomUsable(String str) {  
	    // String regExp =  
	    // "^[A-Za-z]+(([0-9]+[A-Za-z0-9]+)|([A-Za-z0-9]+[0-9]+))|[0-9]+(([A-Za-z]+[A-Za-z0-9]+)|([A-Za-z0-9]+[A-Za-z]+))$";  
	    String regExp = "^([0-9]+)|([A-Za-z]+)$";  
	    Pattern pat = Pattern.compile(regExp);  
	    Matcher mat = pat.matcher(str);  
	    return mat.matches();  
	}  
	
	public static void main(String[] args) {
		System.out.println(getRandomCharAndNumr(12));
	}

}

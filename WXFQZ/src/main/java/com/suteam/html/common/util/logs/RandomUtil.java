package com.suteam.html.common.util.logs;

import java.util.Date;
import java.util.Random;

/**
 * 字符串随机生成工具类
 * 
 * @author zsyun_Fangqingzhu
 *
 */
public class RandomUtil {
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
	 * 随机生成特定位数的字符+数字
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandomCharAndNumr(Integer length) {
		String str = "";
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			boolean b = random.nextBoolean();
			if (b) { // 字符串
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
	public static void main(String[] args) {
		System.out.println(getRandomKey(20) );
	}
	
	
	/**
	 * 随机生成数字验证码
	 */
	public static String returnIdentifyingCode(int num) {
		StringBuffer sb = new StringBuffer();
		// 生成6位数字验证码 每位 0-9
		Random random = new Random();
		int count = 0;
		while (true) {
			if (count == num) {
				break;
			}
			int s = random.nextInt(9) % (9 - 0 + 1) + 0;
			sb.append(s);
			count++;
		}
		return sb.toString();
	}
	
}

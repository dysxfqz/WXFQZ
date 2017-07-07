package com.suteam.html.common.util;

import java.security.MessageDigest;

public class SHA1Util {
	public static String getSha1(String str) {
		if (str == null || str.length() == 0) {
			return null;
		}
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		String key = "zsyun";
		String c = "";
		int num = 3;
		char a[], b[];
		a = key.toCharArray();
		b = str.toCharArray();
		int m = 0;
		for (int i = 0; i < a.length; i++) {
			if (m <= b.length-1) {
				if (i % num == 0 && i != 0) {
					c += (String.valueOf(b[m]) + String.valueOf(a[i]));
					m++;
				} else {
					c += String.valueOf(a[i]);
				}
			}
		}
		if (b.length >= (a.length / num)) {
			c += str.substring(m, str.length());
		}
		try {
			MessageDigest mdTemp = MessageDigest.getInstance("SHA1");
			mdTemp.update(c.getBytes("UTF-8"));

			byte[] md = mdTemp.digest();
			int j = md.length;
			char buf[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				buf[k++] = hexDigits[byte0 >>> 4 & 0xf];
				buf[k++] = hexDigits[byte0 & 0xf];
			}

			return new String(buf);
		} catch (Exception e) {
			return null;
		}
	}
}

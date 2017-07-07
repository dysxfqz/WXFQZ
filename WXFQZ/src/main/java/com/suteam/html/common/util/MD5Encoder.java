package com.suteam.html.common.util;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5加密
 * @Class Name MD5Encoder
 * @Author anting
 * @Create In Mar 17, 2011
 */
public class MD5Encoder {

private static final char[] HEX = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	
	public static final String encode(String source){
		try {
            byte[] sourceBytes = source.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(sourceBytes);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                str[k++] = HEX[md[i] >>> 4 & 0xf];
                str[k++] = HEX[md[i] & 0xf];
            }
            return new String(str);
        }
        catch (Exception e) {
            return null;
        }
	}
	
	public static  byte[] getPasswordMd5Hash(String pw) {
		MessageDigest hash = getDigest("MD5");
		return hash.digest(pw.getBytes());
	}
	
	public static MessageDigest getDigest(String algorithm) {
		try {
			return MessageDigest.getInstance(algorithm);
		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
			return null;
		}
	}
	
	public static String encodeToBase64(byte[] ori) {
		return encodeToBase64(ori);
	}
}

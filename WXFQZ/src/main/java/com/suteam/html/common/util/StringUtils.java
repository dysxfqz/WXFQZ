package com.suteam.html.common.util;


public class StringUtils {
	public static boolean isEmpty(String str){
		if(null == str || "".equals(str.trim())){
			return true;
		}
		return false;
	}
	
	public static String join(String separator, String... array) {
		StringBuffer result = new StringBuffer();
		if (array != null && array.length > 0) {
			for (int i=0; i<array.length; i++) {
				if (i > 0) {
					if (separator != null) 
						result.append(separator);
				}
				result.append(array[i]);
			}
		}
		return result.toString();
	}
	
	public static String concate(String... array) {
		return join((String)null, array);
	}
	
	public static <T> String join(StringGetter<T> getter, String separator, T... array) {
		StringBuffer result = new StringBuffer();
		if (array != null && array.length > 0) {
			for (int i=0; i<array.length; i++) {
				if (i > 0) {
					if (separator != null) 
						result.append(separator);
				}
				result.append(getter.get(array[i]));
			}
		}
		return result.toString();
	}
	
	public static <T> String concate(StringGetter<T> getter, T... array) {
		return join(getter, null, array);
	}
	
	public static interface StringGetter<T>{
		public String get(T t);
	}
}

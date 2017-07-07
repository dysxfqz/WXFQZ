package com.suteam.html.common.util.logs;

public class StringUtils {
	public static boolean isEmpty(String str) {
		if (null == str || "".equals(str.trim())) {
			return true;
		}
		return false;
	}

	public static String join(String separator, String... array) {
		StringBuffer result = new StringBuffer();
		if (array != null && array.length > 0) {
			for (int i = 0; i < array.length; i++) {
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
		return join((String) null, array);
	}

	public static <T> String join(StringGetter<T> getter, String separator, T... array) {
		StringBuffer result = new StringBuffer();
		if (array != null && array.length > 0) {
			for (int i = 0; i < array.length; i++) {
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

	public static interface StringGetter<T> {
		public String get(T t);
	}

	private static int splitGear(int i, int sum) {
		// sum 每当总条数
		// i 每档数量
		int temp = 0;
		temp = (sum % i) == 0 ? (sum / i) : (sum / i) + 1;
		return temp;

	}

	public static boolean equalsNoSpace(String str1,String str2) {
		str1 =str1.replace(" ", "");
		str2 =str2.replace(" ", "");
		return str1.equals(str2);
	}
}

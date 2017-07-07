package com.suteam.html.common.util;

import java.text.DateFormat;

/**============================================================
 * 版权： 久其软件 版权所有 (c) 
 * 包： com.jiuqi.muchmore.clothing.common.tools
 * 修改记录：
 * 日期                作者           内容
 * =============================================================
 * 2012-6-6       Administrator        
 * ============================================================*/

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * <p>
 * 时间格式化类
 * </p>
 * 
 * <p>
 * Copyright: 版权所有 (c)<br>
 * Company: 久其
 * </p>
 * 
 * @author Administrator
 * @version 2012-6-6
 */

public class DateUtil {

	/**
	 * yyyy-MM-dd
	 */
	public static final String YYYY_MM_DD = "yyyy-MM-dd";
	/**
	 * yy-MM-dd
	 */
	public static final String YY_MM_DD = "yy-MM-dd";
	/**
	 * MM/dd HH:mm:ss
	 */
	public static final String MM_DD_HH_MM_SS = "MM/dd HH:mm:ss";
	/**
	 * yyyy-MM-dd HH:mm
	 */
	public static final String YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";

	/**
	 * yyyy-MM-dd HH:mm:ss
	 */
	public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";

	/**
	 * MM/dd HH:mm
	 */
	public static final String MM_DD_HH_MM = "MM/dd HH:mm";

	/**
	 * MM-dd
	 */
	public static final String MM_DD = "MM-dd";

	/**
	 * MM月 dd日 HH:mm
	 */
	public static final String MM_DD_HH_MM1 = "MM月dd日 HH:mm";
	private static final long MINUTE_IN_MILLISECOND = 1000 * 60;
	private static final long DAY_IN_MILLISECOND = 1000 * 3600 * 24;
	/**
	 * 根据long值，转化为yyyy-MM-dd hh:mm的格式
	 * 
	 * @param timelong
	 * @return String
	 */
	public static String getTimeStamp(long timelong) {
		Date d = new Date(timelong);
		SimpleDateFormat df = new SimpleDateFormat(YYYY_MM_DD_HH_MM);
		return df.format(d);
	}

	/**
	 * timepatten就是SimpleDateFormat用到的patten，比如："yyyy-MM-dd HH:mm"
	 * 
	 * @param timelong
	 * @param timepatten
	 * @return String
	 */
	public static String getTimeStamp(long timelong, String timepatten) {
		Date d = new Date(timelong);
		SimpleDateFormat df = new SimpleDateFormat(timepatten);
		return df.format(d);
	}

	/**
	 * timepatten就是SimpleDateFormat用到的patten，比如："yyyy-MM-dd HH:mm"
	 * 
	 * @param timelong
	 * @param timepatten
	 * @return String
	 */
	public static String getTimeStamp(Date date, String timepatten) {
		SimpleDateFormat df = new SimpleDateFormat(timepatten);
		return df.format(date);
	}

	/**
	 * 根据年月日的值取得时间片
	 * 
	 * @param mYear
	 * @param mMonth
	 *            自动减去1900
	 * @param mDay
	 * @return long
	 */
	public static long getTimeStampFromYearMonthDay(int mYear, int mMonth,
			int mDay) {
		Date dt = new Date();
		dt.setYear(mYear - 1900);
		dt.setMonth(mMonth);
		dt.setDate(mDay);
		return dt.getTime();
	}

	/**
	 * 解析字符串，返回Date对象，字符串格式默认为yyyy-MM-dd；如果解析出现异常，返回null。
	 * 
	 * @param strDate
	 * @return Date
	 */
	public static Date parseDate(String strDate) {
		return parseDate(strDate, DateUtil.YYYY_MM_DD);
	}

	/**
	 * 解析字符串，返回Date对象，可以传入字符串格式进行解析，建议使用DateUtil内置的字符串格式。如果解析出现异常，返回null。
	 * 
	 * @param strDate
	 * @return Date
	 */
	public static Date parseDate(String strDate, String dateFormat) {
		Date date = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
			date = sdf.parse(strDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 根据年月日的值取得时间片
	 * 
	 * @param mYear
	 * @param mMonth
	 *            自动减去1900
	 * @param mDay
	 * @return long
	 */
	public static long getTimeStampFromYearMonthDay(int mYear, int mMonth,
			int mDay, int mHour, int mMin) {
		Date dt = new Date();
		dt.setYear(mYear);
		dt.setMonth(mMonth);
		dt.setDate(mDay);
		dt.setHours(mHour);
		dt.setMinutes(mMin);
		return dt.getTime();
	}

	/**
	 * @param dayOfMonth
	 * @param month
	 * @param year
	 * 
	 */
	public static boolean compareDateIsLessThanNow(int year, int month,
			int dayOfMonth) {
		Date dt = new Date();
		int  nowYear = dt.getYear();
		int  nowMonth = dt.getMonth();
		int  nowDayOfMonth = dt.getDate();
		if(year<nowYear){
			return true;
		}
		if(month<nowMonth){
			return true;
		}
		if(dayOfMonth<nowDayOfMonth){
			return true;
		}
		return false;
	}

	public static boolean isEndDateBeforeStartDate(String startDate,String endDate) {
		int  i = startDate.compareToIgnoreCase(endDate);
		if(i>0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 根据传入的字符串按照yyyy-MM-dd HH:mm:ss格式得到对应的date
	 * 
	 * @param pattern
	 * @param date
	 * @return
	 */
	public static Date parseDatetime(String date) {
		try {
			if (StringUtils.isEmpty(date))
				return null;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return df.parse(date);
		} catch (ParseException ignore) {
		}
		return null;
	}
	/**
	 * 在指定的日期增加或减少分钟
	 * 
	 * @param date
	 * @param days
	 * @return
	 */
	public static Date dateMinuteAdd(Date date, int minute) {
		long now = date.getTime() + minute * MINUTE_IN_MILLISECOND;
		return (new java.util.Date(now));
	}
	/**
	 * 得到日期的结束日期，例如2009-1-1 15:12，转换后为2009-1-2 00:00，注意为第二天的0点整
	 * 
	 * @param date
	 * @return
	 */
	public static Date getLastOfDay(Date date) {
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		gc.set(GregorianCalendar.HOUR_OF_DAY, 23);
		gc.set(GregorianCalendar.MINUTE, 59);
		gc.set(GregorianCalendar.SECOND, 59);
		gc.set(GregorianCalendar.MILLISECOND, 999);
		return gc.getTime();
	}
	/**
	 * 比较日期相差天数 start 开始时间 end 结束时间
	 * 
	 * @return 相差天数
	 */
	public static Integer getCompareDays(Date start, Date end) {
		if (start == null || end == null) {
			return null;
		}
		Long startTime = start.getTime();
		Long endTime = end.getTime();
		Long compareMilliSecond = endTime - startTime;
		Long compareDays = compareMilliSecond / DAY_IN_MILLISECOND;
		return compareDays.intValue();
	}
	/**
	 * 在指定的日期增加或减少天数
	 * 
	 * @param date
	 * @param days
	 * @return
	 */
	public static Date dateDayAdd(Date date, int days) {
		long now = date.getTime() + days * DAY_IN_MILLISECOND;
		return (new java.util.Date(now));
	}
	/**
	 * 得到日期的起始日期，例如2009-1-1 15:12，转换后为 2009-1-1 00:00
	 * 
	 * @param date
	 * @return
	 */
	public static Date getFirstOfDay(Date date) {
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		gc.set(GregorianCalendar.HOUR_OF_DAY, 0);
		gc.set(GregorianCalendar.MINUTE, 0);
		gc.set(GregorianCalendar.SECOND, 0);
		gc.set(GregorianCalendar.MILLISECOND, 0);
		return gc.getTime();
	}
	
	/**
	 * 根据传入的字符串按照yyyy-MM-dd格式得到对应的date
	 * 
	 * @param pattern
	 * @param date
	 * @return
	 */
	public static Date parseDate1(String date) {
		try {
			if (StringUtils.isEmpty(date))
				return null;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			return df.parse(date);
		} catch (ParseException ignore) {
		}
		return null;
	}
	/**
	 * 按照yyyy-MM-dd HH:mm:ss的格式格式化日期
	 * 
	 * @param date
	 * @return
	 */
	public static String formatDatetime(Date date) {
		if (date == null)
			return null;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(date);
	}
	
	/**
	 * 比较日期相差妙数 start 开始时间 end 结束时间
	 * 
	 * @return 相差分钟数
	 */
	public static long getSecond(Date start, Date end) {
		long d1 = start.getTime();
		long d2 = end.getTime();
		long d3 = (d1 - d2) / 1000;
		return d3;
	}
	
	
	/**
	 * 比较日期相差妙数 start 开始时间 end 结束时间
	 * @author zyz
	 * @param start
	 * @param end
	 * @return 相差毫秒数
	 */
	public static long getMillisecond(Date start, Date end) {
		long d1 = start.getTime();
		long d2 = end.getTime();
		long d3 = (d1 - d2);
		return d3;
	}
	/**
	 * 按照yyyyMMddHHmmssSSS的格式格式化日期
	 * 
	 * @param date
	 * @return
	 */
	public static String formatDatetimeStr(Date date) {
		if (date == null)
			return null;
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return df.format(date);
	}
}

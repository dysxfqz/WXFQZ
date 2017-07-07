package com.suteam.html.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;


public class LuckDrawNumber {
	public static final String PREFIX = "CJ";
	public static final String PREFIXS = "xl";
    private static long code;

    

    public static synchronized String nextCode() {
        code++;
        String str = new SimpleDateFormat("yy").format(new Date());
        long m = Long.parseLong((str)) * 10000;
        m += code;
        return PREFIX + m;
    }
    public static synchronized String nextCodes() {
        code++;
        String str = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        long m = Long.parseLong((str)) * 10000;
        m += code;
        return PREFIXS+m;
    }

}

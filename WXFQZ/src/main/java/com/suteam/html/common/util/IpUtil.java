package com.suteam.html.common.util;

import javax.servlet.http.HttpServletRequest;

public class IpUtil {
	
	public static String getIpAddr(HttpServletRequest request) {  
        
        String ip = request.getHeader("x-forwarded-for");  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        System.out.println("本次登录的用户IP地址："+ ip);
        return ip;
    }
	
	public static void main(String[] args) {
	    System.out.println(isInRange("202.104.190.200", "202.104.190.184/29"));
	    System.out.println(isInRange("192.168.1.1", "192.168.0.0/23"));
	    System.out.println(isInRange("192.168.1.1", "192.168.0.0/24"));
	    System.out.println(isInRange("192.168.1.1", "192.168.0.0/32"));
	  }

	  public static boolean isInRange(String ip, String cidr) {
	    String[] ips = ip.split("\\.");
	    int ipAddr = (Integer.parseInt(ips[0]) << 24)
	        | (Integer.parseInt(ips[1]) << 16)
	        | (Integer.parseInt(ips[2]) << 8)
	        | Integer.parseInt(ips[3]);
	    int type = Integer.parseInt(cidr.replaceAll(".*/", ""));
	    int mask = 0xFFFFFFFF << (32 - type);
	    String cidrIp = cidr.replaceAll("/.*", "");
	    String[] cidrIps = cidrIp.split("\\.");
	    int cidrIpAddr = (Integer.parseInt(cidrIps[0]) << 24)
	        | (Integer.parseInt(cidrIps[1]) << 16)
	        | (Integer.parseInt(cidrIps[2]) << 8)
	        | Integer.parseInt(cidrIps[3]);

	    return (ipAddr & mask) == (cidrIpAddr & mask);
	  }

}

package com.suteam.html.wechatpay.job;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.suteam.html.wechatpay.service.WeiChatMgr;


public class CheckWXQueryJob {
	public static Logger log = Logger.getLogger(CheckWXQueryJob.class);
	@Autowired
	private WeiChatMgr weiChatMgr;
	public void run() {
		try {
			log.info("处理查询订单任务开始>........");
			// 业务逻辑代码调用
			weiChatMgr.wxTradeQuery();
			log.info("处理查询订单任务结束!");
		} catch (Exception e) {
			log.error("处理查询订单任务出现异常", e);
		}
	}
}

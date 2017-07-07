package com.suteam.html.common.dao;

/**
 * @company suteam
 * @author GengZhi
 * @since 2008-1-30
 * @version 1.0
 */
@SuppressWarnings("unchecked")
public abstract class PaginationAnalyzer {
	
	/**
	 * 处理分页
	 * @param sql SQL语句
	 * @param page 分页对象
	 * @param dao dao对象
	 * @return 处理后带有分页逻辑的SQL语句
	 */
	public abstract Object analyse(Object query, Page page, GenericDao dao, Object... args);

	/**
	 * 分析SQL语句并补充分页代码
	 * @param sql 查询语句
	 * @return 带有分页的查询语句
	 */
	public abstract Object analyse(Object sql, Page page);
}

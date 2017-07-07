package com.suteam.html.common.dao;

import java.io.Serializable;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;


/**
 * @company suteam
 * @author GengZhi
 * @since 2008-2-1
 * @version 1.0
 */
@SuppressWarnings("unchecked")
public class GenericDaoDefault<E extends Entity> extends HibernateDaoSupport implements
		GenericDao<E> {
	
	// 泛型类型
	protected Class entityClass;
	
	// 分页处理器
	private PaginationAnalyzer paginationAnalyzer;
	
	// 删除order by字句使用的正则表达式
	private static Pattern removeOrderByPattern = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);
	
	/**
	 * 构造方法
	 */
	public GenericDaoDefault(){
		this.entityClass = GenericUtils.getGenericClass(this.getClass());
	}
	
	@Resource
	public void setMySessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#count(java.lang.String, java.lang.Object[])
	 */
	public int count(String ql, Object... args) {
		Query query = getSession().createQuery(ql);
	    for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
	    String countQueryString = " select count (*) " + this.removeSelect(this.removeOrderBy(ql));
	    List countlist = getHibernateTemplate().find(countQueryString, args);
	    Long totalCount = 0l;
	    if(countlist != null && countlist.size() >= 1){
	    	if(this.hasGroupBy(ql)){
	    		totalCount = Long.parseLong(countlist.size()+"");
	    	}else{
	    		totalCount = (Long) countlist.get(0);
	    	}
	    }

	    return totalCount.intValue();
	}

	private boolean hasGroupBy(String ql) {
		if(ql != null && !"".equals(ql)){
		    if(ql.indexOf("group by") > -1){
		    	return true;
		    }
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#delete(java.io.Serializable)
	 */
	public void delete(Serializable id) {
		E entity = get(id);
		if(entity != null) {
			super.getHibernateTemplate().delete(this.get(id));
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#delete(com.suteam.platform.common.dao.Entity)
	 */
	public void delete(E entity){
		super.getHibernateTemplate().delete(entity);
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#get(java.io.Serializable)
	 */
	public E get(Serializable id) {
		return (E)super.getHibernateTemplate().get(this.entityClass, id);
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#get(java.lang.String, com.suteam.platform.common.dao.Page, java.lang.Object[])
	 */
	public List query(String ql, Page page, Object... args) {
		Query query = getSession().createQuery(ql);
	    for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
	    HibernatePaginationAnalyzer hap=new HibernatePaginationAnalyzer();
	    query = (Query) hap.analyse(query, page, this, args);
	    page.setRecord(query.list());
		return page.getRecord();
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#get(java.lang.String, java.lang.Object[])
	 */
	public List query(String ql, Object... args) {
		Query query = getSession().createQuery(ql);
		for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
		
		return query.list();
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#queryForLock(java.lang.String, org.hibernate.LockMode, java.lang.Object[])
	 */
	public List queryForLock(String ql, LockOptions lockOptions, Object... args) {
		Assert.notNull(lockOptions);
		Query query = getSession().createQuery(ql);
		lockOptions.handleQuery(query);
		for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
		return query.list();
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#queryForLock(java.lang.String, com.suteam.platform.common.dao.Page, com.suteam.platform.common.dao.LockOptions, java.lang.Object[])
	 */
	public List queryForLock(String ql, Page page, LockOptions lockOptions, Object... args) {
		Assert.notNull(lockOptions);
		Query query = getSession().createQuery(ql);
		lockOptions.handleQuery(query);
	    for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
	    query = (Query) paginationAnalyzer.analyse(query, page, this, args);
	    page.setRecord(query.list());
		return page.getRecord();
	}
	

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#queryWithQueryCache(java.lang.String, com.suteam.platform.common.dao.Page, java.lang.Object[])
	 */
	public List queryWithQueryCache(String ql, Page page, Object... args) {
		Query query = getSession().createQuery(ql).setCacheable(true);
	    for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
	    query = (Query) paginationAnalyzer.analyse(query, page, this, args);
	    page.setRecord(query.list());
		return page.getRecord();
	}

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#queryWithQueryCache(java.lang.String, java.lang.Object[])
	 */
	public List queryWithQueryCache(String ql, Object... args) {
		Query query = getSession().createQuery(ql).setCacheable(true);
		for (int i = 0; i < args.length; i++) {
	      query.setParameter(i, args[i]);
	    }
		return query.list();
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#getAll(com.suteam.platform.common.dao.Page, com.suteam.platform.common.dao.Sort[])
	 */
	public List findAll(Page page, Sort... sorts) {
		StringBuffer ql = new StringBuffer("from ");
		ql.append(this.entityClass.getName());
		ql.append(" t");
		if(sorts != null && sorts.length > 0){
			ql.append(" order by ");
			for(int i = 0; i < sorts.length; i++){
				if(sorts[i] == null){
					continue;
				}
				ql.append(sorts[i].toString());
				ql.append(", ");
			}
			ql.delete(ql.length() - 2, ql.length());
		}
		Query query = super.getSession().createQuery(ql.toString());
		if(page != null) {
			query = (Query) paginationAnalyzer.analyse(query, page, this);
			page.setRecord(query.list());
			return page.getRecord();
		} else {
			return query.list();
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#findAll(com.suteam.platform.common.dao.Page, com.suteam.platform.common.dao.Sort[])
	 */
	public List findAll() {
		return this.findAll(null);
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#save(com.suteam.platform.common.dao.Entity)
	 */
	public void save(E entity) {
		super.getHibernateTemplate().saveOrUpdate(entity);
	}

	/* (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#update(java.lang.String, java.lang.Object[])
	 */
	public int update(String ql, Object... args) {
		Query query = super.getSession().createQuery(ql);
		for(int i = 0; i < args.length; i++){
			query.setParameter(i, args[i]);
		}
		return query.executeUpdate();
	}

	

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#deleteBatchByEntitiesId(java.util.List)
	 */
	public void deleteBatchByEntitiesId(Object[] entitiesId) {
		StringBuffer str = new StringBuffer("delete from ");
		str.append(this.entityClass.getName());
		str.append(" t where t.id in (");
		for(int i = 0; i < entitiesId.length; i++){
			str.append("?,");
		}
		str.deleteCharAt(str.length() - 1);
		str.append(")");
		this.update(str.toString(), entitiesId);
	}

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#getAll(java.lang.Integer, java.lang.Integer, com.suteam.platform.common.dao.Sort[])
	 */
	public List findAll(Integer pageSize, Integer pageIndex, Sort... sorts) {
		Page page = new Page(pageSize, pageIndex, false);
		return this.findAll(page, sorts);
	}

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#query(java.lang.String, java.lang.Integer, java.lang.Integer, java.lang.Object[])
	 */
	public List query(String ql, Integer pageSize, Integer pageIndex, Object... args) {
		Page page = new Page(pageSize, pageIndex, false);
		return this.query(ql, page, args);
	}

	/**
	 * 去除ql语句中的select子句
	 * @param ql 查询语句
	 * @return 删除后的语句
	 */
	private String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql + " must has a keyword 'from'");
		return hql.substring(beginPos);
	}
	
	/**
	 * 删除ql语句中的order by字句
	 * @param ql 查询语句
	 * @return 删除后的查询语句
	 */
	private String removeOrderBy(String ql){
		if(ql != null && !"".equals(ql)){
		    Matcher m = removeOrderByPattern.matcher(ql);
		    StringBuffer sb = new StringBuffer();
		    while (m.find()) {
		      m.appendReplacement(sb, "");
		    }
		    m.appendTail(sb);
		    return sb.toString();
		}
		return "";
	}

	public void setPaginationAnalyzer(PaginationAnalyzer paginationAnalyzer) {
		this.paginationAnalyzer = paginationAnalyzer;
	}

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#refresh(com.suteam.platform.common.dao.Entity, com.suteam.platform.common.dao.LockOptions)
	 */
	public void refresh(Entity entity, LockOptions lockOptions) {
		super.getHibernateTemplate().refresh(entity, lockOptions.getLockMode());
	}

	/*
	 * (non-Javadoc)
	 * @see com.suteam.platform.common.dao.GenericDao#refresh(com.suteam.platform.common.dao.Entity)
	 */
	public void refresh(Entity entity) {
		super.getHibernateTemplate().refresh(entity);
	}

	public void deleteBatchByEntities(List<E> entities) {
		// TODO Auto-generated method stub
		
	}

}

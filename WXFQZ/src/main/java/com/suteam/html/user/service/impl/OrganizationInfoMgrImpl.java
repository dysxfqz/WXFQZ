package com.suteam.html.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.user.dao.OrganizationInfoDao;
import com.suteam.html.user.model.OrganizationInfo;
import com.suteam.html.user.service.OrganizationInfoMgr;

@Service
@SuppressWarnings("unchecked")
public class OrganizationInfoMgrImpl implements OrganizationInfoMgr {

	@Autowired
	private OrganizationInfoDao orgInfoDao;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveOrganizationInfo(OrganizationInfo orgInfo) {
		orgInfoDao.save(orgInfo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public OrganizationInfo findByUserId(String userId) {
		return orgInfoDao.findByUserId(userId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteByUserId(OrganizationInfo orgInfo) {
		orgInfoDao.delete(orgInfo);
	}

}

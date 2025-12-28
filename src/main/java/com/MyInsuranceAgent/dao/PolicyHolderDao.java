package com.MyInsuranceAgent.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.MyInsuranceAgent.model.PolicyHolder;


@Component
public class PolicyHolderDao {
	@Autowired
	public HibernateTemplate hibernateTemplate;
	
	
	@Transactional
	public boolean addPolicyHolder(PolicyHolder policyHolder){
	    Object result = this.hibernateTemplate.save(policyHolder);
	    return result != null;
	}
	
	public List<PolicyHolder> getAllPolicyHolders(){
		List<PolicyHolder> policyHolder = this.hibernateTemplate.loadAll(PolicyHolder.class);
		return policyHolder;
	}
	
	public PolicyHolder getOnePolicyHolder(String email){
		PolicyHolder policyHolder = this.hibernateTemplate.get(PolicyHolder.class, email);
		return policyHolder;
	}
	
	@Transactional
	public void deletePolicyHolder(String email){
		PolicyHolder policyHolder = this.hibernateTemplate.get(PolicyHolder.class, email);
		this.hibernateTemplate.delete(policyHolder);
	}
	
	@Transactional
	public void updatePolicyHolder(PolicyHolder policyHolder){
		this.hibernateTemplate.update(policyHolder);
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
}

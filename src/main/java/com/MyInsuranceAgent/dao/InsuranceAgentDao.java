package com.MyInsuranceAgent.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.MyInsuranceAgent.model.InsuranceAgent;

@Component
public class InsuranceAgentDao {
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	@Transactional
	public boolean addInsuranceAgent(InsuranceAgent insuranceAgent){
		Object result = this.hibernateTemplate.save(insuranceAgent);
		return result != null;
	}
	
	public List<InsuranceAgent> getAllInsuranceAgents(){
		List<InsuranceAgent> insuranceAgent = this.hibernateTemplate.loadAll(InsuranceAgent.class);
		return insuranceAgent;
	}
	
	public InsuranceAgent getOneInsuranceAgent(String email){
		InsuranceAgent insuranceAgent = this.hibernateTemplate.get(InsuranceAgent.class, email);
		return insuranceAgent;
	}
	
	@Transactional
	public void deleteInsuranceAgent(String email){
		InsuranceAgent insuranceAgent = this.hibernateTemplate.get(InsuranceAgent.class,email);
		this.hibernateTemplate.delete(insuranceAgent);
	}
	
	@Transactional
	public void updateInsuranceAgent(InsuranceAgent insuranceAgent){
		this.hibernateTemplate.update(insuranceAgent);
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}

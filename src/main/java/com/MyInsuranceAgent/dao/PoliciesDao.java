package com.MyInsuranceAgent.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.MyInsuranceAgent.model.Policies;

@Component
public class PoliciesDao {
	@Autowired
	private HibernateTemplate hibernateTemplate;

	@Transactional
	public int addPolicies(Policies policies) {
		int r = (Integer) this.hibernateTemplate.save(policies);
		return r;
	}

	public List<Policies> getAllPolicies() {
		List<Policies> policies = this.hibernateTemplate.loadAll(Policies.class);
		return policies;
	}

	public Policies getOnePolicies(int pId) {
		Policies policies = this.hibernateTemplate.get(Policies.class, pId);
		return policies;
	}

	@Transactional
	public void deletePolicies(int pId) {
		Policies policies = this.hibernateTemplate.get(Policies.class, pId);
		this.hibernateTemplate.delete(policies);
	}

	@Transactional
	public void updatePolicies(Policies policies) {
		this.hibernateTemplate.update(policies);
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

}

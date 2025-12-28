package com.MyInsuranceAgent.model;

import javax.persistence.Entity;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Entity
@Component
public class InsuranceAgent {
	@Id
	private String  iaEmail;
	private String  iaName;
	private String  iaDob;
	private String iaContact;
	private String iaAddress;
	private String iaPassword;
	private String iaStatus;
	
	public String getIaEmail() {
		return iaEmail;
	}
	public void setIaEmail(String iaEmail) {
		this.iaEmail = iaEmail;
	}
	public String getIaName() {
		return iaName;
	}
	public void setIaName(String iaName) {
		this.iaName = iaName;
	}
	public String getIaDob() {
		return iaDob;
	}
	public void setIaDob(String iaDob) {
		this.iaDob = iaDob;
	}
	public String getIaContact() {
		return iaContact;
	}
	public void setIaContact(String iaContact) {
		this.iaContact = iaContact;
	}
	public String getIaAddress() {
		return iaAddress;
	}
	public void setIaAddress(String iaAddress) {
		this.iaAddress = iaAddress;
	}
	public String getIaPassword() {
		return iaPassword;
	}
	public void setIaPassword(String iaPassword) {
		this.iaPassword = iaPassword;
	}
	public String getIaStatus() {
		return iaStatus;
	}
	public void setIaStatus(String iaStatus) {
		this.iaStatus = iaStatus;
	}
	public InsuranceAgent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InsuranceAgent(String iaEmail, String iaName, String iaDob, String iaContact, String iaAddress,
			String iaPassword, String iaStatus) {
		super();
		this.iaEmail = iaEmail;
		this.iaName = iaName;
		this.iaDob = iaDob;
		this.iaContact = iaContact;
		this.iaAddress = iaAddress;
		this.iaPassword = iaPassword;
		this.iaStatus = iaStatus;
	}
	@Override
	public String toString() {
		return "InsuranceAgent [iaEmail=" + iaEmail + ", iaName=" + iaName + ", iaDob=" + iaDob + ", iaContact="
				+ iaContact + ", iaAddress=" + iaAddress + ", iaPassword=" + iaPassword + ", iaStatus=" + iaStatus
				+ "]";
	}
	
	
	
}

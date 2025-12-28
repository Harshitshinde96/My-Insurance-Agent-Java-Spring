package com.MyInsuranceAgent.model;

import javax.persistence.Entity;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Entity
@Component
public class PolicyHolder {
	@Id
	private String  phEmail;
	private String  phName;
	private String  phDob;
	private String phContact;
	private String phAddress;
	private String phPassword;	
	
	public String getPhEmail() {
		return phEmail;
	}
	public void setPhEmail(String phEmail) {
		this.phEmail = phEmail;
	}
	public String getPhName() {
		return phName;
	}
	public void setPhName(String phName) {
		this.phName = phName;
	}
	public String getPhDob() {
		return phDob;
	}
	public void setPhDob(String phDob) {
		this.phDob = phDob;
	}
	public String getPhContact() {
		return phContact;
	}
	public void setPhContact(String phContact) {
		this.phContact = phContact;
	}
	public String getPhAddress() {
		return phAddress;
	}
	public void setPhAddress(String phAddress) {
		this.phAddress = phAddress;
	}
	public String getPhPassword() {
		return phPassword;
	}
	public void setPhPassword(String phPassword) {
		this.phPassword = phPassword;
	}
	public PolicyHolder(String phEmail, String phName, String phDob, String phContact, String phAddress,
			String phPassword) {
		super();
		this.phEmail = phEmail;
		this.phName = phName;
		this.phDob = phDob;
		this.phContact = phContact;
		this.phAddress = phAddress;
		this.phPassword = phPassword;
	}
	public PolicyHolder() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PolicyHolder [phEmail=" + phEmail + ", phName=" + phName + ", phDob=" + phDob + ", phContact="
				+ phContact + ", phAddress=" + phAddress + ", phPassword=" + phPassword + "]";
	}
	
	
}

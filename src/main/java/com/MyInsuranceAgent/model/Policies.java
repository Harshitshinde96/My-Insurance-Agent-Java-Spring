package com.MyInsuranceAgent.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


import org.springframework.stereotype.Component;

@Entity
@Table(name="policy_tbl")
@Component
public class Policies {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int  policyId;
	private String  phName;
	private String  phEmail;
	private String  phDob;
	private String phContact;
	private String  policyTitle;
	private String  policyDetails;
	@Temporal(TemporalType.DATE)
	private Date dueDate;
	private String  iaEmail;
	
	public int getPolicyId() {
		return policyId;
	}
	public void setPolicyId(int policyId) {
		this.policyId = policyId;
	}
	public String getPhName() {
		return phName;
	}
	public void setPhName(String phName) {
		this.phName = phName;
	}
	public String getPhEmail() {
		return phEmail;
	}
	public void setPhEmail(String phEmail) {
		this.phEmail = phEmail;
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
	public String getPolicyTitle() {
		return policyTitle;
	}
	public void setPolicyTitle(String policyTitle) {
		this.policyTitle = policyTitle;
	}
	public String getPolicyDetails() {
		return policyDetails;
	}
	public void setPolicyDetails(String policyDetails) {
		this.policyDetails = policyDetails;
	}
	public Date getDueDate() {
		return dueDate;
	}
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public String getIaEmail() {
		return iaEmail;
	}
	public void setIaEmail(String iaEmail) {
		this.iaEmail = iaEmail;
	}
	public Policies(int policyId, String phName, String phEmail, String phDob, String phContact, String policyTitle,
			String policyDetails, Date dueDate, String iaEmail) {
		super();
		this.policyId = policyId;
		this.phName = phName;
		this.phEmail = phEmail;
		this.phDob = phDob;
		this.phContact = phContact;
		this.policyTitle = policyTitle;
		this.policyDetails = policyDetails;
		this.dueDate = dueDate;
		this.iaEmail = iaEmail;
	}
	public Policies() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Policies [policyId=" + policyId + ", phName=" + phName + ", phEmail=" + phEmail + ", phDob=" + phDob
				+ ", phContact=" + phContact + ", policyTitle=" + policyTitle + ", policyDetails=" + policyDetails
				+ ", dueDate=" + dueDate + ", iaEmail=" + iaEmail + "]";
	}
	
	
	
	
}

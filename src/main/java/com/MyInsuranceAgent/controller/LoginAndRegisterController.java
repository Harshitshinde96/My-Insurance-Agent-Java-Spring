
package com.MyInsuranceAgent.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.MyInsuranceAgent.dao.InsuranceAgentDao;
import com.MyInsuranceAgent.dao.PolicyHolderDao;
import com.MyInsuranceAgent.model.InsuranceAgent;
import com.MyInsuranceAgent.model.PolicyHolder;

@Controller
public class LoginAndRegisterController {
	ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");

	PolicyHolder policyHolder = context.getBean("policyHolder", PolicyHolder.class);
	PolicyHolderDao policyHolderDao = context.getBean("policyHolderDao", PolicyHolderDao.class);

	InsuranceAgent insuranceAgent = context.getBean("insuranceAgent", InsuranceAgent.class);
	InsuranceAgentDao insuranceAgentDao = context.getBean("insuranceAgentDao", InsuranceAgentDao.class);


	@RequestMapping("/")
	public String openLoginPage() {
		return "index";
	}

	
	@PostMapping("/loginUser")
	    public String handleLogin(HttpServletRequest request) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String role = request.getParameter("role");
	        if (role.equalsIgnoreCase("admin")) {
	            return "forward:/admin/login";
	        } else if (role.equalsIgnoreCase("insuranceAgent")) {
	            return "forward:/agent/login";
	        } else if (role.equalsIgnoreCase("policyHolder")) {
	            return "forward:/policyholder/login";
	        }
	        
	        return "index";
	    }
	  
	  
	  
	@RequestMapping(value = "/registerAgent", method = RequestMethod.POST)
	public String registerUser(HttpServletRequest request) {

		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String dob = request.getParameter("dob");
		String contact = request.getParameter("contact");
		String address = request.getParameter("address");
		String password = request.getParameter("password");

		System.out.println("Registering user with email: " + email);

		// Insurance Agent Registration
		insuranceAgent.setIaName(fullname);
		insuranceAgent.setIaEmail(email);
		insuranceAgent.setIaDob(dob);
		insuranceAgent.setIaContact(contact);
		insuranceAgent.setIaAddress(address);
		insuranceAgent.setIaPassword(password);
		insuranceAgent.setIaStatus("PENDING");
		boolean result = insuranceAgentDao.addInsuranceAgent(insuranceAgent);
		if (result) {
			System.out.println("Insurance Agent registered successfully.");
			return "index"; // redirect to login page
		} else {
			System.out.println("Insurance Agent registration failed.");
			return "index";
		}

	}
	
	
	


//	@RequestMapping(value = "/loginUser", method = RequestMethod.POST)
//	public String loginUser(HttpServletRequest request, Model model) {
//
//		String email = request.getParameter("email");
//		String password = request.getParameter("password");
//		String role = request.getParameter("role");
//
//		System.out.println("Email: " + email + ", Role: " + role);
//
//		// Admin Login (Hardcoded)
//		if (role.equalsIgnoreCase("admin")) {
//			if (email.equals("admin@gmail.com") && password.equals("admin")) {
//				System.out.println("Admin login successful.");
//				return "admin-dashboard"; // Forward to admin-dashboard.jsp
//			} else {
//				System.out.println("Admin login failed.");
//				return "index"; // Redirect to login page
//			}
//		}
//
//		// Insurance Agent Login
//		if (role.equalsIgnoreCase("insuranceAgent")) {
//			InsuranceAgent agent = insuranceAgentDao.getOneInsuranceAgent(email);
//			if (agent != null && agent.getIaPassword().equals(password) && agent.getIaStatus().equals("APPROVED")) {
//				System.out.println("Insurance Agent login successful.");
//				return "agent-dashboard"; // Forward to agent-dashboard.jsp
//			} else {
//				System.out.println("Insurance Agent login failed.");
//				return "index";
//			}
//		}
//
//		// Policy Holder Login
//		if (role.equalsIgnoreCase("policyHolder")) {
//			PolicyHolder policyHolder = policyHolderDao.getOnePolicyHolder(email);
//			if (policyHolder != null && policyHolder.getPhPassword().equals(password)) {
//				System.out.println("Policy Holder login successful.");
//				return "policy-holder-dashboard"; // Forward to
//													// policy-holder-dashboard.jsp
//			} else {
//				System.out.println("Policy Holder login failed.");
//				return "index";
//			}
//		}
//
//		// If role is invalid or something goes wrong
//		System.out.println("Invalid role or unknown error.");
//		return "index";
//	}

	
	

}

package com.MyInsuranceAgent.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.MyInsuranceAgent.dao.InsuranceAgentDao;
import com.MyInsuranceAgent.dao.PolicyHolderDao;
import com.MyInsuranceAgent.model.InsuranceAgent;
import com.MyInsuranceAgent.model.PolicyHolder;

@Controller
@RequestMapping("/admin")
public class AdminController {
	ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");

	PolicyHolder policyHolder = context.getBean("policyHolder", PolicyHolder.class);
	PolicyHolderDao policyHolderDao = context.getBean("policyHolderDao", PolicyHolderDao.class);

	InsuranceAgent insuranceAgent = context.getBean("insuranceAgent", InsuranceAgent.class);
	InsuranceAgentDao insuranceAgentDao = context.getBean("insuranceAgentDao", InsuranceAgentDao.class);

//	@PostMapping("/login")
	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String adminLogin(HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if (email.equals("admin@gmail.com") && password.equals("admin")) {
			System.out.println("Admin login successful.");
			return "redirect:/admin/dashboard";
		} else {
			System.out.println("Admin login failed.");
			return "redirect:/";
		}
	}

	// Logout Maping
	@RequestMapping("/logout")
	public String adminlogout() {
		return "redirect:/";
	}
	
	@GetMapping("/dashboard")
	public String adminDashboard() {
		return "admin-dashboard";
	}

	@RequestMapping("/manageInsuranceAgents")
	public String manageAgent(Model m) {
		List<InsuranceAgent> allAgents = insuranceAgentDao.getAllInsuranceAgents();
		m.addAttribute("allAgents", allAgents);
		return "manage-insurance-agent";
	}

	@RequestMapping(path = "/changeStatus", method = RequestMethod.POST)
	public String changeStatus(HttpServletRequest request) {
		String email = request.getParameter("iaEmail");
		String newStatus = request.getParameter("newStatus");

		insuranceAgent = insuranceAgentDao.getOneInsuranceAgent(email);
		if (insuranceAgent != null) {
			insuranceAgent.setIaStatus(newStatus);
			insuranceAgentDao.updateInsuranceAgent(insuranceAgent);
		}

		return "redirect:/admin/manageInsuranceAgents";
	}

}

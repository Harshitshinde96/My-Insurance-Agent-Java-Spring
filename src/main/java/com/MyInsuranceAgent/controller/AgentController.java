package com.MyInsuranceAgent.controller;

import java.util.Collections;
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
import com.MyInsuranceAgent.dao.PoliciesDao;
import com.MyInsuranceAgent.dao.PolicyHolderDao;
import com.MyInsuranceAgent.model.InsuranceAgent;
import com.MyInsuranceAgent.model.Policies;
import com.MyInsuranceAgent.model.PolicyHolder;

import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

@Controller
@RequestMapping("/agent")
public class AgentController {
	ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");

	PolicyHolder policyHolder = context.getBean("policyHolder", PolicyHolder.class);
	PolicyHolderDao policyHolderDao = context.getBean("policyHolderDao", PolicyHolderDao.class);

	InsuranceAgent insuranceAgent = context.getBean("insuranceAgent", InsuranceAgent.class);
	InsuranceAgentDao insuranceAgentDao = context.getBean("insuranceAgentDao", InsuranceAgentDao.class);

	Policies policies = context.getBean("policies", Policies.class);
	PoliciesDao policiesDao = context.getBean("policiesDao", PoliciesDao.class);

	// @PostMapping("/login")
	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String agentLogin(HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		InsuranceAgent agent = insuranceAgentDao.getOneInsuranceAgent(email);
		if (agent != null && agent.getIaPassword().equals(password) && agent.getIaStatus().equals("APPROVED")) {

//			insuranceAgent = insuranceAgentDao.getOneInsuranceAgent(email);
			insuranceAgent = agent;

			System.out.println("Insurance Agent login successful.");
			return "redirect:/agent/dashboard";
		} else {
			System.out.println("Login failed for: " + email);
			return "redirect:/?error=login_failed";
		}

	}

	// Logout Maping
	@RequestMapping("/logout")
	public String agentLogout() {
		return "redirect:/";
	}

	@GetMapping("/dashboard")
	public String agentDashboard() {
		return "agent-dashboard";
	}

	@RequestMapping("/addPolicyHolder")
	public String openPolicyHolderPage() {
		System.out.println("Opening Policy Holder Page...");
		return "add-policy-holder";
	}

	@RequestMapping(path = "/submitAddPolicyHolder", method = RequestMethod.POST)
	public String submitAddHolder(HttpServletRequest request) {
		policyHolder.setPhEmail(request.getParameter("phEmail"));
		policyHolder.setPhName(request.getParameter("phName"));
		policyHolder.setPhDob(request.getParameter("phDob"));
		policyHolder.setPhContact(request.getParameter("phContact"));
		policyHolder.setPhAddress(request.getParameter("phAddress"));
		policyHolder.setPhPassword(request.getParameter("phPassword"));

		boolean result = policyHolderDao.addPolicyHolder(policyHolder);
		if (result) {
			return "redirect:/agent/dashboard";
		} else {
			return "add-policy-holder";
		}
	}

	@RequestMapping("/managePolicyHolder")
	public String managePolicyHolder(Model m) {
		List<PolicyHolder> allHolders = policyHolderDao.getAllPolicyHolders();
		if (allHolders == null) {
			allHolders = Collections.emptyList(); // Return empty list instead
													// of null
		}
		m.addAttribute("allHolders", allHolders);
		return "manage-policy-holder";
	}

	@RequestMapping(path = "/deletePolicyHolder", method = RequestMethod.GET)
	public String deletePolicyHolder(HttpServletRequest request) {
		String email = request.getParameter("phEmail");
		policyHolderDao.deletePolicyHolder(email);
		return "redirect:/agent/managePolicyHolder";
	}

	@RequestMapping("/updatePolicyHolderPage")
	public String updatePolicyHolderPage(HttpServletRequest request, Model model) {
		String phEmail = request.getParameter("phEmail");
		PolicyHolder holder = policyHolderDao.getOnePolicyHolder(phEmail);
		if (holder != null) {
			model.addAttribute("policyHolder", holder);
			return "update-policy-holder"; // Should point to your update form
											// JSP
		}
		return "redirect:/agent/managePolicyHolder";
	}

	@RequestMapping(path = "/updatePolicyHolder", method = RequestMethod.POST)
	public String updatePolicyHolder(HttpServletRequest request) {
		String oldEmail = request.getParameter("oldEmail");
		String newAddress = request.getParameter("phAddress");
		String newContact = request.getParameter("phContact");
		String newName = request.getParameter("phName");

		PolicyHolder existing = new PolicyHolder();

		existing = policyHolderDao.getOnePolicyHolder(oldEmail);
		if (existing.getPhEmail() == null) {

			return "redirect:/agent/managePolicyHolder";
		}

		existing.setPhName(newName);
		existing.setPhContact(newContact);
		existing.setPhAddress(newAddress);

		policyHolderDao.updatePolicyHolder(existing);

		return "redirect:/agent/managePolicyHolder";
	}

	@RequestMapping("/addPolicyPage")
	public String addPolicyPage() {
		return "add-new-policy";
	}

	@RequestMapping(path = "/submitAddPolicy", method = RequestMethod.POST)
	public String submitAddPolicy(HttpServletRequest request) {

		policies.setPhName(request.getParameter("holderName"));
		policies.setPhDob(request.getParameter("dob"));
		policies.setPhContact(request.getParameter("contact"));
		String phEmail = request.getParameter("phEmail");
		policies.setPolicyTitle(request.getParameter("policyTitle"));
		policies.setPolicyDetails(request.getParameter("policyDetails"));

		String dueDateStr = request.getParameter("dueDate"); // this will be in
																// format
																// "yyyy-MM-dd"
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		try {
			Date dueDate = formatter.parse(dueDateStr);
			policies.setDueDate(dueDate);
		} catch (ParseException e) {
			e.printStackTrace(); // or handle it properly
		}

		PolicyHolder getEmail = policyHolderDao.getOnePolicyHolder(phEmail);
		policies.setPhEmail(getEmail.getPhEmail());

		String iaemail = insuranceAgent.getIaEmail();
		policies.setIaEmail(iaemail);

		System.out.println(iaemail);
		if (getEmail != null) {
			int result = policiesDao.addPolicies(policies);
			if (result > 0) {
				return "redirect:/agent/viewPolicyDetails"; // If you have this
				// endpoint
			} else {
				return "redirect:/agent/dashboard";
			}
		} else {
			System.out.println("Policy Holder doesnot exist");
			return "add-new-policy";
		}
	}

	@RequestMapping("/viewPolicyDetails")
	public String viewPolicyDetails(Model m) {
		List<Policies> allPolicies = policiesDao.getAllPolicies();
		m.addAttribute("allPolicies", allPolicies);
		return "view-policy";
	}

	@RequestMapping("/updateDueDatePage")
	public String updateDueDatePage(HttpServletRequest request, Model model) {
		int policyId = Integer.parseInt(request.getParameter("pid"));
		Policies policy = policiesDao.getOnePolicies(policyId);
		if (policy != null) {
			model.addAttribute("policy", policy);
			return "update-due-date"; // Should point to your update form
										// JSP
		}
		return "redirect:/agent/viewPolicyDetails";
	}

	@RequestMapping(path = "/updateDueDate", method = RequestMethod.POST)
	public String updateDueDate(HttpServletRequest request, Model model) {
		int policyId = Integer.parseInt(request.getParameter("policyId"));
		String newDate = request.getParameter("newDate");

		try {

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date parsedDate = sdf.parse(newDate);

			Policies policies = policiesDao.getOnePolicies(policyId);
			if (policies.getPolicyId() < 0) {
				return "redirect:/agent/dashboard";
			}

			policies.setDueDate(parsedDate);
			policiesDao.updatePolicies(policies);

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/agent/dashboard";
		}

		return "redirect:/agent/viewPolicyDetails";
	}
}
package com.MyInsuranceAgent.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.MyInsuranceAgent.dao.PoliciesDao;
import com.MyInsuranceAgent.dao.PolicyHolderDao;
import com.MyInsuranceAgent.model.Policies;
import com.MyInsuranceAgent.model.PolicyHolder;

@Controller
@RequestMapping("/policyholder")
public class PolicyHolderController {
	ApplicationContext context = new ClassPathXmlApplicationContext("config.xml");

	PolicyHolder policyHolder = context.getBean("policyHolder", PolicyHolder.class);
	PolicyHolderDao policyHolderDao = context.getBean("policyHolderDao", PolicyHolderDao.class);

	Policies policies = context.getBean("policies", Policies.class);
	PoliciesDao policiesDao = context.getBean("policiesDao", PoliciesDao.class);

	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String policyHolderLogin(HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		PolicyHolder policyHolder = policyHolderDao.getOnePolicyHolder(email);

		if (policyHolder != null && policyHolder.getPhPassword().equals(password)) {
			System.out.println("Policy Holder login successful.");
			// Pass email in redirect
			return "redirect:/policyholder/viewPolicies?phEmail=" + email;
		} else {
			System.out.println("Policy Holder login failed.");
			return "redirect:/";
		}
	}

	// Logout Maping
	@RequestMapping("/logout")
	public String policyHolderLogout() {
		return "redirect:/";
	}

	@RequestMapping(path = "/viewPolicies", method = RequestMethod.GET)
	public String viewPolicies(HttpServletRequest request, Model model) {
		String phEmail = request.getParameter("phEmail");

		if (phEmail == null || phEmail.isEmpty()) {
			model.addAttribute("error", "Policy Holder email is missing.");
			return "policy-holder-dashboard"; // or an error page
		}
		// Retrieve all policies
		List<Policies> allPolicies = policiesDao.getAllPolicies();

		// Filter based on email
		List<Policies> holderPolicies = new ArrayList<Policies>();
		for (Policies policy : allPolicies) {
			if (policy.getPhEmail().equals(phEmail)) {
				holderPolicies.add(policy);
			}
		}

		PolicyHolder holder = policyHolderDao.getOnePolicyHolder(phEmail);

		model.addAttribute("allPolicies", holderPolicies);
		model.addAttribute("policyHolder", holder);

		return "policy-holder-dashboard";
	}
}
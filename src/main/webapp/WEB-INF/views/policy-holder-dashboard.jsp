<%@page import="com.MyInsuranceAgent.model.Policies"%>
<%@page import="com.MyInsuranceAgent.model.PolicyHolder"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Policy Details</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.2/css/all.css">
    <style>
        :root {
            --background: #050505;
            --color: #F5F7FA;
            --sectionBackground: #222126;
            --borderColor: #252429;
            --text1: #F5F7FA;
            --text2: #E6E9ED;
            --shadow: rgba(0,0,0,0.1);
            --iconColor: #05c534;
            --roleButtonBg: #3a3a3a;
            --roleButtonActiveBg: #05c534;
            --roleButtonText: #F5F7FA;
            --card-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            --warning: #ffc107;
            --danger: #dc3545;
        }

        .light-theme {
            --background: #fcfbfe;
            --color: #323133;
            --sectionBackground: #ffffff;
            --borderColor: #e9e9e9;
            --text1: #323133;
            --text2: #3C3B3D;
            --iconColor: #0fce3d;
            --roleButtonBg: #e9e9e9;
            --roleButtonActiveBg: #0fce3d;
            --roleButtonText: #323133;
            --card-shadow: 0 10px 25px rgba(0, 0, 0, 0.1), 0 5px 10px rgba(0, 0, 0, 0.04);
            --warning: #ffc107;
            --danger: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
            color: var(--text1);
            transition: all 0.5s ease;
            min-height: 100vh;
            padding: 40px;
        }

        .gradient-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }
        
        .light-theme .gradient-background {
            display: none;
        }

        .gradient-sphere {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.7;
        }

        .sphere-1 {
            width: 40vw;
            height: 40vw;
            background: linear-gradient(40deg, rgba(255, 0, 128, 0.6), rgba(98, 216, 249, 0.4));
            top: -10%;
            left: -10%;
            animation: float-1 15s ease-in-out infinite alternate;
        }

        .sphere-2 {
            width: 45vw;
            height: 45vw;
            background: linear-gradient(240deg, rgba(72, 0, 255, 0.6), rgba(0, 183, 255, 0.4));
            bottom: -20%;
            right: -10%;
            animation: float-2 18s ease-in-out infinite alternate;
        }
        
        .noise-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.04;
            z-index: 1;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
            pointer-events: none;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--sectionBackground);
            border-radius: 12px;
            padding: 30px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--borderColor);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--text1);
            font-weight: 600;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 8px 16px;
            background: var(--roleButtonBg);
            color: var(--roleButtonText);
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: var(--roleButtonActiveBg);
            color: white;
        }

        .holder-info {
            background: rgba(5, 197, 52, 0.05);
            padding: 20px;
            border-radius: 8px;
            border: 1px solid var(--borderColor);
            margin-bottom: 30px;
        }

        .holder-info h3 {
            color: var(--iconColor);
            margin-bottom: 15px;
            font-weight: 600;
        }

        .holder-info p {
            margin-bottom: 8px;
            color: var(--text1);
        }

        .holder-info p strong {
            color: var(--text1);
            font-weight: 500;
            min-width: 120px;
            display: inline-block;
        }

        .filter-form {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            background: var(--roleButtonBg);
            color: var(--roleButtonText);
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .filter-btn.active {
            background: var(--iconColor);
            color: white;
        }

        .table-container {
            overflow-x: auto;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--borderColor);
        }

        th {
            background-color: rgba(5, 197, 52, 0.1);
            color: var(--iconColor);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        tr.near-expiry {
            background-color: rgba(255, 193, 7, 0.1);
            border-left: 4px solid var(--warning);
        }

        tr.expired {
            background-color: rgba(220, 53, 69, 0.1);
            border-left: 4px solid var(--danger);
        }

        tr:hover {
            background-color: rgba(5, 197, 52, 0.05);
        }

        /* Dark Mode Toggle */
        .darkmode {
            position: fixed;
            bottom: 1rem;
            left: 1rem;
            font-size: 1.75rem;
            padding: 1rem;
            border-radius: 100%;
            border: 1px solid var(--iconColor);
            box-shadow: 0 0 1rem -0.25rem var(--iconColor), inset 0 0 1rem -0.75rem var(--iconColor);
            color: var(--iconColor);
            cursor: pointer;
            transition: all 0.25s;
            background: var(--sectionBackground);
            z-index: 100;
        }

        .darkmode:hover {
            box-shadow: 0 0 1rem -0.25rem var(--iconColor), inset 0 0 1rem -0.25rem var(--iconColor);
        }

        /* Animations */
        @keyframes float-1 {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(10%, 10%) scale(1.1); }
        }

        @keyframes float-2 {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(-10%, -5%) scale(1.15); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 20px;
            }
            
            .container {
                padding: 20px;
            }
            
            th, td {
                padding: 10px 8px;
                font-size: 0.9rem;
            }

            .filter-form {
                flex-direction: column;
                align-items: center;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
            }
            
            h1 {
                font-size: 1.5rem;
            }
            
            .holder-info p {
                display: flex;
                flex-direction: column;
            }
            
            .holder-info p strong {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="gradient-background">
        <div class="gradient-sphere sphere-1"></div>
        <div class="gradient-sphere sphere-2"></div>
        <div class="noise-overlay"></div>
    </div>

    <a href="logout" class="logout-btn">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <button class="darkmode fas fa-moon"></button>

    <div class="container">
        <h1>My Policy Details</h1>
        
        <%
            PolicyHolder holder = (PolicyHolder) request.getAttribute("policyHolder");
            if (holder != null) {
        %>
        <div class="holder-info">
            <h3>Policy Holder Information</h3>
            <p><strong>Name:</strong> <%= holder.getPhName() %></p>
            <p><strong>Email:</strong> <%= holder.getPhEmail() %></p>
            <p><strong>Date of Birth:</strong> <%= holder.getPhDob() %></p>
            <p><strong>Contact:</strong> <%= holder.getPhContact() %></p>
            <p><strong>Address:</strong> <%= holder.getPhAddress() %></p>
        </div>
        <%
            }
        %>
        
        <div class="filter-form">
            <button id="allPoliciesBtn" class="filter-btn active" onclick="filterPolicies('all')">All Policies</button>
            <button id="nearExpiryBtn" class="filter-btn" onclick="filterPolicies('nearExpiry')">Near Expiry (1 Month)</button>
            <button id="expiredBtn" class="filter-btn" onclick="filterPolicies('expired')">Expired Policies</button>
        </div>

        <div class="table-container">
            <table id="policiesTable">
                <thead>
                    <tr>
                        <th>Policy ID</th>
                        <th>Policy Title</th>
                        <th>Date of Birth</th>
                        <th>Holder Email</th>
                        <th>Policy Details</th>
                        <th>Due Date</th>
                        <th>Agent Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Policies> allPolicies = (List<Policies>) request.getAttribute("allPolicies");
                        PolicyHolder policyHolder = (PolicyHolder) request.getAttribute("policyHolder");
                        LocalDate today = LocalDate.now();
                        LocalDate oneMonthLater = today.plusMonths(1);
                        
                        if (allPolicies != null && policyHolder != null) {
                            for (Policies policy : allPolicies) {
                                // Only show policies that belong to the logged-in holder
                                if (policy.getPhEmail().equals(policyHolder.getPhEmail())) {
                                    Date utilDate = new Date(policy.getDueDate().getTime());
                                    LocalDate dueDate = utilDate.toInstant()
                                                      .atZone(ZoneId.systemDefault())
                                                      .toLocalDate();
                                    boolean isNearExpiry = !dueDate.isBefore(today) && !dueDate.isAfter(oneMonthLater);
                                    boolean isExpired = dueDate.isBefore(today);
                                    String rowClass = isNearExpiry ? "near-expiry" : isExpired ? "expired" : "";
                    %>
                    <tr class="<%= rowClass %>" data-expiry="<%= isNearExpiry ? "near" : isExpired ? "expired" : "other" %>">
                        <td><%= policy.getPolicyId() %></td>
                        <td><%= policy.getPolicyTitle() %></td>
                        <td><%= policy.getPhDob() %></td>
                        <td><%= policy.getPhEmail() %></td>
                        <td><%= policy.getPolicyDetails() %></td>
                        <td><%= policy.getDueDate() %></td>
                        <td><%= policy.getIaEmail() %></td>
                    </tr>
                    <%
                                }
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // Dark mode toggle
            $('.darkmode').click(function () {
                $('body').toggleClass('light-theme');
                $(this).toggleClass('fa-moon fa-sun');
            });

            // Filter policies function
            window.filterPolicies = function(filterType) {
                var rows = $("#policiesTable tbody tr");
                var allBtn = $("#allPoliciesBtn");
                var nearBtn = $("#nearExpiryBtn");
                var expiredBtn = $("#expiredBtn");
                
                // Update button styles
                $(".filter-btn").removeClass("active");
                
                if(filterType === 'all') {
                    allBtn.addClass("active");
                    rows.show();
                } else if(filterType === 'nearExpiry') {
                    nearBtn.addClass("active");
                    rows.each(function() {
                        $(this).toggle($(this).data("expiry") === "near");
                    });
                } else if(filterType === 'expired') {
                    expiredBtn.addClass("active");
                    rows.each(function() {
                        $(this).toggle($(this).data("expiry") === "expired");
                    });
                }
            };
        });
    </script>
</body>
</html>
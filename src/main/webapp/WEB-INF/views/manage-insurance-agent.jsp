<%@page import="java.util.List"%>
<%@page import="com.MyInsuranceAgent.model.InsuranceAgent"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String statusFilter = request.getParameter("statusFilter");
    if (statusFilter == null || statusFilter.isEmpty()) {
        statusFilter = "ALL";
    }
    List<InsuranceAgent> allAgents = (List<InsuranceAgent>) request.getAttribute("allAgents");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Insurance Agents</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.2/css/all.css">
    <style>
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
            padding: 30px;
        }

        :root {
            --background: #050505;
            --color: #F5F7FA;
            --sectionBackground: #222126;
            --borderColor: #252429;
            --text1: #F5F7FA;
            --text2: #E6E9ED;
            --iconColor: #05c534;
            --card-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
        }

        .light-theme {
            --background: #fcfbfe;
            --color: #323133;
            --sectionBackground: #ffffff;
            --borderColor: #e9e9e9;
            --text1: #323133;
            --text2: #3C3B3D;
            --iconColor: #0fce3d;
            --card-shadow: 0 10px 25px rgba(0, 0, 0, 0.1), 0 5px 10px rgba(0, 0, 0, 0.04);
        }

        /* Background Effects */
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
            max-width: 1100px;
            margin: auto;
            background: var(--sectionBackground);
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--borderColor);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--text1);
            font-weight: 600;
        }

        .filter-form {
            text-align: center;
            margin-bottom: 30px;
        }

        .filter-form button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            margin: 0 5px;
            cursor: pointer;
            background: var(--roleButtonBg);
            color: var(--roleButtonText);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .filter-form button:hover {
            background: var(--iconColor);
            color: white;
            transform: translateY(-2px);
        }

        .filter-form .active {
            background: var(--roleButtonActiveBg);
            color: white;
            box-shadow: 0 5px 15px rgba(5, 197, 52, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid var(--borderColor);
            color: var(--text1);
        }

        th {
            background: rgba(5, 197, 52, 0.1);
            font-weight: 600;
        }

        tr:hover {
            background: rgba(5, 197, 52, 0.05);
        }

        select {
            padding: 8px 12px;
            border-radius: 8px;
            border: 1px solid var(--borderColor);
            background: var(--sectionBackground);
            color: var(--text1);
            outline: none;
            transition: all 0.3s ease;
        }

        select:focus {
            border-color: var(--iconColor);
            box-shadow: 0 0 0 2px rgba(5, 197, 52, 0.2);
        }

        .status-form {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .status-form button {
            margin-left: 10px;
            padding: 8px 15px;
            border: none;
            border-radius: 8px;
            background: var(--iconColor);
            color: white;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .status-form button:hover {
            background: #0fce3d;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(5, 197, 52, 0.3);
        }

        .back-link {
            text-align: center;
            margin-top: 30px;
        }

        .back-link a {
            text-decoration: none;
            color: var(--iconColor);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            color: var(--text1);
            transform: translateX(-5px);
        }

        .back-link a i {
            margin-right: 8px;
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

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-PENDING {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-APPROVED {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-REJECTED {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
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
            .container {
                padding: 20px;
            }
            
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .filter-form button {
                padding: 8px 12px;
                margin: 5px 2px;
                font-size: 0.9rem;
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

<button class="darkmode fas fa-moon"></button>

<div class="container">
    <h1>Manage Insurance Agents</h1>

    <form method="GET" action="manageInsuranceAgents" class="filter-form">
        <button name="statusFilter" value="ALL" class="<%= statusFilter.equals("ALL") ? "active" : "" %>">All Agents</button>
        <button name="statusFilter" value="PENDING" class="<%= statusFilter.equals("PENDING") ? "active" : "" %>">Pending</button>
        <button name="statusFilter" value="APPROVED" class="<%= statusFilter.equals("APPROVED") ? "active" : "" %>">Approved</button>
        <button name="statusFilter" value="REJECTED" class="<%= statusFilter.equals("REJECTED") ? "active" : "" %>">Rejected</button>
    </form>
    
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Address</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            for (InsuranceAgent agent : allAgents) {
                if (statusFilter.equals("ALL") || agent.getIaStatus().equalsIgnoreCase(statusFilter)) {
        %>
        <tr>
            <td><%= agent.getIaName() %></td>
            <td><%= agent.getIaEmail() %></td>
            <td><%= agent.getIaContact() %></td>
            <td><%= agent.getIaAddress() %></td>
            <td>
                <span class="status-badge status-<%= agent.getIaStatus() %>">
                    <%= agent.getIaStatus() %>
                </span>
            </td>
            <td>
                <form action="changeStatus" method="POST" class="status-form">
                    <input type="hidden" name="iaEmail" value="<%= agent.getIaEmail() %>" />
                    <select name="newStatus">
                        <option value="PENDING" <%= "PENDING".equals(agent.getIaStatus()) ? "selected" : "" %>>PENDING</option>
                        <option value="APPROVED" <%= "APPROVED".equals(agent.getIaStatus()) ? "selected" : "" %>>APPROVED</option>
                        <option value="REJECTED" <%= "REJECTED".equals(agent.getIaStatus()) ? "selected" : "" %>>REJECTED</option>
                    </select>
                    <button type="submit">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
    
    <div class="back-link">
        <a href="dashboard"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $('.darkmode').click(function () {
            $('body').toggleClass('light-theme');
            $(this).toggleClass('fa-moon fa-sun');
        });
    });
</script>
</body>
</html>
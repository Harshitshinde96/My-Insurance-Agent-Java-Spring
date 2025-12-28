<%@page import="java.util.List"%>
<%@page import="com.MyInsuranceAgent.model.PolicyHolder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Policy Holders</title>
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
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

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
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

        tr:hover {
            background-color: rgba(5, 197, 52, 0.05);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            padding: 8px 15px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .delete-btn {
            color: #ff4d4d;
            background-color: rgba(255, 77, 77, 0.1);
        }

        .delete-btn:hover {
            background-color: rgba(255, 77, 77, 0.2);
        }

        .update-btn {
            color: var(--iconColor);
            background-color: rgba(5, 197, 52, 0.1);
        }

        .update-btn:hover {
            background-color: rgba(5, 197, 52, 0.2);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--iconColor);
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: var(--roleButtonActiveBg);
        }

        .back-link i {
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
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
            }
            
            h1 {
                font-size: 1.5rem;
            }
            
            .action-btn {
                padding: 6px 10px;
                font-size: 0.85rem;
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
        <h1>Manage Policy Holders</h1>
        
        <div class="table-container">
            <table class="accounts-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Date of Birth</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>Action</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<PolicyHolder> allHolders = (List<PolicyHolder>) request.getAttribute("allHolders");
                        for (PolicyHolder ph : allHolders) {
                    %>
                    <tr>
                        <td><%=ph.getPhName()%></td>
                        <td><%=ph.getPhEmail()%></td>
                        <td><%=ph.getPhDob()%></td>
                        <td><%=ph.getPhContact()%></td>
                        <td><%=ph.getPhAddress()%></td>
                        <td>
                            <a href="deletePolicyHolder?phEmail=<%= ph.getPhEmail() %>" class="action-btn delete-btn">
                                <i class="fas fa-trash-alt" style="margin-right: 6px;"></i> Delete
                            </a>
                        </td>
                        <td>
                            <a href="updatePolicyHolderPage?phEmail=<%= ph.getPhEmail() %>" class="action-btn update-btn">
                                <i class="fas fa-edit" style="margin-right: 6px;"></i> Update
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <a href="dashboard" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // Dark mode toggle
            $('.darkmode').click(function () {
                $('body').toggleClass('light-theme');
                $(this).toggleClass('fa-moon fa-sun');
            });
        });
    </script>
</body>
</html>
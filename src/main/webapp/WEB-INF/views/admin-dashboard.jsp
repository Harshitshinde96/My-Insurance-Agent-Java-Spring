<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - My Insurance Agent</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
    min-height: 100vh;
    overflow-x: hidden;
  }

  body.light-theme {
    background: #fcfbfe;
  }

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
    --sidebar-width: 280px;
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

  /* Layout Structure */
  .dashboard-wrapper {
    display: flex;
    min-height: 100vh;
  }

  /* Sidebar */
  .sidebar {
    width: var(--sidebar-width);
    background: rgba(34, 33, 38, 0.8);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    padding: 30px 0;
    transition: all 0.3s ease;
    position: fixed;
    height: 100vh;
    z-index: 10;
  }

  .light-theme .sidebar {
    background: rgba(255, 255, 255, 0.8);
    border-right: 1px solid rgba(0, 0, 0, 0.1);
  }

  .sidebar-header {
    padding: 0 25px 30px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 30px;
  }

  .light-theme .sidebar-header {
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  }

  .sidebar-header h2 {
    color: var(--text1);
    font-weight: 600;
    font-size: 1.5rem;
  }

  .sidebar-header p {
    color: var(--text2);
    font-size: 0.9rem;
    opacity: 0.8;
  }

  .nav-menu {
    list-style: none;
  }

  .nav-item {
    margin-bottom: 5px;
  }

  .nav-link {
    display: flex;
    align-items: center;
    padding: 12px 25px;
    color: var(--text2);
    text-decoration: none;
    transition: all 0.3s ease;
    font-weight: 500;
  }

  .nav-link:hover, .nav-link.active {
    color: var(--iconColor);
    background: rgba(5, 197, 52, 0.1);
  }

  .nav-link i {
    margin-right: 12px;
    font-size: 1.1rem;
    width: 20px;
    text-align: center;
  }

  /* Main Content */
  .main-content {
    flex: 1;
    margin-left: var(--sidebar-width);
    padding: 30px;
    transition: all 0.3s ease;
  }

  /* Top Navigation */
  .top-nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }

  .light-theme .top-nav {
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  }

  .page-title h1 {
    color: var(--text1);
    font-weight: 600;
    font-size: 1.8rem;
  }

  .user-menu {
    display: flex;
    align-items: center;
  }

  .user-info {
    margin-right: 15px;
    text-align: right;
  }

  .user-name {
    color: var(--text1);
    font-weight: 500;
  }

  .user-role {
    color: var(--text2);
    font-size: 0.8rem;
    opacity: 0.8;
  }

  .user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: var(--iconColor);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: 600;
    cursor: pointer;
  }

  /* Dashboard Cards */
  .card-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 25px;
    margin-bottom: 30px;
  }

  .card {
    background: var(--sectionBackground);
    border-radius: 12px;
    padding: 25px;
    box-shadow: var(--card-shadow);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: 1px solid var(--borderColor);
  }

  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
  }

  .light-theme .card:hover {
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .card-title {
    font-size: 1rem;
    color: var(--text2);
    font-weight: 500;
  }

  .card-icon {
    width: 40px;
    height: 40px;
    border-radius: 8px;
    background: rgba(5, 197, 52, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--iconColor);
  }

  .card-value {
    font-size: 2rem;
    font-weight: 600;
    color: var(--text1);
    margin-bottom: 5px;
  }

  .card-description {
    font-size: 0.9rem;
    color: var(--text2);
    opacity: 0.8;
  }

  /* Recent Activity */
  .activity-section {
    background: var(--sectionBackground);
    border-radius: 12px;
    padding: 25px;
    box-shadow: var(--card-shadow);
    margin-bottom: 30px;
    border: 1px solid var(--borderColor);
  }

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .section-title {
    font-size: 1.2rem;
    color: var(--text1);
    font-weight: 600;
  }

  .view-all {
    color: var(--iconColor);
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 500;
  }

  .activity-list {
    list-style: none;
  }

  .activity-item {
    display: flex;
    padding: 15px 0;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  }

  .light-theme .activity-item {
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  }

  .activity-item:last-child {
    border-bottom: none;
  }

  .activity-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: rgba(5, 197, 52, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--iconColor);
    margin-right: 15px;
    flex-shrink: 0;
  }

  .activity-content {
    flex: 1;
  }

  .activity-title {
    color: var(--text1);
    font-weight: 500;
    margin-bottom: 5px;
  }

  .activity-time {
    color: var(--text2);
    font-size: 0.8rem;
    opacity: 0.8;
  }

  /* Quick Actions */
  .quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 15px;
    margin-top: 30px;
  }

  .action-btn {
    background: var(--roleButtonBg);
    border-radius: 8px;
    padding: 15px;
    text-align: center;
    color: var(--roleButtonText);
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
    border: 1px solid var(--borderColor);
  }

  .action-btn:hover {
    background: var(--roleButtonActiveBg);
    color: white;
    transform: translateY(-3px);
  }

  .action-btn i {
    font-size: 1.5rem;
    margin-bottom: 10px;
    color: var(--iconColor);
  }

  .action-btn:hover i {
    color: white;
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
  @media (max-width: 992px) {
    .sidebar {
      width: 80px;
      overflow: hidden;
    }
    
    .sidebar-header h2, 
    .sidebar-header p,
    .nav-link span {
      display: none;
    }
    
    .nav-link {
      justify-content: center;
      padding: 15px 0;
    }
    
    .nav-link i {
      margin-right: 0;
      font-size: 1.3rem;
    }
    
    .main-content {
      margin-left: 80px;
    }
  }

  @media (max-width: 768px) {
    .card-grid {
      grid-template-columns: 1fr;
    }
    
    .quick-actions {
      grid-template-columns: 1fr 1fr;
    }
  }

  @media (max-width: 576px) {
    .sidebar {
      transform: translateX(-100%);
      width: 280px;
      z-index: 100;
    }
    
    .sidebar.active {
      transform: translateX(0);
    }
    
    .main-content {
      margin-left: 0;
    }
    
    .top-nav {
      flex-direction: column;
      align-items: flex-start;
    }
    
    .user-menu {
      margin-top: 15px;
      width: 100%;
      justify-content: space-between;
    }
    
    .quick-actions {
      grid-template-columns: 1fr;
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

  <div class="dashboard-wrapper">
    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="sidebar-header">
        <h2>Insurance Admin</h2>
        <p>Administration Panel</p>
      </div>
      
      <ul class="nav-menu">
        <li class="nav-item">
          <a href="#" class="nav-link active">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="manageInsuranceAgents" class="nav-link">
            <i class="fas fa-users-cog"></i>
            <span>Manage Agents</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="fas fa-user-friends"></i>
            <span>Policy Holders</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="fas fa-file-contract"></i>
            <span>Policies</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="fas fa-chart-line"></i>
            <span>Analytics</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
          </a>
        </li>
        <li class="nav-item">
          <a href="logout" class="nav-link">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
          </a>
        </li>
      </ul>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="top-nav">
        <div class="page-title">
          <h1>Admin Dashboard</h1>
        </div>
        
        <div class="user-menu">
          <div class="user-info">
            <div class="user-name">Admin User</div>
            <div class="user-role">Super Administrator</div>
          </div>
          <div class="user-avatar">AU</div>
        </div>
      </div>

      <!-- Dashboard Cards -->
      <div class="card-grid">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Total Agents</div>
            <div class="card-icon">
              <i class="fas fa-users"></i>
            </div>
          </div>
          <div class="card-value">142</div>
          <div class="card-description">+12 this month</div>
        </div>
        
        <div class="card">
          <div class="card-header">
            <div class="card-title">Active Policies</div>
            <div class="card-icon">
              <i class="fas fa-file-contract"></i>
            </div>
          </div>
          <div class="card-value">2,548</div>
          <div class="card-description">+124 this week</div>
        </div>
        
        <div class="card">
          <div class="card-header">
            <div class="card-title">Pending Claims</div>
            <div class="card-icon">
              <i class="fas fa-clipboard-list"></i>
            </div>
          </div>
          <div class="card-value">87</div>
          <div class="card-description">12 awaiting review</div>
        </div>
        
        <div class="card">
          <div class="card-header">
            <div class="card-title">Revenue</div>
            <div class="card-icon">
              <i class="fas fa-dollar-sign"></i>
            </div>
          </div>
          <div class="card-value">$284K</div>
          <div class="card-description">+8.5% from last month</div>
        </div>
      </div>

      <!-- Recent Activity -->
      <div class="activity-section">
        <div class="section-header">
          <h2 class="section-title">Recent Activity</h2>
          <a href="#" class="view-all">View All</a>
        </div>
        
        <ul class="activity-list">
          <li class="activity-item">
            <div class="activity-icon">
              <i class="fas fa-user-plus"></i>
            </div>
            <div class="activity-content">
              <div class="activity-title">New agent registered</div>
              <div class="activity-time">10 minutes ago</div>
            </div>
          </li>
          
          <li class="activity-item">
            <div class="activity-icon">
              <i class="fas fa-file-signature"></i>
            </div>
            <div class="activity-content">
              <div class="activity-title">Policy #45892 was approved</div>
              <div class="activity-time">2 hours ago</div>
            </div>
          </li>
          
          <li class="activity-item">
            <div class="activity-icon">
              <i class="fas fa-exclamation-circle"></i>
            </div>
            <div class="activity-content">
              <div class="activity-title">System maintenance scheduled</div>
              <div class="activity-time">Yesterday, 5:30 PM</div>
            </div>
          </li>
          
          <li class="activity-item">
            <div class="activity-icon">
              <i class="fas fa-chart-line"></i>
            </div>
            <div class="activity-content">
              <div class="activity-title">Monthly report generated</div>
              <div class="activity-time">Yesterday, 11:45 AM</div>
            </div>
          </li>
        </ul>
      </div>

      <!-- Quick Actions -->
      <h2 class="section-title">Quick Actions</h2>
      <div class="quick-actions">
        <a href="manageInsuranceAgents" class="action-btn">
          <i class="fas fa-users-cog"></i>
          Manage Agents
        </a>
        
        <a href="#" class="action-btn">
          <i class="fas fa-user-plus"></i>
          Add New Agent
        </a>
        
        <a href="#" class="action-btn">
          <i class="fas fa-file-import"></i>
          Import Policies
        </a>
        
        <a href="#" class="action-btn">
          <i class="fas fa-chart-pie"></i>
          View Reports
        </a>
      </div>
    </main>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script>
    $(document).ready(function () {
      // Dark mode toggle
      $('.darkmode').click(function () {
        $('body').toggleClass('light-theme');
        $(this).toggleClass('fa-moon fa-sun');
      });

      // Mobile menu toggle
      $('.user-avatar').click(function() {
        $('.sidebar').toggleClass('active');
      });
    });
  </script>
</body>
</html>
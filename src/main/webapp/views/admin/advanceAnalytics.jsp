<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    // AUTH GUARD - You should place the AUTH GUARD logic here if the servlet
    // is not explicitly handling authorization before forwarding.
    // Example:
    /*
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("role") == null ||
            !"ADMIN".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
    */
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Analytics - Nexus Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144;      /* Primary Dark Blue/Teal (Sidebar/Headings) */
            --nexus-accent: #008be6;    /* Bright Blue/Cyan Accent (Links/Primary Action) */
            --nexus-light: #F0F4F8;     /* Light background */
            --sidebar-active: #0055a4;
        }

        /* --- GLOBAL STYLES --- */
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--nexus-light);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* --- SIDEBAR --- */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--nexus-dark), #203a43, #2c5364);
            color: #ffffff;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }
        .sidebar-header {
            padding: 2rem 1.5rem;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            background: rgba(0,0,0,0.1);
        }
        .nexus-brand {
            font-weight: 800;
            font-size: 1.5rem;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            color: #ffffff;
        }
        .nexus-brand svg { width: 28px; height: 28px; fill: var(--nexus-accent); }
        .sidebar-nav { padding-top: 1rem; }
        .sidebar-nav .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 1rem 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-left: 4px solid transparent;
        }
        .sidebar-nav .nav-link i {
            margin-right: 1rem;
            width: 25px;
            text-align: center;
            transition: transform 0.3s;
        }
        .sidebar-nav .nav-link:hover {
            background-color: rgba(255,255,255,0.05);
            color: #ffffff;
            padding-left: 2.5rem;
        }
        .sidebar-nav .nav-link.active {
            background: var(--sidebar-active);
            color: #ffffff;
            font-weight: 600;
            border-left: 4px solid var(--nexus-accent);
            box-shadow: inset 5px 0 10px -5px rgba(0, 163, 255, 0.4);
        }
        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 1.5rem;
            background: rgba(0,0,0,0.2);
        }

        /* --- MAIN CONTENT / CARD STYLES --- */
        .main-content { margin-left: 280px; width: calc(100% - 280px); transition: all 0.3s; }
        .top-navbar { background-color: #ffffff; box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05); padding: 1rem 2rem; position: sticky; top: 0; z-index: 999; }

        .main-card { border: 1px solid #e0e0e0; border-radius: 15px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05); background: white; padding: 1.5rem; }
        .card-header-custom { border-bottom: 1px solid #eee; padding-bottom: 1rem; margin-bottom: 1rem; display: flex; justify-content: space-between; align-items: center;}
        .card-header-custom h5 { color: var(--nexus-dark); font-weight: 700; }

        /* KPI Card Styling */
        .kpi-stat-number { font-size: 2.5rem; font-weight: 900; color: var(--nexus-dark); }
        .kpi-stat-label { font-size: 0.9rem; font-weight: 600; color: #666; }
        .kpi-card {
            border-left: 5px solid var(--nexus-accent);
            border-radius: 10px;
            padding: 1rem;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: all 0.3s;
            height: 100%;
        }
        .kpi-card:hover {
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }


        /* Responsive collapse logic */
        @media (max-width: 991.98px) { .sidebar { margin-left: -280px; } .main-content { margin-left: 0; width: 100%; } .sidebar.active { margin-left: 0; } }
    </style>
</head>
<body>

<%-- 1. SIDEBAR STRUCTURE --%>
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="nexus-brand animate__animated animate__fadeIn">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-1.88 12.82l-2.58-2.58L6.47 12l2.05 2.05 4.49-4.49 1.06 1.06-5.55 5.55z"/>
            </svg>
            NEXUS HUB
        </div>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management">
                <i class="fas fa-users-cog"></i> User Management
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/complaint-monitor">
                <i class="fas fa-tasks"></i> Complaint Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/analytics">
                <i class="fas fa-chart-line"></i> Advanced Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/station-directory">
                <i class="fas fa-building"></i> Station/Dept.
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/broadcast_aleart.jsp" data-bs-toggle="modal" data-bs-target="#alertModal">
                <i class="fas fa-bullhorn"></i> Broadcast Alert
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light w-100 btn-sm fw-bold">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<%-- 2. MAIN CONTENT AREA --%>
<div class="main-content" id="main-content">
    <nav class="navbar navbar-expand-lg top-navbar">
        <div class="container-fluid">
            <button class="btn border-0" id="sidebar-toggle">
                <i class="fas fa-bars fs-4 text-secondary"></i>
            </button>
            <div class="ms-auto d-flex align-items-center gap-3">
                <span class="fw-bold text-uppercase text-secondary me-3">Advanced Analytics</span>
                <img src="https://ui-avatars.com/api/?name=Admin+User&background=1C3144&color=fff" class="rounded-circle shadow-sm" width="35" height="35" alt="Admin">
            </div>
        </div>
    </nav>
    <div class="container-fluid p-4">
        <h3 class="fw-bold text-dark mb-4"><i class="fas fa-chart-line me-2 text-secondary"></i> Advanced System Analytics</h3>

        <div class="row g-4 mb-5">

            <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="100">
                <div class="kpi-card" style="border-left-color: #007bff;">
                    <div class="kpi-stat-number">${totalPolice}</div>
                    <div class="kpi-stat-label">Total Police Officers</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                <div class="kpi-card" style="border-left-color: #28a745;">
                    <div class="kpi-stat-number">${totalCivilians}</div>
                    <div class="kpi-stat-label">Total Civilians Registered</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                <div class="kpi-card" style="border-left-color: #ff9800;">
                    <div class="kpi-stat-number">${totalStations}</div>
                    <div class="kpi-stat-label">Active Police Stations</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="400">
                <div class="kpi-card" style="border-left-color: #673ab7;">
                    <div class="kpi-stat-number">${totalComplaints}</div>
                    <div class="kpi-stat-label">Total Complaints Filed</div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">

            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="kpi-card" style="border-left-color: #4caf50;">
                    <div class="kpi-stat-number">${resolvedComplaints}</div>
                    <div class="kpi-stat-label">Cases Marked Resolved</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                <div class="kpi-card" style="border-left-color: #ff5722;">
                    <div class="kpi-stat-number">${investigationComplaints}</div>
                    <div class="kpi-stat-label">Currently Under Investigation</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                <div class="kpi-card" style="border-left-color: #03a9f4;">
                    <div class="kpi-stat-number">${assignedComplaints}</div>
                    <div class="kpi-stat-label">Total Cases Assigned</div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                <div class="kpi-card" style="border-left-color: #e91e63;">
                    <div class="kpi-stat-number">${unassignedComplaints}</div>
                    <div class="kpi-stat-label">Unassigned Complaints (Pending Review)</div>
                </div>
            </div>
        </div>
        <div class="row g-4 mb-4">
            <div class="col-lg-6" data-aos="fade-right">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-chart-bar me-2"></i> Monthly Complaint Volume</h5>
                    </div>
                    <canvas id="volumeChart" style="max-height: 350px;"></canvas>
                </div>
            </div>
            <div class="col-lg-6" data-aos="fade-left">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-location-arrow me-2"></i> Top 5 Incident Types</h5>
                    </div>
                    <canvas id="typeChart" style="max-height: 350px;"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- 3. JAVASCRIPT --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });

    // Sidebar Toggle Logic (essential for responsiveness)
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        // Toggle the 'active' class for mobile responsiveness
        sidebar.classList.toggle('active');

        // Toggle the margin-left for desktop
        if (window.innerWidth >= 992) {
            // Check if the sidebar is currently off-screen (due to previous toggle)
            if (sidebar.classList.contains('active')) {
                mainContent.style.marginLeft = '280px'; // Push content back
            } else {
                mainContent.style.marginLeft = '0px'; // Remove content margin (hides sidebar)
            }
        }
    });

    // --- Chart JS Logic for Advanced Analytics ---

    // 1. Monthly Complaint Volume (Bar Chart)
    const ctxVolume = document.getElementById('volumeChart').getContext('2d');
    new Chart(ctxVolume, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Total Complaints',
                data: [450, 480, 520, 500, 550, 610],
                backgroundColor: 'var(--nexus-accent)',
                borderColor: 'var(--nexus-accent)',
                borderWidth: 1,
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: { y: { beginAtZero: true } }
        }
    });

    // 2. Top 5 Incident Types (Radar Chart)
    const ctxType = document.getElementById('typeChart').getContext('2d');
    new Chart(ctxType, {
        type: 'radar',
        data: {
            labels: ['Theft', 'Assault', 'Cybercrime', 'Domestic', 'Accident'],
            datasets: [{
                label: 'Volume Share (%)',
                data: [30, 20, 15, 12, 8],
                backgroundColor: 'rgba(28, 49, 68, 0.4)',
                borderColor: 'var(--nexus-dark)',
                borderWidth: 2,
                pointBackgroundColor: 'var(--nexus-accent)'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            },
            elements: { line: { tension: 0.1 } },
            scales: { r: {
                    ticks: { display: false },
                    pointLabels: { font: { size: 12, weight: 'bold' } },
                    grid: { color: 'rgba(0,0,0,0.1)' }
                }}
        }
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Civilian Dashboard - Nexus Hub</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144;      /* Primary Dark Blue/Teal (Sidebar/Headings) */
            --nexus-accent: #00A3FF;    /* Bright Blue/Cyan Accent (Links/Primary Action) */
            --nexus-light: #F0F4F8;     /* Light background */
            --nexus-light-hover: #e8ecf2; /* New: Slightly darker light background for contrast */
            --sidebar-hover: #004d7a;
            --sidebar-active: #0055a4;
            --card-shadow: 0 8px 25px rgba(0,0,0,0.12); /* Deeper shadow for cards */
        }

        /* --- GLOBAL STYLES --- */
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--nexus-light);
            display: flex;
            min-height: 100vh;
        }

        /* --- SIDEBAR (Navigation) */
        .sidebar {
            width: 260px;
            background: var(--nexus-dark);
            color: #ffffff;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            box-shadow: 4px 0 20px rgba(0,0,0,0.4); /* Much stronger shadow for depth */
            z-index: 1000;
            transition: all 0.3s;
        }
        .sidebar-header {
            padding: 1.5rem;
            text-align: center;
            border-bottom: 2px solid var(--sidebar-hover);
            font-weight: 900;
            letter-spacing: 0.5px; /* Added letter spacing */
        }
        .sidebar-header h3 i {
            color: var(--nexus-accent);
            text-shadow: 0 0 5px rgba(0, 163, 255, 0.5); /* Glowing effect */
        }

        .sidebar-nav .nav-link {
            color: #e0e0e0;
            padding: 1.1rem 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94); /* Smoother transition curve */
            border-left: 5px solid transparent;
            position: relative;
        }
        .sidebar-nav .nav-link:hover {
            background-color: var(--sidebar-hover);
            color: #ffffff;
            transform: scale(1.02); /* Slight scale on hover for depth */
        }
        .sidebar-nav .nav-link.active {
            background-color: var(--sidebar-active);
            color: #ffffff;
            font-weight: 800;
            border-left: 5px solid var(--nexus-accent);
            box-shadow: inset 3px 0 8px rgba(0, 163, 255, 0.3); /* Inner shadow for depth */
        }
        .sidebar-nav .nav-link i { margin-right: 12px; font-size: 1.2rem; }

        .sidebar-footer {
            /* Position fixed to ensure it stays at the bottom */
            position: sticky;
            bottom: 0;
            width: 100%;
            padding: 1rem;
            background-color: var(--nexus-dark); /* Ensure background covers content */
            border-top: 1px solid var(--sidebar-hover);
        }

        /* --- MAIN CONTENT --- */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 0;
            transition: margin-left 0.3s;
        }
        .top-navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1); /* Lighter shadow for the top bar */
            padding: 0.75rem 2rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }
        .content-area {
            padding: 2rem;
            background-color: var(--nexus-light-hover); /* Introduce slight background color variation */
        }
        .welcome-text {
            color: var(--nexus-dark);
            font-weight: 800;
            font-size: 1.3rem;
            text-shadow: 0 1px 1px rgba(0,0,0,0.1); /* Subtle heading shadow */
        }
        .main-heading { font-weight: 900; color: var(--nexus-dark); margin-bottom: 2rem; }

        /* --- FEATURED BLOCKS --- */
        .welcome-banner {
            background: linear-gradient(135deg, #ffffff 40%, var(--nexus-light) 100%); /* Diagonal gradient for modern look */
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            border-left: 6px solid var(--nexus-accent);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15); /* Deep shadow */
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease-out;
        }
        .welcome-banner:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .alert-card {
            background-color: #fdd; /* Very light red background */
            border: 2px solid #dc3545;
            color: #a71d2a; /* Deeper red text */
            padding: 1.5rem;
            border-radius: 12px;
            font-weight: 700;
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }
        .alert-card:hover {
            background-color: #fff0f0;
            transform: scale(1.02); /* Lift and scale */
        }
        .alert-card .btn-outline-danger {
            border-width: 2px;
        }

        /* --- STAT CARDS --- */
        .stat-card {
            background-color: #ffffff;
            border: none;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            height: 100%;
            position: relative;
            overflow: hidden;
        }
        .stat-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 100% 0, rgba(255,255,255,0.05) 10%, transparent 70%);
            transition: opacity 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-8px); /* Deeper lift */
            box-shadow: 0 18px 40px rgba(0,0,0,0.2); /* Deeper shadow */
        }
        .card-icon {
            width: 65px;
            height: 65px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-right: 1.5rem;
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.25); /* Inner shadow for icons */
        }

        .icon-total { background-color: #3f51b5; }
        .icon-pending { background-color: #ff9800; }
        .icon-resolved { background-color: #4caf50; }

        .card-info h5 {
            font-size: 1.05rem;
            font-weight: 700;
            color: #555;
            margin-bottom: 0.25rem;
        }
        .stat-number {
            font-size: 2.8rem;
            font-weight: 900;
            color: var(--nexus-dark);
            text-shadow: 1px 1px 0 rgba(0,0,0,0.05);
        }

        /* --- CHART/ANALYTICS CARD/MAIN CARD --- */
        .analytics-card, .main-card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 0;
            transition: box-shadow 0.3s;
            overflow: hidden;
        }
        .analytics-card {
            padding: 1.5rem;
        }
        .analytics-card h5, .main-card h4 {
            font-weight: 900;
            color: var(--nexus-dark);
            text-shadow: 0 1px 0 rgba(0,0,0,0.05);
        }
        .main-card .card-header {
            border-bottom: 1px solid var(--nexus-light-hover);
            padding: 1.2rem 1.5rem;
        }


        /* --- TABLE STYLES --- */
        .table-responsive {
            border-radius: 0 0 15px 15px; /* Round bottom corners */
            overflow: hidden;
        }
        .table {
            --bs-table-hover-bg: var(--nexus-light); /* Highlight rows clearly */
        }
        .table > :not(caption) > * > * {
            padding: 1rem 1.5rem;
            border-bottom-width: 0; /* Remove horizontal lines */
        }
        .table thead tr {
            border-bottom: 2px solid var(--nexus-light-hover); /* Add separator to header */
        }
        .badge-status {
            font-weight: 800;
            padding: 0.7em 1.2em;
            min-width: 120px;
            border-radius: 50px;
            text-transform: uppercase;
        }

        /* Custom Button Styling */
        .btn-primary-accent {
            background-color: var(--nexus-accent);
            border-color: var(--nexus-accent);
            color: #ffffff; /* Change text to white for contrast */
            font-weight: 800;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 163, 255, 0.4);
            text-shadow: 0 1px 1px rgba(0,0,0,0.2);
        }
        .btn-primary-accent:hover {
            background-color: #008be6;
            border-color: #008be6;
            color: #ffffff;
            box-shadow: 0 6px 20px rgba(0, 163, 255, 0.6);
            transform: translateY(-2px);
        }

        /* Modals - Deeper Look */
        .modal-content {
            box-shadow: 0 15px 50px rgba(0,0,0,0.4);
            border: none;
        }

        /* Responsive Sidebar Toggle */
        @media (max-width: 768px) {
            .sidebar {
                margin-left: -260px;
                box-shadow: none;
            }
            .main-content { margin-left: 0; width: 100%; }
            .sidebar.active {
                margin-left: 0;
                box-shadow: 4px 0 20px rgba(0,0,0,0.4);
            }
        }
    </style>
</head>

<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h3><i class="bi bi-shield-fill-check"></i> NEXUS HUB</h3>
    </div>

    <ul class="nav flex-column sidebar-nav p-3">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="fas fa-chart-line"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#fileComplaintModal">
                <i class="fas fa-file-alt"></i> File New Complaint
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#complaint-history">
                <i class="fas fa-history"></i> My History
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#analytics-section">
                <i class="fas fa-chart-pie"></i> My Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#nearby-crimes">
                <i class="fas fa-map-marked-alt"></i> Nearby Crime Map
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#tips-resources">
                <i class="fas fa-lightbulb"></i> Tips & Resources
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/civilian/profile">
                <i class="fas fa-user-circle"></i> Profile Settings
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">

        <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light w-100 fw-bold">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<div class="main-content" id="main-content">

    <nav class="navbar navbar-expand-lg top-navbar">
        <div class="container-fluid">
            <button class="btn d-md-none" id="sidebar-toggle">
                <i class="fas fa-bars fs-5 text-secondary"></i>
            </button>

            <span class="navbar-text welcome-text d-none d-md-block">
                Welcome, <%= session.getAttribute("user_name") %> 👋 !
            </span>

            <div class="ms-auto d-flex align-items-center">
                <a class="btn btn-primary-accent btn-md me-3 d-none d-lg-block" href="#" data-bs-toggle="modal" data-bs-target="#fileComplaintModal">
                    <i class="fas fa-plus me-1"></i> File New Complaint
                </a>
                <a href="#" class="text-decoration-none position-relative" title="Notifications">
                    <i class="fas fa-bell fs-5 text-secondary"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">3</span>
                </a>
            </div>
        </div>
    </nav>

    <main class="content-area">

        <div class="row g-4 mb-5">
            <div class="col-lg-8">
                <div class="welcome-banner">
                    <h4 class="fw-bold text-dark mb-2">Hello, <%= session.getAttribute("user_name") %>!</h4>
                    <p class="text-muted mb-0">Your safety is our priority. Use the <b>File New Complaint</b> option to report incidents or check your case status below.</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="stat-card bg-primary bg-gradient text-white" style="border:none; background: linear-gradient(45deg, var(--sidebar-active), var(--nexus-accent));">
                    <div class="card-icon" style="background: rgba(255,255,255,0.2);"><i class="fas fa-hand-point-right"></i></div>
                    <div class="card-info">
                        <h5 class="text-uppercase text-white">Need to Report?</h5>
                        <a href="#" class="btn btn-sm btn-light fw-bold mt-1" data-bs-toggle="modal" data-bs-target="#fileComplaintModal">
                            <i class="fas fa-plus-circle me-1"></i> File New Complaint
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-lg-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="stat-card">
                            <div class="card-icon icon-total"><i class="fas fa-file-alt"></i></div>
                            <div class="card-info">
                                <h5 class="text-uppercase">Total Filed</h5>
                                <span class="stat-number"><%= session.getAttribute("totalFiled") %></span>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="stat-card">
                            <div class="card-icon icon-pending"><i class="fas fa-hourglass-half"></i></div>
                            <div class="card-info">
                                <h5 class="text-uppercase">In Progress</h5>
                                <span class="stat-number"><%= session.getAttribute("inProgress") %></span>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="stat-card">
                            <div class="card-icon icon-resolved"><i class="fas fa-check-circle"></i></div>
                            <div class="card-info">
                                <h5 class="text-uppercase">Cases Resolved</h5>
                                <span class="stat-number"><%= session.getAttribute("resolved") %></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4" id="analytics-section">
                <div class="analytics-card h-100">
                    <h5 class="mb-3"><i class="fas fa-chart-pie me-2"></i>My Case Status Breakdown</h5>
                    <div style="height: 250px;">
                        <canvas id="caseStatusChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="alert-card h-100">
                    <div class="d-flex align-items-center mb-2">
                        <i class="fas fa-exclamation-triangle me-2 fs-4"></i>
                        <h6 class="mb-0 fw-bold">CRIME ALERT: Nearby Incident!</h6>
                    </div>
                    <p class="small mb-2">A recent incident (Theft) reported 1.5 km from your registered address. Stay vigilant.</p>
                    <a href="#nearby-crimes" class="small text-decoration-none fw-bold" style="color: #a71d2a;">View Map Details →</a>
                    <hr class="text-danger my-2">
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold">Submit Anonymous Tip</button>
                </div>
            </div>
        </div>

        <div class="container mt-4" id="complaint-history">

            <div class="main-card">

                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-list-ul me-2"></i> My Complaint History</h4>
                    <a href="${pageContext.request.contextPath}/civilian/complaints" class="btn btn-sm btn-outline-secondary">View All</a>
                </div>

                <div class="table-responsive">

                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Complaint ID</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Assigned To</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="c" items="${sessionScope.complaints}">
                            <tr>

                                <td><strong>${c.complaintId}</strong></td>

                                <td>${c.complaintType}</td>

                                <td>
                <span class="badge rounded-pill badge-status
                    <c:choose>
                        <c:when test='${c.currentStatus == "RESOLVED"}'> bg-success </c:when>
                        <c:when test='${c.currentStatus == "UNDER_INVESTIGATION"}'> bg-warning text-dark </c:when>
                        <c:when test='${c.currentStatus == "UNDER_REVIEW"}'> bg-info text-dark </c:when>
                        <c:otherwise> bg-secondary </c:otherwise>
                    </c:choose>
                ">
                        ${c.currentStatus}
                </span>
                                </td>

                                <td class="text-muted">Not Assigned</td>

                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-2"
                                            data-bs-toggle="modal"
                                            data-bs-target="#timelineModal">
                                        <i class="fas fa-sitemap"></i> Timeline
                                    </button>

                                    <button class="btn btn-sm btn-outline-info"
                                            data-bs-toggle="modal"
                                            data-bs-target="#followupModal">
                                        <i class="fas fa-share-square"></i> Follow-up
                                    </button>
                                </td>

                            </tr>
                        </c:forEach>

                        <c:if test="${empty sessionScope.complaints}">
                            <tr>
                                <td colspan="6" class="text-center text-muted p-4">
                                    <i class="fas fa-file-invoice me-2"></i>
                                    No complaints filed yet. Start your first report!
                                </td>
                            </tr>
                        </c:if>

                        </tbody>
                    </table>


                </div>
            </div>

        </div>


        <div class="main-card mt-5" id="nearby-crimes">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4><i class="fas fa-map-marked-alt me-2"></i>Nearby Crime Activity</h4>
                <select class="form-select w-auto form-select-sm">
                    <option>Last 7 Days</option>
                    <option>Last 30 Days</option>
                    <option>All Time</option>
                </select>
            </div>
            <div class="p-4 text-center">
                <div id="map-container">
                    <div style="display: flex; align-items: center; justify-content: center; height: 100%; color: #343a40;">
                        <i class="fas fa-map-marker-alt fs-1 me-2"></i>
                        Loading Google Map...
                    </div>
                </div>
            </div>
        </div>

        <div class="main-card mt-5" id="tips-resources">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4><i class="fas fa-lightbulb me-2"></i>Safety Tips & Resources</h4>
            </div>
            <div class="p-4">
                <div class="row g-4">
                    <div class="col-md-6">
                        <h6 class="fw-bold text-primary"><i class="fas fa-lock me-2"></i>Digital Safety Tips</h6>
                        <ul class="small text-muted mb-0 list-unstyled">
                            <li><i class="fas fa-check-circle me-2 text-success"></i>Use two-factor authentication on all sensitive accounts.</li>
                            <li><i class="fas fa-check-circle me-2 text-success"></i>Verify calls/emails claiming to be from your bank.</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6 class="fw-bold text-primary"><i class="fas fa-ambulance me-2"></i>Emergency Contacts</h6>
                        <p class="small mb-0">Police: <strong class="text-danger">100</strong> | Fire: <strong class="text-danger">101</strong> | Nexus Support: <strong class="text-dark">support@nexus.gov</strong></p>
                        <a href="#" class="btn btn-sm btn-outline-info mt-2">Download Official Safety Guide</a>
                    </div>
                </div>
            </div>
        </div>


    </main>
</div>

<div class="modal fade" id="fileComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-3">
            <div class="modal-header text-white" style="background: var(--nexus-dark);">
                <h5 class="modal-title fw-bold">
                    <i class="fas fa-pencil-alt me-2"></i>File a New Complaint
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body p-4">
                <%
                    String error = (String) request.getParameter("error");
                    String msg = (String) request.getParameter("msg");
                %>

                <% if (msg != null) { %>
                <div class="alert alert-success fw-semibold">
                    <i class="bi bi-check-circle-fill me-1"></i> <%= msg %>
                </div>
                <% } %>

                <% if (error != null) { %>
                <div class="alert alert-danger fw-semibold">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i> <%= error %>
                </div>
                <% } %>

                <p class="text-muted small">
                    Please provide accurate details to help the police investigate quickly.
                </p>

                <form action="<%=request.getContextPath()%>/file_complaint" method="post">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Complaint Type</label>
                            <select name="complaint_type" class="form-select" required>
                                <option value="">Select type...</option>
                                <option value="Theft">Theft / Robbery</option>
                                <option value="Assault">Assault / Harassment</option>
                                <option value="Cybercrime">Cybercrime / Online Fraud</option>
                                <option value="Accident">Accident</option>
                                <option value="Domestic Violence">Domestic Violence</option>
                                <option value="Missing Person">Missing Person</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Date of Incident</label>
                            <input type="date" name="date_of_incident" class="form-control" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold small">Location of Incident</label>
                            <input type="text" name="location" class="form-control"
                                   placeholder="E.g., Near City Park, Main Street" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Latitude</label>
                            <input type="number" step="0.000001" name="latitude" class="form-control"
                                   placeholder="Optional">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Longitude</label>
                            <input type="number" step="0.000001" name="longitude" class="form-control"
                                   placeholder="Optional">
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold small">Incident Description</label>
                            <textarea name="description" class="form-control" rows="4"
                                      placeholder="Describe what happened..." required></textarea>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold small">Suspect Information (If Any)</label>
                            <textarea name="suspect_details" class="form-control" rows="2"
                                      placeholder="Appearance, clothing, vehicle, etc."></textarea>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold small">Victim Details (If Any)</label>
                            <textarea name="victim_details" class="form-control" rows="2"
                                      placeholder="Self / others involved, injuries, etc."></textarea>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Urgency Level</label>
                            <select name="urgency_level" class="form-select" required>
                                <option value="LOW">Low</option>
                                <option value="MEDIUM">Medium</option>
                                <option value="HIGH">High</option>
                            </select>
                        </div>
                    </div>

                    <div class="modal-footer bg-light border-0 mt-4 px-0">
                        <button type="button" class="btn btn-link text-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>

                        <button type="submit" class="btn btn-primary-accent px-4 fw-bold">
                            <i class="fas fa-paper-plane me-2"></i> Submit Complaint
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="timelineModal" tabindex="-1">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-3">
            <div class="modal-header text-white" style="background: var(--sidebar-active);">
                <h5 class="modal-title fw-bold"><i class="fas fa-sitemap me-2"></i>Case Timeline: #N-1025</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div class="timeline">
                    <div class="timeline-item filed">
                        <div class="timeline-icon"><i class="fas fa-upload"></i></div>
                        <h6 class="fw-bold text-dark">Complaint Filed</h6>
                        <p class="small text-muted mb-0">Details and evidence submitted by citizen.</p>
                        <span class="badge bg-light text-secondary small">Oct 30, 2025 | 14:30 HRS</span>
                    </div>
                    <div class="p-4 text-center">
                        <div id="map-container" style="height: 200px; margin-bottom: 20px;">
                            <div style="display: flex; align-items: center; justify-content: center; height: 100%; color: #343a40;">
                                <i class="fas fa-map-marker-alt fs-1 me-2"></i>
                                Incident Location Map Placeholder
                            </div>
                        </div>
                    </div>
                    <div class="timeline-item investigation">
                        <div class="timeline-icon"><i class="fas fa-share-square"></i></div>
                        <h6 class="fw-bold text-dark">Case Assigned</h6>
                        <p class="small text-muted mb-0">Assigned to Off. Sharma (PS ID 42) for primary investigation.</p>
                        <span class="badge bg-light text-secondary small">Oct 31, 2025 | 09:00 HRS</span>
                    </div>

                    <div class="timeline-item investigation">
                        <div class="timeline-icon"><i class="fas fa-search"></i></div>
                        <h6 class="fw-bold text-dark">Under Investigation</h6>
                        <p class="small text-muted mb-0">Initial witness statements are being processed.</p>
                        <span class="badge bg-light text-secondary small">Nov 01, 2025 | 11:15 HRS</span>
                    </div>

                    <div class="timeline-item resolved">
                        <div class="timeline-icon"><i class="fas fa-check"></i></div>
                        <h6 class="fw-bold text-dark">Case Resolved!</h6>
                        <p class="small text-muted mb-0">Suspect apprehended. Full resolution report available soon.</p>
                        <span class="badge bg-light text-secondary small">Nov 15, 2025 | 16:00 HRS</span>
                    </div>
                </div>
                <p class="text-center small mt-3"><a href="#" class="text-primary fw-bold">Contact Assigned Officer</a></p>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="followupModal" tabindex="-1">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-3">
            <div class="modal-header text-white" style="background: #198754;">
                <h5 class="modal-title fw-bold"><i class="fas fa-share-square me-2"></i>Submit Follow-up for #N-1025</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <p class="small text-muted">Use this form to add **new evidence** or **clarifying details** to your existing complaint. Do not report a new incident here.</p>
                <form>
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">New Information / Details</label>
                        <textarea class="form-control" rows="3" placeholder="I just remembered the suspect was wearing a blue jacket..."></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">New Evidence Files</label>
                        <input type="file" class="form-control">
                    </div>
                </form>
            </div>
            <div class="modal-footer bg-light border-0">
                <button type="button" class="btn btn-link text-secondary text-decoration-none" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-success px-4 fw-bold"><i class="fas fa-upload me-2"></i>Send Follow-up</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_GOES_HERE&callback=initMap">
</script>

<script>
    // --- CHART.JS SETUP ---
    // Fetching backend values from session
    const totalFiled = ${sessionScope.totalFiled};
    const inProgress = ${sessionScope.inProgress};
    const resolved = ${sessionScope.resolved};

    const ctx = document.getElementById('caseStatusChart').getContext('2d');

    new Chart(ctx, {
        type: 'doughnut', // or 'pie'
        data: {
            labels: ['Total Filed', 'In Progress', 'Resolved'],
            datasets: [{
                data: [totalFiled, inProgress, resolved],
                backgroundColor: ['#007bff', '#ffc107', '#28a745'], // blue, yellow, green
                borderColor: '#fff',
                borderWidth: 2,
                hoverOffset: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        font: { family: 'Inter' }
                    }
                }
            }
        }
    });

    // --- SIDEBAR TOGGLE ---
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // --- GOOGLE MAPS INITIALIZATION FUNCTION (Global Scope) ---
    function initMap() {
        const initialLocation = { lat: 18.5204, lng: 73.8567 };

        // Get the map container elements (Dashboard map and Timeline map)
        const dashboardMapContainer = document.querySelector("#nearby-crimes #map-container");
        const timelineMapContainer = document.querySelector("#timelineModal #map-container");


        // 1. Initialize Dashboard Map
        if (dashboardMapContainer) {
            dashboardMapContainer.innerHTML = '';

            const map = new google.maps.Map(dashboardMapContainer, {
                zoom: 12,
                center: initialLocation,
                mapId: 'DEMO_MAP_ID'
            });

            // Example Crime Location
            const crimeLocation = { lat: 18.5500, lng: 73.8400 };

            new google.maps.Marker({
                position: crimeLocation,
                map: map,
                title: "Theft Incident - 1.5km Away",
                icon: {
                    url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
                }
            });

            new google.maps.Circle({
                strokeColor: "#00A3FF",
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: "#00A3FF",
                fillOpacity: 0.15,
                map: map,
                center: initialLocation,
                radius: 5000
            });
        }

        // 2. Clear Placeholder for Timeline Map (optional, as it's a modal)
        // Note: Full map initialization inside a Bootstrap modal requires an event listener
        // (like 'shown.bs.modal') to ensure the map div is visible, but we'll leave
        // the map object creation logic simple for this single file.
        if(timelineMapContainer) {
            timelineMapContainer.innerHTML = 'Incident Location Map Placeholder';
            // To properly render map in modal, you'd add:
            // $('#timelineModal').on('shown.bs.modal', function () { /* map initialization here */ });
        }
    }
</script>
</body>
</html>
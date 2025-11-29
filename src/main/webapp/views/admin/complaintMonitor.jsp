<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%-- This JSP assumes a list of 'complaints' is passed from the controller --%>
<c:set var="complaints" value="${sessionScope.allComplaints}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Monitor - Nexus Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144;      /* Primary Dark Blue/Teal (Sidebar/Headings) */
            --nexus-accent: #008be6;    /* Bright Blue/Cyan Accent (Links/Primary Action) */
            --nexus-light: #F0F4F8;     /* Light background */
            --sidebar-hover: #004d7a;
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
        .nexus-brand svg { /* Custom SVG Shield with checkmark */
            width: 28px;
            height: 28px;
            fill: var(--nexus-accent);
        }
        .sidebar-nav {
            padding-top: 1rem;
        }
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
        .sidebar-nav .nav-link:hover i {
            transform: scale(1.1);
            color: var(--nexus-accent);
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
        .sidebar-footer .btn-outline-light {
            border-color: rgba(255,255,255,0.3);
            font-weight: 600;
        }

        /* --- MAIN CONTENT / TOP NAVBAR / CARD STYLES --- */
        .main-content { margin-left: 280px; width: calc(100% - 280px); transition: all 0.3s; }
        .top-navbar { background-color: #ffffff; box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05); padding: 1rem 2rem; position: sticky; top: 0; z-index: 999; }
        .btn-nexus { background: var(--nexus-accent) !important; border: 1px solid var(--nexus-accent) !important; color: white !important; font-weight: 600; transition: all 0.3s; }
        .btn-nexus:hover { background: #007bbd !important; border-color: #007bbd !important; color: white !important; transform: translateY(-1px); box-shadow: 0 4px 10px rgba(0, 163, 255, 0.3); }
        .main-card { border: 1px solid #e0e0e0; border-radius: 15px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05); background: white; padding: 1.5rem; }
        .card-header-custom { border-bottom: 1px solid #eee; padding-bottom: 1rem; margin-bottom: 1rem; display: flex; justify-content: space-between; align-items: center;}
        .card-header-custom h5 { color: var(--nexus-dark); font-weight: 700; }

        /* --- DYNAMIC BADGES (Complaint Monitor Specific) --- */
        /* Urgency Badges */
        .badge-urgency-HIGH { background-color: #dc3545; color: #fff; } /* Red */
        .badge-urgency-MEDIUM { background-color: #ffc107; color: var(--nexus-dark); } /* Yellow */
        .badge-urgency-LOW { background-color: #17a2b8; color: #fff; } /* Cyan */

        /* Responsive collapse logic */
        @media (max-width: 991.98px) { .sidebar { margin-left: -280px; } .main-content { margin-left: 0; width: 100%; } .sidebar.active { margin-left: 0; } }
    </style>
</head>
<body>

<%-- 1. SIDEBAR STRUCTURE --%>
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="nexus-brand animate__animated animate__fadeIn">
            <!-- SVG Shield Icon with checkmark -->
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-1.88 12.82l-2.58-2.58L6.47 12l2.05 2.05 4.49-4.49 1.06 1.06-5.55 5.55z"/>
            </svg>
            NEXUS HUB
        </div>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/userManagement.jsp">
                <i class="fas fa-users-cog"></i> User Management
            </a>
        </li>
        <li class="nav-item">
            <%-- Set 'active' class for the current page: Complaint Monitor --%>
            <a class="nav-link active" href="${pageContext.request.contextPath}/views/admin/complaintMonitor.jsp">
                <i class="fas fa-tasks"></i> Complaint Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/advanceAnalytics.jsp">
                <i class="fas fa-chart-line"></i> Advanced Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-building"></i> Station/Dept.
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-clipboard-list"></i> System Logs
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#alertModal">
                <i class="fas fa-bullhorn"></i> Broadcast Alert
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-light w-100 btn-sm fw-bold">
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
                <span class="fw-bold text-uppercase text-secondary me-3">Complaint Monitor</span>
                <img src="https://ui-avatars.com/api/?name=Admin+User&background=1C3144&color=fff" class="rounded-circle shadow-sm" width="35" height="35" alt="Admin">
            </div>
        </div>
    </nav>
    <div class="container-fluid p-4">
        <h3 class="fw-bold text-dark mb-4"><i class="fas fa-tasks me-2 text-secondary"></i> Live Complaint Monitoring</h3>

        <div class="row g-4 mb-4">
            <div class="col-lg-12">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-list me-2"></i> Active Case List</h5>
                        <div class="d-flex gap-3">
                            <select class="form-select w-auto form-select-sm">
                                <option>Filter by Type</option>
                                <option>Theft</option>
                                <option>Assault</option>
                                <option>Cybercrime</option>
                            </select>
                            <select class="form-select w-auto form-select-sm">
                                <option>Sort by Urgency</option>
                                <option>HIGH</option>
                                <option>MEDIUM</option>
                                <option>LOW</option>
                            </select>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Type</th>
                                <th>Urgency</th>
                                <th>Status</th>
                                <th>Location</th>
                                <th>Filed By</th>
                                <th>Date Filed</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="comp" items="${complaints}">
                                <tr>
                                    <td class="ps-4 fw-bold text-primary">#N-${comp.complaintId}</td>
                                    <td>${comp.complaintType}</td>
                                    <td>
                                            <span class="badge rounded-pill badge-urgency-
                                            <c:choose>
                                                <c:when test='${comp.urgencyLevel == "HIGH"}'>HIGH</c:when>
                                                <c:when test='${comp.urgencyLevel == "MEDIUM"}'>MEDIUM</c:when>
                                                <c:otherwise>LOW</c:otherwise>
                                            </c:choose>
                                            fw-semibold">
                                                    ${comp.urgencyLevel}
                                            </span>
                                    </td>
                                    <td>
                                            <span class="badge rounded-pill
                                                <c:choose>
                                                    <c:when test='${comp.currentStatus == "RESOLVED" || comp.currentStatus == "CLOSED"}'>bg-success</c:when>
                                                    <c:when test='${comp.currentStatus == "UNDER_INVESTIGATION"}'>bg-warning text-dark</c:when>
                                                    <c:when test='${comp.currentStatus == "UNDER_REVIEW"}'>bg-info text-dark</c:when>
                                                    <c:when test='${comp.currentStatus == "FILED"}'>bg-primary</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose> fw-semibold">
                                                    ${comp.currentStatus}
                                            </span>
                                    </td>
                                    <td>${comp.locationOfIncident}</td>
                                    <td class="small text-muted">${comp.filedBy}</td>
                                    <td class="small"><fmt:formatDate value="${comp.dateFiled}" pattern="MMM dd, yyyy HH:mm"/></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-secondary border" data-bs-toggle="dropdown"><i class="fas fa-ellipsis-v"></i></button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow animate__animated animate__fadeIn">
                                                <li><a class="dropdown-item small" href="#"><i class="fas fa-eye me-2"></i> View Details</a></li>
                                                <li><a class="dropdown-item small" href="#"><i class="fas fa-user-plus me-2"></i> Assign Officer</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item small text-success" href="#"><i class="fas fa-check-double me-2"></i> Mark Resolved</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty complaints}">
                                <tr><td colspan="8" class="text-center text-muted p-4">No active complaints found.</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
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
            if (mainContent.style.marginLeft === '0px' || mainContent.style.marginLeft === '') {
                mainContent.style.marginLeft = '280px';
            } else {
                mainContent.style.marginLeft = '0px';
            }
        }
    });
</script>
</body>
</html>
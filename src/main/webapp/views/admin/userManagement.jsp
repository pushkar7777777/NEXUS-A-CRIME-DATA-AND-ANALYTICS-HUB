<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    // AUTH GUARD - Ensures only ADMIN role can access this page
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("role") == null ||
            !"ADMIN".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Nexus Hub</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144;
            --nexus-accent: #008be6;
            --nexus-light: #F0F4F8;
            --nexus-blue-dark: #0055a4;
        }

        /* --- GLOBAL LAYOUT --- */
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--nexus-light);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--nexus-dark), #203a43, #2c5364);
            color: #ffffff;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            transition: 0.3s;
            z-index: 1000;
        }
        .sidebar-header {
            padding: 2rem;
            text-align: center;
            background: rgba(0,0,0,0.12);
        }
        .sidebar-nav .nav-link {
            color: rgba(255,255,255,0.88);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            transition: 0.3s;
            border-left: 4px solid transparent;
        }
        .sidebar-nav .nav-link:hover:not(.active) {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
        }
        .sidebar-nav .nav-link.active {
            background: var(--nexus-blue-dark);
            border-left: 4px solid var(--nexus-accent);
            color: #fff;
            font-weight: 600;
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            padding: 0;
        }

        .top-navbar {
            background: #fff;
            padding: 1rem 2rem;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .main-card {
            background: #fff;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
        }

        /* Custom Bootstrap Badges */
        .badge-approved { background: #28a745 !important; color: #fff !important; } /* Success */
        .badge-pending { background: #ffc107 !important; color: #000 !important; } /* Warning */
        .badge-rejected { background: #dc3545 !important; color: #fff !important; } /* Danger */
        .badge-verified { background: var(--nexus-accent) !important; color: #fff !important; } /* Accent */

        .table-responsive {
            overflow-x: auto;
        }

        .table-actions {
            white-space: nowrap;
        }

        /* Add User Button Styling */
        .btn-add-user {
            background-color: var(--nexus-accent);
            border-color: var(--nexus-accent);
            color: white;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-add-user:hover {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }

        /* Tab Styling */
        .nav-tabs .nav-link {
            color: var(--nexus-dark);
            font-weight: 600;
        }
        .nav-tabs .nav-link.active {
            color: var(--nexus-accent);
            border-color: var(--nexus-accent) var(--nexus-accent) #fff;
        }

        /* Table header text color */
        .table thead th {
            font-weight: 700;
            color: #6c757d;
        }

    </style>
</head>

<body>

<div class="sidebar">
    <div class="sidebar-header">
        <h3 class="fw-bold">NEXUS HUB</h3>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/user-management">
                <i class="fas fa-users-cog me-2"></i> User Management
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/complaint-monitor">
                <i class="fas fa-tasks me-2"></i> Complaint Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/analytics">
                <i class="fas fa-chart-line me-2"></i> Advanced Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/station-directory">
                <i class="fas fa-building me-2"></i> Station/Dept.
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/broadcast_aleart.jsp" data-bs-toggle="modal" data-bs-target="#alertModal">
                <i class="fas fa-bullhorn me-2"></i> Broadcast Alert
            </a>
        </li>
    </ul>

    <div class="sidebar-footer p-3 mt-5">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light w-100">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<div class="main-content">
    <nav class="top-navbar d-flex justify-content-between align-items-center">
        <h4 class="fw-bold text-secondary">User Management</h4>
        <img src="https://ui-avatars.com/api/?name=Admin&background=1C3144&color=fff" class="rounded-circle" width="38" alt="Admin Avatar">
    </nav>

    <div class="container-fluid p-4 p-md-5">

        <div class="d-flex justify-content-between align-items-center mb-5 animate__animated animate__fadeInDown">
            <h3 class="fw-bold text-dark m-0">
                <i class="fas fa-users-cog me-2 text-primary"></i>
                User Accounts Overview
            </h3>

            <div class="dropdown" data-aos="fade-left">
                <button class="btn btn-add-user dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-plus me-1"></i> Add User
                </button>

                <ul class="dropdown-menu dropdown-menu-end shadow animate__animated animate__fadeInUp">
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/views/admin/addPolice.jsp">
                            <i class="fa fa-shield-alt me-2 text-info"></i> Add Police Officer
                        </a>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/views/admin/addCivilian.jsp">
                            <i class="fa fa-user me-2 text-success"></i> Add Civilian User
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-card animate__animated animate__fadeInUp">

            <ul class="nav nav-tabs mb-4" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active"
                            data-bs-toggle="tab"
                            data-bs-target="#policeTab"
                            type="button">
                        <i class="fas fa-shield-alt me-2"></i>
                        Police Officers <span class="badge bg-secondary ms-1">${fn:length(policeUsers)}</span>
                    </button>
                </li>

                <li class="nav-item">
                    <button class="nav-link"
                            data-bs-toggle="tab"
                            data-bs-target="#civilianTab"
                            type="button">
                        <i class="fas fa-user-friends me-2"></i>
                        Civilians <span class="badge bg-secondary ms-1">${fn:length(civilianUsers)}</span>
                    </button>
                </li>
            </ul>

            <div class="tab-content">

                <div class="tab-pane fade show active" id="policeTab">

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="bg-light">
                            <tr>
                                <th>Reg ID</th>
                                <th>Name</th>
                                <th>Rank</th>
                                <th>Station-ID</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="p" items="${policeUsers}">
                                <tr>
                                    <td>P${p.regId}</td>
                                    <td>${p.fullName}</td>
                                    <td>${p.rankDetails}</td>
                                    <td>${p.policeStationId}</td>
                                    <td>${p.email}</td>
                                    <td>
                                    <span class="badge rounded-pill
                                        <c:choose>
                                            <c:when test="${p.approvalStatus == 'APPROVED'}">badge-approved</c:when>
                                            <c:when test="${p.approvalStatus == 'PENDING'}">badge-pending</c:when>
                                            <c:otherwise>badge-rejected</c:otherwise>
                                        </c:choose>
                                    ">
                                            ${p.approvalStatus}
                                    </span>
                                    </td>


                                    <td class="table-actions">

                                        <form id="editPoliceForm-${p.regId}"
                                              action="${pageContext.request.contextPath}/UpdatePoliceServlet"
                                              method="post" style="display:none;">
                                            <input type="hidden" name="regId" value="${p.regId}">
                                            <input type="hidden" name="status" value="APPROVED">   <!-- or whatever you want -->
                                        </form>

                                        <button class="btn btn-sm btn-primary me-1"
                                                title="Edit Officer Details"
                                                onclick="document.getElementById('editPoliceForm-${p.regId}').submit();">
                                            <i class="fas fa-edit"></i>
                                        </button>


                                        <a href="${pageContext.request.contextPath}/DeletePoliceServlet?regId=${p.regId}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to delete P${p.regId}?');"
                                           title="Delete Officer Record">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty policeUsers}">
                                <tr><td colspan="7" class="text-center text-muted p-4">No police officers found.</td></tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="tab-pane fade" id="civilianTab">

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="bg-light">
                            <tr>
                                <th>Reg ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>National ID</th>
                                <th>DOB</th>
                                <th>Actions</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="civ" items="${civilianUsers}">
                                <tr>
                                    <td class="fw-bold text-primary">C${civ.regId}</td>
                                    <td>${civ.fullName}</td>
                                    <td class="small">${civ.email}</td>
                                    <td>${civ.phone}</td>
                                    <td class="small">${civ.nationalId}</td>
                                    <td class="small">${civ.dateOfBirth}</td>

                                    <td class="table-actions">
                                        <button class="btn btn-sm btn-outline-info me-1" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>

                                        <a href="${pageContext.request.contextPath}/UpdateCivilianServlet?regId=${civ.regId}&action=showEditForm"
                                           class="btn btn-sm btn-primary me-1"
                                           title="Edit Civilian Details">
                                            <i class="fas fa-edit"></i>
                                        </a>

                                        <a href="${pageContext.request.contextPath}/DeleteCivilianServlet?regId=${civ.regId}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to delete C${civ.regId}?');"
                                           title="Delete Civilian Record">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>


                                </tr>
                            </c:forEach>


                            <c:if test="${empty civilianUsers}">
                                <tr><td colspan="7" class="text-center text-muted p-4">No civilians found.</td></tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>

                </div>

            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });
</script>

</body>
</html>
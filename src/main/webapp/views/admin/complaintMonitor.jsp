<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!-- Receive complaints list sent by servlet -->
<c:set var="complaints" value="${requestScope.complaints}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Monitor - Nexus Hub</title>

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --nexus-dark: #1C3144;
            --nexus-accent: #008be6;
            --nexus-light: #F0F4F8;
            --sidebar-active: #0055a4;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--nexus-light);
            display: flex;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--nexus-dark), #203a43, #2c5364);
            color: #fff;
            height: 100vh;
            position: fixed;
            overflow-y: auto;
        }

        .sidebar-nav .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 1rem 2rem;
        }

        .nav-link.active {
            background: var(--sidebar-active);
            border-left: 4px solid var(--nexus-accent);
            color: #fff;
        }

        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
        }

        .badge-urgency-HIGH { background: #dc3545; color:#fff; }
        .badge-urgency-MEDIUM { background: #ffc107; color:#000; }
        .badge-urgency-LOW { background: #17a2b8; color:#fff; }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="p-4 text-center fw-bold fs-4">NEXUS HUB</div>

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
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/analytics">
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

    <div class="p-3 mt-5">
        <a href="${pageContext.request.contextPath}/logout"
           class="btn btn-outline-light w-100">Logout</a>
    </div>
</div>


<!-- MAIN CONTENT -->
<div class="main-content">
    <nav class="navbar bg-white shadow-sm px-4">
        <h5 class="fw-bold">Complaint Monitor</h5>
        <img src="https://ui-avatars.com/api/?name=Admin&background=1C3144&color=fff"
             class="rounded-circle" width="38" />
    </nav>

    <div class="container-fluid p-4">

        <h3 class="fw-bold mb-3"><i class="fas fa-tasks me-2 text-primary"></i> Active Complaints</h3>

        <div class="card shadow-sm">
            <div class="card-body">

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="bg-light">
                        <tr>
                            <th>ID</th>
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

                        <!-- Loop Complaints -->
                        <c:forEach var="comp" items="${complaints}">
                            <tr>
                                <td class="fw-bold text-primary">${comp.complaintId}</td>
                                <td>${comp.complaintType}</td>

                                <td>
                                    <span class="badge rounded-pill badge-urgency-${comp.urgencyLevel}">
                                            ${comp.urgencyLevel}
                                    </span>
                                </td>

                                <td>
                                    <span class="badge rounded-pill
                                        <c:choose>
                                            <c:when test="${comp.currentStatus == 'RESOLVED'}">bg-success</c:when>
                                            <c:when test="${comp.currentStatus == 'UNDER_INVESTIGATION'}">bg-warning text-dark</c:when>
                                            <c:when test="${comp.currentStatus == 'UNDER_REVIEW'}">bg-info text-dark</c:when>
                                            <c:otherwise>bg-primary</c:otherwise>
                                        </c:choose>">
                                            ${comp.currentStatus}
                                    </span>
                                </td>

                                <td>${comp.locationOfIncident}</td>
                                <td>${comp.filedBy}</td>

                                <td>
                                    <c:if test="${comp.dateFiled != null}">
                                        ${comp.dateFiled}
                                    </c:if>

                                    <c:if test="${comp.dateFiled == null}">
                                        <span class="text-muted">N/A</span>
                                    </c:if>
                                </td>


                                <!-- ACTIONS -->
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="dropdown">
                                            <i class="fas fa-ellipsis-v"></i>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end shadow">
                                            <li>
                                                <a class="dropdown-item small"
                                                   href="${pageContext.request.contextPath}/admin/complaint-details?cid=${comp.complaintId}">
                                                    <i class="fas fa-eye me-2"></i> View Details
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item small"
                                                   href="${pageContext.request.contextPath}/admin/assign-officer?cid=${comp.complaintId}">
                                                    <i class="fas fa-user-plus me-2"></i> Assign Officer
                                                </a>
                                            </li>

                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-success" href="#"><i class="fas fa-check me-2"></i> Mark Resolved</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- IF EMPTY -->
                        <c:if test="${empty complaints}">
                            <tr>
                                <td colspan="8" class="text-center p-4 text-muted">No complaints found.</td>
                            </tr>
                        </c:if>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

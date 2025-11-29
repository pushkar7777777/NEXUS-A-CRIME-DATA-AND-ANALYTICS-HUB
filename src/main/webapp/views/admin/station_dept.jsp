<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%-- Mock data structure for demonstration --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Station & Department Management - Nexus Hub</title>
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
        .main-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); }
        .card-header-custom { border-bottom: 1px solid #eee; padding-bottom: 1rem; margin-bottom: 1rem; display: flex; justify-content: space-between; align-items: center;}
        .card-header-custom h5 { color: var(--nexus-dark); font-weight: 700; }

        /* Badges */
        .badge-status-active { background-color: #28a745; color: #fff; }
        .badge-status-inactive { background-color: #dc3545; color: #fff; }

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
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/complaintMonitor.jsp">
                <i class="fas fa-tasks"></i> Complaint Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/views/admin/advanceAnalytics.jsp">
                <i class="fas fa-chart-line"></i> Advanced Analytics
            </a>
        </li>
        <li class="nav-item">
            <%-- Set 'active' class for the current page: Station/Dept. --%>
            <a class="nav-link active" href="${pageContext.request.contextPath}/views/admin/station_department.jsp">
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
                <span class="fw-bold text-uppercase text-secondary me-3">Station/Department Management</span>
                <img src="https://ui-avatars.com/api/?name=Admin+User&background=1C3144&color=fff" class="rounded-circle shadow-sm" width="35" height="35" alt="Admin">
            </div>
        </div>
    </nav>
    <div class="container-fluid p-4">
        <h3 class="fw-bold text-dark mb-4"><i class="fas fa-building me-2 text-secondary"></i> Station and Department Directory</h3>

        <div class="row g-4 mb-4">
            <div class="col-lg-12">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-table me-2"></i> Station Records</h5>
                        <div class="d-flex gap-3">
                            <button class="btn btn-sm btn-outline-secondary">Export Data</button>
                            <button class="btn btn-sm btn-nexus" data-bs-toggle="modal" data-bs-target="#stationModal" data-mode="add">
                                <i class="fas fa-plus me-1"></i> Add New Station
                            </button>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between mb-4 mt-3">
                        <div class="input-group w-50">
                            <input type="text" class="form-control" placeholder="Search by Name or Address">
                            <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                        </div>
                        <select class="form-select w-auto">
                            <option>All Departments</option>
                            <option>Police</option>
                            <option>Traffic</option>
                            <option>Cyber Crime</option>
                        </select>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Address</th>
                                <th>Officers</th>
                                <th>Status</th>
                                <th>Chief</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="station" items="${stationList}">
                                <tr>
                                    <td class="ps-4 fw-bold text-primary">#S-${station.stationId}</td>
                                    <td>${station.stationName}</td>
                                    <td><span class="badge bg-secondary">${station.department}</span></td>
                                    <td class="small text-muted">${station.address}</td>
                                    <td>${station.officerCount}</td>
                                    <td>
                                            <span class="badge rounded-pill badge-status-
                                            <c:choose>
                                                <c:when test='${station.isActive}'>active</c:when>
                                                <c:otherwise>inactive</c:otherwise>
                                            </c:choose> fw-semibold">
                                                    ${station.isActive ? 'Active' : 'Decommissioned'}
                                            </span>
                                    </td>
                                    <td class="small">${station.chiefName}</td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-secondary border" data-bs-toggle="dropdown"><i class="fas fa-ellipsis-v"></i></button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow animate__animated animate__fadeIn">
                                                <li><a class="dropdown-item small view-btn" href="#"
                                                       data-bs-toggle="modal" data-bs-target="#stationModal" data-mode="view"
                                                       data-id="${station.stationId}"
                                                       data-name="${station.stationName}"
                                                       data-dept="${station.department}"
                                                       data-address="${station.address}"
                                                       data-chief="${station.chiefName}"
                                                       data-officers="${station.officerCount}"
                                                       data-active="${station.isActive ? 'Active' : 'Inactive'}">
                                                    <i class="fas fa-eye me-2"></i> View Details
                                                </a></li>
                                                <li><a class="dropdown-item small edit-btn" href="#"
                                                       data-bs-toggle="modal" data-bs-target="#stationModal" data-mode="edit"
                                                       data-id="${station.stationId}"
                                                       data-name="${station.stationName}"
                                                       data-dept="${station.department}"
                                                       data-address="${station.address}"
                                                       data-chief="${station.chiefName}"
                                                       data-officers="${station.officerCount}"
                                                       data-is-active="${station.isActive ? 'true' : 'false'}">
                                                    <i class="fas fa-edit me-2"></i> Edit Record
                                                </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item small text-danger delete-btn" href="#"
                                                       data-id="${station.stationId}" data-name="${station.stationName}">
                                                    <i class="fas fa-trash-alt me-2"></i> Delete
                                                </a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty stationList}">
                                <tr><td colspan="8" class="text-center text-muted p-4">No station records found.</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 3. Station/Department Modal (Add/Edit/View) --%>
<div class="modal fade" id="stationModal" tabindex="-1" aria-labelledby="stationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background: var(--nexus-dark);">
                <h5 class="modal-title fw-bold" id="stationModalLabel"><i class="fas fa-plus me-2"></i> Add New Station</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <form id="stationForm" method="post" action="${pageContext.request.contextPath}/admin/saveStation">
                <div class="modal-body p-4">
                    <input type="hidden" name="stationId" id="modalStationId">

                    <div class="mb-3">
                        <label for="stationName" class="form-label fw-bold small">Station Name</label>
                        <input type="text" class="form-control" id="stationName" name="stationName" required>
                    </div>

                    <div class="mb-3">
                        <label for="department" class="form-label fw-bold small">Department</label>
                        <select class="form-select" id="department" name="department" required>
                            <option value="Police">Police</option>
                            <option value="Traffic">Traffic</option>
                            <option value="Cyber Crime">Cyber Crime</option>
                            <option value="Special Operations">Special Operations</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label fw-bold small">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="chiefName" class="form-label fw-bold small">Chief/Head Name</label>
                            <input type="text" class="form-control" id="chiefName" name="chiefName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="officerCount" class="form-label fw-bold small">Officer Count</label>
                            <input type="number" class="form-control" id="officerCount" name="officerCount" min="0" required>
                        </div>
                    </div>

                    <div class="form-check form-switch mb-3" id="statusSwitchContainer">
                        <input class="form-check-input" type="checkbox" id="isActive" name="isActive" checked>
                        <label class="form-check-label fw-bold small" for="isActive">Active Status</label>
                    </div>

                    <div id="viewDetails" class="alert alert-info small d-none">
                        <p class="mb-1"><strong>Officer Count:</strong> <span id="viewOfficerCount"></span></p>
                        <p class="mb-0"><strong>Status:</strong> <span id="viewStatus"></span></p>
                    </div>
                </div>

                <div class="modal-footer bg-light border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-nexus" id="modalSubmitButton">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 4. JAVASCRIPT --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });

    // Sidebar Toggle Logic
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');
        sidebar.classList.toggle('active');

        if (window.innerWidth >= 992) {
            mainContent.style.marginLeft = sidebar.classList.contains('active') ? '0px' : '280px';
        }
    });

    // --- Modal Handler for Add/Edit/View ---
    document.addEventListener('DOMContentLoaded', () => {
        const stationModal = document.getElementById('stationModal');
        const form = document.getElementById('stationForm');
        const modalTitle = document.getElementById('stationModalLabel');
        const submitButton = document.getElementById('modalSubmitButton');

        stationModal.addEventListener('show.bs.modal', function (event) {
            const relatedTarget = event.relatedTarget;
            const mode = relatedTarget.getAttribute('data-mode');

            // Reset form visibility and fields
            form.reset();
            document.getElementById('viewDetails').classList.add('d-none');
            document.getElementById('statusSwitchContainer').classList.remove('d-none');

            const inputs = form.querySelectorAll('input, select, textarea');
            inputs.forEach(input => input.removeAttribute('readonly'));
            submitButton.classList.remove('d-none');

            // Handle different modes
            if (mode === 'add') {
                modalTitle.innerHTML = '<i class="fas fa-plus me-2"></i> Add New Station';
                submitButton.innerText = 'Add Station';
                form.action = '${pageContext.request.contextPath}/admin/addStation';
                document.getElementById('modalStationId').value = '';
                document.getElementById('isActive').checked = true;

            } else if (mode === 'edit' || mode === 'view') {
                const data = relatedTarget.dataset;
                const stationId = data.id;

                document.getElementById('modalStationId').value = stationId;
                document.getElementById('stationName').value = data.name;
                document.getElementById('department').value = data.dept;
                document.getElementById('address').value = data.address;
                document.getElementById('chiefName').value = data.chief;
                document.getElementById('officerCount').value = data.officers;
                document.getElementById('isActive').checked = data.isActive === 'true';

                if (mode === 'edit') {
                    modalTitle.innerHTML = `<i class="fas fa-edit me-2"></i> Edit Station #${stationId}`;
                    submitButton.innerText = 'Save Changes';
                    form.action = '${pageContext.request.contextPath}/admin/updateStation';
                }

                if (mode === 'view') {
                    modalTitle.innerHTML = `<i class="fas fa-eye me-2"></i> View Station Details #${stationId}`;
                    inputs.forEach(input => input.setAttribute('readonly', 'readonly'));
                    document.getElementById('statusSwitchContainer').classList.add('d-none');
                    document.getElementById('viewDetails').classList.remove('d-none');
                    document.getElementById('viewOfficerCount').innerText = data.officers;
                    document.getElementById('viewStatus').innerText = data.active;
                    submitButton.classList.add('d-none'); // Hide submit button in view mode
                }
            }
        });

        // --- Delete Button Handler (requires confirmation) ---
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const stationId = btn.dataset.id;
                const stationName = btn.dataset.name;

                if (confirm(`Are you sure you want to delete the station: ${stationName} (#S-${stationId})? This action cannot be undone.`)) {
                    // Implement actual deletion logic here, likely a POST request to a delete servlet
                    alert(`Simulating deletion of Station #S-${stationId}`);
                    // window.location.href = '${pageContext.request.contextPath}/admin/deleteStation?id=' + stationId;
                }
            });
        });
    });

    // Mock Class for compilation (replace with actual Java class definition)
    class Station {
        constructor(stationId, stationName, address, department, officerCount, isActive, chiefName) {
            this.stationId = stationId;
            this.stationName = stationName;
            this.address = address;
            this.department = department;
            this.officerCount = officerCount;
            this.isActive = isActive;
            this.chiefName = chiefName;
        }
    }
</script>
</body>
</html>
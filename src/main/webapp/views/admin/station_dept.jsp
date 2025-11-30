<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%--
    NOTE: The AUTH GUARD logic should be moved to the beginning of this file
    if the servlet is mapped to a different URL (not directly to the JSP path).
    Assuming the Servlet handles security check and forwards here.
--%>

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
            --nexus-dark: #1C3144;
            --nexus-accent: #008be6;
            --nexus-light: #F0F4F8;
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
            border-left: 4px solid transparent;
        }
        .sidebar-nav .nav-link i { margin-right: 1rem; width: 25px; text-align: center;}
        .sidebar-nav .nav-link:hover { background-color: rgba(255,255,255,0.05); color: #ffffff; padding-left: 2.5rem; }
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
        .sidebar-footer .btn-outline-light { border-color: rgba(255,255,255,0.3); font-weight: 600; }

        /* --- MAIN CONTENT / TOP NAVBAR / CARD STYLES --- */
        .main-content { margin-left: 280px; width: calc(100% - 280px); transition: all 0.3s; }
        .top-navbar { background-color: #ffffff; box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05); padding: 1rem 2rem; position: sticky; top: 0; z-index: 999; }
        .btn-nexus { background: var(--nexus-accent) !important; border: 1px solid var(--nexus-accent) !important; color: white !important; font-weight: 600; transition: all 0.3s; }
        .btn-nexus:hover { background: #007bbd !important; border-color: #007bbd !important; color: white !important; transform: translateY(-1px); box-shadow: 0 4px 10px rgba(0, 163, 255, 0.3); }
        .main-card { border: 1px solid #e0e0e0; border-radius: 15px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05); background: white; padding: 1.5rem; }
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
                            <option>Special Operations</option>
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
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty stationList}">
                                    <c:forEach var="station" items="${stationList}">
                                        <tr>
                                            <td class="ps-4 fw-bold text-primary">S-${station.policeStationId}</td>

                                            <td>${station.stationName}</td>

                                            <td><span class="badge bg-secondary">${station.jurisdictionArea}</span></td>

                                            <td class="small text-muted">${station.location}</td>

                                            <td>${station.officerCount}</td> <!-- officerCount does NOT exist in your model -->

                                            <td>
                                                <span class="badge bg-info">Active</span>
                                            </td>
                                            <!-- chiefName does not exist -->

                                            <td>
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-outline-secondary border" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>

                                                    <ul class="dropdown-menu dropdown-menu-end shadow">
                                                        <li>
                                                            <a class="dropdown-item small"
                                                               href="#"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#stationModal"
                                                               data-mode="view"
                                                               data-id="${station.policeStationId}"
                                                               data-name="${station.stationName}"
                                                               data-dept="${station.jurisdictionArea}"
                                                               data-address="${station.location}">
                                                                <i class="fas fa-eye me-2"></i> View Details
                                                            </a>
                                                        </li>

                                                        <li>
                                                            <a class="dropdown-item small"
                                                               href="#"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#stationModal"
                                                               data-mode="edit"
                                                               data-id="${station.policeStationId}"
                                                               data-name="${station.stationName}"
                                                               data-dept="${station.jurisdictionArea}"
                                                               data-address="${station.location}">
                                                                <i class="fas fa-edit me-2"></i> Edit Record
                                                            </a>
                                                        </li>

                                                        <li><hr class="dropdown-divider"></li>

                                                        <li>
                                                            <a class="dropdown-item small text-danger delete-btn"
                                                               href="#"
                                                               data-id="${station.policeStationId}"
                                                               data-name="${station.stationName}">
                                                                <i class="fas fa-trash-alt me-2"></i> Delete
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="8" class="text-center text-muted p-4">No station records found.</td></tr>
                                </c:otherwise>
                            </c:choose>
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

                    <div id="readOnlyView" class="mb-3 d-none">
                        <p class="mb-1 fw-bold small text-secondary">Station ID:</p>
                        <p class="mb-3 fw-bold text-primary" id="viewStationId"></p>
                    </div>

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
        const readOnlyView = document.getElementById('readOnlyView');

        stationModal.addEventListener('show.bs.modal', function (event) {
            const relatedTarget = event.relatedTarget;
            const mode = relatedTarget.getAttribute('data-mode');
            const data = relatedTarget.dataset;

            // --- Reset View ---
            form.reset();
            readOnlyView.classList.add('d-none');
            document.getElementById('statusSwitchContainer').classList.remove('d-none');
            submitButton.classList.remove('d-none');
            submitButton.disabled = false;

            const inputs = form.querySelectorAll('input:not([type="hidden"]), select, textarea');
            inputs.forEach(input => input.removeAttribute('readonly'));
            inputs.forEach(input => input.disabled = false);


            // Handle different modes
            if (mode === 'add') {
                modalTitle.innerHTML = '<i class="fas fa-plus me-2"></i> Add New Station';
                submitButton.innerText = 'Add Station';
                form.action = '${pageContext.request.contextPath}/admin/addStation';
                document.getElementById('modalStationId').value = '';
                document.getElementById('isActive').checked = true;

            } else if (mode === 'edit' || mode === 'view') {
                const stationId = data.id;

                // --- Populate Fields ---
                document.getElementById('modalStationId').value = stationId;
                document.getElementById('stationName').value = data.name;
                document.getElementById('department').value = data.dept;
                document.getElementById('address').value = data.address;
                document.getElementById('chiefName').value = data.chief;
                document.getElementById('officerCount').value = data.officers;
                document.getElementById('isActive').checked = data.isActive === 'true'; // Note: data-is-active vs isActive
                document.getElementById('viewStationId').innerText = `#S-${stationId}`;


                if (mode === 'edit') {
                    modalTitle.innerHTML = `<i class="fas fa-edit me-2"></i> Edit Station #S-${stationId}`;
                    submitButton.innerText = 'Save Changes';
                    form.action = '${pageContext.request.contextPath}/admin/updateStation';
                }

                if (mode === 'view') {
                    modalTitle.innerHTML = `<i class="fas fa-eye me-2"></i> View Station Details #S-${stationId}`;
                    readOnlyView.classList.remove('d-none');
                    inputs.forEach(input => input.setAttribute('readonly', 'readonly'));
                    inputs.forEach(input => input.disabled = true); // Disable for true read-only status
                    document.getElementById('statusSwitchContainer').classList.add('d-none');
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
                    window.location.href = '${pageContext.request.contextPath}/admin/deleteStation?id=' + stationId;
                }
            });
        });
    });

</script>
</body>
</html>
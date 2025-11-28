<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%-- Expect attributes: stats (PoliceDashboardStats), assignedCases (List<Complaint>), session attribute user_name --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Police Dashboard - Nexus Hub</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* (same CSS as your template) */
        :root {
            --nexus-dark: #1C3144;
            --nexus-accent: #00A3FF;
            --nexus-light: #F0F4F8;
            --sidebar-hover: #004d7a;
            --sidebar-active: #0055a4;
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--nexus-light); display:flex; min-height:100vh; overflow-x:hidden; }
        .sidebar { width:280px; background: linear-gradient(180deg, var(--nexus-dark), #203a43, #2c5364); color:#fff; position:fixed; height:100%; overflow-y:auto; z-index:1000; box-shadow:4px 0 15px rgba(0,0,0,0.1); }
        .sidebar-header { padding:2rem 1.5rem; text-align:center; border-bottom:1px solid rgba(255,255,255,0.1); background:rgba(0,0,0,0.1); }
        .nexus-brand { font-weight:800; font-size:1.5rem; display:flex; gap:10px; align-items:center; justify-content:center; }
        .sidebar-nav .nav-link { color: rgba(255,255,255,0.8); padding:1rem 2rem; display:flex; align-items:center; border-left:4px solid transparent; transition:all .25s; }
        .sidebar-nav .nav-link:hover { background-color:var(--sidebar-hover); color:#fff; padding-left:2.5rem; }
        .sidebar-nav .nav-link.active { background:var(--sidebar-active); border-left:4px solid var(--nexus-accent); font-weight:600; }
        .sidebar-footer { position:absolute; bottom:0; width:100%; padding:1.5rem; background:rgba(0,0,0,0.2); }
        .main-content { margin-left:280px; width:calc(100% - 280px); transition:all .3s; }
        .top-navbar { background:#fff; box-shadow:0 2px 15px rgba(0,0,0,0.05); padding:1rem 2rem; position:sticky; top:0; z-index:999; }
        .dashboard-hero { background: linear-gradient(135deg, var(--nexus-dark), #2c5364); color:#fff; border-radius:15px; padding:2rem; margin-bottom:2rem; box-shadow:0 10px 20px rgba(28,49,68,0.2); }
        .stat-card { border-radius:15px; background:#fff; padding:1.5rem; display:flex; align-items:center; box-shadow:0 5px 15px rgba(0,0,0,0.05); }
        .card-icon { width:60px; height:60px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:1.8rem; margin-right:1.5rem; }
        .icon-pending { background:#ffc107; color:#7f5200; } .icon-active { background:#007bff; color:#fff; } .icon-closed { background:#28a745; color:#fff; }
        .stat-number { font-size:2.2rem; font-weight:800; color:var(--nexus-dark); }
        .main-card { border-radius:15px; background:#fff; box-shadow:0 5px 15px rgba(0,0,0,0.05); overflow:hidden; }
        .card-header-custom { padding:1.5rem; border-bottom:1px solid #eee; background:#fff; }
        .btn-nexus { background:var(--nexus-accent); border-color:var(--nexus-accent); color:var(--nexus-dark); font-weight:600; }
        @media (max-width:991.98px) { .sidebar { margin-left:-280px; } .main-content { margin-left:0; width:100%; } .sidebar.active { margin-left:0; } }
    </style>
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="nexus-brand">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--nexus-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                <circle cx="12" cy="8" r="1.5" fill="var(--nexus-accent)" stroke="none"/>
            </svg>
            NEXUS
        </div>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-inbox me-2"></i> Pending Assignments
                <span class="badge bg-danger ms-auto rounded-pill"> <c:out value="${stats.totalAssigned - stats.inProgress}" default="0"/> </span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#my-cases">
                <i class="fas fa-tasks me-2"></i> My Active Cases
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#station-reports">
                <i class="fas fa-file-invoice me-2"></i> Station Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#analytics">
                <i class="fas fa-chart-line me-2"></i> Crime Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#profile">
                <i class="fas fa-user-shield me-2"></i> Profile
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light w-100 btn-sm fw-bold">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<div class="main-content" id="main-content">

    <nav class="navbar navbar-expand-lg top-navbar">
        <div class="container-fluid">
            <button class="btn border-0" id="sidebar-toggle">
                <i class="fas fa-bars fs-4 text-secondary"></i>
            </button>

            <div class="ms-auto d-flex align-items-center gap-3">
                <a href="#" class="btn btn-sm btn-outline-danger d-none d-md-block animate__animated animate__flash animate__infinite animate__slow">
                    <i class="fas fa-exclamation-circle me-1"></i> High Priority Alert
                </a>

                <div class="dropdown">
                    <a href="#" class="text-secondary position-relative bell-shake" data-bs-toggle="dropdown">
                        <i class="fas fa-bell fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size:0.6rem;">5</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 animate__animated animate__fadeIn">
                        <li><h6 class="dropdown-header">Alerts</h6></li>
                        <li><a class="dropdown-item small" href="#">New FIR #1026 Assigned</a></li>
                        <li><a class="dropdown-item small text-danger" href="#">Emergency in Sector 4</a></li>
                    </ul>
                </div>

                <div class="d-none d-md-flex align-items-center gap-2">
                    <img src="https://ui-avatars.com/api/?name=${fn:escapeXml(sessionScope.user_name)}&background=1C3144&color=fff" class="rounded-circle border border-2 border-light shadow-sm" width="35" height="35" alt="Officer">
                    <span class="fw-semibold small text-secondary">${sessionScope.user_name}</span>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid p-4">

        <div class="dashboard-hero animate__animated animate__fadeInDown">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold mb-1">Station Command Center</h2>
                    <p class="mb-0 opacity-75">Overview of daily operations and pending assignments for <span class="fw-bold">Station</span>.</p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <div class="d-inline-block bg-white bg-opacity-25 px-3 py-2 rounded border border-light border-opacity-25">
                        <i class="fas fa-clock me-2"></i> <span id="liveClock">--:--</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card">
                    <div class="card-icon icon-pending">
                        <i class="fas fa-inbox"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">New Complaints</h6>
                        <div class="stat-number counter" data-target="${stats.totalAssigned - stats.inProgress}">0</div>
                    </div>
                </div>
            </div>

            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card">
                    <div class="card-icon icon-active">
                        <i class="fas fa-search-location"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Active Cases (Assigned)</h6>
                        <div class="stat-number counter" data-target="${stats.totalAssigned}">0</div>
                    </div>
                </div>
            </div>

            <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                <div class="stat-card">
                    <div class="card-icon icon-closed">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Resolved This Month</h6>
                        <div class="stat-number counter" data-target="${stats.resolved}">0</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="400">
            <div class="col-12">
                <div class="main-card">
                    <div class="card-header-custom d-flex align-items-center justify-content-between">
                        <h5 class="fw-bold mb-0"><i class="fas fa-clipboard-list me-2"></i>Incoming Assignments</h5>
                        <div>
                            <a href="${pageContext.request.contextPath}/police/assignments" class="btn btn-sm btn-outline-primary fw-bold">View All Pending</a>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Case ID</th>
                                <th>Type</th>
                                <th>Date</th>
                                <th>Location</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="c" items="${assignedCases}">
                                <tr data-aos="fade-left">
                                    <td class="ps-4 fw-bold text-primary">#C-${c.complaintId}</td>
                                    <td><i class="fas fa-file-alt me-2 text-secondary"></i>${c.complaintType}</td>
                                    <td><fmt:formatDate value="${c.dateFiled}" pattern="MMM dd, yyyy" /></td>
                                    <td><c:out value="${c.locationOfIncident}" default="N/A"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.urgencyLevel == 'HIGH'}">
                                                <span class="badge badge-priority-high rounded-pill">High</span>
                                            </c:when>
                                            <c:when test="${c.urgencyLevel == 'MEDIUM'}">
                                                <span class="badge badge-priority-med rounded-pill">Medium</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-priority-low rounded-pill">Low</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.currentStatus == 'FILED'}">
                                                <span class="badge bg-primary">Filed</span>
                                            </c:when>
                                            <c:when test="${c.currentStatus == 'UNDER_INVESTIGATION'}">
                                                <span class="badge bg-warning text-dark">Under Investigation</span>
                                            </c:when>
                                            <c:when test="${c.currentStatus == 'RESOLVED'}">
                                                <span class="badge bg-success">Resolved</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${c.currentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-nexus px-3 manage-btn"
                                                data-id="${c.complaintId}"
                                                data-type="${c.complaintType}"
                                                data-date="<fmt:formatDate value='${c.dateFiled}' pattern='yyyy-MM-dd HH:mm:ss'/>"
                                                data-location="${c.locationOfIncident}"
                                                data-priority="${c.urgencyLevel}"
                                                data-status="${c.currentStatus}"
                                                data-description="${fn:escapeXml(c.description)}"
                                                data-regid="${c.regId}"
                                                data-bs-toggle="modal" data-bs-target="#complaintModal">
                                            Manage
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty assignedCases}">
                                <tr>
                                    <td colspan="7" class="text-center p-4 text-muted">
                                        No assigned cases yet.
                                    </td>
                                </tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Manage Case Modal -->
<div class="modal fade" id="complaintModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background: linear-gradient(135deg, var(--nexus-dark), #2c5364);">
                <h5 class="modal-title fw-bold" id="complaintModalTitle"><i class="fas fa-folder-open me-2"></i>Manage Case</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <form id="manageCaseForm" method="post" action="${pageContext.request.contextPath}/police/updateStatus">
                <div class="modal-body p-4">
                    <input type="hidden" name="complaintId" id="modalComplaintId">

                    <div class="row mb-3">
                        <div class="col-md-6 border-end">
                            <h6 class="text-primary fw-bold small">Civilian (Reporter)</h6>
                            <p class="mb-1"><strong>Reporter ID:</strong> <span id="modalReporterId">-</span></p>
                            <p class="mb-1"><strong>Contact:</strong> <span id="modalReporterContact">N/A</span></p>
                        </div>
                        <div class="col-md-6 ps-md-4">
                            <h6 class="text-primary fw-bold small">Incident Details</h6>
                            <p class="mb-1"><strong>Type:</strong> <span id="modalType">-</span></p>
                            <p class="mb-1"><strong>Location:</strong> <span id="modalLocation">-</span></p>
                            <p class="mb-0"><strong>Date:</strong> <span id="modalDate">-</span></p>
                        </div>
                    </div>

                    <div class="bg-light p-3 rounded mb-3">
                        <h6 class="fw-bold text-secondary">Description</h6>
                        <p class="mb-0 small text-muted" id="modalDescription">-</p>
                    </div>

                    <h6 class="fw-bold border-bottom pb-2 mb-3">Update Status & Assignment</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Assign Investigator</label>
                            <select name="assignTo" id="modalAssignTo" class="form-select">
                                <option value="">-- Select Officer --</option>
                                <%-- You can populate options server-side or via another AJAX call --%>
                                <option value="101">Officer Dave (Cyber Unit)</option>
                                <option value="102">Officer Priya (General)</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Case Status</label>
                            <select name="status" id="modalStatus" class="form-select" required>
                                <option value="FILED">Filed</option>
                                <option value="UNDER_REVIEW">Under Review</option>
                                <option value="UNDER_INVESTIGATION">Under Investigation</option>
                                <option value="RESOLVED">Resolved</option>
                                <option value="CLOSED">Closed</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label small fw-bold">Internal Notes</label>
                            <textarea name="notes" id="modalNotes" class="form-control" rows="2" placeholder="Add internal notes..."></textarea>
                        </div>
                    </div>

                </div>

                <div class="modal-footer bg-light border-0">
                    <button type="button" class="btn btn-link text-secondary text-decoration-none" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-nexus px-4">Update Case</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });

    // Sidebar Toggle
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
        if (window.innerWidth >= 992) {
            document.querySelector('.main-content').style.marginLeft =
                document.querySelector('.main-content').style.marginLeft === '0px' ? '280px' : '0px';
        }
    });

    // Live Clock
    setInterval(() => {
        const now = new Date();
        document.getElementById('liveClock').innerText = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    }, 1000);

    // Counter Animation (reads data-target attributes)
    const counters = document.querySelectorAll('.counter');
    const animateCounters = () => {
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target') || 0;
            const increment = Math.max(1, Math.floor(target / 50));
            const updateCounter = () => {
                const c = +counter.innerText || 0;
                if (c < target) {
                    counter.innerText = Math.min(target, Math.ceil(c + increment));
                    setTimeout(updateCounter, 15);
                } else {
                    counter.innerText = target;
                }
            };
            updateCounter();
        });
    };
    document.addEventListener('DOMContentLoaded', animateCounters);

    // Manage button — populate modal with data-* attributes
    document.querySelectorAll('.manage-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const id = this.dataset.id;
            const type = this.dataset.type || '';
            const date = this.dataset.date || '';
            const location = this.dataset.location || '';
            const priority = this.dataset.priority || '';
            const status = this.dataset.status || '';
            const description = this.dataset.description || '';
            const regId = this.dataset.regid || '-';

            document.getElementById('complaintModalTitle').innerText = "Manage Case #C-" + id;
            document.getElementById('modalComplaintId').value = id;
            document.getElementById('modalType').innerText = type;
            document.getElementById('modalDate').innerText = date;
            document.getElementById('modalLocation').innerText = location;
            document.getElementById('modalDescription').innerText = description;
            document.getElementById('modalReporterId').innerText = "CIV-" + regId;
            document.getElementById('modalReporterContact').innerText = "N/A";

            // set selected status
            const statusEl = document.getElementById('modalStatus');
            if(statusEl) {
                for (let i=0;i<statusEl.options.length;i++){
                    statusEl.options[i].selected = (statusEl.options[i].value === status);
                }
            }

            // set priority (visual only)
            // ... you can also set a DOM node if required
        });
    });
</script>

</body>
</html>

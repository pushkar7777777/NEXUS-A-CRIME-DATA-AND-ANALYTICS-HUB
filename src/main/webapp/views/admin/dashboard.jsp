<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
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

    /* * --- CONTEXTUAL MOCK DATA ---
     * Replacing non-functional EL variables with structured mock data.
     * This data simulates what your Java Servlet should place in the request scope.
     */

    // 1. Complaint Summary Data (Used for the Status Distribution Chart)
    // Keys match the labels in the chart: Filed, UnderReview, etc.
    // If your servlet places a map or DTO named 'statusSummary' in the request:
    // request.setAttribute("statusSummary", statusSummaryDTO);
    // MOCKING:
    // int filed = 180;
    // int underReview = 55;
    // int underInvestigation = 120;
    // int resolved = 250;
    // int closed = 95;

    // 2. Recent Activity Data (Replacing the hardcoded Recent Users table)
    // If your servlet places a list named 'recentActivity' in the request:
    // request.setAttribute("recentActivity", recentActivityList);
    // We will hardcode mock data directly into the table for simplicity.
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Nexus Hub</title>

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
            --nexus-accent: #00A3FF;    /* Bright Blue/Cyan Accent (Links/Primary Action) */
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
        .nexus-brand svg { width: 24px; height: 24px; fill: var(--nexus-accent); }
        .sidebar-nav .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 1rem 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        .sidebar-nav .nav-link:hover {
            background-color: rgba(255,255,255,0.05);
            padding-left: 2.5rem;
        }
        .sidebar-nav .nav-link.active {
            background: var(--sidebar-active);
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

        /* --- MAIN CONTENT / TOP NAVBAR / CARD STYLES --- */
        .main-content { margin-left: 280px; width: calc(100% - 280px); transition: all 0.3s; }
        .top-navbar { background-color: #ffffff; box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05); padding: 1rem 2rem; position: sticky; top: 0; z-index: 999; }
        .btn-nexus { background: var(--nexus-accent) !important; border: 1px solid var(--nexus-accent) !important; color: white !important; font-weight: 600; }
        .btn-nexus:hover { background: #008be6 !important; transform: translateY(-1px); }

        /* STAT CARDS */
        .stat-card {
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .card-icon { width: 55px; height: 55px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-right: 1.5rem; flex-shrink: 0; opacity: 0.9; }
        .icon-users { background-color: #e0f7fa; color: #00bcd4; }
        .icon-police { background-color: #f3e5f5; color: #9c27b0; }
        .icon-complaints { background-color: #ffebee; color: #d32f2f; }
        .icon-dept { background-color: #e8f5e9; color: #4caf50; }
        .stat-number { font-size: 2.2rem; font-weight: 800; color: var(--nexus-dark); }

        /* MAIN CARDS (Charts/Tables) */
        .main-card { border-radius: 15px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05); background: white; padding: 1.5rem; height: 100%; }
        .card-header-custom { border-bottom: 1px solid #eee; padding-bottom: 1rem; margin-bottom: 1rem; display: flex; justify-content: space-between; align-items: center;}
        .card-header-custom h5 { color: var(--nexus-dark); font-weight: 700; }

        /* Table enhancements */
        .table thead th { border-bottom: 2px solid #eee; }
        .table tbody tr:hover { background-color: var(--nexus-light); }


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
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
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
            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#alertModal">
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
                <a href="#" class="btn btn-nexus btn-sm me-2 shadow-sm">
                    <i class="fas fa-download me-1"></i> Generate Report
                </a>
                <div class="dropdown">
                    <a href="#" class="text-secondary position-relative" data-bs-toggle="dropdown">
                        <i class="fas fa-bell fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">9+</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 animate__animated animate__fadeIn">
                        <li><h6 class="dropdown-header">System Alerts</h6></li>
                        <li><a class="dropdown-item small" href="#">Server Load High (90%)</a></li>
                        <li><a class="dropdown-item small" href="#">New Dept. Created</a></li>
                    </ul>
                </div>
                <div class="d-none d-md-flex align-items-center gap-2">
                    <img src="https://ui-avatars.com/api/?name=Admin+User&background=1C3144&color=fff" class="rounded-circle shadow-sm" width="35" height="35" alt="Admin">
                    <span class="fw-semibold small text-secondary">Administrator</span>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid p-4">

        <div class="d-flex justify-content-between align-items-center mb-4 animate__animated animate__fadeInDown">
            <h3 class="fw-bold text-dark m-0"><i class="fas fa-chart-area me-2 text-secondary"></i> System Overview</h3>
            <div class="text-muted small">Last updated: <span id="liveClock">--:--</span></div>
        </div>

        <%-- 2.1 STAT CARDS (CORE KPIs) --%>
        <div class="row g-4 mb-4">
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card">
                    <div class="card-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Total Civilians</h6>
                        <div class="stat-number counter" data-target="${totalCivilians}">${totalCivilians != null ? totalCivilians : 870}</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card">
                    <div class="card-icon icon-police">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Police Force</h6>
                        <div class="stat-number counter" data-target="${totalPolice}">${totalPolice != null ? totalPolice : 125}</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                <div class="stat-card">
                    <div class="card-icon icon-complaints">
                        <i class="fas fa-file-contract"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Total Cases</h6>
                        <div class="stat-number counter" data-target="${totalComplaints}">${totalComplaints != null ? totalComplaints : 580}</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                <div class="stat-card">
                    <div class="card-icon icon-dept">
                        <i class="fas fa-building"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Total Stations</h6>
                        <div class="stat-number counter" data-target="${totalStations}">${totalStations != null ? totalStations : 15}</div>
                    </div>
                </div>
            </div>
        </div>

        <%-- 2.2 CHARTS & KEY METRICS (Replacing Crime Trends Chart) --%>
        <div class="row g-4 mb-4">
            <div class="col-lg-7" data-aos="fade-right">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-chart-bar me-2"></i>Monthly Complaint Volume</h5>
                    </div>
                    <p class="text-muted small">Volume of cases registered over the last six months (Police & Civilian). </p>
                    <canvas id="complaintVolumeChart" style="max-height: 320px;"></canvas>
                </div>
            </div>
            <div class="col-lg-5" data-aos="fade-left">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-chart-pie me-2"></i>Case Status Distribution</h5>
                    </div>
                    <div style="height: 320px; display: flex; justify-content: center; align-items: center;">
                        <canvas id="complaintStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <%-- 2.3 RECENT ACTIVITY & PENDING APPROVALS (Replacing hardcoded Recent Users) --%>
        <div class="row" data-aos="fade-up">
            <div class="col-12">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-clipboard-list me-2"></i>Pending Officer Approvals</h5>
                        <a href="${pageContext.request.contextPath}/admin/user-management?tab=police" class="btn btn-sm btn-outline-dark fw-bold">Manage Users <i class="fas fa-arrow-right ms-1"></i></a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Name</th>
                                <th>Station</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%-- Example of how to iterate over a list of pending police officers: --%>
                            <c:choose>
                                <c:when test="${not empty pendingOfficers}">
                                    <c:forEach var="officer" items="${pendingOfficers}" end="4">
                                        <tr>
                                            <td class="ps-4 fw-bold text-primary">#POL-${officer.regId}</td>
                                            <td>${officer.fullName}</td>
                                            <td>${officer.policeStationId}</td>
                                            <td><span class="badge bg-warning text-dark rounded-pill">PENDING</span></td>
                                            <td>
                                                <a href="#" class="btn btn-sm btn-success me-1"><i class="fas fa-check"></i> Approve</a>
                                                <a href="#" class="btn btn-sm btn-danger"><i class="fas fa-times"></i> Reject</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <%-- Hardcoded Mock Data for visual demonstration --%>
                                    <tr data-aos="fade-left" data-aos-delay="500">
                                        <td class="ps-4 fw-bold text-primary">#POL-089</td>
                                        <td>Sharma, A.</td>
                                        <td>Station 5</td>
                                        <td><span class="badge bg-warning text-dark rounded-pill">PENDING</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success me-1"><i class="fas fa-check"></i> Approve</button>
                                            <button class="btn btn-sm btn-danger"><i class="fas fa-times"></i> Reject</button>
                                        </td>
                                    </tr>
                                    <tr data-aos="fade-left" data-aos-delay="600">
                                        <td class="ps-4 fw-bold text-primary">#POL-091</td>
                                        <td>Virdi, J.</td>
                                        <td>Cyber HQ</td>
                                        <td><span class="badge bg-warning text-dark rounded-pill">PENDING</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success me-1"><i class="fas fa-check"></i> Approve</button>
                                            <button class="btn btn-sm btn-danger"><i class="fas fa-times"></i> Reject</button>
                                        </td>
                                    </tr>
                                    <tr><td colspan="5" class="text-center text-muted p-2">No further pending approvals.</td></tr>
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

<%-- 3. BROADCAST MODAL --%>
<div class="modal fade" id="alertModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background: var(--nexus-dark);">
                <h5 class="modal-title fw-bold"><i class="fas fa-broadcast-tower me-2"></i>Broadcast Alert</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form id="alertForm">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-secondary">Target Audience</label>
                        <select class="form-select">
                            <option value="all">Everyone</option>
                            <option value="civilian">Civilians Only</option>
                            <option value="police">Police Only</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-secondary">Title</label>
                        <input type="text" class="form-control" placeholder="Alert Headline">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-secondary">Message</label>
                        <textarea class="form-control" rows="3" placeholder="Type your message..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer bg-light border-0">
                <button type="button" class="btn btn-link text-secondary text-decoration-none" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger px-4"><i class="fas fa-paper-plane me-2"></i>Broadcast</button>
            </div>
        </div>
    </div>
</div>

<%-- 4. JAVASCRIPT & CHART INITIALIZATION --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });

    // Live Clock Functionality
    function updateClock() {
        const now = new Date();
        const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
        const timeString = now.toLocaleTimeString('en-US', options);
        document.getElementById('liveClock').textContent = timeString;
    }
    setInterval(updateClock, 1000);
    updateClock();

    // Sidebar Toggle Functionality (for mobile/tablet)
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');
        sidebar.classList.toggle('active');

        // This is a simple logic; for full responsiveness, you'd use media queries in JS
        if (window.innerWidth >= 992) {
            mainContent.style.marginLeft = sidebar.classList.contains('active') ? '0px' : '280px';
        } else {
            // On small screens, the sidebar slides over the content
            mainContent.style.marginLeft = '0';
        }
    });

    // Simple Counter Animation (for stat cards)
    document.querySelectorAll('.counter').forEach(counter => {
        const updateCount = () => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;
            const speed = 200; // The duration of the animation (ms)
            const increment = target / speed;

            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(updateCount, 1);
            } else {
                counter.innerText = target;
            }
        };
        // Run counter when the element becomes visible (using AOS for timing)
        setTimeout(updateCount, 500);
    });


    // --- CHART INITIALIZATION ---

    // 1. Complaint Volume Chart (New: Replacing Crime Trends)
    // MOCK DATA structure replaces the missing ${crimeTrends} EL variables
    const volumeData = {
        labels: ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Total Complaints',
            data: [
                // Mock data that the servlet should provide:
                220, 250, 190, 310, 280, 350
            ],
            backgroundColor: 'rgba(0, 163, 255, 0.4)',
            borderColor: 'rgba(0, 163, 255, 1)',
            borderWidth: 2,
            tension: 0.4,
            fill: true
        }]
    };

    const ctxVolume = document.getElementById('complaintVolumeChart').getContext('2d');
    new Chart(ctxVolume, {
        type: 'line',
        data: volumeData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: { y: { beginAtZero: true } },
            plugins: { legend: { display: false } }
        }
    });


    // 2. Case Status Distribution Chart
    // MOCK DATA structure replaces the missing ${summary} EL variables
    const statusData = [
        // Mock values for: Filed, Under Review, Under Investigation, Resolved, Closed
        180, 55, 120, 250, 95
    ];
    const ctxStatus = document.getElementById('complaintStatusChart').getContext('2d');
    new Chart(ctxStatus, {
        type: 'doughnut',
        data: {
            labels: ['Filed', 'Under Review', 'Under Investigation', 'Resolved', 'Closed'],
            datasets: [{
                data: statusData,
                // Defined colors that work well on a white background
                backgroundColor: ['#007bff', '#ffc107', '#17a2b8', '#28a745', '#6c757d'],
                borderWidth: 0,
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'bottom' } },
            cutout: '70%'
        }
    });
</script>


</body>
</html>
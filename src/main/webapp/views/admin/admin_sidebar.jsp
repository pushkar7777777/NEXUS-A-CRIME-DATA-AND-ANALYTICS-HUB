<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Nexus Hub</title>
    <style>
        /* --- BRAND COLORS --- */
        /* ... (Root variables remain the same) ... */
        :root {
            --nexus-dark: #1C3144;
            --nexus-accent: #00A3FF;
            --nexus-light: #F0F4F8;
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
        /* NOTE: Sidebar CSS must remain here since this page defines the layout */
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
        /* ... (Remaining sidebar styles like .sidebar-header, .sidebar-nav, etc., must be here) ... */
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
        }
        .nexus-brand svg path, .nexus-brand svg circle {
            stroke: var(--nexus-accent);
            fill: var(--nexus-accent);
        }
        .nexus-brand svg path[d*="8l-3 5"] {
            stroke: #fff;
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


        /* --- MAIN CONTENT --- */
        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            transition: all 0.3s;
        }

        /* --- TOP NAVBAR --- */
        /* ... (Remaining layout styles) ... */
        .top-navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }
        .bell-shake:hover {
            animation: shake 0.5s infinite;
        }
        .top-navbar .btn-nexus {
            background: var(--nexus-accent);
            border: 1px solid var(--nexus-accent);
            color: var(--nexus-dark);
            font-weight: 600;
            transition: all 0.3s;
        }
        .top-navbar .btn-nexus:hover {
            background: #008be6;
            border-color: #008be6;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(0, 163, 255, 0.3);
        }

        /* --- STAT CARDS --- */
        .stat-card {
            border: 1px solid #e0e0e0;
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .card-icon {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-right: 1.5rem;
            flex-shrink: 0;
            opacity: 0.9;
        }
        .icon-users { background-color: #e0f7fa; color: #00bcd4; }
        .icon-police { background-color: #f3e5f5; color: #9c27b0; }
        .icon-complaints { background-color: #ffebee; color: #d32f2f; }
        .icon-dept { background-color: #e8f5e9; color: #4caf50; }

        .stat-card h6 {
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            font-weight: 700;
            color: #888;
        }
        .stat-number {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--nexus-dark);
        }

        /* --- MAIN CARDS (Charts/Tables) --- */
        .main-card {
            border: 1px solid #e0e0e0;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            height: 100%;
            background: white;
            transition: transform 0.3s;
        }

        .main-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
        }

        .card-header-custom {
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }
        .card-header-custom h5 {
            color: var(--nexus-dark);
            font-weight: 700;
        }

        .table-hover tbody tr:hover {
            background-color: var(--nexus-light);
            transform: none;
            box-shadow: none;
        }

        /* --- MODAL --- */
        .modal-header-nexus {
            background: linear-gradient(135deg, var(--nexus-dark), #2c5364);
        }

        @media (max-width: 991.98px) {
            .sidebar { margin-left: -280px; }
            .main-content { margin-left: 0; width: 100%; }
            .sidebar.active { margin-left: 0; }
        }
    </style>
</head>
<body>

<%-- 🎯 FIX: Replace the hardcoded sidebar HTML with the include 🎯 --%>
<jsp:include page="admin_sidebar.jsp" flush="true"/>

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
                    <a href="#" class="text-secondary position-relative bell-shake" data-bs-toggle="dropdown">
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

        <div class="row g-4 mb-4">
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card">
                    <div class="card-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <h6 class="text-uppercase mb-1 small fw-bold">Total Civilians</h6>
                        <div class="stat-number counter" data-target="${totalCivilians}">${totalCivilians}</div>
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
                        <div class="stat-number counter" data-target="${totalPolice}">${totalPolice}</div>
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
                        <div class="stat-number counter" data-target="${totalComplaints}">${totalComplaints}</div>
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
                        <div class="stat-number counter" data-target="${totalStations}">${totalStations}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-lg-7" data-aos="fade-right">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-chart-line me-2"></i>Crime Trends (Last 6 Months)</h5>
                    </div>
                    <canvas id="crimeTrendChart" style="max-height: 300px;"></canvas>
                </div>
            </div>
            <div class="col-lg-5" data-aos="fade-left">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-chart-pie me-2"></i>Case Status Distribution</h5>
                    </div>
                    <div style="height: 300px; display: flex; justify-content: center;">
                        <canvas id="complaintStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" data-aos="fade-up">
            <div class="col-12">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-users-cog me-2"></i>Recent User Activity</h5>
                        <button class="btn btn-sm btn-outline-dark fw-bold">Manage All</button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th class="ps-4">User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr data-aos="fade-left" data-aos-delay="500">
                                <td class="ps-4 fw-bold text-primary">#CIV-101</td>
                                <td>Alice Green</td>
                                <td>alice@email.com</td>
                                <td><span class="badge bg-info text-dark border border-info-subtle fw-normal">Civilian</span></td>
                                <td><span class="badge bg-success rounded-pill">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-secondary border"><i class="fas fa-ellipsis-h"></i></button>
                                </td>
                            </tr>
                            <tr data-aos="fade-left" data-aos-delay="600">
                                <td class="ps-4 fw-bold text-primary">#POL-055</td>
                                <td>Officer Ray</td>
                                <td>ray@police.gov</td>
                                <td><span class="badge bg-dark fw-normal">Police</span></td>
                                <td><span class="badge bg-success rounded-pill">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-secondary border"><i class="fas fa-ellipsis-h"></i></button>
                                </td>
                            </tr>
                            <tr data-aos="fade-left" data-aos-delay="700">
                                <td class="ps-4 fw-bold text-primary">#CIV-102</td>
                                <td>Bob Smith</td>
                                <td>bob@email.com</td>
                                <td><span class="badge bg-info text-dark border border-info-subtle fw-normal">Civilian</span></td>
                                <td><span class="badge bg-warning text-dark rounded-pill">Suspended</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-secondary border"><i class="fas fa-ellipsis-h"></i></button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="alertModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white modal-header-nexus">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });

    // Sidebar Toggle Logic (needed for the button in the main page)
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
        const mainContent = document.querySelector('.main-content');
        mainContent.style.marginLeft =
            mainContent.style.marginLeft === '0px' ? '280px' : '0px';
    });

    // Clock
    setInterval(() => {
        const now = new Date();
        document.getElementById('liveClock').innerText = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    }, 1000);

    // Counter Animation
    const counters = document.querySelectorAll('.counter');
    counters.forEach(counter => {
        const target = +counter.getAttribute('data-target');
        const increment = target / 50;
        const updateCounter = () => {
            const c = +counter.innerText;
            if(c < target) {
                counter.innerText = Math.ceil(c + increment);
                setTimeout(updateCounter, 20);
            } else {
                counter.innerText = target;
            }
        };
        updateCounter();
    });

    // --- CHARTS ---

    // 1. Crime Trend Chart (Line)
    const ctxTrend = document.getElementById('crimeTrendChart').getContext('2d');
    new Chart(ctxTrend, {
        type: 'line',
        data: {
            labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
            datasets: [{
                label: 'Theft',
                data: [120, 150, 140, 160, 180, 170],
                borderColor: '#0d47a1',
                backgroundColor: 'rgba(13, 71, 161, 0.1)',
                fill: true,
                tension: 0.4
            }, {
                label: 'Cybercrime',
                data: [80, 90, 110, 100, 130, 140],
                borderColor: '#ff6f00',
                backgroundColor: 'rgba(255, 111, 0, 0.1)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: { duration: 2000, easing: 'easeOutQuart' },
            plugins: { legend: { position: 'top' } },
            scales: { y: { beginAtZero: true, grid: { borderDash: [5, 5] } } }
        }
    });

    // SAFE SUMMARY VALUES (Updated for completeness)
    const statusData = [
        ${summary.filed != null ? summary.filed : 0},
        ${summary.underReview != null ? summary.underReview : 0},
        ${summary.underInvestigation != null ? summary.underInvestigation : 0},
        ${summary.resolved != null ? summary.resolved : 0},
        ${summary.closed != null ? summary.closed : 0}
    ];

    // 2. Complaint Status Chart (Doughnut)
    const ctxStatus = document.getElementById('complaintStatusChart').getContext('2d');
    new Chart(ctxStatus, {
        type: 'doughnut',
        data: {
            labels: ['Filed', 'Under Review', 'Under Investigation', 'Resolved', 'Closed'],
            datasets: [{
                data: statusData,
                backgroundColor: ['#007bff', '#ffc107', '#17a2b8', '#28a745', '#6c757d'],
                borderWidth: 0,
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: { animateScale: true, animateRotate: true },
            plugins: { legend: { position: 'bottom' } },
            cutout: '70%'
        }
    });

</script>

</body>
</html>
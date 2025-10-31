<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Crime Data Hub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Google Fonts (Inter) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Custom CSS for Dashboard -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f7f6;
            display: flex;
            min-height: 100vh;
        }

        /* --- Sidebar --- */
        .sidebar {
            width: 260px;
            background-color: #212529; /* Dark charcoal/black for Admin */
            color: #ffffff;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 1.5rem;
            text-align: center;
            border-bottom: 1px solid #343a40;
        }

        .sidebar-header h3 {
            margin: 0;
            font-weight: 700;
            font-size: 1.5rem;
        }

        .sidebar-nav .nav-link {
            color: #e0e0e0;
            padding: 1rem 1.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: all 0.2s;
        }

        .sidebar-nav .nav-link i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
        }

        .sidebar-nav .nav-link:hover {
            background-color: #343a40;
            color: #ffffff;
        }

        .sidebar-nav .nav-link.active {
            background-color: #0055a4; /* Primary blue as accent */
            color: #ffffff;
            font-weight: 600;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 1rem 1.5rem;
            background-color: #000000;
        }

        /* --- Main Content --- */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            transition: all 0.3s;
            padding: 0;
        }

        /* --- Top Bar --- */
        .top-navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 0.75rem 2rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }

        .navbar-toggler {
            border: none;
            font-size: 1.5rem;
        }

        .user-profile {
            font-weight: 600;
            color: #333;
        }

        /* --- Content Area --- */
        .content-area {
            padding: 2rem;
        }

        /* Stat Cards */
        .stat-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-card .card-icon {
            font-size: 2.5rem;
            padding: 1rem;
            border-radius: 50%;
            margin-right: 1rem;
        }

        .stat-card .card-info h5 {
            font-size: 1rem;
            color: #666;
            margin-bottom: 0.25rem;
        }

        .stat-card .card-info .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
        }

        .icon-users { background-color: #e6f0ff; color: #0055a4; }
        .icon-complaints { background-color: #fff4e6; color: #ff9800; }
        .icon-police { background-color: #e0e7ef; color: #343a40; }
        .icon-dept { background-color: #e6f7ec; color: #28a745; }

        /* Main Card (for tables, charts, etc.) */
        .main-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
            padding: 1.5rem;
            height: 100%;
        }

        .main-card .card-header {
            background-color: transparent;
            border-bottom: 1px solid #eee;
            padding: 0 0 1rem 0;
            margin-bottom: 1rem;
        }

        .main-card .card-header h4 {
            font-weight: 600;
            color: #212529;
            margin: 0;
        }

        .btn-primary {
            background-color: #0055a4;
            border-color: #0055a4;
        }

        .btn-primary:hover {
            background-color: #004488;
            border-color: #004488;
        }

        .badge-status {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.4em 0.7em;
        }

        /* --- Responsive --- */
        @media (max-width: 991.98px) {
            .sidebar {
                margin-left: -260px;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .sidebar.active {
                margin-left: 0;
            }
        }

    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-cogs"></i> Admin Panel</h3>
    </div>
    <ul class="nav flex-column sidebar-nav p-3">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="fas fa-tachometer-alt"></i>
                Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-users-cog"></i>
                User Management
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-tasks"></i>
                Complaint Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-chart-pie"></i>
                Analytics & Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-building"></i>
                Manage Departments
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-clipboard-list"></i>
                System Logs
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#alertModal">
                <i class="fas fa-bullhorn"></i>
                Send Alert
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <a href="index.html" class="btn btn-outline-light w-100">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<!-- Main Content Wrapper -->
<div class="main-content" id="main-content">

    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg top-navbar">
        <div class="container-fluid">
            <!-- Mobile Menu Toggle -->
            <button class="navbar-toggler" type="button" id="sidebar-toggle">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Welcome Message -->
            <span class="navbar-text user-profile d-none d-md-block">
                    Welcome, Administrator!
                </span>

            <!-- Quick Actions -->
            <div class="ms-auto d-flex align-items-center">
                <a href="#" class="btn btn-primary btn-sm me-3">
                    <i class="fas fa-download me-1"></i> Generate Report
                </a>
                <i class="fas fa-bell fs-5 text-secondary"></i>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <main class="content-area">

        <!-- Dashboard Title -->
        <h1 class="h3 mb-4" style="font-weight: 600; color: #212529;">System Dashboard</h1>

        <!-- Stat Cards -->
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="card-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Total Civilians</h5>
                        <span class="stat-number">1,450</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="card-icon icon-police">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Total Police</h5>
                        <span class="stat-number">210</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="card-icon icon-complaints">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Total Complaints</h5>
                        <span class="stat-number">3,890</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="card-icon icon-dept">
                        <i class="fas fa-building"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Departments</h5>
                        <span class="stat-number">15</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Row -->
        <div class="row mt-4">

            <!-- Crime Trend Analysis -->
            <div class="col-lg-7 mb-4">
                <div class="main-card">
                    <div class="card-header">
                        <h4><i class="fas fa-chart-line me-2"></i>Crime Trend Analysis (Last 6 Months)</h4>
                    </div>
                    <canvas id="crimeTrendChart" style="max-height: 350px;"></canvas>
                </div>
            </div>

            <!-- Complaint Status -->
            <div class="col-lg-5 mb-4">
                <div class="main-card">
                    <div class="card-header">
                        <h4><i class="fas fa-chart-pie me-2"></i>Complaints by Status</h4>
                    </div>
                    <canvas id="complaintStatusChart" style="max-height: 350px;"></canvas>
                </div>
            </div>

        </div>

        <!-- User Management Table -->
        <div class="row mt-2">
            <div class="col-lg-12">
                <div class="main-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4><i class="fas fa-users-cog me-2"></i>User Management</h4>
                        <a href="#" class="btn btn-outline-primary btn-sm">View All Users</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><strong>#CIV-101</strong></td>
                                <td>Civilian Name</td>
                                <td>civilian@email.com</td>
                                <td><span class="badge bg-light text-dark">Civilian</span></td>
                                <td><span class="badge rounded-pill bg-success badge-status">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-warning">Suspend</button>
                                    <button class="btn btn-sm btn-outline-danger">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#POL-55</strong></td>
                                <td>Officer Sharma</td>
                                <td>osharma@police.gov</td>
                                <td><span class="badge bg-primary">Police</span></td>
                                <td><span class="badge rounded-pill bg-success badge-status">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-warning">Suspend</button>
                                    <button class="btn btn-sm btn-outline-danger">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#CIV-102</strong></td>
                                <td>Another User</td>
                                <td>user2@email.com</td>
                                <td><span class="badge bg-light text-dark">Civilian</span></td>
                                <td><span class="badge rounded-pill bg-warning text-dark badge-status">Suspended</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-success">Activate</button>
                                    <button class="btn btn-sm btn-outline-danger">Delete</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </main>
</div>

<!-- Send Alert Modal -->
<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form id="alertForm" action="send-alert-servlet" method="POST">
                <div class="modal-header" style="background-color: #212529; color: white;">
                    <h5 class="modal-title" id="alertModalLabel"><i class="fas fa-bullhorn me-2"></i>Broadcast System Alert</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <!-- Target Audience -->
                    <div class="mb-3">
                        <label for="alertTarget" class="form-label">Target Audience</label>
                        <select class="form-select" id="alertTarget" name="alertTarget" required>
                            <option value="all">All Users (Civilians & Police)</option>
                            <option value="civilian">Civilians Only</option>
                            <option value="police">Police Only</option>
                        </select>
                    </div>

                    <!-- Alert Title -->
                    <div class="mb-3">
                        <label for="alertTitle" class="form-label">Alert Title</label>
                        <input type="text" class="form-control" id="alertTitle" name="alertTitle" placeholder="e.g., System Maintenance" required>
                    </div>

                    <!-- Alert Message -->
                    <div class="mb-3">
                        <label for="alertMessage" class="form-label">Message</label>
                        <textarea class="form-control" id="alertMessage" name="alertMessage" rows="4" placeholder="Enter alert details..."></textarea>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger"><i class="fas fa-paper-plane me-2"></i>Send Broadcast</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Custom JS for Dashboard -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebar-toggle');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }

        // --- Charts ---

        // 1. Crime Trend Chart (Line)
        const ctxTrend = document.getElementById('crimeTrendChart');
        if (ctxTrend) {
            new Chart(ctxTrend, {
                type: 'line',
                data: {
                    labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
                    datasets: [{
                        label: 'Theft',
                        data: [120, 150, 140, 160, 180, 170],
                        borderColor: '#0055a4',
                        backgroundColor: 'rgba(0, 85, 164, 0.1)',
                        fill: true,
                        tension: 0.3
                    }, {
                        label: 'Cybercrime',
                        data: [80, 90, 110, 100, 130, 140],
                        borderColor: '#ff9800',
                        backgroundColor: 'rgba(255, 152, 0, 0.1)',
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        }

        // 2. Complaint Status Chart (Doughnut)
        const ctxStatus = document.getElementById('complaintStatusChart');
        if (ctxStatus) {
            new Chart(ctxStatus, {
                type: 'doughnut',
                data: {
                    labels: ['Resolved', 'Under Investigation', 'Filed', 'Closed'],
                    datasets: [{
                        label: 'Complaint Status',
                        data: [1800, 800, 400, 890],
                        backgroundColor: [
                            '#28a745', // green
                            '#ff9800', // orange
                            '#0055a4', // blue
                            '#6c757d'  // grey
                        ],
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                }
            });
        }

        // Handle Alert Form Submission (Demo)
        const alertForm = document.getElementById('alertForm');
        if (alertForm) {
            alertForm.addEventListener('submit', function(e) {
                e.preventDefault();
                console.log('Alert form submitted.');
                var modal = bootstrap.Modal.getInstance(document.getElementById('alertModal'));
                modal.hide();
                alert('System-wide alert has been broadcast!');
            });
        }
    });
</script>
</body>
</html>

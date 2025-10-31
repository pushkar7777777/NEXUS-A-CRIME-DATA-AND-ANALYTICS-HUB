<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Police Dashboard - Crime Data Hub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Google Fonts (Inter) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
            background-color: #1a2b40; /* Slightly different dark blue for Police */
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
            border-bottom: 1px solid #2a3c50;
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
            background-color: #2a3c50;
            color: #ffffff;
        }

        .sidebar-nav .nav-link.active {
            background-color: #0055a4; /* Primary blue */
            color: #ffffff;
            font-weight: 600;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 1rem 1.5rem;
            background-color: #0d1620;
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

        .icon-pending { background-color: #fff4e6; color: #ff9800; }
        .icon-active { background-color: #e6f0ff; color: #0055a4; }
        .icon-closed { background-color: #e6f7ec; color: #28a745; }

        /* Main Card (for tables, etc.) */
        .main-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
            padding: 1.5rem;
        }

        .main-card .card-header {
            background-color: transparent;
            border-bottom: 1px solid #eee;
            padding: 0 0 1rem 0;
            margin-bottom: 1rem;
        }

        .main-card .card-header h4 {
            font-weight: 600;
            color: #1a2b40;
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

        .badge-priority {
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
        <h3><i class="fas fa-user-shield"></i> Police Hub</h3>
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
                <i class="fas fa-inbox"></i>
                Pending Complaints
                <span class="badge bg-danger ms-auto">8</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-tasks"></i>
                Active Cases
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-file-invoice"></i>
                Investigation Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-chart-line"></i>
                Crime Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-users"></i>
                Department
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-user-cog"></i>
                My Profile
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <a href="../../index.jsp" class="btn btn-outline-light w-100">
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
                    Welcome, Officer Sharma!
                </span>

            <!-- Quick Actions -->
            <div class="ms-auto d-flex align-items-center">
                <a href="#" class="btn btn-outline-danger btn-sm me-3">
                    <i class="fas fa-exclamation-triangle me-1"></i> New Alert
                </a>
                <i class="fas fa-bell fs-5 text-secondary"></i>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <main class="content-area">

        <!-- Dashboard Title -->
        <h1 class="h3 mb-4" style="font-weight: 600; color: #1a2b40;">Police Dashboard</h1>

        <!-- Stat Cards -->
        <div class="row">
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-pending">
                        <i class="fas fa-inbox"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">New Complaints</h5>
                        <span class="stat-number">8</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-active">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Active Investigations</h5>
                        <span class="stat-number">22</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-closed">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Cases Closed (Month)</h5>
                        <span class="stat-number">45</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Row -->
        <div class="row mt-4">

            <!-- Recent Complaints Table -->
            <div class="col-lg-12">
                <div class="main-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4><i class="fas fa-list-ul me-2"></i>New Pending Complaints</h4>
                        <a href="#" class="btn btn-outline-primary btn-sm">View All Pending</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Case ID</th>
                                <th>Type</th>
                                <th>Date Filed</th>
                                <th>Location</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Mock Data Row 1 -->
                            <tr>
                                <td><strong>#C-1026</strong></td>
                                <td>Noise Complaint</td>
                                <td>2025-10-31</td>
                                <td>Residential Area</td>
                                <td><span class="badge bg-light text-dark badge-priority">Low</span></td>
                                <td><span class="badge rounded-pill bg-primary badge-status">Filed</span></td>
                                <td><a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#complaintModal">View/Assign</a></td>
                            </tr>
                            <!-- Mock Data Row 2 -->
                            <tr>
                                <td><strong>#C-1025</strong></td>
                                <td>Cybercrime</td>
                                <td>2025-10-30</td>
                                <td>Online</td>
                                <td><span class="badge bg-warning text-dark badge-priority">Medium</span></td>
                                <td><span class="badge rounded-pill bg-primary badge-status">Filed</span></td>
                                <td><a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#complaintModal">View/Assign</a></td>
                            </tr>
                            <!-- Mock Data Row 3 -->
                            <tr>
                                <td><strong>#C-1023</strong></td>
                                <td>Assault</td>
                                <td>2025-10-29</td>
                                <td>City Park</td>
                                <td><span class="badge bg-danger badge-priority">High</span></td>
                                <td><span class="badge rounded-pill bg-primary badge-status">Filed</span></td>
                                <td><a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#complaintModal">View/Assign</a></td>
                            </tr>
                            <!-- Mock Data Row 4 -->
                            <tr>
                                <td><strong>#C-1022</strong></td>
                                <td>Theft</td>
                                <td>2025-10-29</td>
                                <td>Downtown</td>
                                <td><span class="badge bg-warning text-dark badge-priority">Medium</span></td>
                                <td><span class="badge rounded-pill bg-primary badge-status">Filed</span></td>
                                <td><a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#complaintModal">View/Assign</a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </main>
</div>


<!-- View/Assign Complaint Modal -->
<div class="modal fade" id="complaintModal" tabindex="-1" aria-labelledby="complaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <form id="assignCaseForm" action="assign-case-servlet" method="POST">
                <div class="modal-header" style="background-color: #1a2b40; color: white;">
                    <h5 class="modal-title" id="complaintModalLabel">Case Details: #C-1025</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h5><strong>Civilian Details</strong></h5>
                            <p><strong>Name:</strong> Civilian Name<br>
                                <strong>Contact:</strong> +91 98XXXXX123<br>
                                <strong>Email:</strong> civilian@email.com</p>
                        </div>
                        <div class="col-md-6">
                            <h5><strong>Incident Details</strong></h5>
                            <p><strong>Type:</strong> Cybercrime<br>
                                <strong>Location:</strong> Online<br>
                                <strong>Date:</strong> 2025-10-30</p>
                        </div>
                    </div>

                    <hr>

                    <h5><strong>Complaint Description</strong></h5>
                    <p>This is the full description from the civilian about the cybercrime incident. It would detail what happened, any fraudulent links, and potential losses.</p>

                    <h5><strong>Evidence Submitted</strong></h5>
                    <p><a href="#">screenshot.png</a>, <a href="#">transaction_log.pdf</a></p>

                    <hr>

                    <h4><strong>Update Case Status</strong></h4>

                    <!-- Hidden Complaint ID -->
                    <input type="hidden" name="complaintId" value="1025">

                    <!-- Assign Investigator -->
                    <div class="mb-3">
                        <label for="assignOfficer" class="form-label">Assign Investigator</label>
                        <select class="form-select" id="assignOfficer" name="assignOfficer" required>
                            <option value="" disabled selected>Select an officer...</option>
                            <option value="officer_101">Officer Dave (Cyber)</option>
                            <option value="officer_102">Officer Priya (Theft)</option>
                            <option value="officer_103">Officer Raj (General)</option>
                        </select>
                    </div>

                    <!-- Update Status -->
                    <div class="mb-3">
                        <label for="caseStatus" class="form-label">Update Case Status</label>
                        <select class="form-select" id="caseStatus" name="caseStatus" required>
                            <option value="Filed">Filed (Pending Assignment)</option>
                            <option value="Under Investigation" selected>Under Investigation</option>
                            <option value="Evidence Collected">Evidence Collected</option>
                            <option value="Suspect Identified">Suspect Identified</option>
                            <option value="Resolved">Resolved</option>
                            <option value="Closed">Closed</option>
                        </select>
                    </div>

                    <!-- Investigation Notes -->
                    <div class="mb-3">
                        <label for="investigationNotes" class="form-label">Investigation Notes (Internal)</label>
                        <textarea class="form-control" id="investigationNotes" name="investigationNotes" rows="3" placeholder="Add notes for the case file..."></textarea>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Save Updates</button>
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
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebar-toggle');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }

        // Handle form submission for demo
        const assignCaseForm = document.getElementById('assignCaseForm');
        if (assignCaseForm) {
            assignCaseForm.addEventListener('submit', function(e) {
                e.preventDefault(); // Stop actual submission for this demo

                console.log('Case update form submitted.');

                // For demo, just close the modal.
                var modal = bootstrap.Modal.getInstance(document.getElementById('complaintModal'));
                modal.hide();

                // Show a simple confirmation (replace with a proper toast/alert)
                alert('Case details have been updated!');
            });
        }
    });
</script>
</body>
</html>

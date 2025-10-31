<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Civilian Dashboard - Crime Data Hub</title>

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
            background-color: #f4f7f6; /* Lighter grey background */
            display: flex;
            min-height: 100vh;
        }

        /* --- Sidebar --- */
        .sidebar {
            width: 260px;
            background-color: #003366; /* Dark blue from project theme */
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
            border-bottom: 1px solid #004488;
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
            background-color: #004488;
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
            background-color: #002244;
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

        .icon-total { background-color: #e6f0ff; color: #0055a4; }
        .icon-pending { background-color: #fff4e6; color: #ff9800; }
        .icon-resolved { background-color: #e6f7ec; color: #28a745; }

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
            color: #003366;
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
        <h3><i class="fas fa-shield-alt"></i> Crime Hub</h3>
    </div>
    <ul class="nav flex-column sidebar-nav p-3">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="fas fa-home"></i>
                Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#fileComplaintModal">
                <i class="fas fa-file-alt"></i>
                File New Complaint
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-list-ul"></i>
                My Complaints
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-bell"></i>
                Notifications
                <span class="badge bg-danger ms-auto">3</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-chart-bar"></i>
                Crime Statistics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-book-open"></i>
                Safety Tips
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-map-marker-alt"></i>
                Nearest Stations
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-user-circle"></i>
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
                    Welcome, Civilian Name!
                </span>

            <!-- Quick Actions -->
            <div class="ms-auto d-flex align-items-center">
                <a href="#" class="btn btn-primary btn-sm me-3" data-bs-toggle="modal" data-bs-target="#fileComplaintModal">
                    <i class="fas fa-plus me-1"></i> File Complaint
                </a>
                <i class="fas fa-bell fs-5 text-secondary"></i>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <main class="content-area">

        <!-- Dashboard Title -->
        <h1 class="h3 mb-4" style="font-weight: 600; color: #003366;">My Dashboard</h1>

        <!-- Stat Cards -->
        <div class="row">
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-total">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Total Complaints</h5>
                        <span class="stat-number">12</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-pending">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">In Progress</h5>
                        <span class="stat-number">2</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="stat-card">
                    <div class="card-icon icon-resolved">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="card-info">
                        <h5 class="text-uppercase">Resolved</h5>
                        <span class="stat-number">10</span>
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
                        <h4><i class="fas fa-list-ul me-2"></i>My Complaint History</h4>
                        <a href="#" class="btn btn-outline-primary btn-sm">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Complaint ID</th>
                                <th>Type</th>
                                <th>Date Filed</th>
                                <th>Location</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- Mock Data Row 1 -->
                            <tr>
                                <td><strong>#C-1024</strong></td>
                                <td>Theft</td>
                                <td>2025-10-28</td>
                                <td>Market Area</td>
                                <td><span class="badge rounded-pill bg-success badge-status">Resolved</span></td>
                                <td><a href="#" class="btn btn-sm btn-outline-secondary">View</a></td>
                            </tr>
                            <!-- Mock Data Row 2 -->
                            <tr>
                                <td><strong>#C-1025</strong></td>
                                <td>Cybercrime</td>
                                <td>2025-10-30</td>
                                <td>Online</td>
                                <td><span class="badge rounded-pill bg-warning text-dark badge-status">Under Investigation</span></td>
                                <td><a href="#" class="btn btn-sm btn-outline-secondary">View</a></td>
                            </tr>
                            <!-- Mock Data Row 3 -->
                            <tr>
                                <td><strong>#C-1026</strong></td>
                                <td>Noise Complaint</td>
                                <td>2025-10-31</td>
                                <td>Residential Area</td>
                                <td><span class="badge rounded-pill bg-primary badge-status">Filed</span></td>
                                <td><a href="#" class="btn btn-sm btn-outline-secondary">View</a></td>
                            </tr>
                            <!-- Mock Data Row 4 -->
                            <tr>
                                <td><strong>#C-1021</strong></td>
                                <td>Assault</td>
                                <td>2025-10-15</td>
                                <td>City Park</td>
                                <td><span class="badge rounded-pill bg-success badge-status">Resolved</span></td>
                                <td><a href="#" class="btn btn-sm btn-outline-secondary">View</a></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Quick Actions & Notifications (Example) -->
            <!-- You can add more cards here as needed -->

        </div>

    </main>
</div>


<!-- File Complaint Modal -->
<div class="modal fade" id="fileComplaintModal" tabindex="-1" aria-labelledby="fileComplaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <form id="complaintForm" action="file-complaint-servlet" method="POST" enctype="multipart/form-data">
                <div class="modal-header" style="background-color: #003366; color: white;">
                    <h5 class="modal-title" id="fileComplaintModalLabel"><i class="fas fa-file-alt me-2"></i>File a New Complaint</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted">Please provide as much detail as possible.</p>

                    <div class="row">
                        <!-- Complaint Type -->
                        <div class="col-md-6 mb-3">
                            <label for="complaintType" class="form-label">Type of Complaint</label>
                            <select class="form-select" id="complaintType" name="complaintType" required>
                                <option value="" disabled selected>Select crime type...</option>
                                <option value="Theft">Theft</option>
                                <option value="Assault">Assault</option>
                                <option value="Cybercrime">Cybercrime</option>
                                <option value="Vandalism">Vandalism</option>
                                <option value="Noise Complaint">Noise Complaint</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <!-- Date of Incident -->
                        <div class="col-md-6 mb-3">
                            <label for="incidentDate" class="form-label">Date of Incident</label>
                            <input type="date" class="form-control" id="incidentDate" name="incidentDate" required>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="mb-3">
                        <label for="location" class="form-label">Location of Incident</label>
                        <input type="text" class="form-control" id="location" name="location" placeholder="e.g., '123 Main St' or 'City Park near fountain'" required>
                    </div>

                    <!-- Description -->
                    <div class="mb-3">
                        <label for="description" class="form-label">Detailed Description</label>
                        <textarea class="form-control" id="description" name="description" rows="4" placeholder="Describe what happened..."></textarea>
                    </div>

                    <!-- Suspect Details -->
                    <div class="mb-3">
                        <label for="suspects" class="form-label">Suspect Details (if any)</label>
                        <textarea class="form-control" id="suspects" name="suspects" rows="2" placeholder="Describe any suspects (optional)"></textarea>
                    </div>

                    <!-- Evidence Upload -->
                    <div class="mb-3">
                        <label for="evidenceUpload" class="form-label">Upload Evidence</label>
                        <input class="form-control" type="file" id="evidenceUpload" name="evidenceUpload" multiple>
                        <small class="form-text text-muted">You can upload images, videos, or documents (max 10MB).</small>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-2"></i>Submit Complaint</button>
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
        const complaintForm = document.getElementById('complaintForm');
        if (complaintForm) {
            complaintForm.addEventListener('submit', function(e) {
                e.preventDefault(); // Stop actual submission for this demo

                console.log('Complaint form submitted.');

                // In a real app, you'd use AJAX or let the form submit
                // For demo, just close the modal.
                var modal = bootstrap.Modal.getInstance(document.getElementById('fileComplaintModal'));
                modal.hide();

                // Show a simple confirmation (replace with a proper toast/alert)
                alert('Your complaint has been filed successfully!');
            });
        }
    });
</script>
</body>
</html>

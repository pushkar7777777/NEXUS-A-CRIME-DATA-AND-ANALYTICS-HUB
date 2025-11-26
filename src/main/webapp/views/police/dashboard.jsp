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
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144;      /* Primary Dark Blue/Teal (Sidebar/Headings) */
            --nexus-accent: #00A3FF;    /* Bright Blue/Cyan Accent (Links/Primary Action) */
            --nexus-light: #F0F4F8;     /* Light background */
            --sidebar-hover: #004d7a;
            --sidebar-active: #0055a4;
        }

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
            /* Nexus Dark Gradient */
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
        }
        .nexus-brand svg path, .nexus-brand svg circle {
            stroke: var(--nexus-accent);
            fill: var(--nexus-accent);
        }
        .nexus-brand svg path[d*="8l-3 5"] { stroke: #fff; }


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
            background-color: var(--sidebar-hover);
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
        .sidebar-footer .btn-outline-light { font-weight: 600; }

        /* --- MAIN CONTENT --- */
        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            transition: all 0.3s;
        }

        /* --- TOP NAVBAR --- */
        .top-navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }
        .bell-shake:hover { animation: shake 0.5s infinite; }

        /* --- POLICE DASHBOARD HEADER (Mini Hero) --- */
        .dashboard-hero {
            /* Using the standard Nexus Dark gradient */
            background: linear-gradient(135deg, var(--nexus-dark), #2c5364);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(28, 49, 68, 0.2);
        }
        .dashboard-hero h2 { font-weight: 800; }

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
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .stat-card::after { /* Removed hover shine effect for cleaner look */ content: none; }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-right: 1.5rem;
            flex-shrink: 0;
            opacity: 0.9;
        }

        .icon-pending { background-color: #ffc107; color: #7f5200; } /* Warning/Pending color */
        .icon-active { background-color: #007bff; color: white; } /* Primary/Active color */
        .icon-closed { background-color: #28a745; color: white; } /* Success/Resolved color */

        .stat-card h6 { font-size: 0.75rem; font-weight: 700; color: #888; letter-spacing: 0.5px; }
        .stat-number { font-size: 2.2rem; font-weight: 800; color: var(--nexus-dark); }

        /* --- TABLE CARD --- */
        .main-card {
            border: 1px solid #e0e0e0;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 0;
            overflow: hidden;
            background: white;
        }

        .card-header-custom {
            background-color: white;
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
        }
        .card-header-custom h5 { font-weight: 700; color: var(--nexus-dark); }


        .badge-priority-high { background-color: #dc3545; color: white; } /* Danger */
        .badge-priority-med { background-color: #ffc107; color: #212529; } /* Warning */
        .badge-priority-low { background-color: #007bff; color: white; } /* Primary */

        /* --- BUTTONS --- */
        .btn-nexus {
            /* Use the primary accent color */
            background-color: var(--nexus-accent);
            border-color: var(--nexus-accent);
            color: var(--nexus-dark);
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-nexus:hover {
            background-color: #008be6;
            border-color: #008be6;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 163, 255, 0.3);
        }

        @media (max-width: 991.98px) {
            .sidebar { margin-left: -280px; }
            .main-content { margin-left: 0; width: 100%; }
            .sidebar.active { margin-left: 0; }
        }
    </style>
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="nexus-brand animate__animated animate__fadeIn">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--nexus-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                <circle cx="12" cy="8" r="1.5" fill="var(--nexus-accent)" stroke="none"/>
                <circle cx="9" cy="13" r="1.5" fill="var(--nexus-accent)" stroke="none"/>
                <circle cx="15" cy="13" r="1.5" fill="var(--nexus-accent)" stroke="none"/>
                <path d="M12 8l-3 5" stroke="#fff"/>
                <path d="M12 8l3 5" stroke="#fff"/>
                <path d="M9 13h6" stroke="#fff"/>
            </svg>
            NEXUS
        </div>
    </div>

    <ul class="nav flex-column sidebar-nav">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-inbox"></i>
                Pending Assignments
                <span class="badge bg-danger ms-auto rounded-pill animate__animated animate__pulse animate__infinite">8</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-tasks"></i> My Active Cases
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-file-invoice"></i> Station Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-chart-line"></i> Crime Analytics
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="fas fa-user-shield"></i> Profile
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="../../index.jsp" class="btn btn-outline-light w-100 btn-sm fw-bold">
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
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">5</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 animate__animated animate__fadeIn">
                        <li><h6 class="dropdown-header">Alerts</h6></li>
                        <li><a class="dropdown-item small" href="#">New FIR #1026 Assigned</a></li>
                        <li><a class="dropdown-item small text-danger" href="#">Emergency in Sector 4</a></li>
                    </ul>
                </div>
                <div class="d-none d-md-flex align-items-center gap-2">
                    <img src="https://ui-avatars.com/api/?name=Officer+Sharma&background=1C3144&color=fff" class="rounded-circle border border-2 border-light shadow-sm" width="35" height="35" alt="Officer">
                    <span class="fw-semibold small text-secondary"> <%= session.getAttribute("user_name") %> </span>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid p-4">

        <div class="dashboard-hero animate__animated animate__fadeInDown">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold mb-1">Station Command Center</h2>
                    <p class="mb-0 opacity-75">Overview of daily operations and pending assignments for <span class="fw-bold">Police Station ID 42.</span></p>
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
                        <div class="stat-number counter" data-target="8">0</div>
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
                        <div class="stat-number counter" data-target="22">0</div>
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
                        <div class="stat-number counter" data-target="45">0</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="400">
            <div class="col-12">
                <div class="main-card">
                    <div class="card-header-custom">
                        <h5 class="fw-bold mb-0"><i class="fas fa-clipboard-list me-2"></i>Incoming Assignments</h5>
                        <button class="btn btn-sm btn-outline-primary fw-bold">View All Pending</button>
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
                            <tr data-aos="fade-left" data-aos-delay="500">
                                <td class="ps-4 fw-bold text-primary">#C-1023</td>
                                <td><i class="fas fa-fist-raised me-2 text-secondary"></i>Assault</td>
                                <td>Oct 29, 2025</td>
                                <td>City Park</td>
                                <td><span class="badge badge-priority-high rounded-pill">High</span></td>
                                <td><span class="badge bg-primary">Filed</span></td>
                                <td><button class="btn btn-sm btn-nexus px-3" data-bs-toggle="modal" data-bs-target="#complaintModal">Manage</button></td>
                            </tr>
                            <tr data-aos="fade-left" data-aos-delay="600">
                                <td class="ps-4 fw-bold text-primary">#C-1025</td>
                                <td><i class="fas fa-laptop-code me-2 text-secondary"></i>Cybercrime</td>
                                <td>Oct 30, 2025</td>
                                <td>Online</td>
                                <td><span class="badge badge-priority-med rounded-pill">Medium</span></td>
                                <td><span class="badge bg-primary">Filed</span></td>
                                <td><button class="btn btn-sm btn-nexus px-3" data-bs-toggle="modal" data-bs-target="#complaintModal">Manage</button></td>
                            </tr>
                            <tr data-aos="fade-left" data-aos-delay="700">
                                <td class="ps-4 fw-bold text-primary">#C-1026</td>
                                <td><i class="fas fa-volume-up me-2 text-secondary"></i>Noise</td>
                                <td>Oct 31, 2025</td>
                                <td>Res. Area</td>
                                <td><span class="badge badge-priority-low rounded-pill">Low</span></td>
                                <td><span class="badge bg-primary">Filed</span></td>
                                <td><button class="btn btn-sm btn-nexus px-3" data-bs-toggle="modal" data-bs-target="#complaintModal">Manage</button></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="complaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background: linear-gradient(135deg, var(--nexus-dark), #2c5364);">
                <h5 class="modal-title fw-bold"><i class="fas fa-folder-open me-2"></i>Manage Case #C-1025</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row mb-4">
                    <div class="col-md-6 border-end">
                        <h6 class="text-primary fw-bold text-uppercase small">Civilian Details</h6>
                        <p class="mb-1"><strong>Name:</strong> John Doe</p>
                        <p class="mb-1"><strong>Contact:</strong> +91 9876543210</p>
                        <p><strong>Email:</strong> john.doe@email.com</p>
                    </div>
                    <div class="col-md-6 ps-md-4">
                        <h6 class="text-primary fw-bold text-uppercase small">Incident Details</h6>
                        <p class="mb-1"><strong>Type:</strong> Cybercrime</p>
                        <p class="mb-1"><strong>Location:</strong> Online / Banking App</p>
                        <p><strong>Date:</strong> Oct 30, 2025 - 14:30</p>
                    </div>
                </div>

                <div class="bg-light p-3 rounded mb-4">
                    <h6 class="fw-bold text-secondary">Description</h6>
                    <p class="mb-0 small text-muted">"Victim reported unauthorized transaction of Rs. 50,000 from credit card. Suspect claimed to be bank official..."</p>
                </div>

                <form id="assignCaseForm">
                    <h6 class="fw-bold border-bottom pb-2 mb-3">Update Status & Assignment</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Assign Investigator</label>
                            <select class="form-select">
                                <option>Select Officer...</option>
                                <option>Off. Dave (Cyber Unit)</option>
                                <option>Off. Priya (General)</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Case Status</label>
                            <select class="form-select">
                                <option>Filed</option>
                                <option selected>Under Investigation</option>
                                <option>Resolved</option>
                                <option>Closed</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Internal Notes</label>
                            <textarea class="form-control" rows="2" placeholder="Add initial investigation directives..."></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer bg-light border-0">
                <button type="button" class="btn btn-link text-secondary text-decoration-none" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-nexus px-4">Update Case</button>
            </div>
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
        // Toggle main content margin based on screen size
        if (window.innerWidth >= 992) {
            document.querySelector('.main-content').style.marginLeft =
                document.querySelector('.main-content').style.marginLeft === '0px' ? '280px' : '0px';
        }
    });

    // Simple Live Clock
    setInterval(() => {
        const now = new Date();
        document.getElementById('liveClock').innerText = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    }, 1000);

    // Counter Animation
    const counters = document.querySelectorAll('.counter');
    const animateCounters = () => {
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
    };

    // Trigger counter animation only when stats are visible (optional: can be integrated with AOS)
    document.addEventListener('DOMContentLoaded', animateCounters);
</script>

</body>
</html>
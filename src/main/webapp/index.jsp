<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crime Data & Analysis Hub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Google Fonts (Inter) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="views/assets/css/style.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <!-- SVG Icon for Brand -->
            <svg width="30" height="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="d-inline-block align-text-top me-2">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" fill="none" stroke="#0055a4" stroke-width="2"/>
                <path d="M12 2L12 10M12 10L8 7M12 10L16 7" stroke="#0055a4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M3.5 11C2.5 13 2 15 2 17C2 21 6 23 12 23C18 23 22 21 22 17C22 15 21.5 13 20.5 11" stroke="#0055a4" stroke-width="2" stroke-linecap="round"/>
            </svg>
            Crime Data Hub
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#features">Features</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#how-it-works">How It Works</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Crime Awareness</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="views/civilian/dashboard.jsp">Civilian Dashboard</a>
                </li> <li class="nav-item">
                <a class="nav-link" href="views/police/dashboard.jsp">Police Dashboard</a>
            </li> <li class="nav-item">
                <a class="nav-link" href="views/admin/dashboard.jsp">Admin Dashboard</a>
            </li>


            </ul>
            <div class="d-flex">
                <a href="views/auth/login.jsp" class="btn btn-outline-primary me-2" id="signInBtn">Sign In</a>
                <a href="views/auth/register.jsp" class="btn btn-primary" id="signUpBtn">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero text-center">
    <div class="container">
        <h1 class="display-3">Crime Data & Analysis Hub</h1>
        <p class="lead">
            A centralized platform for civilians, police, and administrators to report, manage, and analyze crime data for a safer community.
        </p>
        <a href="views/auth/register.jsp" class="btn btn-primary btn-lg" id="reportCrimeBtn">Report a Crime</a>
    </div>
</header>

<!-- Main Content Area -->
<main>
    <!-- Features Section (The Modules) -->
    <section id="features" class="py-5 my-5">
        <div class="container">
            <h2 class="text-center section-title">A Unified Platform for Everyone</h2>
            <div class="row g-4 mt-4">

                <!-- Civilian Card -->
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card">
                        <div class="card-body">
                            <div class="feature-icon">
                                <!-- Heroicon: User Group -->
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 0 0-3.154-1.12c-.598-.122-1.21.3-1.21.91v2.96a.75.75 0 0 0 1.5 0v-2.14a7.59 7.59 0 0 1 2.864.87c.398.113.826-.145.826-.57v-1.9a.75.75 0 0 0-1.122-.64Z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9a3.75 3.75 0 1 0 0-7.5A3.75 3.75 0 0 0 12 9ZM13.5 12.75h-3a6.75 6.75 0 0 0-6.75 6.75v.006c0 .414.336.75.75.75h16.5a.75.75 0 0 0 .75-.75v-.006a6.75 6.75 0 0 0-6.75-6.75Z" />
                                </svg>
                            </div>
                            <h3 class="card-title">For Civilians</h3>
                            <p class="card-text">Easily file new complaints, upload supporting evidence like photos or documents, and track the status of your case from "Filed" to "Resolved."</p>
                        </div>
                    </div>
                </div>

                <!-- Police Card -->
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card">
                        <div class="card-body">
                            <div class="feature-icon">
                                <!-- Heroicon: Shield Check -->
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75m-3-7.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.333 9-6.031 9-11.623v-1.14c0-1.041-.16-2.06-.46-3.045A11.959 11.959 0 0 1 12 2.714Z" />
                                </svg>
                            </div>
                            <h3 class="card-title">For Police</h3>
                            <p class="card-text">Access a dedicated dashboard to view pending complaints, assign cases to investigators, update investigation progress, and upload official reports.</p>
                        </div>
                    </div>
                </div>

                <!-- Admin Card -->
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card">
                        <div class="card-body">
                            <div class="feature-icon">
                                <!-- Heroicon: Chart Bar Square -->
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 14.25v2.25m3-4.5v4.5m3-6.75v6.75m3-9v9M6 20.25h12A2.25 2.25 0 0 0 20.25 18V5.75A2.25 2.25 0 0 0 18 3.5H6A2.25 2.25 0 0 0 3.75 5.75v12.5A2.25 2.25 0 0 0 6 20.25Z" />
                                </svg>
                            </div>
                            <h3 class="card-title">For Admins</h3>
                            <p class="card-text">Monitor the entire system, generate powerful analytics and reports, analyze crime trends with data visualizations, and manage all user accounts.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-5 my-5 how-it-works">
        <div class="container">
            <h2 class="text-center section-title">How It Works</h2>
            <div class="row g-4 mt-4">
                <div class="col-md-4">
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <h4>File Complaint</h4>
                        <p>Civilians securely submit incident details and evidence through the portal.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <h4>Investigate & Update</h4>
                        <p>Police departments receive, assign, and update the case progress in real-time.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <h4>Analyze & Resolve</h4>
                        <p>Admins monitor performance and analyze data to improve public safety.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="py-5 text-center bg-primary text-white">
        <div class="container">
            <h2 class="display-6 fw-bold">Help Make Your Community Safer</h2>
            <p class="lead col-lg-8 mx-auto">Register today to report incidents, stay informed, and contribute to a more secure environment.
                </Your voice matters.</p>
            <button class="btn btn-light btn-lg text-primary fw-bold mt-3" id="registerNowBtn">Register Now</button>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-5">
                <h5>Crime Data & Analysis Hub</h5>
                <p>
                    Our mission is to leverage technology to create a transparent,
                    efficient, and data-driven approach to crime management,
                    fostering collaboration between civilians and law enforcement.
                </p>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#how-it-works">How It Works</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                </ul>
            </div>
            <div class="col-lg-4 col-md-6">
                <h5>Contact Us</h5>
                <p>
                    Emergency: <strong>100</strong> / <strong>112</strong><br>
                    Hub Support: support@crimedatahub.gov<br>
                    123 Police Plaza, New City, 10001
                </p>
            </div>
        </div>

        <div class="footer-bottom d-flex justify-content-between align-items-center">
            <span>&copy; 2025 Crime Data & Analysis Hub. All rights reserved.</span>
            <!-- Social media icons would go here -->
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Custom JS -->
<script src="views/assets/js/script.js"></script>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nexus: Crime Data & Analytics Hub</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* --- BRAND COLORS --- */
        :root {
            --nexus-dark: #1C3144; /* Primary Dark Blue/Teal */
            --nexus-accent: #00A3FF; /* Bright Blue/Cyan Accent */
            --nexus-light: #F0F4F8; /* Light background */
            --nexus-fresh: #008be6; /* New fresh accent color for hover/secondary */
        }

        body {
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
            background-color: var(--nexus-light);
        }

        /* --- NAVIGATION BAR --- */
        .navbar-brand { font-weight: 800 !important; color: var(--nexus-dark) !important; }
        .nav-link { font-weight: 600; transition: color 0.3s, border-bottom 0.3s; padding: 10px 15px !important; }
        .nav-link:hover, .nav-link.active {
            color: var(--nexus-fresh) !important;
            border-bottom: 3px solid var(--nexus-fresh);
            padding-bottom: 7px !important; /* Adjust padding due to border */
        }
        .navbar-nav { gap: 10px; }
        .navbar-brand svg { stroke: var(--nexus-fresh) !important; }

        /* --- ANIMATED HERO SECTION --- */
        .hero {
            position: relative;
            /* Updated Gradient to incorporate the fresh blue */
            background: linear-gradient(-45deg, var(--nexus-dark), #1A5276, var(--nexus-fresh), #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: white;
            padding: 160px 0 140px 0;
            overflow: hidden;
            /* Smoother curve at the bottom */
            border-bottom-left-radius: 70px;
            border-bottom-right-radius: 70px;
            margin-bottom: 60px;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .circles {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            overflow: hidden; z-index: 0;
        }
        .circles li {
            position: absolute; display: block; list-style: none;
            width: 20px; height: 20px; background: rgba(255, 255, 255, 0.15);
            animation: animate 25s linear infinite; bottom: -150px;
            border-radius: 50%;
        }
        /* (Specific particle styles omitted for brevity, but exist in the original code) */
        @keyframes animate {
            0%{ transform: translateY(0) rotate(0deg); opacity: 1; border-radius: 0; }
            100%{ transform: translateY(-1000px) rotate(720deg); opacity: 0; border-radius: 50%; }
        }
        .hero-content { position: relative; z-index: 2; }
        .hero-content h1 { font-weight: 800 !important; letter-spacing: 3px; text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); }
        .hero-content h2 { font-weight: 500; opacity: 0.85; }

        /* --- FEATURE CARDS --- */
        .feature-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08); /* More prominent shadow */
            transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
            height: 100%;
            background: white;
            border-bottom: 5px solid transparent; /* Prepare for border color change */
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
            border-bottom-color: var(--nexus-fresh); /* Highlight border on hover */
        }
        .feature-icon {
            color: var(--nexus-fresh); /* Use fresh accent color */
            margin-bottom: 25px;
            background-color: rgba(0, 139, 230, 0.1); /* Light background for icon */
            display: inline-flex;
            padding: 15px;
            border-radius: 15px;
        }
        .feature-icon i {
            font-size: 3rem;
        }
        .feature-card h3 { color: var(--nexus-dark); }

        /* --- HOW IT WORKS STEPS --- */
        .step-number {
            width: 75px; height: 75px;
            background: var(--nexus-fresh); /* Use fresh accent color */
            color: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 30px; font-weight: 800;
            margin: 0 auto 25px auto;
            box-shadow: 0 0 0 10px rgba(0, 139, 230, 0.15); /* Fresh shadow ring */
        }
        .step-item { transition: transform 0.3s; }
        .step-item h4 { font-weight: 800; color: var(--nexus-dark); }
        .step-item:hover { transform: translateY(-5px) scale(1.02); }
        .how-it-works { background-color: var(--nexus-light); }


        /* --- CTA BUTTON PULSE (using fresh color) --- */
        .btn-primary-nexus {
            background: var(--nexus-fresh);
            border-color: var(--nexus-fresh);
            color: white; /* Changed text color to white for contrast */
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 30px;
            transition: all 0.3s;
        }
        .btn-primary-nexus:hover {
            background: var(--nexus-dark); /* Darker hover for better contrast */
            border-color: var(--nexus-dark);
            color: var(--nexus-fresh);
        }
        .btn-pulse {
            animation: pulse-fresh 2s infinite;
        }
        @keyframes pulse-fresh {
            0% { box-shadow: 0 0 0 0 rgba(0, 139, 230, 0.6); }
            70% { box-shadow: 0 0 0 20px rgba(0, 139, 230, 0); }
            100% { box-shadow: 0 0 0 0 rgba(0, 139, 230, 0); }
        }
        .btn-outline-dark {
            border-radius: 30px;
            font-weight: 700 !important;
            color: var(--nexus-dark);
            border-color: var(--nexus-dark);
            transition: all 0.3s;
        }
        .btn-outline-dark:hover {
            background-color: var(--nexus-dark);
            color: white;
            border-color: var(--nexus-dark);
        }

        /* --- GENERAL SECTIONS --- */
        .section-title {
            font-size: 2.75rem;
            font-weight: 900;
            color: var(--nexus-dark);
            position: relative;
        }
        .section-title::after {
            content: '';
            width: 80px;
            height: 5px;
            background-color: var(--nexus-fresh);
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        /* --- STATS SECTION --- */
        .stat-box {
            background-color: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border-left: 6px solid var(--nexus-fresh); /* Use fresh accent color */
            transition: transform 0.3s;
        }
        .stat-box:hover { transform: scale(1.05); }
        .stat-value { font-size: 3rem; font-weight: 900; color: var(--nexus-dark); }
        .stat-label { font-weight: 600; color: var(--nexus-fresh); text-transform: uppercase; letter-spacing: 1px; }

        /* --- ADVANCED FEATURES SECTION (NEW) --- */
        .advanced-feature {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid #e0e0e0;
            height: 100%;
            transition: all 0.4s;
        }
        .advanced-feature:hover {
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            border-color: var(--nexus-fresh);
        }
        .advanced-feature i {
            font-size: 2.5rem;
            color: var(--nexus-fresh);
        }
        .advanced-feature h4 {
            font-weight: 700;
            color: var(--nexus-dark);
        }

        /* --- FOOTER --- */
        .footer { background-color: white; padding: 60px 0 20px 0; border-top: 1px solid #dcdcdc; }
        .footer-links a {
            color: var(--nexus-dark);
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s;
            display: block;
            margin-bottom: 5px;
        }
        .footer-links a:hover { color: var(--nexus-fresh); text-decoration: underline; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">
            <svg width="35" height="35" viewBox="0 0 24 24" fill="none" stroke="var(--nexus-fresh)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="d-inline-block align-text-top me-2 animate__animated animate__pulse animate__infinite">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                <circle cx="12" cy="8" r="1.5" fill="var(--nexus-fresh)" stroke="none"/>
                <circle cx="9" cy="13" r="1.5" fill="var(--nexus-fresh)" stroke="none"/>
                <circle cx="15" cy="13" r="1.5" fill="var(--nexus-fresh)" stroke="none"/>
                <path d="M12 8l-3 5" stroke="var(--nexus-dark)"/>
                <path d="M12 8l3 5" stroke="var(--nexus-dark)"/>
                <path d="M9 13h6" stroke="var(--nexus-dark)"/>
            </svg>
            NEXUS
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#advanced">Analytics</a></li> <li class="nav-item"><a class="nav-link" href="#impact">Impact</a></li>
                <li class="nav-item"><a class="nav-link" href="#how-it-works">Process</a></li>
                <li class="nav-item"><a class="nav-link" href="views/about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="views/contactus.jsp">Contact Us</a></li> </ul>
            <div class="d-flex">
                <a href="views/auth/login.jsp" class="btn btn-outline-dark me-2 border-2 fw-bold">Sign In</a>
                <a href="views/auth/register.jsp" class="btn btn-primary-nexus fw-bold">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<header class="hero text-center">
    <ul class="circles">
        <li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li>
    </ul>

    <div class="container hero-content">
        <h1 class="display-1 fw-bold mb-3 animate__animated animate__fadeInDown">NEXUS</h1>
        <h2 class="h4 fw-light mb-4 animate__animated animate__fadeInUp">The Global Crime Data & Real-Time Analytics Hub</h2>
        <p class="lead mb-5 animate__animated animate__fadeInUp animate__delay-1s opacity-90 col-lg-8 mx-auto">
            Connecting <b>civilians</b>, <b>law enforcement</b>, and <b>data science</b> on a single, secure platform to drive <b>intelligence-led policing</b> and create safer, smarter communities.
        </p>

        <a href="views/auth/register.jsp" class="btn btn-primary-nexus btn-lg fw-bold animate__animated animate__zoomIn animate__delay-2s shadow-lg btn-pulse">
            <i class="bi bi-cloud-upload me-2"></i> Report an Incident Now
        </a>
    </div>
</header>

<main>
    <section id="features" class="py-5 my-5">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">A Unified Platform for Everyone</h2>
            <div class="row g-4">

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center p-4 p-md-5">
                            <div class="feature-icon">
                                <i class="bi bi-person-fill-lock"></i>
                            </div>
                            <h3 class="card-title fw-bold">For Civilians</h3>
                            <p class="card-text text-muted">Securely file new complaints, upload supporting evidence (photos/videos), and track the status of your case with live updates on our portal.</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center p-4 p-md-5">
                            <div class="feature-icon">
                                <i class="bi bi-shield-fill-check"></i>
                            </div>
                            <h3 class="card-title fw-bold">For Police Officers</h3>
                            <p class="card-text text-muted">Access geo-tagged complaints, collaborate on case assignments, update investigation logs, and generate official compliance reports for audits.</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mx-auto" data-aos="fade-up" data-aos-delay="300">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center p-4 p-md-5">
                            <div class="feature-icon">
                                <i class="bi bi-graph-up-arrow"></i>
                            </div>
                            <h3 class="card-title fw-bold">For Data Analysts</h3>
                            <p class="card-text text-muted">Monitor key performance indicators (KPIs), visualize heat maps, predict future crime hotspots, and manage all system configurations centrally.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="advanced" class="py-5 my-5 bg-white">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Advanced Analytics & Intelligence</h2>
            <div class="row g-4">

                <div class="col-lg-4 col-md-6" data-aos="fade-right" data-aos-delay="100">
                    <div class="advanced-feature text-center h-100">
                        <i class="bi bi-bell-fill mb-3"></i>
                        <h4>Real-Time Threat Alerts</h4>
                        <p class="text-muted small">Automated alerts for emerging crime patterns, suspicious activity, and high-risk zones based on deep learning models.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="advanced-feature text-center h-100">
                        <i class="bi bi-people-fill mb-3"></i>
                        <h4>Resource Optimization</h4>
                        <p class="text-muted small">AI-driven deployment planner suggesting optimal patrol routes and officer distribution based on predicted needs and live incidents.</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mx-auto" data-aos="fade-left" data-aos-delay="300">
                    <div class="advanced-feature text-center h-100">
                        <i class="bi bi-fingerprint mb-3"></i>
                        <h4>Evidence Traceability</h4>
                        <p class="text-muted small">Blockchain-secured chain of custody for all digital evidence, ensuring tamper-proof integrity from filing to court presentation.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="impact" class="py-5 my-5">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Nexus in Action: Our Impact</h2>
            <div class="row g-4 text-center">

                <div class="col-md-4" data-aos="fade-right">
                    <div class="stat-box">
                        <div class="stat-value"><i class="bi bi-check-circle-fill me-2 text-success"></i>99.5%</div>
                        <div class="stat-label">Data Reliability Score</div>
                        <p class="small text-muted mt-2">Verified and standardized incident data fueling better decisions.</p>
                    </div>
                </div>

                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="stat-box">
                        <div class="stat-value"><i class="bi bi-clock-fill me-2 text-info"></i>75%</div>
                        <div class="stat-label">Faster Case Initialisation</div>
                        <p class="small text-muted mt-2">Efficiency gains through digital automation and instant routing.</p>
                    </div>
                </div>

                <div class="col-md-4" data-aos="fade-left">
                    <div class="stat-box">
                        <div class="stat-value"><i class="bi bi-pin-map-fill me-2 text-danger"></i>150+</div>
                        <div class="stat-label">Law Enforcement Agencies</div>
                        <p class="small text-muted mt-2">Growing network across multiple districts and regions worldwide.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="how-it-works" class="py-5 my-5 how-it-works">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="zoom-in">The Simple 3-Step Process</h2>
            <div class="row g-5 text-center">
                <div class="col-md-4" data-aos="fade-right" data-aos-delay="100">
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <h4 class="mt-4">Secure Filing</h4>
                        <p class="text-muted">An incident is **filed electronically** by a citizen or officer, instantly creating a secure, digital case record.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <h4 class="mt-4">Real-Time Routing</h4>
                        <p class="text-muted">The intelligent system automatically **geo-routes the case** to the nearest and most relevant police station for immediate action.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-left" data-aos-delay="300">
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <h4 class="mt-4">Data-Driven Resolution</h4>
                        <p class="text-muted">Case progress is tracked; once resolved, the data feeds into the analytics engine for **predictive policing** and strategic reporting.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 text-center text-white" style="background: linear-gradient(135deg, var(--nexus-dark), var(--nexus-fresh));">
        <div class="container" data-aos="flip-up">
            <h2 class="display-6 fw-bold">Ready to Join the Network?</h2>
            <p class="lead col-lg-8 mx-auto mb-4 opacity-90">
                Register your account today to access tailored dashboards, contribute data, and become part of the Nexus solution for a safer community.
            </p>

            <a href="views/auth/register.jsp" class="btn btn-primary-nexus btn-lg fw-bold btn-pulse">
                Get Started with Nexus <i class="bi bi-arrow-right-circle-fill ms-2"></i>
            </a>
        </div>
    </section>
</main>

<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-5">
                <h5 class="fw-bold text-dark border-bottom border-3 border-secondary pb-2">NEXUS</h5>
                <p class="text-muted small">
                    Nexus is dedicated to transparent and efficient crime management. Leveraging secure data analytics for better public safety outcomes, making communities smarter and safer.
                </p>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="fw-bold text-dark border-bottom border-3 border-secondary pb-2">Platform</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="#features">Platform Features</a></li>
                    <li><a href="#advanced">Advanced Analytics</a></li>
                    <li><a href="#impact">Our Impact</a></li>
                    <li><a href="views/auth/login.jsp">Login Portal</a></li>
                </ul>
            </div>
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold text-dark border-bottom border-3 border-secondary pb-2">Company & Contact</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="views/about.jsp">About Us</a></li>
                    <li><a href="views/contactus.jsp">Contact Us</a></li>
                    <li><a href="#">Terms & Privacy</a></li>
                </ul>
                <p class="text-muted small mt-3">
                    <i class="bi bi-telephone-fill me-2 text-danger"></i> Hotline: <strong>100 / 112</strong><br>
                    <i class="bi bi-envelope-fill me-2 text-info"></i> Support: <a href="mailto:support@nexus.gov" class="text-info">support@nexus.gov</a>
                </p>
            </div>
        </div>
        <div class="text-center mt-4 pt-3 border-top text-muted small">
            &copy; 2025 Nexus Crime Data & Analytics Hub. All rights reserved. | <span class="text-info">Built for a Safer Future.</span>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 900,
        once: true,
        easing: 'ease-in-out'
    });
</script>
</body>
</html>
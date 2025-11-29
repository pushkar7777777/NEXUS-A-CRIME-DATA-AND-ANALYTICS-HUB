<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Nexus</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- AOS Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* --- BRAND COLORS (Copied from index.html) --- */
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

        /* --- NAVIGATION BAR (Copied from index.html) --- */
        .navbar-brand { font-weight: 800 !important; color: var(--nexus-dark) !important; }
        .nav-link { font-weight: 600; transition: color 0.3s, border-bottom 0.3s; padding: 10px 15px !important; }
        .nav-link:hover, .nav-link.active {
            color: var(--nexus-fresh) !important;
            border-bottom: 3px solid var(--nexus-fresh);
            padding-bottom: 7px !important;
        }
        .navbar-nav { gap: 10px; }
        .navbar-brand svg { stroke: var(--nexus-fresh) !important; }

        /* --- CTA BUTTON PULSE (Copied from index.html) --- */
        .btn-primary-nexus {
            background: var(--nexus-fresh);
            border-color: var(--nexus-fresh);
            color: white;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 30px;
            transition: all 0.3s;
        }
        .btn-primary-nexus:hover {
            background: var(--nexus-dark);
            border-color: var(--nexus-dark);
            color: var(--nexus-fresh);
        }
        .btn-pulse { animation: pulse-fresh 2s infinite; }
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

        /* --- GENERAL SECTIONS (Copied from index.html) --- */
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

        /* --- FOOTER (Copied from index.html) --- */
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

        /* --- PAGE SPECIFIC STYLES --- */
        .page-header {
            background: linear-gradient(90deg, var(--nexus-dark), var(--nexus-fresh));
            color: white;
            padding: 80px 0;
            margin-bottom: 50px;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
        }
        .page-header h1 { font-weight: 900; letter-spacing: 1px; }
        .vision-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            border-top: 5px solid var(--nexus-fresh);
            height: 100%;
            transition: transform 0.3s;
        }
        .vision-card:hover {
            transform: translateY(-5px);
        }
        .vision-card i {
            font-size: 2.5rem;
            color: var(--nexus-fresh);
            margin-bottom: 15px;
        }
        .team-member-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .team-member-card:hover {
            transform: translateY(-8px);
        }
        .team-member-card img { height: 250px; object-fit: cover; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="../index.jsp">
            <svg width="35" height="35" viewBox="0 0 24 24" fill="none" stroke="var(--nexus-fresh)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="d-inline-block align-text-top me-2">
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
                <li class="nav-item"><a class="nav-link" href="../index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="../index.jsp#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="../index.jsp#advanced">Analytics</a></li>
                <li class="nav-item"><a class="nav-link" href="../index.jsp#impact">Impact</a></li>
                <li class="nav-item"><a class="nav-link" href="../index.jsp#how-it-works">Process</a></li>
                <li class="nav-item"><a class="nav-link active" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contactus.jsp">Contact Us</a></li>
            </ul>
            <div class="d-flex">
                <a href="../views/auth/login.jsp" class="btn btn-outline-dark me-2 border-2 fw-bold">Sign In</a>
                <a href="../views/auth/register.jsp" class="btn btn-primary-nexus fw-bold">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<header class="page-header text-center">
    <div class="container">
        <h1 class="display-3 mb-2" data-aos="fade-down">About Nexus</h1>
        <p class="lead" data-aos="fade-up" data-aos-delay="200">Our Mission to Empower Safer Communities through Data.</p>
    </div>
</header>

<main>
    <section id="story" class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0" data-aos="fade-right">
                    <img src="https://placehold.co/600x400/1C3144/F0F4F8?text=Vision+of+Justice" class="img-fluid rounded-3 shadow-lg" alt="Vision of Justice">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h2 class="section-title text-start mb-4 pb-3 mx-0">Our Story</h2>
                    <p class="lead text-muted">Nexus was founded in 2023 by a team of former law enforcement professionals, data scientists, and community advocates who recognized a critical gap: the lack of a centralized, real-time, and accessible platform for managing crime data.</p>
                    <p>Traditional reporting systems were slow, fragmented, and failed to empower citizens or leverage the power of modern predictive analytics. Nexus was built to bridge that divide, creating a seamless, secure, and transparent digital ecosystem that connects every stakeholder in public safety—from the concerned citizen filing a report to the police chief deploying resources.</p>
                    <a href="../index.jsp#advanced" class="btn btn-primary-nexus mt-3">See Our Technology <i class="bi bi-arrow-right-circle-fill ms-2"></i></a>
                </div>
            </div>
        </div>
    </section>

    <section id="mission-vision" class="py-5 bg-white">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Our Mission, Vision, and Values</h2>
            <div class="row g-4 text-center">
                <!-- Mission -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="vision-card">
                        <i class="bi bi-bullseye"></i>
                        <h4 class="fw-bold text-dark">Mission</h4>
                        <p class="text-muted">To provide a secure, real-time data platform that drastically improves the efficiency of law enforcement and the transparency of public safety operations.</p>
                    </div>
                </div>
                <!-- Vision -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="vision-card">
                        <i class="bi bi-eye"></i>
                        <h4 class="fw-bold text-dark">Vision</h4>
                        <p class="text-muted">To be the global standard for intelligence-led policing, making every community a predictive and safer place to live and work.</p>
                    </div>
                </div>
                <!-- Values -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="vision-card">
                        <i class="bi bi-hand-thumbs-up"></i>
                        <h4 class="fw-bold text-dark">Core Values</h4>
                        <p class="text-muted">Transparency, Security, Accountability, and Community Empowerment drive every decision we make in the development of Nexus.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="team" class="py-5 my-5">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Meet the Leadership</h2>
            <div class="row g-4">

                <!-- Team Member 1 -->
                <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="100">
                    <div class="card team-member-card text-center h-100">
                        <img src="https://placehold.co/400x400/008be6/FFFFFF?text=J.D.+Smith" class="card-img-top" alt="Founder J.D. Smith">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">J.D. Smith</h5>
                            <p class="card-text small text-muted">CEO & Founder, Former Chief of Police (Ret.)</p>
                            <a href="#" class="text-secondary"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>

                <!-- Team Member 2 -->
                <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="card team-member-card text-center h-100">
                        <img src="https://placehold.co/400x400/1C3144/FFFFFF?text=A.+Chen" class="card-img-top" alt="CTO A. Chen">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Ava Chen</h5>
                            <p class="card-text small text-muted">Chief Technology Officer, AI/ML Specialist</p>
                            <a href="#" class="text-secondary"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>

                <!-- Team Member 3 -->
                <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="card team-member-card text-center h-100">
                        <img src="https://placehold.co/400x400/008be6/FFFFFF?text=Dr.+E.+Kaur" class="card-img-top" alt="Data Science Lead Dr. Kaur">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Dr. Elena Kaur</h5>
                            <p class="card-text small text-muted">Director of Data Science & Research</p>
                            <a href="#" class="text-secondary"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>

                <!-- Team Member 4 -->
                <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="400">
                    <div class="card team-member-card text-center h-100">
                        <img src="https://placehold.co/400x400/1C3144/FFFFFF?text=M.+Perez" class="card-img-top" alt="Community Liaison M. Perez">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-dark">Marcus Perez</h5>
                            <p class="card-text small text-muted">VP of Community Engagement</p>
                            <a href="#" class="text-secondary"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
            </div>
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
                    <li><a href="../index.jsp#features">Platform Features</a></li>
                    <li><a href="../index.jsp#advanced">Advanced Analytics</a></li>
                    <li><a href="../index.jsp#impact">Our Impact</a></li>
                    <li><a href="../views/auth/login.jsp">Login Portal</a></li>
                </ul>
            </div>
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold text-dark border-bottom border-3 border-secondary pb-2">Company & Contact</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contactus.jsp">Contact Us</a></li>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS JS -->
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
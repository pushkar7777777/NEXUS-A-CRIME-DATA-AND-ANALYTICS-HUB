<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Nexus</title>

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
        .btn-form-submit {
            background-color: var(--nexus-fresh);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 700;
            transition: background-color 0.3s;
        }
        .btn-form-submit:hover {
            background-color: var(--nexus-dark);
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
        .contact-icon-large { font-size: 3.5rem; color: var(--nexus-fresh); }
        .contact-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border-left: 5px solid var(--nexus-fresh);
            height: 100%;
            transition: transform 0.3s;
        }
        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 139, 230, 0.15);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ddd;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(0, 139, 230, 0.25);
            border-color: var(--nexus-fresh);
        }
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
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link active" href="contactus.jsp">Contact Us</a></li>
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
        <h1 class="display-3 mb-2" data-aos="fade-down">Get In Touch</h1>
        <p class="lead" data-aos="fade-up" data-aos-delay="200">We're here to answer your questions about the platform, partnerships, or support.</p>
    </div>
</header>

<main>
    <section id="contact-form" class="py-5">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Send Us a Message</h2>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card p-4 shadow-lg border-0" data-aos="zoom-in">
                        <div class="card-body">
                            <form>
                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label fw-bold">Full Name</label>
                                        <input type="text" class="form-control" id="name" placeholder="John Doe" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label fw-bold">Email Address</label>
                                        <input type="email" class="form-control" id="email" placeholder="john@example.com" required>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label for="subject" class="form-label fw-bold">Subject</label>
                                    <select id="subject" class="form-select" required>
                                        <option selected>Select a Subject</option>
                                        <option>Platform Support</option>
                                        <option>Partnership/Integration Inquiry</option>
                                        <option>Data Request</option>
                                        <option>General Inquiry</option>
                                    </select>
                                </div>
                                <div class="mb-4">
                                    <label for="message" class="form-label fw-bold">Your Message</label>
                                    <textarea class="form-control" id="message" rows="5" placeholder="Write your detailed message here..." required></textarea>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-form-submit btn-lg">
                                        Submit Inquiry <i class="bi bi-send-fill ms-2"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="contact-info" class="py-5 my-5 bg-white">
        <div class="container">
            <h2 class="text-center section-title mb-5 pb-4" data-aos="fade-up">Find Us</h2>
            <div class="row g-4 text-center">

                <div class="col-lg-4 col-md-6" data-aos="fade-right" data-aos-delay="100">
                    <div class="contact-card h-100">
                        <i class="bi bi-geo-alt contact-icon-large mb-3"></i>
                        <h4 class="fw-bold text-dark">Headquarters</h4>
                        <p class="text-muted mb-0">Nexus Global Command Center</p>
                        <p class="text-muted">456 Data Street, Analytics City, 10010</p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="contact-card h-100">
                        <i class="bi bi-envelope contact-icon-large mb-3"></i>
                        <h4 class="fw-bold text-dark">General Support</h4>
                        <p class="text-muted mb-0">Non-emergency inquiries & technical support:</p>
                        <a href="mailto:info@nexus.gov" class="fw-bold text-decoration-none" style="color: var(--nexus-fresh);">info@nexus.gov</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mx-auto" data-aos="fade-left" data-aos-delay="300">
                    <div class="contact-card h-100">
                        <i class="bi bi-telephone-fill contact-icon-large mb-3"></i>
                        <h4 class="fw-bold text-dark">Partnership & Media</h4>
                        <p class="text-muted mb-0">Business, media, and agency collaboration:</p>
                        <a href="tel:+15551234567" class="fw-bold text-decoration-none" style="color: var(--nexus-fresh);">+1 (555) 123-4567</a>
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
                    <li><a href="about.html">About Us</a></li>
                    <li><a class="text-info" href="contact.html">Contact Us</a></li>
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
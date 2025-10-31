<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Crime Data & Analysis Hub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Google Fonts (Inter) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        /* --- Navigation --- */
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #003366 !important;
        }

        .navbar {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            background-color: #ffffff;
        }

        .btn-primary {
            background-color: #0055a4;
            border-color: #0055a4;
        }

        .btn-primary:hover {
            background-color: #004488;
            border-color: #004488;
        }

        .form-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }

        .form-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            width: 100%;
        }

        .form-card .card-header {
            background-color: #003366;
            color: white;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            padding: 1.5rem;
            text-align: center;
        }

        .form-card .card-header h2 {
            margin: 0;
            font-weight: 600;
        }

        .form-card .card-body {
            padding: 2.5rem;
        }

        .form-label {
            font-weight: 500;
            color: #333;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0055a4;
            box-shadow: 0 0 0 0.25rem rgba(0, 85, 164, 0.25);
        }

        .back-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #555;
        }

        .back-link a {
            font-weight: 600;
            color: #0055a4;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container">
        <a class="navbar-brand" href="../../index.jsp">
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
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="../../index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Forgot Password Section -->
<div class="container form-container">
    <div class="card form-card">
        <div class="card-header">
            <h2>Forgot Password</h2>
        </div>
        <div class="card-body">
            <p class="text-muted mb-4">
                Enter your email address and we will send you a link to reset your password.
            </p>

            <!-- In a real JSP/Servlet project, the action would be to a servlet handling password reset logic -->
            <form id="forgotPasswordForm" method="POST" action="forgot-password">

                <!-- Email Address -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary w-100 btn-lg">
                    Send Reset Link
                </button>

            </form>

            <!-- Back to Login Link -->
            <div class="back-link">
                Remembered your password? <a href="login.jsp">Back to Login</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Custom JS (for demonstration) -->
<script>
    document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent actual form submission for this demo

        const email = document.getElementById('email').value;
        console.log(`Password reset requested for: ${email}`);

        // In a real application, you'd send this to your servlet
        // and show a confirmation message.
        alert("If an account exists for " + email + ", you will receive a password reset link.");

        // Optionally redirect back to login
        // window.location.href = 'login.html';
    });
</script>
</body>
</html>

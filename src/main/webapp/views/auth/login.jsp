<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Nexus Login</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Configure Tailwind to use the 'Inter' font */
        html { font-family: 'Inter', sans-serif; }

        /* Custom Gradient Background Animation (Kept from original for dynamic effect) */
        @keyframes gradientBG {
            0% { background-position:0% 50%; }
            50% { background-position:100% 50%; }
            100% { background-position:0% 50%; }
        }

        .animated-bg {
            /* Using the original dark blue/teal gradient */
            background: linear-gradient(-45deg, #0f2027, #203a43, #2c5364, #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        /* Custom styles for the input focus state */
        .form-input {
            transition: all 0.3s ease;
        }
        .form-input:focus {
            box-shadow: 0 0 0 3px rgba(44, 83, 100, 0.4); /* Custom shadow color */
            border-color: #2c5364; /* Dark Teal Border */
        }
    </style>
</head>
<body class="animated-bg min-h-screen flex items-center justify-center p-4">

<div class="login-card max-w-md w-full bg-white/95 backdrop-blur-md p-8 rounded-2xl shadow-2xl animate__animated animate__fadeInDown">

    <h3 class="text-3xl text-center mb-6 font-extrabold text-gray-800">
        <i class="fa-solid fa-lock text-blue-700 mr-2"></i> Nexus Login
    </h3>

    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="bg-red-100 border-l-4 border-red-600 p-4 text-red-800 font-semibold rounded-lg mb-6">
        <i class="fa-solid fa-exclamation-circle mr-2"></i> <%= error %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post" class="space-y-4">

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Login As</label>
            <select name="role" class="form-input w-full p-3 border border-gray-300 rounded-lg appearance-none" required>
                <option value="CIVILIAN">Civilian</option>
                <option value="POLICE">Police</option>
                <option value="ADMIN">Admin</option>
            </select>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input type="email" class="form-input w-full p-3 border border-gray-300 rounded-lg" name="email" placeholder="user@nexus.gov" required>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <input type="password" class="form-input w-full p-3 border border-gray-300 rounded-lg" name="password" placeholder="******" required>
        </div>

        <button type="submit" class="w-full py-3 mt-4 bg-gradient-to-r from-blue-700 to-gray-800 hover:from-blue-800/90 hover:to-gray-900 rounded-xl text-white text-lg font-bold tracking-wide shadow-lg transform hover:scale-[1.005] transition-all duration-300">
            Secure Login
        </button>

    </form>

    <div class="text-center mt-5">
        <p class="text-gray-600 text-sm">Don't have an account?
            <a href="<%= request.getContextPath() %>/views/auth/register.jsp" class="font-bold text-blue-700 hover:text-blue-900 transition-colors duration-200 ml-1">
                Register Here
            </a>
        </p>
    </div>

</div>

</body>
</html>
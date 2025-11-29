<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Login | Nexus</title>

    <!-- Tailwind CSS Script -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <!-- Animate CSS for Initial Load -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* Define Nexus Colors for easy Tailwind reference */
        /*
            --nexus-dark: #1C3144
            --nexus-fresh: #008be6
        */

        /* Configure Tailwind to use the 'Inter' font */
        html { font-family: 'Inter', sans-serif; }

        /* Custom Gradient Background Animation (Using Nexus Dark/Fresh colors) */
        @keyframes gradientBG {
            0% { background-position:0% 50%; }
            50% { background-position:100% 50%; }
            100% { background-position:0% 50%; }
        }

        .animated-bg {
            /* Using a smooth transition between Nexus Dark and a complementary teal/blue */
            background: linear-gradient(-45deg, #1C3144, #1A5276, #2c5364, #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        /* Custom styles for the input focus state */
        .form-input {
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.07);
        }
        .form-input:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 139, 230, 0.4); /* Focus ring using fresh blue */
            border-color: #008be6; /* Fresh Blue Border */
        }
    </style>
</head>
<body class="animated-bg min-h-screen flex items-center justify-center p-4">

<div class="login-card max-w-lg w-full bg-white p-8 rounded-3xl shadow-2xl animate__animated animate__fadeInDown border-t-8 border-[#008be6]">

    <h3 class="text-4xl text-center mb-6 font-black text-[#1C3144]">
        <i class="fa-solid fa-shield-halved text-[#008be6] mr-3"></i> NEXUS Login
    </h3>
    <p class="text-center text-gray-500 mb-8 font-medium">Access your secure crime data and analytics dashboard.</p>

    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <!-- Styled Error Message -->
    <div class="bg-red-50 border-l-4 border-red-600 p-4 text-red-800 font-semibold rounded-lg mb-6">
        <i class="fa-solid fa-exclamation-triangle mr-2"></i> <%= error %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post" class="space-y-6">

        <div>
            <label class="block text-sm font-bold text-gray-700 mb-2">Login As</label>
            <select name="role" class="form-input w-full p-3 border border-gray-300 rounded-xl appearance-none cursor-pointer text-[#1C3144] font-medium" required>
                <option value="CIVILIAN" class="text-gray-700">Civilian (Report & Track)</option>
                <option value="POLICE" class="text-gray-700">Police (Case Management)</option>
                <option value="ADMIN" class="text-gray-700">Admin (System Configuration)</option>
            </select>
        </div>

        <div>
            <label class="block text-sm font-bold text-gray-700 mb-2">Email</label>
            <input type="email" class="form-input w-full p-3 border border-gray-300 rounded-xl" name="email" placeholder="user@nexus.gov" required>
        </div>

        <div>
            <label class="block text-sm font-bold text-gray-700 mb-2">Password</label>
            <input type="password" class="form-input w-full p-3 border border-gray-300 rounded-xl" name="password" placeholder="••••••••" required>
        </div>

        <!-- Submit Button using Nexus Fresh Blue -->
        <button type="submit" class="w-full py-4 mt-6
                bg-gradient-to-r from-[#008be6] to-[#00A3FF]
                hover:from-[#1C3144] hover:to-[#2c5364]
                rounded-2xl text-white text-xl font-extrabold tracking-wider
                shadow-xl shadow-blue-500/30 transform hover:scale-[1.01] transition-all duration-500">
            Secure Login
        </button>

    </form>

    <div class="text-center mt-6">
        <p class="text-gray-500 text-sm">Don't have an account?
            <a href="<%= request.getContextPath() %>/views/auth/register.jsp" class="font-extrabold text-[#008be6] hover:text-[#1C3144] transition-colors duration-200 ml-1">
                Register Here
            </a>
        </p>
        <p class="text-gray-500 text-sm mt-3">
            <a href="<%= request.getContextPath() %>/index.jsp" class="font-medium text-gray-500 hover:text-[#1C3144] transition-colors duration-200">
                <i class="fa-solid fa-arrow-left mr-1"></i> Back to Homepage
            </a>
        </p>
    </div>

</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.nexus.dao.PoliceRegistrationDAO"%>
<%@ page import="org.example.nexus.model.PoliceStation"%>
<%@ page import="java.util.List"%>

<%
    PoliceRegistrationDAO psdao = new PoliceRegistrationDAO();
    List<PoliceStation> stations = psdao.getAllStations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register – Nexus Crime Data Hub</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        html { font-family: 'Inter', sans-serif; }

        @keyframes gradientBG {
            0% { background-position:0% 50% }
            50% { background-position:100% 50% }
            100% { background-position:0% 50% }
        }
        .animated-bg {
            background: linear-gradient(-45deg, #0f2027, #203a43, #2c5364, #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }
        .form-input {
            transition: all 0.3s ease;
        }
        .form-input:focus {
            box-shadow: 0 0 0 3px rgba(44, 83, 100, 0.4);
            border-color: #2c5364;
        }
        .hidden { display: none !important; }
    </style>
</head>

<body class="animated-bg min-h-screen flex items-center justify-center overflow-hidden p-4">

<div class="register-card max-w-2xl w-full bg-white/95 backdrop-blur-md rounded-2xl shadow-2xl overflow-hidden animate__animated animate__zoomIn">

    <div class="card-header bg-gradient-to-r from-gray-800 to-blue-900 text-white p-6 text-center">
        <h2 class="text-3xl font-bold"><i class="bi bi-person-fill-lock mr-2"></i>Create Your Nexus Account</h2>
    </div>

    <div class="p-6 sm:p-8">

        <% String error = request.getParameter("error"); if (error != null) { %>
        <div class="bg-red-100 border-l-4 border-red-600 p-4 text-red-800 font-semibold rounded-lg mb-6">
            <i class="bi bi-exclamation-triangle-fill mr-2"></i> <%= error %>
        </div>
        <% } %>

        <!-- TABS -->
        <div class="flex mb-6 space-x-3">
            <button id="tab-civilian" class="tab-btn flex-1 py-2 rounded-xl font-semibold border border-gray-400 bg-white text-gray-700"
                    onclick="switchForm('civilianForm')">Civilian</button>
            <button id="tab-police" class="tab-btn flex-1 py-2 rounded-xl font-semibold border border-gray-400 bg-white text-gray-700"
                    onclick="switchForm('policeForm')">Police</button>
            <button id="tab-admin" class="tab-btn flex-1 py-2 rounded-xl font-semibold border border-gray-400 bg-white text-gray-700"
                    onclick="switchForm('adminForm')">Admin</button>
        </div>

        <!-- ================= CIVILIAN FORM ================= -->
        <form id="civilianForm" action="<%= request.getContextPath() %>/civilian_register" method="post" class="space-y-4">

            <h5 class="text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                General Public Registration <i class="bi bi-person-circle text-blue-600"></i>
            </h5>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label>Email</label>
                    <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                </div>
                <div>
                    <label>Phone</label>
                    <input type="text" name="phone" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                </div>
            </div>

            <label>Password</label>
            <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <label>National ID</label>
            <input type="text" name="national_id" class="form-input w-full p-3 border border-gray-300 rounded-lg">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label>Date of Birth</label>
                    <input type="date" name="dob" class="form-input w-full p-3 border border-gray-300 rounded-lg">
                </div>
                <div>
                    <label>Gender</label>
                    <select name="gender" class="form-input w-full p-3 border border-gray-300 rounded-lg">
                        <option>Male</option><option>Female</option><option>Other</option>
                    </select>
                </div>
            </div>

            <button type="submit"
                    class="w-full py-3 mt-6 bg-gradient-to-r from-blue-700 to-gray-800 text-white rounded-xl font-bold">
                Register as Civilian
            </button>
        </form>

        <!-- ================= POLICE FORM ================= -->
        <form id="policeForm" class="hidden space-y-4" action="<%= request.getContextPath() %>/police_register" method="post">

            <h5 class="text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                Police Registration <i class="bi bi-shield-fill-check text-green-600"></i>
            </h5>

            <div>
                <label>Full Name</label>
                <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label>Email</label>
                    <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                </div>

                <div>
                    <label>Phone Number</label>
                    <input type="text" name="phone" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                </div>
            </div>

            <label>Password</label>
            <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label>Rank</label>
                    <input type="text" name="rank" class="form-input w-full p-3 border border-gray-300 rounded-lg">
                </div>

                <div>
                    <label>Police Station</label>
                    <select name="police_station_id" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                        <option value="">-- Select Station --</option>

                        <% for (PoliceStation ps : stations) { %>
                        <option value="<%= ps.getPoliceStationId() %>">
                            <%= ps.getPoliceStationId() %> – <%= ps.getStationName() %>
                        </option>
                        <% } %>

                    </select>
                </div>
            </div>

            <label>Joining Code</label>
            <input type="text" name="joining_code" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <button type="submit"
                    class="w-full py-3 mt-6 bg-gradient-to-r from-blue-700 to-gray-800 text-white rounded-xl font-bold">
                Register as Police
            </button>
        </form>

        <!-- ================= ADMIN FORM ================= -->
        <form id="adminForm" class="hidden space-y-4" action="<%= request.getContextPath() %>/admin_register" method="post">

            <h5 class="text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                Admin Registration <i class="bi bi-gear-fill text-yellow-600"></i>
            </h5>

            <label>Full Name</label>
            <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <label>Email</label>
            <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <label>Password</label>
            <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <label>Role</label>
            <select name="role" class="form-input w-full p-3 border border-gray-300 rounded-lg">
                <option value="SUPER_ADMIN">Super Admin</option>
                <option value="ANALYST">Analyst</option>
                <option value="AUDITOR">Auditor</option>
            </select>

            <label>Secret Admin Code</label>
            <input type="text" name="secret_admin_code" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>

            <button type="submit"
                    class="w-full py-3 mt-6 bg-gradient-to-r from-blue-700 to-gray-800 text-white rounded-xl font-bold">
                Register as Admin
            </button>
        </form>

        <div class="text-center mt-8 text-sm text-gray-600">
            Already have an account?
            <a href="login.jsp" class="font-bold text-blue-700">Login</a>
        </div>

    </div>
</div>

<script>
    function switchForm(formId) {
        document.querySelectorAll("form").forEach(f => f.classList.add("hidden"));
        document.getElementById(formId).classList.remove("hidden");

        document.querySelectorAll(".tab-btn").forEach(btn =>
            btn.classList.remove("bg-blue-700", "text-white", "border-blue-700")
        );

        const activeBtn = document.getElementById("tab-" + formId.replace("Form", ""));
        activeBtn.classList.add("bg-blue-700", "text-white", "border-blue-700");
    }

    document.addEventListener("DOMContentLoaded", () => switchForm("civilianForm"));
</script>

</body>
</html>

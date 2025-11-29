<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.nexus.dao.PoliceRegistrationDAO"%>
<%@ page import="org.example.nexus.model.PoliceStation"%>
<%@ page import="java.util.List"%>

<%
    // Placeholder code for database access, assuming functionality is external
    PoliceRegistrationDAO psdao = new PoliceRegistrationDAO();
    List<PoliceStation> stations = psdao.getAllStations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – Nexus Crime Data Hub</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* Define Nexus Colors for easy Tailwind reference */
        /*
            --nexus-dark: #1C3144
            --nexus-fresh: #008be6
        */

        html { font-family: 'Inter', sans-serif; }

        @keyframes gradientBG {
            0% { background-position:0% 50% }
            50% { background-position:100% 50% }
            100% { background-position:0% 50% }
        }
        .animated-bg {
            /* Using a smooth transition between Nexus Dark and a complementary teal/blue */
            background: linear-gradient(-45deg, #1C3144, #1A5276, #2c5364, #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }
        .form-input {
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.07);
            border-radius: 0.75rem; /* rounded-xl */
        }
        .form-input:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 139, 230, 0.4); /* Focus ring using fresh blue */
            border-color: #008be6; /* Fresh Blue Border */
        }
        .hidden { display: none !important; }

        /* Custom style for active tab button */
        .tab-btn {
            transition: all 0.3s ease;
            font-weight: 700;
        }
        .tab-btn.active {
            background-color: #008be6; /* Fresh Blue */
            color: white;
            border-color: #008be6;
            box-shadow: 0 4px 6px -1px rgba(0, 139, 230, 0.3), 0 2px 4px -2px rgba(0, 139, 230, 0.3);
        }
    </style>
</head>

<body class="animated-bg min-h-screen flex items-center justify-center p-4">

<!-- Main Registration Card -->
<div class="register-card max-w-2xl w-full bg-white rounded-3xl shadow-2xl overflow-hidden animate__animated animate__zoomIn border-t-8 border-[#008be6]">

    <div class="card-header bg-gradient-to-r from-[#1C3144] to-[#2c5364] text-white p-6 text-center">
        <h2 class="text-3xl font-black"><i class="bi bi-person-fill-lock mr-3 text-[#008be6]"></i>Create Your Nexus Account</h2>
    </div>

    <div class="p-6 sm:p-8">

        <% String error = request.getParameter("error"); if (error != null) { %>
        <!-- Styled Error Message -->
        <div class="bg-red-50 border-l-4 border-red-600 p-4 text-red-800 font-semibold rounded-lg mb-6">
            <i class="bi bi-exclamation-triangle-fill mr-2"></i> <%= error %>
        </div>
        <% } %>

        <!-- TABS -->
        <div class="flex mb-8 space-x-4">
            <button id="tab-civilian" class="tab-btn flex-1 py-3 rounded-xl border border-gray-300 bg-white text-gray-700 hover:border-[#008be6] hover:text-[#008be6]"
                    onclick="switchForm('civilianForm')">Civilian</button>
            <button id="tab-police" class="tab-btn flex-1 py-3 rounded-xl border border-gray-300 bg-white text-gray-700 hover:border-[#008be6] hover:text-[#008be6]"
                    onclick="switchForm('policeForm')">Police</button>
            <button id="tab-admin" class="tab-btn flex-1 py-3 rounded-xl border border-gray-300 bg-white text-gray-700 hover:border-[#008be6] hover:text-[#008be6]"
                    onclick="switchForm('adminForm')">Admin</button>
        </div>

        <!-- ================= CIVILIAN FORM ================= -->
        <form id="civilianForm" action="<%= request.getContextPath() %>/civilian_register" method="post" class="space-y-5">

            <h5 class="text-xl font-extrabold text-[#1C3144] mb-4 border-b border-gray-200 pb-3">
                General Public Registration <i class="bi bi-person-circle text-[#008be6] ml-2"></i>
            </h5>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Full Name</label>
                <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Jane Doe" required>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Email</label>
                    <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="jane.doe@email.com" required>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Phone</label>
                    <input type="text" name="phone" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="+1 (555) 123-4567" required>
                </div>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Password</label>
                <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="••••••••" required>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">National ID (Optional)</label>
                <input type="text" name="national_id" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="ID Number">
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Date of Birth</label>
                    <input type="date" name="dob" class="form-input w-full p-3 border border-gray-300 rounded-xl">
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Gender</label>
                    <select name="gender" class="form-input w-full p-3 border border-gray-300 rounded-xl appearance-none cursor-pointer">
                        <option>Male</option><option>Female</option><option>Other</option>
                    </select>
                </div>
            </div>

            <!-- Submit Button using Nexus Fresh Blue -->
            <button type="submit"
                    class="w-full py-4 mt-6
                    bg-gradient-to-r from-[#008be6] to-[#00A3FF]
                    hover:from-[#1C3144] hover:to-[#2c5364]
                    rounded-2xl text-white text-xl font-extrabold tracking-wider
                    shadow-xl shadow-blue-500/30 transform hover:scale-[1.01] transition-all duration-500">
                Register as Civilian
            </button>
        </form>

        <!-- ================= POLICE FORM ================= -->
        <form id="policeForm" class="hidden space-y-5" action="<%= request.getContextPath() %>/police_register" method="post">

            <h5 class="text-xl font-extrabold text-[#1C3144] mb-4 border-b border-gray-200 pb-3">
                Law Enforcement Registration <i class="bi bi-shield-fill-check text-[#008be6] ml-2"></i>
            </h5>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Full Name</label>
                <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Officer John Smith" required>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Email</label>
                    <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="john.smith@police.gov" required>
                </div>

                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Phone Number</label>
                    <input type="text" name="phone" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="+1 (555) 987-6543" required>
                </div>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Password</label>
                <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="••••••••" required>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Rank</label>
                    <input type="text" name="rank" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Sergeant / Detective">
                </div>

                <!-- POLICE STATION SELECTION WITH SEARCH INPUT -->
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Police Station</label>
                    <!-- New Search Input Field -->
                    <input type="text" id="policeStationSearch"
                           class="form-input w-full p-3 border border-gray-300 rounded-xl mb-3"
                           placeholder="Search station by name..."
                           onkeyup="filterStations()">

                    <select name="police_station_id" id="policeStationSelect" class="form-input w-full p-3 border border-gray-300 rounded-xl appearance-none cursor-pointer" required>
                        <option value="">-- Select Station --</option>

                        <% for (PoliceStation ps : stations) { %>
                        <option value="<%= ps.getPoliceStationId() %>">
                            <%= ps.getPoliceStationId() %> – <%= ps.getStationName() %>
                        </option>
                        <% } %>

                    </select>
                </div>
                <!-- END POLICE STATION SELECTION -->
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Official Joining Code</label>
                <input type="text" name="joining_code" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Unique Official Code" required>
            </div>

            <button type="submit"
                    class="w-full py-4 mt-6
                    bg-gradient-to-r from-[#008be6] to-[#00A3FF]
                    hover:from-[#1C3144] hover:to-[#2c5364]
                    rounded-2xl text-white text-xl font-extrabold tracking-wider
                    shadow-xl shadow-blue-500/30 transform hover:scale-[1.01] transition-all duration-500">
                Register as Police
            </button>
        </form>

        <!-- ================= ADMIN FORM ================= -->
        <form id="adminForm" class="hidden space-y-5" action="<%= request.getContextPath() %>/admin_register" method="post">

            <h5 class="text-xl font-extrabold text-[#1C3144] mb-4 border-b border-gray-200 pb-3">
                Administrator/Analyst Registration <i class="bi bi-gear-fill text-[#1C3144] ml-2"></i>
            </h5>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Full Name</label>
                <input type="text" name="full_name" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Admin Name" required>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Email</label>
                <input type="email" name="email" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="admin@nexus.gov" required>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Password</label>
                <input type="password" name="password" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="••••••••" required>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Role</label>
                <select name="role" class="form-input w-full p-3 border border-gray-300 rounded-xl appearance-none cursor-pointer">
                    <option value="SUPER_ADMIN">Super Admin</option>
                    <option value="ANALYST">Analyst (Data Access)</option>
                    <option value="AUDITOR">Auditor (Compliance)</option>
                </select>
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-2">Secret Admin Code</label>
                <input type="text" name="secret_admin_code" class="form-input w-full p-3 border border-gray-300 rounded-xl" placeholder="Required for Authorization" required>
            </div>

            <button type="submit"
                    class="w-full py-4 mt-6
                    bg-gradient-to-r from-[#008be6] to-[#00A3FF]
                    hover:from-[#1C3144] hover:to-[#2c5364]
                    rounded-2xl text-white text-xl font-extrabold tracking-wider
                    shadow-xl shadow-blue-500/30 transform hover:scale-[1.01] transition-all duration-500">
                Register as Admin
            </button>
        </form>

        <div class="text-center mt-8 text-sm text-gray-600">
            Already have an account?
            <a href="login.jsp" class="font-extrabold text-[#008be6] hover:text-[#1C3144] transition-colors duration-200 ml-1">Login</a>
        </div>

    </div>
</div>

<script>
    function switchForm(formId) {
        document.querySelectorAll("form").forEach(f => f.classList.add("hidden"));
        document.getElementById(formId).classList.remove("hidden");

        // Tailwind CSS class names
        const activeClasses = ["active"];
        const removeClasses = ["bg-blue-700", "text-white", "border-blue-700"]; // Placeholder classes to clear

        document.querySelectorAll(".tab-btn").forEach(btn => {
            btn.classList.remove(...activeClasses);
            // Clear hover/active classes that might interfere
            btn.classList.remove("bg-[#008be6]", "text-white", "border-[#008be6]");
        });

        const activeBtn = document.getElementById("tab-" + formId.replace("Form", ""));
        activeBtn.classList.add(...activeClasses, "bg-[#008be6]", "text-white", "border-[#008be6]");
    }

    // NEW FILTERING FUNCTIONALITY
    function filterStations() {
        const input = document.getElementById('policeStationSearch');
        const filter = input.value.toUpperCase();
        const select = document.getElementById('policeStationSelect');
        const options = select.getElementsByTagName('option');

        for (let i = 0; i < options.length; i++) {
            const option = options[i];
            const textValue = option.textContent || option.innerText;

            // The first option (-- Select Station --) is always visible
            if (i === 0) {
                option.style.display = "";
                continue;
            }

            // Check if the option text starts with the filter string (case-insensitive)
            if (textValue.toUpperCase().startsWith(filter)) {
                option.style.display = "";
            } else {
                option.style.display = "none";
            }
        }

        // Ensure the currently selected option is visible, or reset if hidden
        if (select.options[select.selectedIndex] && select.options[select.selectedIndex].style.display === 'none') {
            select.selectedIndex = 0;
        }
    }

    document.addEventListener("DOMContentLoaded", () => {
        // Initialize with Civilian form active
        switchForm("civilianForm");

        // Apply active class on initial load since switchForm only handles the first button initially
        document.getElementById("tab-civilian").classList.add("active");
    });
</script>

</body>
</html>
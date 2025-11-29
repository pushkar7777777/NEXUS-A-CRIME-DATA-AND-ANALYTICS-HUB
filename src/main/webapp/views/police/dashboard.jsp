<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Police Dashboard - Nexus Hub (Tailwind)</title>

    <!-- Load Tailwind CSS from CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Load Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Load Chart.js for Analytics -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <!-- Custom Tailwind Configuration -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'nexus-dark': '#1C3144',
                        'nexus-blue': '#008be6',
                        'nexus-light': '#F0F4F8',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>

    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

    <!-- AOS (Animate On Scroll) Styles -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        /* Custom Styles for Sidebar Gradient and Sticky Main Content */
        .sidebar-bg {
            background: linear-gradient(180deg, #1C3144 0%, #294660 100%);
        }
        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            min-height: 100vh;
            transition: margin-left 0.3s;
        }
        .sidebar-active-link {
            border-left: 5px solid #ffc107; /* Gold accent */
            padding-left: 1.75rem !important;
        }
    </style>
</head>
<body class="bg-nexus-light text-nexus-dark font-sans flex min-h-screen">

<!-- ======================== SIDEBAR ======================== -->
<div class="sidebar fixed w-70 h-full text-white overflow-y-auto shadow-2xl z-20 sidebar-bg flex flex-col"
     style="width: 280px;">

    <div class="sidebar-header p-7 text-center border-b border-white/15">
        <div class="flex items-center justify-center space-x-2">
            <!-- NEXUS HUB Logo (Custom SVG Shield with checkmark) -->
            <svg class="w-7 h-7 text-nexus-blue" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-1.88 12.82l-2.58-2.58L6.47 12l2.05 2.05 4.49-4.49 1.06 1.06-5.55 5.55z"/>
            </svg>
            <h3 class="font-black text-3xl mb-0 text-white">NEXUS HUB</h3>
        </div>
        <p class="text-sm opacity-75 mt-1 mb-0">Officer: ${sessionScope.user_name}</p>
        <p class="text-xs opacity-75">Rank: Inspector (Example)</p>
    </div>

    <ul class="nav flex-col sidebar-nav flex-grow">
        <!-- Dashboard Link -->
        <li><a class="nav-link flex items-center p-4 px-8 font-medium hover:bg-white/10 transition-colors duration-200 active:bg-nexus-blue active:sidebar-active-link"
               data-bs-toggle="tab" href="#overview" data-target="#overview"><i class="fas fa-tachometer-alt mr-2 w-7 text-lg"></i>Dashboard</a></li>

        <!-- Assignments Link -->
        <li><a class="nav-link flex items-center p-4 px-8 font-medium hover:bg-white/10 transition-colors duration-200"
               data-bs-toggle="tab" href="#assignments" data-target="#assignments"><i class="fas fa-inbox mr-2 w-7 text-lg"></i>Case Assignments</a></li>

        <!-- Investigation Link -->
        <li><a class="nav-link flex items-center p-4 px-8 font-medium hover:bg-white/10 transition-colors duration-200"
               data-bs-toggle="tab" href="#investigation" data-target="#investigation"><i class="fas fa-magnifying-glass mr-2 w-7 text-lg"></i>Case Investigation</a></li>

        <!-- Analytics Link -->
        <li><a class="nav-link flex items-center p-4 px-8 font-medium hover:bg-white/10 transition-colors duration-200"
               data-bs-toggle="tab" href="#analytics" data-target="#analytics"><i class="fas fa-chart-line mr-2 w-7 text-lg"></i>Crime Analytics</a></li>

        <!-- Profile Link -->
        <li><a class="nav-link flex items-center p-4 px-8 font-medium hover:bg-white/10 transition-colors duration-200"
               data-bs-toggle="tab" href="#profile" data-target="#profile"><i class="fas fa-user-shield mr-2 w-7 text-lg"></i>Officer Profile</a></li>
    </ul>

    <div class="p-3">
        <!-- Notifications -->
        <a href="#" class="block text-center mb-2 px-4 py-2 bg-yellow-400/10 text-yellow-400 font-bold rounded-lg border border-yellow-400 hover:bg-yellow-500/20 transition duration-200">
            <i class="fas fa-bell mr-2"></i>Notifications (3)
        </a>
        <!-- Logout -->
        <a href="${pageContext.request.contextPath}/logout" class="block text-center px-4 py-3 bg-transparent border border-white/30 text-white font-bold rounded-lg hover:bg-white/10 transition duration-200">
            <i class="fas fa-sign-out-alt mr-2"></i>Logout
        </a>
    </div>
</div>


<!-- ======================== MAIN CONTENT ======================== -->
<div class="main-content">

    <!-- TOP NAV with Search, Clock and Profile -->
    <nav class="sticky top-0 bg-white p-4 px-8 flex items-center justify-between shadow-md z-10">
        <h5 class="font-bold text-gray-600 mb-0">Police Operations Dashboard</h5>

        <!-- Search Bar -->
        <div class="max-w-md w-full hidden md:block">
            <div class="flex">
                <input type="text" class="flex-grow p-2 border border-gray-300 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-nexus-blue"
                       placeholder="Search Case ID, Officer, or Reporter...">
                <button class="bg-nexus-blue text-white p-2.5 rounded-r-lg hover:bg-blue-700 transition-colors duration-200" type="button"><i class="fas fa-search"></i></button>
            </div>
        </div>

        <!-- Live Clock & Profile -->
        <div class="flex items-center space-x-4">
            <div class="hidden sm:block px-3 py-1 bg-nexus-light text-nexus-dark rounded-lg font-semibold text-sm">
                <i class="fas fa-clock mr-2 text-nexus-blue"></i> <span id="liveClock">--:--</span>
            </div>
            <span class="font-bold text-gray-800 hidden md:block">${sessionScope.user_name}</span>
            <img src="https://ui-avatars.com/api/?name=${sessionScope.user_name}&background=1C3144&color=fff&size=40"
                 class="rounded-full shadow-md w-10 h-10" alt="Avatar">
        </div>
    </nav>

    <div class="container mx-auto p-4 lg:p-8">

        <div class="tab-content" id="tabContent">

            <!-- ======================== 1. OVERVIEW / KPI DASHBOARD ======================== -->
            <div class="tab-pane fade show active" id="overview" data-aos="fade-up">

                <h2 class="font-bold text-3xl mb-6 text-gray-800"><i class="fas fa-warehouse mr-3 text-nexus-blue"></i>Station Command Center</h2>

                <!-- KPI CARDS -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">

                    <!-- New Assignments -->
                    <div class="flex items-center p-6 bg-white rounded-xl shadow-lg border border-gray-200 hover:shadow-xl transition-shadow duration-300" data-aos="fade-up" data-aos-delay="100">
                        <div class="w-14 h-14 bg-yellow-500 rounded-full flex items-center justify-center text-white text-2xl mr-4"><i class="fas fa-bell"></i></div>
                        <div>
                            <p class="text-xs font-bold mb-1 text-gray-500 uppercase">New Assignments</p>
                            <div class="text-4xl font-extrabold text-nexus-dark counter" data-target="${stats.totalAssigned - stats.inProgress}">0</div>
                        </div>
                    </div>

                    <!-- Total Active Cases -->
                    <div class="flex items-center p-6 bg-white rounded-xl shadow-lg border border-gray-200 hover:shadow-xl transition-shadow duration-300" data-aos="fade-up" data-aos-delay="200">
                        <div class="w-14 h-14 bg-nexus-blue rounded-full flex items-center justify-center text-white text-2xl mr-4"><i class="fas fa-search-location"></i></div>
                        <div>
                            <p class="text-xs font-bold mb-1 text-gray-500 uppercase">Total Active Cases</p>
                            <div class="text-4xl font-extrabold text-nexus-dark counter" data-target="${stats.totalAssigned}">0</div>
                        </div>
                    </div>

                    <!-- Resolved Cases -->
                    <div class="flex items-center p-6 bg-white rounded-xl shadow-lg border border-gray-200 hover:shadow-xl transition-shadow duration-300" data-aos="fade-up" data-aos-delay="300">
                        <div class="w-14 h-14 bg-green-600 rounded-full flex items-center justify-center text-white text-2xl mr-4"><i class="fas fa-check-circle"></i></div>
                        <div>
                            <p class="text-xs font-bold mb-1 text-gray-500 uppercase">Resolved Cases</p>
                            <div class="text-4xl font-extrabold text-nexus-dark counter" data-target="${stats.resolved}">0</div>
                        </div>
                    </div>

                    <!-- High Priority (Static example) -->
                    <div class="flex items-center p-6 bg-white rounded-xl shadow-lg border border-gray-200 hover:shadow-xl transition-shadow duration-300" data-aos="fade-up" data-aos-delay="400">
                        <div class="w-14 h-14 bg-red-600 rounded-full flex items-center justify-center text-white text-2xl mr-4"><i class="fas fa-fire"></i></div>
                        <div>
                            <p class="text-xs font-bold mb-1 text-gray-500 uppercase">High Priority</p>
                            <div class="text-4xl font-extrabold text-nexus-dark counter" data-target="25">0</div>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-6 rounded-xl shadow-lg" data-aos="fade-up" data-aos-delay="500">
                    <h4 class="font-bold text-xl mb-4 text-nexus-blue"><i class="fas fa-clipboard-list mr-2"></i>Top 5 Recent Assigned Cases</h4>

                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-nexus-dark text-white text-left text-sm uppercase font-semibold tracking-wider">
                            <tr>
                                <th class="p-4 rounded-tl-xl">ID</th>
                                <th class="p-4">Type</th>
                                <th class="p-4">Priority</th>
                                <th class="p-4">Status</th>
                                <th class="p-4 rounded-tr-xl">Date</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                            <c:forEach var="c" items="${assignedCases}" begin="0" end="4">
                                <tr class="hover:bg-nexus-light/50 transition duration-150 cursor-pointer" data-bs-toggle="modal" data-bs-target="#manageModal">
                                    <td class="p-4 font-bold text-nexus-blue">#C-${c.complaintId}</td>
                                    <td class="p-4">${c.complaintType}</td>
                                    <td class="p-4">
                                        <!-- PRIORITY BADGE - ROBUST METHOD -->
                                        <c:choose>
                                            <c:when test='${c.urgencyLevel == "HIGH"}'><c:set var="priorityClass" value="bg-red-600 text-white"/></c:when>
                                            <c:when test='${c.urgencyLevel == "MEDIUM"}'><c:set var="priorityClass" value="bg-yellow-400 text-gray-800"/></c:when>
                                            <c:otherwise><c:set var="priorityClass" value="bg-blue-300 text-gray-800"/></c:otherwise>
                                        </c:choose>
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-semibold ${priorityClass}">${c.urgencyLevel}</span>
                                    </td>
                                    <td class="p-4">
                                        <!-- STATUS BADGE - ROBUST METHOD -->
                                        <c:choose>
                                            <c:when test='${c.currentStatus == "RESOLVED" || c.currentStatus == "CLOSED"}'><c:set var="statusClass" value="bg-green-600 text-white"/></c:when>
                                            <c:when test='${c.currentStatus == "UNDER_INVESTIGATION"}'><c:set var="statusClass" value="bg-nexus-blue text-white"/></c:when>
                                            <c:when test='${c.currentStatus == "UNDER_REVIEW"}'><c:set var="statusClass" value="bg-yellow-400 text-gray-800"/></c:when>
                                            <c:otherwise><c:set var="statusClass" value="bg-gray-500 text-white"/></c:otherwise>
                                        </c:choose>
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-semibold ${statusClass}">${c.currentStatus}</span>
                                    </td>
                                    <td class="p-4"><fmt:formatDate value="${c.dateFiled}" pattern="MMM dd, yyyy"/></td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty assignedCases}">
                                <tr><td colspan="5" class="text-center p-6 text-gray-400 italic">No recent cases assigned.</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-right mt-4">
                        <a href="#assignments" data-bs-toggle="tab" class="inline-flex items-center px-4 py-2 border border-nexus-blue text-sm font-medium rounded-lg text-nexus-blue hover:bg-nexus-light transition duration-200">
                            View All Assignments <i class="fas fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- ======================== 2. ASSIGNMENTS (Full List & Filtering) ======================== -->
            <div class="tab-pane fade hidden" id="assignments">
                <h2 class="font-bold text-3xl mb-6 text-gray-800" data-aos="fade-right"><i class="fas fa-inbox mr-3 text-nexus-blue"></i> Case Assignment Inbox</h2>

                <!-- Filter/Search Panel -->
                <div class="bg-white p-5 rounded-xl shadow-lg mb-6" data-aos="fade-up">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div>
                            <select class="w-full p-2 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue text-sm">
                                <option>Filter by Type</option>
                                <option>Theft</option><option>Cyber Crime</option><option>Missing Person</option>
                            </select>
                        </div>
                        <div>
                            <select class="w-full p-2 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue text-sm">
                                <option>Filter by Priority</option>
                                <option>HIGH</option><option>MEDIUM</option><option>LOW</option>
                            </select>
                        </div>
                        <div>
                            <input type="date" class="w-full p-2 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue text-sm">
                        </div>
                        <div>
                            <button class="w-full bg-nexus-blue text-white p-2 font-semibold rounded-lg hover:bg-blue-700 transition-colors duration-200 text-sm">
                                <i class="fas fa-filter mr-2"></i>Apply Filters
                            </button>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-lg overflow-hidden" data-aos="fade-up" data-aos-delay="100">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-nexus-dark text-white text-left text-sm uppercase font-semibold tracking-wider">
                            <tr>
                                <th class="p-4">ID</th>
                                <th class="p-4">Type</th>
                                <th class="p-4">Date Filed</th>
                                <th class="p-4">Location</th>
                                <th class="p-4">Priority</th>
                                <th class="p-4">Status</th>
                                <th class="p-4">Action</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">

                            <c:forEach var="c" items="${assignedCases}">
                                <tr class="hover:bg-nexus-light/50 transition duration-150">
                                    <td class="p-4 font-bold text-nexus-blue">#C-${c.complaintId}</td>
                                    <td class="p-4">${c.complaintType}</td>
                                    <td class="p-4"><fmt:formatDate value="${c.dateFiled}" pattern="MMM dd, yyyy"/></td>
                                    <td class="p-4">${c.locationOfIncident}</td>

                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test='${c.urgencyLevel == "HIGH"}'><c:set var="priorityClass" value="bg-red-600 text-white"/></c:when>
                                            <c:when test='${c.urgencyLevel == "MEDIUM"}'><c:set var="priorityClass" value="bg-yellow-400 text-gray-800"/></c:when>
                                            <c:otherwise><c:set var="priorityClass" value="bg-blue-300 text-gray-800"/></c:otherwise>
                                        </c:choose>
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-semibold ${priorityClass}">${c.urgencyLevel}</span>
                                    </td>

                                    <td class="p-4">
                                        <c:choose>
                                            <c:when test='${c.currentStatus == "RESOLVED" || c.currentStatus == "CLOSED"}'><c:set var="statusClass" value="bg-green-600 text-white"/></c:when>
                                            <c:when test='${c.currentStatus == "UNDER_INVESTIGATION"}'><c:set var="statusClass" value="bg-nexus-blue text-white"/></c:when>
                                            <c:when test='${c.currentStatus == "UNDER_REVIEW"}'><c:set var="statusClass" value="bg-yellow-400 text-gray-800"/></c:when>
                                            <c:otherwise><c:set var="statusClass" value="bg-gray-500 text-white"/></c:otherwise>
                                        </c:choose>
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-semibold ${statusClass}">${c.currentStatus}</span>
                                    </td>

                                    <td class="p-4">
                                        <button class="px-3 py-1 bg-nexus-blue text-white font-medium rounded-lg hover:bg-blue-700 transition-colors text-sm manageBtn"
                                                data-id="${c.complaintId}"
                                                data-type="${c.complaintType}"
                                                data-date="<fmt:formatDate value='${c.dateFiled}' pattern='MMM dd, yyyy'/>"
                                                data-location="${c.locationOfIncident}"
                                                data-priority="${c.urgencyLevel}"
                                                data-status="${c.currentStatus}"
                                                data-description="${fn:escapeXml(c.description)}"
                                                data-regid="${c.regId}"
                                                data-bs-toggle="modal"
                                                data-bs-target="#manageModal">
                                            Update Status
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty assignedCases}">
                                <tr><td colspan="7" class="text-center p-6 text-green-600 font-medium">No active case assignments found.</td></tr>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- ======================== 3. CASE INVESTIGATION (Shell) ======================== -->
            <div class="tab-pane fade hidden" id="investigation">
                <h2 class="font-bold text-3xl mb-6 text-gray-800" data-aos="fade-right"><i class="fas fa-magnifying-glass mr-3 text-nexus-blue"></i> Case Investigation Panel</h2>

                <div class="p-4 bg-blue-100 border border-blue-400 text-blue-800 rounded-lg shadow-md mb-6" role="alert" data-aos="fade-up">
                    <i class="fas fa-info-circle mr-2"></i> This panel provides a dedicated interface for **Investigation Notes, Evidence Upload, and Civilian Reporter Information**.
                </div>

                <!-- Detailed Case Card -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <div class="lg:col-span-2 bg-white p-6 rounded-xl shadow-lg h-full" data-aos="fade-up" data-aos-delay="100">
                        <h4 class="text-xl font-bold text-nexus-blue mb-4">Investigation Workflow: Case #C-9901 (Example)</h4>
                        <p class="text-gray-500 text-sm mb-4">Update notes and upload evidence below.</p>

                        <div class="border-b border-gray-200">
                            <ul class="flex -mb-px text-sm font-medium text-center space-x-4" role="tablist">
                                <li role="presentation"><a class="inline-block p-4 border-b-2 border-nexus-blue text-nexus-blue rounded-t-lg active" data-bs-toggle="tab" href="#notes">Notes</a></li>
                                <li role="presentation"><a class="inline-block p-4 border-b-2 border-transparent hover:text-gray-600 hover:border-gray-300" data-bs-toggle="tab" href="#evidence">Evidence</a></li>
                                <li role="presentation"><a class="inline-block p-4 border-b-2 border-transparent hover:text-gray-600 hover:border-gray-300" data-bs-toggle="tab" href="#history">History</a></li>
                            </ul>
                        </div>

                        <div class="tab-content pt-4">
                            <div class="tab-pane active" id="notes">
                                <textarea class="w-full p-3 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue mb-3" rows="5" placeholder="Add investigation notes..."></textarea>
                                <button class="px-4 py-2 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition-colors text-sm"><i class="fas fa-save mr-1"></i>Save Notes</button>
                            </div>
                            <div class="tab-pane hidden" id="evidence">
                                <div class="mb-3"><label class="block text-gray-700 font-bold mb-1">Upload Files (Max 10MB)</label><input class="w-full p-2 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue" type="file" multiple></div>
                                <button class="px-4 py-2 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition-colors text-sm"><i class="fas fa-upload mr-1"></i>Upload Evidence</button>
                            </div>
                            <div class="tab-pane hidden" id="history">
                                <p class="text-gray-500 text-sm mb-1">Case creation: Jan 1, 2025.</p>
                                <p class="text-gray-500 text-sm mb-1">Status updated to UNDER_INVESTIGATION by Officer Smith: Jan 2, 2025.</p>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow-lg" data-aos="fade-up" data-aos-delay="200">
                        <h4 class="text-xl font-bold text-blue-500 mb-4"><i class="fas fa-user-circle mr-2"></i>Reporter Info</h4>
                        <div class="space-y-2 text-gray-700">
                            <p class="mb-1"><strong>Name:</strong> Jane Doe</p>
                            <p class="mb-1"><strong>Contact:</strong> <span class="px-3 py-1 bg-gray-500 text-white rounded-full text-xs font-medium">555-***-5678 (Masked)</span></p>
                            <p class="mb-1"><strong>Address:</strong> 45 Wall Street, NYC</p>
                        </div>
                        <hr class="my-4">
                        <p class="text-red-500 text-sm font-semibold mb-3"><strong>History:</strong> **1** previous false report.</p>
                        <button class="w-full px-4 py-2 border border-blue-500 text-blue-500 font-semibold rounded-lg hover:bg-blue-500 hover:text-white transition-colors text-sm mt-2"><i class="fas fa-phone-alt mr-2"></i>Contact Reporter</button>
                    </div>
                </div>
            </div>

            <!-- ======================== 4. CRIME ANALYTICS (Functional Charts) ======================== -->
            <div class="tab-pane fade hidden" id="analytics">
                <h2 class="font-bold text-3xl mb-6 text-gray-800" data-aos="fade-right"><i class="fas fa-chart-line mr-3 text-nexus-blue"></i> Crime Analytics & Trends</h2>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="bg-white p-6 rounded-xl shadow-lg" data-aos="fade-up" data-aos-delay="100">
                        <h5 class="text-xl font-bold text-nexus-blue mb-3">Crime Type Frequency (Last 30 Days)</h5>
                        <p class="text-gray-500 text-sm mb-4">Theft is the most common complaint.</p>
                        <div class="relative h-80">
                            <canvas id="crimeTypeChart"></canvas>
                        </div>
                    </div>
                    <div class="bg-white p-6 rounded-xl shadow-lg" data-aos="fade-up" data-aos-delay="200">
                        <h5 class="text-xl font-bold text-nexus-blue mb-3">Monthly Case Resolution Rate</h5>
                        <p class="text-gray-500 text-sm mb-4">Maintain a resolution rate above 70%.</p>
                        <div class="relative h-80">
                            <canvas id="resolutionRateChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ======================== 5. OFFICER PROFILE (Shell) ======================== -->
            <div class="tab-pane fade hidden" id="profile">
                <h2 class="font-bold text-3xl mb-6 text-gray-800" data-aos="fade-right"><i class="fas fa-user mr-3 text-nexus-blue"></i> Officer Profile</h2>

                <div class="bg-white p-8 rounded-xl shadow-lg max-w-lg mx-auto" data-aos="fade-up">
                    <div class="text-center mb-6">
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.user_name}&background=1C3144&color=fff&size=80"
                             class="rounded-full shadow-xl mb-3 w-20 h-20 mx-auto" alt="Avatar">
                        <h4 class="text-2xl font-bold text-gray-800">${sessionScope.user_name}</h4>
                        <p class="text-gray-500 text-sm">Officer Badge ID: **99876**</p>
                    </div>

                    <form>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-bold mb-1">Rank / Unit</label>
                            <input type="text" class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50" value="Inspector / Cyber Crime Unit" readonly>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-bold mb-1">Phone Number</label>
                            <input type="tel" class="w-full p-3 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue" value="555-123-4567">
                        </div>
                        <div class="mb-6">
                            <label class="block text-gray-700 font-bold mb-1">Station</label>
                            <input type="text" class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50" value="Central Division, Precinct 4" readonly>
                        </div>

                        <div class="space-y-3">
                            <button type="submit" class="w-full px-4 py-3 bg-green-600 text-white font-bold rounded-lg hover:bg-green-700 transition-colors"><i class="fas fa-save mr-2"></i>Update Profile</button>
                            <button type="button" class="w-full px-4 py-3 border border-red-500 text-red-500 font-bold rounded-lg hover:bg-red-500 hover:text-white transition-colors">Reset Password</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ======================== MANAGE CASE MODAL (Tailwind Styled) ======================== -->
<div class="modal fade hidden" id="manageModal" tabindex="-1" aria-labelledby="manageModalLabel" aria-hidden="true" role="dialog"
     style="background-color: rgba(0,0,0,0.5);">
    <div class="modal-dialog fixed inset-0 flex items-center justify-center p-4">
        <div class="modal-content bg-white rounded-xl shadow-2xl max-w-4xl w-full">

            <div class="bg-nexus-dark text-white p-5 rounded-t-xl flex justify-between items-center">
                <h5 class="text-xl font-bold" id="manageModalLabel"><i class="fas fa-edit mr-2"></i>Manage Case: <span id="modalCaseId"></span></h5>
                <button type="button" class="text-white hover:text-gray-300 transition" data-bs-dismiss="modal" aria-label="Close">&times;</button>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/police/updateStatus">
                <div class="p-6 space-y-6">

                    <input type="hidden" name="complaintId" id="modalComplaintId">

                    <!-- Reporter & Incident Details -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-b pb-4 border-gray-200">
                        <div class="space-y-1">
                            <h6 class="text-sm font-bold text-nexus-blue border-b border-blue-100 pb-1 mb-2">Civilian (Reporter)</h6>
                            <p class="text-sm"><strong class="text-gray-600">Reporter ID:</strong> <span id="modalReporterId" class="font-medium text-gray-800">-</span></p>
                            <p class="text-sm"><strong class="text-gray-600">Contact:</strong> <span id="modalReporterContact" class="font-medium text-gray-800">N/A</span></p>
                        </div>
                        <div class="space-y-1">
                            <h6 class="text-sm font-bold text-nexus-blue border-b border-blue-100 pb-1 mb-2">Case Info</h6>
                            <p class="text-sm"><strong class="text-gray-600">Type:</strong> <span id="modalType" class="font-medium text-gray-800">-</span></p>
                            <p class="text-sm"><strong class="text-gray-600">Date:</strong> <span id="modalDate" class="font-medium text-gray-800">-</span></p>
                        </div>
                        <div class="space-y-1">
                            <h6 class="text-sm font-bold text-nexus-blue border-b border-blue-100 pb-1 mb-2">Location & Priority</h6>
                            <p class="text-sm"><strong class="text-gray-600">Location:</strong> <span id="modalLocation" class="font-medium text-gray-800">-</span></p>
                            <p class="text-sm"><strong class="text-gray-600">Priority:</strong> <span class="inline-flex items-center px-3 py-1 bg-red-600 text-white rounded-full text-xs font-semibold" id="modalPriority"></span></p>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="bg-nexus-light p-4 rounded-lg">
                        <h6 class="font-bold text-gray-700 mb-2 text-sm">Incident Description</h6>
                        <p class="text-gray-600 text-sm" id="modalDescription">-</p>
                    </div>


                    <!-- Status Update & Assignment -->
                    <h6 class="text-lg font-bold border-b pb-2 mb-4 text-gray-700">Update Workflow</h6>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        <!-- Assign Officer -->
                        <div>
                            <label class="block text-gray-700 font-bold mb-2 text-sm">Assign Investigator</label>
                            <select name="assignTo" id="modalAssignTo" class="w-full p-3 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue">
                                <option value="">-- Select Officer --</option>
                                <%-- Populate options dynamically or hardcode for now --%>
                                <option value="101">Officer Dave (Cyber Unit)</option>
                                <option value="102">Officer Priya (General)</option>
                                <option value="${sessionScope.user_id}">Me (${sessionScope.user_name})</option>
                            </select>
                        </div>

                        <!-- Case Status -->
                        <div>
                            <label class="block text-gray-700 font-bold mb-2 text-sm">Case Status</label>
                            <select name="status" id="modalStatus" class="w-full p-3 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue" required>
                                <option value="FILED">Filed</option>
                                <option value="UNDER_REVIEW">Under Review</option>
                                <option value="UNDER_INVESTIGATION">Under Investigation</option>
                                <option value="RESOLVED">Resolved</option>
                                <option value="CLOSED">Closed</option>
                            </select>
                        </div>
                    </div>

                    <!-- Internal Notes -->
                    <div>
                        <label class="block text-gray-700 font-bold mb-2 text-sm">Internal Notes</label>
                        <textarea class="w-full p-3 border border-gray-300 rounded-lg focus:ring-nexus-blue focus:border-nexus-blue" name="notes" rows="3" placeholder="Add internal notes for this status change..."></textarea>
                    </div>

                </div>

                <div class="p-5 bg-gray-gray-50 rounded-b-xl flex justify-end space-x-3 border-t border-gray-200">
                    <button type="button" class="px-4 py-2 bg-gray-500 text-white font-semibold rounded-lg hover:bg-gray-600 transition-colors" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="px-4 py-2 bg-nexus-blue text-white font-bold rounded-lg hover:bg-blue-700 transition-colors"><i class="fas fa-upload mr-2"></i>Update Case</button>
                </div>
            </form>

        </div>
    </div>
</div>


<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // Global flag to ensure charts are only initialized once
    let chartsInitialized = false;

    // Initialize AOS for animations
    AOS.init({
        duration: 800,
        once: true
    });

    // ============================ LIVE CLOCK ===============================
    function updateLiveClock() {
        const now = new Date();
        const clockElement = document.getElementById('liveClock');
        if (clockElement) {
            clockElement.innerText = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }
    }
    setInterval(updateLiveClock, 1000);
    updateLiveClock(); // Initial call

    // ============================ KPI COUNTER ANIMATION ===============================
    const counters = document.querySelectorAll('.counter');
    const animateCounters = () => {
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target') || 0;
            const increment = Math.max(1, Math.floor(target / 50));
            const updateCounter = () => {
                const c = +counter.innerText || 0;
                if (c < target) {
                    counter.innerText = Math.min(target, Math.ceil(c + increment));
                    setTimeout(updateCounter, 15);
                } else {
                    counter.innerText = target;
                }
            };
            updateCounter();
        });
    };

    // ============================ ANALYTICS CHART INITIALIZATION ===============================
    function initAnalyticsCharts() {
        if (chartsInitialized) return;

        // --- Crime Type Frequency (Pie Chart) ---
        new Chart(document.getElementById('crimeTypeChart'), {
            type: 'doughnut',
            data: {
                labels: ['Theft', 'Assault', 'Cyber Crime', 'Missing Person', 'Vandalism'],
                datasets: [{
                    data: [35, 25, 15, 10, 15], // Mock data, replace with Servlet data
                    backgroundColor: [
                        '#008be6', // nexus-blue
                        '#1C3144', // nexus-dark
                        '#ffc107', // yellow/warning
                        '#dc3545', // red/danger
                        '#28a745'  // green/success
                    ],
                    hoverOffset: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' },
                    title: { display: false }
                }
            }
        });

        // --- Monthly Resolution Rate (Bar Chart) ---
        new Chart(document.getElementById('resolutionRateChart'), {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Resolved Cases',
                    data: [45, 60, 55, 75, 80, 72], // Mock data
                    backgroundColor: '#28a745', // Green
                    borderColor: '#28a745',
                    borderWidth: 1
                }, {
                    label: 'Total Cases',
                    data: [60, 80, 90, 100, 110, 95], // Mock data
                    backgroundColor: '#1C3144', // Dark
                    borderColor: '#1C3144',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, max: 120 }
                },
                plugins: {
                    legend: { position: 'top' },
                    title: { display: false }
                }
            }
        });

        chartsInitialized = true;
    }

    // ============================ TAB SWITCHING ===============================
    function handleTabSwitching() {
        const tabTriggers = document.querySelectorAll('[data-bs-toggle="tab"]');

        tabTriggers.forEach(trigger => {
            trigger.addEventListener('click', function(e) {
                e.preventDefault();

                const targetId = this.getAttribute('href');
                const targetPane = document.querySelector(targetId);

                if (!targetPane) return;

                // Deactivate all links and tabs
                document.querySelectorAll('.sidebar-nav a').forEach(link => {
                    link.classList.remove('active', 'bg-nexus-blue', 'sidebar-active-link');
                });

                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.add('hidden');
                    pane.classList.remove('active', 'show');
                });

                // Activate the target tab content
                targetPane.classList.remove('hidden');
                targetPane.classList.add('active', 'show');

                // If switching to overview, run counter animation again
                if (targetId === '#overview') {
                    animateCounters();
                }

                // If switching to analytics, initialize charts
                if (targetId === '#analytics') {
                    initAnalyticsCharts();
                }

                // Activate the corresponding sidebar link style
                const sidebarLink = document.querySelector(`.sidebar-nav a[href="${targetId}"]`);
                if (sidebarLink) {
                    sidebarLink.classList.add('active', 'bg-nexus-blue', 'sidebar-active-link');
                }
            });
        });

        // Set initial active state and run counter animation
        const initialActiveLink = document.querySelector('.sidebar-nav a[href="#overview"]');
        const initialActivePane = document.querySelector('#overview');
        if (initialActiveLink && initialActivePane) {
            initialActiveLink.classList.add('active', 'bg-nexus-blue', 'sidebar-active-link');
            initialActivePane.classList.remove('hidden');
            initialActivePane.classList.add('active', 'show');
            animateCounters();
        }
    }

    // ============================ MODAL SETTER (Populates detailed modal) ===============================
    document.querySelectorAll('.manageBtn').forEach(btn => {
        btn.addEventListener('click', () => {
            const id = btn.dataset.id;
            const priority = btn.dataset.priority;
            const status = btn.dataset.status;

            // Set Form Values (used for Servlet submission)
            document.getElementById('modalComplaintId').value = id;
            document.getElementById('modalCaseId').innerText = "#C-" + id;

            // Incident/Reporter Info
            document.getElementById('modalType').innerText = btn.dataset.type || 'N/A';
            document.getElementById('modalDate').innerText = btn.dataset.date || 'N/A';
            document.getElementById('modalLocation').innerText = btn.dataset.location || 'N/A';
            document.getElementById('modalDescription').innerText = btn.dataset.description || 'No description provided.';
            document.getElementById('modalReporterId').innerText = "CIV-" + (btn.dataset.regid || '-');

            // Set Priority Badge Visual
            const prioritySpan = document.getElementById('modalPriority');
            prioritySpan.innerText = priority;
            // The class is static in HTML, no need to change here unless priority classes were dynamic.

            // Set Status dropdown selection
            const statusEl = document.getElementById('modalStatus');
            if(statusEl && status) {
                statusEl.value = status;
            }

            // Ensure Modal is visible
            document.getElementById('manageModal').classList.remove('hidden');
        });
    });

    // ============================ MODAL BEHAVIOR (Tailwind Show/Hide) ===============================
    document.querySelectorAll('[data-bs-dismiss="modal"]').forEach(closer => {
        closer.addEventListener('click', () => {
            document.getElementById('manageModal').classList.add('hidden');
        });
    });

    // Run main application logic
    document.addEventListener('DOMContentLoaded', handleTabSwitching);
</script>
</body>
</html>
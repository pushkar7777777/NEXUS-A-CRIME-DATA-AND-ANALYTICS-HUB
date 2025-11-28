<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="profile" value="${sessionScope.userProfile}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - ${profile.fullName}</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'nexus-dark': '#1C3144',
                        'nexus-accent': '#00A3FF',
                        'nexus-light': '#F0F4F8',
                    },
                    fontFamily: { sans: ['Inter', 'sans-serif'] }
                }
            }
        }
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body class="bg-nexus-light min-h-screen p-6">

<!-- Back Button -->
<a href="${pageContext.request.contextPath}/civilian/dashboard"
   class="text-nexus-dark hover:text-nexus-accent font-medium inline-flex items-center mb-6">
    <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
</a>

<!-- Page Title -->
<h2 class="text-3xl font-extrabold text-nexus-dark mb-6 flex items-center">
    <i class="fas fa-user-circle mr-3 text-nexus-accent"></i> My Civilian Profile
</h2>

<div class="bg-white shadow-xl rounded-xl p-6 md:p-10">

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- LEFT SIDE: PHOTO + STATUS -->
        <div class="lg:border-r lg:pr-8 border-gray-200">
            <div class="flex flex-col items-center">

                <!-- Profile Image -->
                <img src="${pageContext.request.contextPath}/uploads/profile/profile_${profile.regId}.jpg"
                     onerror="this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png'"
                     class="w-32 h-32 rounded-full object-cover border-4 border-nexus-accent shadow-md mb-4">

                <h3 class="text-xl font-bold text-nexus-dark mt-4">${profile.fullName}</h3>

                <!-- STATUS BADGE -->
                <span class="mt-3 px-3 py-1 rounded-full text-xs font-semibold
                    <c:choose>
                        <c:when test='${profile.status == "VERIFIED"}'> bg-green-100 text-green-800 </c:when>
                        <c:otherwise> bg-yellow-100 text-yellow-800 </c:otherwise>
                    </c:choose>">
                    ${profile.status}
                </span>

                <!-- FIXED DETAILS -->
                <div class="mt-6 w-full text-center">
                    <p class="text-sm text-gray-600 font-medium border-t pt-3">
                        <i class="fas fa-id-card mr-2"></i> National ID:
                        <span class="font-bold text-gray-900 block">${profile.nationalId}</span>
                    </p>
                    <p class="text-sm text-gray-600 font-medium pt-3">
                        <i class="fas fa-calendar-alt mr-2"></i> Joined:
                        <span class="font-bold text-gray-900 block">
                            <fmt:formatDate value="${profile.createdAt}" pattern="MMM dd, yyyy"/>
                        </span>
                    </p>
                </div>

            </div>
        </div>

        <!-- RIGHT SIDE: ONLY DETAILS (NO EDITING) -->
        <div class="lg:col-span-2">

            <h3 class="text-2xl font-bold text-nexus-dark mb-6 border-b pb-3">
                <i class="fas fa-id-badge mr-2 text-nexus-accent"></i>
                Civilian Details
            </h3>

            <div class="space-y-4">

                <!-- EMAIL -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">Email</label>
                    <p class="p-3 bg-gray-100 rounded-lg">${profile.email}</p>
                </div>

                <!-- PHONE -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">Phone</label>
                    <p class="p-3 bg-gray-100 rounded-lg">${profile.phone}</p>
                </div>

                <!-- DOB -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">Date of Birth</label>
                    <p class="p-3 bg-gray-100 rounded-lg">${profile.dateOfBirth}</p>
                </div>

                <!-- GENDER -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">Gender</label>
                    <p class="p-3 bg-gray-100 rounded-lg">${profile.gender}</p>
                </div>

                <!-- CHANGE PASSWORD LINK -->
                <div class="pt-4 border-t">
                    <a href="#" onclick="togglePasswordModal(true)"
                       class="text-sm text-red-500 hover:text-red-700 hover:underline">
                        <i class="fas fa-lock mr-2"></i> Change Password
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>


<!-- Include your password modal (previous response) below -->
<!-- ... -->


</body>
</html>

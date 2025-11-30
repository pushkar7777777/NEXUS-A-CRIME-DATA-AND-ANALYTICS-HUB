<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    // AUTH GUARD (recommended)
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("role") == null || !"ADMIN".equals(sess.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Civilian Details</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        .container-box {
            max-width: 650px;
            margin-top: 40px;
        }
    </style>
</head>

<body class="bg-light">

<div class="container container-box bg-white shadow p-4 rounded">

    <h3 class="mb-4 text-primary fw-bold">
        <i class="fas fa-user-edit me-2"></i>Edit Civilian Details
    </h3>

    <!-- Get the civilian model -->
    <c:set var="civ" value="${civilian}" />

    <form method="post" action="${pageContext.request.contextPath}/UpdateCivilianServlet">

        <!-- Hidden regId -->
        <input type="hidden" name="regId" value="${civ.regId}" />

        <!-- Full Name -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Full Name</label>
            <input type="text" name="fullName" class="form-control"
                   value="${civ.fullName}" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Email</label>
            <input type="email" name="email" class="form-control"
                   value="${civ.email}" required>
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Phone</label>
            <input type="text" name="phone" class="form-control"
                   value="${civ.phone}">
        </div>

        <!-- National ID -->
        <div class="mb-3">
            <label class="form-label fw-semibold">National ID</label>
            <input type="text" name="nationalId" class="form-control"
                   value="${civ.nationalId}">
        </div>

        <!-- Gender -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Gender</label>
            <select name="gender" class="form-select">
                <option value="Male"   <c:if test="${civ.gender == 'Male'}">selected</c:if>>Male</option>
                <option value="Female" <c:if test="${civ.gender == 'Female'}">selected</c:if>>Female</option>
                <option value="Other"  <c:if test="${civ.gender == 'Other'}">selected</c:if>>Other</option>
            </select>
        </div>

        <!-- Date of Birth -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Date of Birth</label>

            <input type="date" name="dateOfBirth" class="form-control"
                   value="${civ.dateOfBirth}">
        </div>

        <!-- Status -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Status</label>
            <select name="status" class="form-select">
                <option value="PENDING"
                        <c:if test="${civ.status == 'PENDING'}">selected</c:if>>PENDING</option>

                <option value="VERIFIED"
                        <c:if test="${civ.status == 'VERIFIED'}">selected</c:if>>VERIFIED</option>

                <option value="SUSPENDED"
                        <c:if test="${civ.status == 'SUSPENDED'}">selected</c:if>>SUSPENDED</option>
            </select>
        </div>

        <!-- Buttons -->
        <div class="mt-4">
            <button type="submit" class="btn btn-primary px-4">
                Save Changes
            </button>

            <a href="${pageContext.request.contextPath}/admin/user-management"
               class="btn btn-secondary px-4">
                Cancel
            </a>
        </div>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

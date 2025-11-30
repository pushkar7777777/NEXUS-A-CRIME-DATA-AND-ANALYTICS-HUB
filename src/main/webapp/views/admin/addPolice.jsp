<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Police Officer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <div class="card shadow-lg p-4">
        <h3 class="text-primary mb-4"><i class="fas fa-user-shield me-2"></i>Add Police Officer</h3>

        <form action="${pageContext.request.contextPath}/admin/add-police" method="post">

            <div class="mb-3">
                <label class="form-label">Full Name *</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email *</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone *</label>
                <input type="text" name="phone" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Rank *</label>
                <input type="text" name="rankDetails" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Police Station ID *</label>
                <input type="number" name="policeStationId" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Temporary Password *</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <button class="btn btn-primary mt-2">Add Officer</button>
            <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-secondary mt-2">Cancel</a>
        </form>
    </div>

</div>

</body>
</html>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="c" value="${complaint}" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Details</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background: #f5f7fa;
        }

        .details-card {
            max-width: 850px;
            margin: auto;
            border-radius: 12px;
            overflow: hidden;
        }

        .section-title {
            font-size: 1.1rem;
            margin-top: 25px;
            font-weight: 700;
            color: #1C3144;
        }

        .value-box {
            background: #f1f4f8;
            padding: 10px 14px;
            border-radius: 8px;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <div class="card shadow-lg details-card">

        <!-- HEADER -->
        <div class="card-header bg-primary text-white py-3">
            <h4 class="mb-0">
                <i class="fas fa-folder-open me-2"></i>
                Complaint #N-${c.complaintId}
            </h4>
        </div>

        <!-- BODY -->
        <div class="card-body p-4">

            <!-- Complaint Info -->
            <div class="section-title">Complaint Info</div>
            <hr>

            <div class="value-box"><strong>Type:</strong> ${c.complaintType}</div>
            <div class="value-box"><strong>Urgency:</strong> ${c.urgencyLevel}</div>
            <div class="value-box"><strong>Status:</strong> ${c.currentStatus}</div>

            <div class="value-box">
                <strong>Date Filed:</strong>
                <c:choose>
                    <c:when test="${c.dateFiled != null}">
                        ${c.dateFiled}
                    </c:when>
                    <c:otherwise>
                        N/A
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Location Information -->
            <div class="section-title">Location Information</div>
            <hr>

            <div class="value-box"><strong>Location:</strong> ${c.locationOfIncident}</div>
            <div class="value-box"><strong>Latitude:</strong> ${c.latitude}</div>
            <div class="value-box"><strong>Longitude:</strong> ${c.longitude}</div>

            <!-- Description -->
            <div class="section-title">Description</div>
            <hr>
            <p class="value-box">${c.description}</p>

            <!-- Suspect Details -->
            <div class="section-title">Suspect Details</div>
            <hr>
            <p class="value-box">${c.suspectDetails}</p>

            <!-- Victim Details -->
            <div class="section-title">Victim Details</div>
            <hr>
            <p class="value-box">${c.victimDetails}</p>

            <!-- Filed By -->
            <div class="section-title">Filed By</div>
            <hr>
            <p class="value-box">${c.filedBy}</p>

            <!-- Back Button -->
            <a href="${pageContext.request.contextPath}/admin/complaint-monitor"
               class="btn btn-secondary mt-3">
                <i class="fa fa-arrow-left me-2"></i> Back
            </a>

        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

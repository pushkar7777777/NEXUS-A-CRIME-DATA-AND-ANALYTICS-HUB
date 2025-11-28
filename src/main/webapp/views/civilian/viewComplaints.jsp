<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Complaints</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        // Configure Tailwind to recognize the custom Nexus Blue color
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'nexus-blue': '#0055a4', // Custom color definition
                    },
                    // Use a stronger hover state for the custom color
                    boxShadow: {
                        'nexus-focus': '0 0 0 3px rgba(0, 85, 164, 0.5)',
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>

<body class="bg-gray-50 min-h-screen">
<div class="container mx-auto p-4 sm:p-6 lg:p-8">

    <h2 class="text-3xl font-extrabold text-gray-900 mb-6 flex items-center">
        <i class="fas fa-list-ul mr-3 text-nexus-blue"></i>
        All Complaints Filed by You
    </h2>

    <div class="bg-white shadow-xl rounded-lg overflow-hidden">
        <div class="p-4 sm:p-6">

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200 border border-gray-200 rounded-lg">
                    <thead class="bg-nexus-blue text-white">
                    <tr>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">ID</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Type</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Date of Incident</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Location</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Latitude</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Longitude</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Description</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Suspect Details</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Victim Details</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Urgency</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Date Filed</th>
                        <th class="px-4 py-3 text-left text-sm font-semibold tracking-wider">Status</th>
                    </tr>
                    </thead>

                    <tbody class="bg-white divide-y divide-gray-200">

                    <c:forEach var="c" items="${complaints}">
                        <tr class="hover:bg-gray-50 transition duration-150 ease-in-out">
                            <td class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900"> ${c.complaintId}</td>
                            <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-700">${c.complaintType}</td>
                            <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-700">${c.dateOfIncident}</td>
                            <td class="px-4 py-3 text-sm text-gray-700">${c.locationOfIncident}</td>
                            <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-700">${c.latitude}</td>
                            <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-700">${c.longitude}</td>
                            <td class="px-4 py-3 text-sm text-gray-700 max-w-xs overflow-hidden truncate" title="${c.description}">${c.description}</td>
                            <td class="px-4 py-3 text-sm text-gray-700 max-w-xs overflow-hidden truncate" title="${c.suspectDetails}">${c.suspectDetails}</td>
                            <td class="px-4 py-3 text-sm text-gray-700 max-w-xs overflow-hidden truncate" title="${c.victimDetails}">${c.victimDetails}</td>

                            <td class="px-4 py-3 whitespace-nowrap text-sm">
                                <span class="inline-flex items-center px-3 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-800">
                                        ${c.urgencyLevel}
                                </span>
                            </td>

                            <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-700">${c.dateFiled}</td>

                            <td class="px-4 py-3 whitespace-nowrap text-sm">
                                <span class="inline-flex items-center px-3 py-0.5 rounded-full text-xs font-semibold
                                    <c:choose>
                                        <c:when test='${c.currentStatus == "RESOLVED"}'>bg-green-100 text-green-800</c:when>
                                        <c:when test='${c.currentStatus == "UNDER_INVESTIGATION"}'>bg-yellow-100 text-yellow-800</c:when>
                                        <c:when test='${c.currentStatus == "UNDER_REVIEW"}'>bg-blue-100 text-blue-800</c:when>
                                        <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                    </c:choose>
                                ">
                                        ${c.currentStatus}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty complaints}">
                        <tr>
                            <td colspan="12" class="px-4 py-12 text-center text-lg font-medium text-gray-500 bg-gray-50">
                                <i class="fas fa-file-invoice mr-2"></i>
                                No Complaints Found
                            </td>
                        </tr>
                    </c:if>

                    </tbody>
                </table>
            </div>
            <a href="${pageContext.request.contextPath}/civilian/dashboard"
               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-nexus-blue hover:bg-[#004d7a] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-nexus-blue mt-6 transition duration-150 ease-in-out">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Dashboard
            </a>

        </div>
    </div>
</div>

</body>
</html>
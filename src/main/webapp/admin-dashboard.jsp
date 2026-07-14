<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - DormDesk</title>
    <link href="assets/css/tailwind.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-50 text-gray-800 transition-colors duration-300 flex">
    
    <!-- Sidebar -->
    <aside class="glass w-64 h-screen sticky top-0 flex flex-col justify-between hidden md:flex border-r border-gray-200">
        <div>
            <div class="h-16 flex items-center px-6 border-b border-gray-200/50">
                <img src="assets/images/logo.png" alt="DormDesk Logo" class="h-8 w-auto mr-2">
                <span class="font-bold text-lg text-gray-800">Admin Panel</span>
            </div>
            <nav class="p-4 space-y-2">
                <a href="#" class="flex items-center px-4 py-3 bg-green-50 text-green-700 rounded-lg transition">
                    <i class="fa-solid fa-chart-line mr-3"></i> Overview
                </a>
                <a href="#complaints" class="flex items-center px-4 py-3 text-gray-600 hover:bg-gray-100 rounded-lg transition">
                    <i class="fa-solid fa-list-check mr-3"></i> Manage Complaints
                </a>
            </nav>
        </div>
        <div class="p-4 border-t border-gray-200/50">
            <div class="flex items-center mb-4 px-4">
                <div class="w-8 h-8 rounded-full bg-green-600 flex items-center justify-center text-white font-bold mr-3">
                    A
                </div>
                <div class="text-sm">
                    <div class="font-medium text-gray-800">${sessionScope.user.name}</div>
                    <div class="text-gray-500">Administrator</div>
                </div>
            </div>
            <a href="auth?action=logout" class="flex items-center justify-center w-full px-4 py-2 text-sm text-red-600 bg-red-50 hover:bg-red-100 rounded-lg transition">
                <i class="fa-solid fa-arrow-right-from-bracket mr-2"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 p-8 overflow-y-auto w-full">
        <header class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-gray-900">System Overview</h1>
            <button id="theme-toggle" class="p-2 rounded-full bg-white shadow-sm border border-gray-200 hover:bg-gray-50 transition">
                <i class="fa-solid fa-moon text-gray-600"></i>
            </button>
        </header>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-green-500 hover-scale">
                <p class="text-sm text-gray-500 mb-1">Total Complaints</p>
                <h3 class="text-3xl font-bold text-gray-800">${totalComplaints}</h3>
            </div>
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-red-500 hover-scale">
                <p class="text-sm text-gray-500 mb-1">Pending</p>
                <h3 class="text-3xl font-bold text-gray-800">${pendingComplaints}</h3>
            </div>
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-cyan-500 hover-scale">
                <p class="text-sm text-gray-500 mb-1">In Progress</p>
                <h3 class="text-3xl font-bold text-gray-800">${inProgressComplaints}</h3>
            </div>
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-green-500 hover-scale">
                <p class="text-sm text-gray-500 mb-1">Resolved</p>
                <h3 class="text-3xl font-bold text-gray-800">${resolvedComplaints}</h3>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8">
            <!-- Chart Section -->
            <div class="lg:col-span-2 glass p-6 rounded-2xl shadow-sm">
                <h2 class="text-xl font-bold mb-4 border-b pb-2 text-gray-800">Complaint Status Distribution</h2>
                <div class="h-64 flex justify-center items-center">
                    <canvas id="statusChart"></canvas>
                </div>
            </div>
            <div class="lg:col-span-1 glass p-6 rounded-2xl shadow-sm bg-green-600 text-white border-0">
                <h2 class="text-xl font-bold mb-4 border-b border-green-400 pb-2">Quick Actions</h2>
                <ul class="space-y-4">
                    <li><button class="w-full bg-white/10 hover:bg-white/20 text-left px-4 py-3 rounded-lg transition"><i class="fa-solid fa-file-export mr-2"></i> Export Monthly Report</button></li>
                    <li><button onclick="window.print()" class="w-full bg-white/10 hover:bg-white/20 text-left px-4 py-3 rounded-lg transition"><i class="fa-solid fa-print mr-2"></i> Print Tasks List</button></li>
                    <li>
                        <form action="notification" method="POST" id="notifForm">
                            <input type="hidden" name="message" id="notifMessage">
                            <button type="button" onclick="const msg = prompt('Enter Alert Message for Wardens:'); if(msg) { document.getElementById('notifMessage').value = msg; document.getElementById('notifForm').submit(); }" class="w-full bg-white/10 hover:bg-white/20 text-left px-4 py-3 rounded-lg transition"><i class="fa-solid fa-bell mr-2"></i> Send Notification</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Recent Notifications -->
        <c:if test="${not empty notifications}">
        <div class="glass p-6 rounded-2xl shadow-sm mb-8 animate-fade-in border-l-4 border-yellow-500 bg-yellow-50/50">
            <h2 class="text-xl font-bold mb-4 border-b border-yellow-200 pb-2 text-yellow-800"><i class="fa-solid fa-bullhorn mr-2"></i>Warden Alerts</h2>
            <div class="space-y-3">
                <c:forEach var="n" items="${notifications}">
                    <div class="bg-white p-3 rounded shadow-sm border border-yellow-100 flex justify-between items-start">
                        <div>
                            <p class="font-medium text-gray-800">${n.message}</p>
                            <p class="text-xs text-gray-500 mt-1">Sent by ${n.senderName}</p>
                        </div>
                        <span class="text-xs text-gray-400 whitespace-nowrap ml-4">${n.date.toString().substring(0,16)}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
        </c:if>

        <!-- Manage Complaints Table -->
        <div id="complaints" class="glass p-6 rounded-2xl shadow-sm overflow-x-auto">
            <h2 class="text-xl font-bold mb-4 border-b pb-2 text-gray-800">Assign & Manage Complaints</h2>
            
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="text-sm text-gray-500 border-b">
                        <th class="py-3 px-4 font-medium">ID / Category</th>
                        <th class="py-3 px-4 font-medium">Description</th>
                        <th class="py-3 px-4 font-medium">Priority</th>
                        <th class="py-3 px-4 font-medium">Status / Action</th>
                    </tr>
                </thead>
                <tbody class="text-sm">
                    <c:forEach var="c" items="${complaints}">
                        <tr class="border-b border-gray-100 hover:bg-gray-50/50 transition">
                            <td class="py-3 px-4">
                                <div class="font-medium text-gray-800">${c.category}</div>
                                <div class="text-xs text-green-600 bg-green-50 font-semibold px-2 py-0.5 rounded inline-block mt-1 mb-1">${c.hostelType} - ${c.blockName}</div>
                                <div class="text-xs text-gray-400">User ID: ${c.userId}</div>
                            </td>
                            <td class="py-3 px-4 text-gray-600 max-w-xs">
                                <div class="truncate" title="${c.description}">${c.description}</div>
                                <c:if test="${not empty c.imageBase64}">
                                    <div class="mt-2 text-center">
                                        <a href="${c.imageBase64}" target="_blank">
                                            <img src="${c.imageBase64}" alt="Complaint Image" class="max-h-24 rounded border shadow-sm mx-auto hover:opacity-80 transition cursor-pointer">
                                        </a>
                                    </div>
                                </c:if>
                            </td>
                            <td class="py-3 px-4">
                                <c:choose>
                                    <c:when test="${c.priority == 'High'}"><span class="bg-red-100 text-red-800 text-xs px-2 py-1 rounded-full font-semibold">High</span></c:when>
                                    <c:when test="${c.priority == 'Medium'}"><span class="bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full font-semibold">Medium</span></c:when>
                                    <c:otherwise><span class="bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full font-semibold">Low</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4">
                                <span class="mb-2 block ${c.status == 'Resolved' ? 'text-green-600' : 'text-gray-600'} font-medium">
                                    Current: ${c.status}
                                </span>
                                <c:if test="${c.status != 'Resolved'}">
                                    <form action="complaint" method="POST" class="flex gap-2">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="complaintId" value="${c.id}">
                                        <select name="status" class="text-xs border rounded p-1 bg-white">
                                            <option value="Pending" ${c.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="In Progress" ${c.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Resolved">Resolved</option>
                                        </select>
                                        <button type="submit" class="bg-green-600 hover:bg-green-700 text-white text-xs px-2 py-1 rounded">Update</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <div id="toast-container"></div>
    <script src="assets/js/main.js"></script>
    
    <script>
        // Chart.js implementation
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('statusChart').getContext('2d');
            const statusChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Pending', 'In Progress', 'Resolved'],
                    datasets: [{
                        data: [${pendingComplaints}, ${inProgressComplaints}, ${resolvedComplaints}],
                        backgroundColor: [
                            '#EF4444', // Red
                            '#F59E0B', // Amber
                            '#10B981'  // Green
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: 'bottom' }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
</body>
</html>

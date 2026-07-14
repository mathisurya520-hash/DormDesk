<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - DormDesk</title>
    <link href="assets/css/tailwind.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 text-gray-800 transition-colors duration-300 flex">
    
    <!-- Sidebar -->
    <aside class="glass w-64 h-screen sticky top-0 flex flex-col justify-between hidden md:flex border-r border-gray-200">
        <div>
            <div class="h-16 flex items-center px-6 border-b border-gray-200/50">
                <img src="assets/images/logo.png" alt="DormDesk Logo" class="h-8 w-auto mr-2">
                <span class="font-bold text-lg text-gray-800">Student Panel</span>
            </div>
            <nav class="p-4 space-y-2">
                <a href="#" class="flex items-center px-4 py-3 bg-green-50 text-green-700 rounded-lg transition">
                    <i class="fa-solid fa-chart-pie mr-3"></i> Dashboard
                </a>
                <a href="#history" class="flex items-center px-4 py-3 text-gray-600 hover:bg-gray-100 rounded-lg transition">
                    <i class="fa-solid fa-list mr-3"></i> History
                </a>
            </nav>
        </div>
        <div class="p-4 border-t border-gray-200/50">
            <div class="flex items-center mb-4 px-4">
                <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center text-green-600 font-bold mr-3">
                    ${sessionScope.user.name.charAt(0)}
                </div>
                <div class="text-sm">
                    <div class="font-medium text-gray-800">${sessionScope.user.name}</div>
                    <div class="text-xs font-semibold text-green-600 bg-green-50 inline-block px-2 py-1 rounded mt-1">${sessionScope.user.hostelType} - ${sessionScope.user.blockName}</div>
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
            <h1 class="text-3xl font-bold text-gray-900">Welcome, ${sessionScope.user.name}</h1>
            <button id="theme-toggle" class="p-2 rounded-full bg-white shadow-sm border border-gray-200 hover:bg-gray-50 transition">
                <i class="fa-solid fa-moon text-gray-600"></i>
            </button>
        </header>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-green-500 hover-scale">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 mb-1">Total Complaints</p>
                        <h3 class="text-3xl font-bold text-gray-800">${totalComplaints}</h3>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center">
                        <i class="fa-solid fa-folder text-green-500 text-xl"></i>
                    </div>
                </div>
            </div>
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-yellow-500 hover-scale">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 mb-1">Pending</p>
                        <h3 class="text-3xl font-bold text-gray-800">${pendingComplaints}</h3>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-yellow-100 flex items-center justify-center">
                        <i class="fa-solid fa-clock text-yellow-500 text-xl"></i>
                    </div>
                </div>
            </div>
            <div class="glass p-6 rounded-2xl shadow-sm border-l-4 border-green-500 hover-scale">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 mb-1">Resolved</p>
                        <h3 class="text-3xl font-bold text-gray-800">${resolvedComplaints}</h3>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center">
                        <i class="fa-solid fa-check-circle text-green-500 text-xl"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Add Complaint Form -->
            <div class="lg:col-span-1 glass p-6 rounded-2xl shadow-sm">
                <h2 class="text-xl font-bold mb-4 border-b pb-2 text-gray-800">Lodge a Complaint</h2>
                <form action="complaint" method="POST" enctype="multipart/form-data" class="space-y-4">
                    <input type="hidden" name="action" value="add">
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                        <select name="category" required class="w-full p-2 border border-gray-300 rounded focus:ring-green-500 focus:border-green-500 bg-white/50">
                            <option value="Electrical">Electrical</option>
                            <option value="Plumbing">Plumbing</option>
                            <option value="Carpentry">Carpentry</option>
                            <option value="Internet/WiFi">Internet/WiFi</option>
                            <option value="Cleaning">Cleaning</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                        <textarea name="description" rows="4" required placeholder="Describe your issue detailedly..." class="w-full p-2 border border-gray-300 rounded focus:ring-green-500 focus:border-green-500 bg-white/50"></textarea>
                    </div>
                    
                    <label class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center cursor-pointer block hover:bg-gray-50 transition" id="upload-label">
                        <i class="fa-solid fa-cloud-arrow-up text-gray-400 text-3xl mb-2"></i>
                        <p id="upload-text" class="text-sm text-gray-500">Upload Image (Optional)</p>
                        <input type="file" name="image" class="hidden" accept="image/*" onchange="document.getElementById('upload-text').innerText = this.files[0].name; document.getElementById('upload-label').classList.add('bg-green-50', 'border-green-300');">
                    </label>

                    <p class="text-xs text-gray-500 italic"><i class="fa-solid fa-robot mr-1"></i> Our AI will automatically assign priority based on keywords.</p>

                    <button type="submit" class="w-full bg-green-600 text-white font-medium py-2 px-4 rounded hover:bg-green-700 transition">
                        Submit Complaint
                    </button>
                </form>
            </div>

            <!-- Complaint History Table -->
            <div id="history" class="lg:col-span-2 glass p-6 rounded-2xl shadow-sm overflow-x-auto">
                <h2 class="text-xl font-bold mb-4 border-b pb-2 text-gray-800">Complaint History</h2>
                
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-sm text-gray-500 border-b">
                            <th class="py-3 px-4 font-medium">Category</th>
                            <th class="py-3 px-4 font-medium">Description</th>
                            <th class="py-3 px-4 font-medium">Priority</th>
                            <th class="py-3 px-4 font-medium">Status</th>
                            <th class="py-3 px-4 font-medium">Date</th>
                        </tr>
                    </thead>
                    <tbody class="text-sm">
                        <c:forEach var="c" items="${complaints}">
                            <tr class="border-b border-gray-100 hover:bg-gray-50/50 transition">
                                <td class="py-3 px-4 font-medium text-gray-800">${c.category}</td>
                                <td class="py-3 px-4 text-gray-600 truncate max-w-xs">${c.description}</td>
                                <td class="py-3 px-4">
                                    <c:choose>
                                        <c:when test="${c.priority == 'High'}"><span class="bg-red-100 text-red-800 text-xs px-2 py-1 rounded-full font-semibold">High</span></c:when>
                                        <c:when test="${c.priority == 'Medium'}"><span class="bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full font-semibold">Medium</span></c:when>
                                        <c:otherwise><span class="bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full font-semibold">Low</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-3 px-4">
                                    <c:choose>
                                        <c:when test="${c.status == 'Resolved'}"><span class="text-green-600 font-medium"><i class="fa-solid fa-check mr-1"></i> Resolved</span></c:when>
                                        <c:when test="${c.status == 'In Progress'}"><span class="text-cyan-600 font-medium"><i class="fa-solid fa-spinner animate-spin mr-1"></i> In Progress</span></c:when>
                                        <c:otherwise><span class="text-yellow-600 font-medium"><i class="fa-solid fa-clock mr-1"></i> Pending</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-3 px-4 text-gray-500">${c.date.toString().substring(0,10)}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty complaints}">
                            <tr>
                                <td colspan="5" class="py-8 text-center text-gray-500">No complaints lodged yet.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div id="toast-container"></div>
    <script src="assets/js/main.js"></script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DormDesk AI-Enabled Complaint System</title>
    <!-- Tailwind CSS -->
    <link href="assets/css/tailwind.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/style.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="min-h-screen bg-gradient-to-br from-green-50 to-yellow-50 transition-colors duration-300">

    <!-- Navigation -->
    <nav class="glass sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="flex-shrink-0 flex items-center">
                    <img src="assets/images/logo.png" alt="DormDesk Logo" class="h-10 w-auto mr-3">
                    <span class="font-bold text-xl text-gray-800">DormDesk</span>
                </div>
                <div class="flex items-center space-x-4">
                    <button id="theme-toggle" class="p-2 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700 transition">
                        <i class="fa-solid fa-moon text-gray-600 dark:text-gray-300"></i>
                    </button>
                    <a href="login.jsp" class="text-green-600 hover:text-green-900 font-medium px-3 py-2">Login</a>
                    <a href="register.jsp" class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-md font-medium shadow-md transition-transform hover:scale-105">Get Started</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 flex flex-col md:flex-row items-center animate-fade-in">
        <div class="md:w-1/2 mb-10 md:mb-0">
            <h1 class="text-5xl md:text-6xl font-extrabold text-gray-900 tracking-tight leading-tight mb-6">
                Revolutionize your <span class="text-transparent bg-clip-text bg-gradient-to-r from-green-600 to-yellow-600">Hostel Experience</span>
            </h1>
            <p class="text-xl text-gray-600 mb-8 leading-relaxed">
                Our AI-Powered DormDesk Complaint Management System auto-categorizes, prioritizes, and assigns issues to ensure lightning-fast resolutions.
            </p>
            <div class="flex space-x-4">
                <a href="login.jsp" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-8 rounded-full shadow-lg transition-transform hover:-translate-y-1">
                    Enter Portal
                </a>
            </div>
        </div>
        
        <!-- Hero Graphic (Glassmorphism card) -->
        <div class="md:w-1/2 relative flex justify-center mt-10 md:mt-0">
            <div class="glass w-full max-w-md rounded-2xl p-8 relative z-10 shadow-2xl hover-scale">
                <div class="flex items-center space-x-4 mb-6">
                    <div class="w-12 h-12 rounded-full bg-red-100 flex items-center justify-center text-red-500">
                        <i class="fa-solid fa-droplet"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-gray-800">Water Leakage</h3>
                        <p class="text-sm text-gray-500">Auto-assigned Priority: <span class="text-red-500 font-semibold">High</span></p>
                    </div>
                </div>
                <div class="h-2 bg-gray-200 rounded-full mb-2">
                    <div class="h-2 bg-green-600 rounded-full w-3/4"></div>
                </div>
                <p class="text-xs text-gray-500 text-right mb-6">Admin notified...</p>
                
                <div class="flex items-center space-x-4">
                    <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center text-green-500">
                        <i class="fa-solid fa-wifi"></i>
                    </div>
                    <div>
                        <h3 class="font-bold text-gray-800">Slow Internet</h3>
                        <p class="text-sm text-gray-500">Status: <span class="text-green-500 font-semibold">Resolved</span></p>
                    </div>
                </div>
            </div>
            
            <!-- Decorative blobs -->
            <div class="absolute top-0 right-10 w-64 h-64 bg-yellow-300 rounded-full mix-blend-multiply filter blur-3xl opacity-50 animate-blob"></div>
            <div class="absolute top-20 left-10 w-64 h-64 bg-green-300 rounded-full mix-blend-multiply filter blur-3xl opacity-50 animate-blob animation-delay-2000"></div>
        </div>
    </main>

    <!-- Features Section -->
    <section class="bg-white py-20 dark:bg-gray-900 transition-colors duration-300">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-extrabold text-gray-900 dark:text-white">Smart Features Built for Efficiency</h2>
                <p class="mt-4 text-xl text-gray-500 dark:text-gray-400">Everything you need to manage your hostel flawlessly.</p>
            </div>
            
            <div class="grid md:grid-cols-3 gap-10">
                <div class="glass p-8 rounded-xl hover-scale">
                    <i class="fa-solid fa-brain text-4xl text-yellow-600 mb-4"></i>
                    <h3 class="text-xl font-bold mb-2">AI Prioritization</h3>
                    <p class="text-gray-600 dark:text-gray-400">Our Smart Factory Pattern automatically scans descriptions to assign High, Medium, or Low priority.</p>
                </div>
                <div class="glass p-8 rounded-xl hover-scale">
                    <i class="fa-solid fa-bolt text-4xl text-yellow-500 mb-4"></i>
                    <h3 class="text-xl font-bold mb-2">Real-time Updates</h3>
                    <p class="text-gray-600 dark:text-gray-400">Students get instant feedback when complaints move from Pending to In Progress to Resolved.</p>
                </div>
                <div class="glass p-8 rounded-xl hover-scale">
                    <i class="fa-solid fa-chart-pie text-4xl text-green-500 mb-4"></i>
                    <h3 class="text-xl font-bold mb-2">Data-Driven Dashboard</h3>
                    <p class="text-gray-600 dark:text-gray-400">Admins have complete oversight with unified charts and historical data overview.</p>
                </div>
            </div>
        </div>
    </section>

    <div id="toast-container"></div>
    <script src="assets/js/main.js"></script>
</body>
</html>

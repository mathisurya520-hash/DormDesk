<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - DormDesk</title>
    <link href="assets/css/tailwind.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-primary transition-colors duration-300 py-10">
    <button id="theme-toggle" class="absolute top-5 right-5 p-2 rounded-full text-white hover:bg-white/20 transition">
        <i class="fa-solid fa-moon text-xl"></i>
    </button>

    <div class="glass w-full max-w-md p-8 rounded-2xl shadow-2xl animate-fade-in relative z-10">
        <div class="text-center mb-8">
            <i class="fa-solid fa-user-plus text-green-200 text-4xl mb-2"></i>
            <h2 class="text-3xl font-bold text-gray-800">Create Account</h2>
            <p class="text-gray-500 mt-2">Join the DormDesk platform.</p>
        </div>

        <form action="auth" method="POST" class="space-y-5">
            <input type="hidden" name="action" value="register">
            
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa-solid fa-user text-gray-400"></i>
                    </div>
                    <input type="text" id="name" name="name" required
                        class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 bg-white/50">
                </div>
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa-solid fa-envelope text-gray-400"></i>
                    </div>
                    <input type="email" id="email" name="email" required
                        class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 bg-white/50">
                </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa-solid fa-lock text-gray-400"></i>
                    </div>
                    <input type="password" id="password" name="password" required
                        class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 bg-white/50">
                </div>
            </div>

            <div>
                <label for="hostelType" class="block text-sm font-medium text-gray-700 mb-1">Hostel Type</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa-solid fa-building text-gray-400"></i>
                    </div>
                    <select id="hostelType" name="hostelType" onchange="updateBlocks()" required class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 bg-white/50">
                        <option value="">Select Hostel Phase</option>
                        <option value="Boys Hostel">Boys Hostel</option>
                        <option value="Girls Hostel">Girls Hostel</option>
                    </select>
                </div>
            </div>

            <div>
                <label for="blockName" class="block text-sm font-medium text-gray-700 mb-1">Block / Section</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fa-solid fa-door-open text-gray-400"></i>
                    </div>
                    <select id="blockName" name="blockName" required class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 bg-white/50">
                        <option value="">Please select a hostel first</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors mt-6">
                Register <i class="fa-solid fa-arrow-right ml-2 mt-1"></i>
            </button>
        </form>

        <p class="mt-6 text-center text-sm text-gray-600">
            Already have an account? 
            <a href="login.jsp" class="font-medium text-green-600 hover:text-green-500 transition-colors">Sign in here</a>
        </p>
    </div>
    
    <script>
        function updateBlocks() {
            const hostelType = document.getElementById("hostelType").value;
            const blockSelect = document.getElementById("blockName");
            blockSelect.innerHTML = ""; // Clear existing options

            if (hostelType === "Boys Hostel") {
                const boysBlocks = ["Block A", "Block B", "Block C", "Block D", "Block E"];
                boysBlocks.forEach(b => blockSelect.add(new Option(b, b)));
            } else if (hostelType === "Girls Hostel") {
                const girlsBlocks = ["MCA", "Main"];
                girlsBlocks.forEach(b => blockSelect.add(new Option(b, b)));
            } else {
                blockSelect.add(new Option("Please select a hostel first", ""));
            }
        }
    </script>
    <script src="assets/js/main.js"></script>
</body>
</html>

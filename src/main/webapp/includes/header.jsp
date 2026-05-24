<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<div class="navbar">
    <a href="index.jsp" class="nav-brand"><i class="fa-solid fa-utensils"></i> GrandEats</a>

    <% if(session.getAttribute("userEmail") == null) { %>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="menu.jsp">Menu</a>
            <a href="about.jsp">About Us</a>
            <a href="contact.jsp">Contact Us</a>
        </div>
    <% } %>

    <div class="nav-right">
        <button class="theme-toggle" onclick="toggleTheme()" title="Switch Theme">
            <i id="theme-icon" class="fa-solid fa-moon"></i>
        </button>

        <% if(session.getAttribute("userEmail") != null) { %>
            <a href="dashboard.jsp" class="btn btn-outline"><i class="fa-solid fa-chart-line"></i> Dashboard</a>
            <a href="LogoutServlet" class="btn btn-danger"><i class="fa-solid fa-sign-out-alt"></i> Logout</a>
        <% } else { %>
            <a href="login.jsp" class="btn btn-text"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
            <a href="signup.jsp" class="btn btn-primary"><i class="fa-solid fa-user-plus"></i> Sign Up</a>
        <% } %>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        if(localStorage.getItem('theme') === 'dark') {
            document.body.classList.add('dark-mode');
        }
        updateThemeIcon();
    });

    function toggleTheme() {
        document.body.classList.toggle('dark-mode');
        let theme = document.body.classList.contains('dark-mode') ? 'dark' : 'light';
        localStorage.setItem('theme', theme);
        updateThemeIcon();
    }

    function updateThemeIcon() {
        const icon = document.getElementById('theme-icon');
        if (document.body.classList.contains('dark-mode')) {
            icon.className = 'fa-solid fa-sun';
            icon.style.color = '#f39c12';
        } else {
            icon.className = 'fa-solid fa-moon';
            icon.style.color = '#ffffff';
        }
    }
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - GrandEats Reservation</title>

</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="hero animate-up">
            <div class="hero-bg"></div>
            <div class="hero-overlay"></div>
            <div class="hero-content">
                <h1>Experience Fine Dining</h1>
                <p>Reserve your perfect table in seconds and enjoy world-class culinary delights.</p>
                <a href="signup.jsp" class="btn btn-primary">Book a Table Now</a>
            </div>
        </div>

        <div class="grid-3 mt-4 mb-4">
            <div class="glass-card text-center animate-up delay-1">
                <i class="fa-solid fa-clock" style="font-size: 40px; color: var(--primary-color); margin-bottom: 15px;"></i>
                <h3>Instant Booking</h3>
                <p>Check availability in real-time and secure your table without any hassle.</p>
            </div>
            <div class="glass-card text-center animate-up delay-2">
                <i class="fa-solid fa-star" style="font-size: 40px; color: var(--primary-color); margin-bottom: 15px;"></i>
                <h3>Premium Service</h3>
                <p>Enjoy VIP tables, custom menus, and top-tier hospitality.</p>
            </div>
            <div class="glass-card text-center animate-up delay-3">
                <i class="fa-solid fa-wine-glass" style="font-size: 40px; color: var(--primary-color); margin-bottom: 15px;"></i>
                <h3>Rich Menu</h3>
                <p>Explore a variety of dishes crafted by our award-winning chefs.</p>
            </div>
        </div>
    </div>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About Us - GrandEats</title>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container animate-up">
        <div class="glass-card" style="display: flex; gap: 40px; align-items: center; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 300px;">
                <h2 style="color: var(--primary-color); margin-bottom: 20px; font-size: 32px;">Our Story</h2>
                <p style="color: var(--text-muted); line-height: 1.8;">Founded in 2020, GrandEats started with a simple vision: to bridge the gap between extraordinary culinary art and seamless customer experience.</p>
                <p style="color: var(--text-muted); line-height: 1.8;">We understand that a great dining experience starts before you even enter the restaurant. That is why we built this state-of-the-art reservation platform. Whether it’s a romantic dinner, a corporate meeting, or a family gathering, we guarantee your table is ready.</p>
                <p style="color: var(--text-main); line-height: 1.8;"><strong><i class="fa-solid fa-bullseye" style="color: var(--primary-color);"></i> Our Mission:</strong> To provide unparalleled dining experiences with zero waiting times.</p>
            </div>
            <div class="animate-up delay-1" style="flex: 1; min-width: 300px;">
                <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800" alt="Restaurant Interior" style="width: 100%; border-radius: 16px; box-shadow: var(--shadow-md); transition: transform 0.5s;" onmouseover="this.style.transform='scale(1.02)'" onmouseout="this.style.transform='scale(1)'">
            </div>
        </div>
    </div>

</body>
</html>
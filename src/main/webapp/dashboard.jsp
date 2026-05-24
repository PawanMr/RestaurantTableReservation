<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<html>
<head>
    <title>Overview - GrandEats</title>
    <style>
        .welcome-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .activity-list { list-style: none; padding: 0; margin-top: 20px; }
        .activity-list li { padding: 15px 20px; border-left: 4px solid var(--primary-color); background: var(--card-bg); margin-bottom: 12px; border-radius: 8px; font-size: 14px; box-shadow: var(--shadow-sm); display: flex; justify-content: space-between; align-items: center; transition: 0.3s; }
        .activity-list li:hover { transform: translateX(5px); }
        .activity-left { display: flex; align-items: center; gap: 15px; color: var(--text-main); font-weight: 500;}
        .activity-left i { color: var(--primary-color); font-size: 18px; width: 20px; text-align: center;}
        .activity-time { font-size: 12px; color: var(--text-muted); background: rgba(150,150,150,0.1); padding: 4px 10px; border-radius: 20px;}

        .promo-banner { background: linear-gradient(135deg, #f6d365 0%, #fda085 100%); padding: 30px; border-radius: 16px; color: white; margin-top: 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 10px 20px rgba(253, 160, 133, 0.4);}
        .promo-text h3 { margin: 0 0 8px 0; font-size: 24px; color: white;}
        .promo-text p { margin: 0; font-size: 16px; opacity: 0.95; color: white;}
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-layout">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="welcome-header animate-up">
                <div>
                    <h2>Welcome Back! <i class="fa-solid fa-hand-wave" style="color: var(--primary-color);"></i></h2>
                    <p style="color: var(--text-muted); margin-top: -10px;">Here is what's happening with your dining account today.</p>
                </div>

                <div style="display: flex; gap: 15px;">
                    <a href="contact.jsp" class="btn btn-outline">
                        <i class="fa-solid fa-envelope"></i> Contact Support
                    </a>
                    <a href="book_table.jsp" class="btn btn-primary">
                        <i class="fa-solid fa-plus"></i> New Booking
                    </a>
                </div>
            </div>

            <div class="grid-3 animate-up delay-1">
                <div class="glass-card text-white" style="background: linear-gradient(45deg, #4facfe, #00f2fe);">
                    <i class="fa-solid fa-calendar-check" style="font-size: 30px; margin-bottom: 10px;"></i>
                    <h3 style="color: white;">1</h3>
                    <p style="color: white;">Upcoming Bookings</p>
                </div>
                <div class="glass-card text-white" style="background: linear-gradient(45deg, #43e97b, #38f9d7);">
                    <i class="fa-solid fa-utensils" style="font-size: 30px; margin-bottom: 10px;"></i>
                    <h3 style="color: white;">4</h3>
                    <p style="color: white;">Total Past Visits</p>
                </div>
                <div class="glass-card text-white" style="background: linear-gradient(45deg, #fa709a, #fee140);">
                    <i class="fa-solid fa-star" style="font-size: 30px; margin-bottom: 10px;"></i>
                    <h3 style="color: white;">450</h3>
                    <p style="color: white;">Loyalty Points</p>
                </div>
                <div class="glass-card text-white" style="background: linear-gradient(45deg, #667eea, #764ba2);">
                    <i class="fa-solid fa-crown" style="font-size: 30px; margin-bottom: 10px;"></i>
                    <h3 style="font-size: 26px; margin-top: 10px; color: white;">Gold</h3>
                    <p style="color: white;">Member Status</p>
                </div>
            </div>

            <div class="promo-banner animate-up delay-2">
                <div class="promo-text">
                    <h3><i class="fa-solid fa-gift"></i> Special Member Offer!</h3>
                    <p>Redeem 300 Loyalty Points for a complimentary dessert on your next visit.</p>
                </div>
                <a href="book_table.jsp" class="btn" style="background: white; color: #d35400;">Claim Offer</a>
            </div>

            <h3 style="margin-top: 40px; border-bottom: 2px solid var(--border-color); padding-bottom: 10px; color: var(--text-main);" class="animate-up delay-3">Recent Activity</h3>
            <ul class="activity-list">
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        <span>Logged into the dashboard securely</span>
                    </div>
                    <span class="activity-time">Just now</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-calendar-plus" style="color: #28a745;"></i>
                        <span>Reserved a VIP Private Room for 4 Guests</span>
                    </div>
                    <span class="activity-time">Yesterday, 10:30 AM</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-envelope-circle-check" style="color: #17a2b8;"></i>
                        <span>Updated account email address</span>
                    </div>
                    <span class="activity-time">April 18, 2026</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-star" style="color: #e67e22;"></i>
                        <span>Left a 5-star review for the Seafood Platter</span>
                    </div>
                    <span class="activity-time">April 10, 2026</span>
                </li>
            </ul>

        </div>
    </div>
</body>
</html>
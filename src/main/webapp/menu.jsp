<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Food Menu - GrandEats</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-layout">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="welcome-header animate-up">
                <div>
                    <h2><i class="fa-solid fa-burger" style="color: var(--primary-color);"></i> Our Menu</h2>
                    <p style="color: var(--text-muted); margin-top: -10px;">Discover our delicious food and beverages. Book a table to enjoy!</p>
                </div>
            </div>

            <div class="grid-3 animate-up delay-1">
                <%
                    MenuService ms = new MenuService();
                    List<MenuItem> menuItems = ms.getAllMenuItems();

                    if(menuItems.isEmpty()) {
                %>
                    <div class="glass-card" style="grid-column: 1 / -1; text-align: center; padding: 50px;">
                        <i class="fa-solid fa-plate-wheat" style="font-size: 40px; color: var(--border-color); margin-bottom: 15px;"></i>
                        <h3>Menu is currently being updated!</h3>
                        <p style="color: var(--text-muted);">Please check back later.</p>
                    </div>
                <%  } else {
                        for(MenuItem m : menuItems) {
                %>
                    <div class="menu-card">
                        <img src="<%= m.getImageUrl() %>" class="menu-img" alt="<%= m.getName() %>">
                        <div class="menu-title"><%= m.getName() %></div>
                        <div class="menu-category"><%= m.getCategory() %></div>
                        <div class="menu-price">Rs. <%= m.getPrice() %></div>
                        <div>
                            <% if("Available".equalsIgnoreCase(m.getStatus())) { %>
                                <span class="badge badge-available"><i class="fa-solid fa-check"></i> Available</span>
                            <% } else { %>
                                <span class="badge badge-out"><i class="fa-solid fa-xmark"></i> Out of Stock</span>
                            <% } %>
                        </div>
                    </div>
                <%      }
                    }
                %>
            </div>

        </div>
    </div>
</body>
</html>
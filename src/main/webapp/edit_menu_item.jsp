<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }

    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("admin_menu.jsp");
        return;
    }

    int itemId = Integer.parseInt(idParam);
    MenuService ms = new MenuService();

    MenuItem item = ms.getMenuItemById(itemId);

    if (item == null) {
        response.sendRedirect("admin_menu.jsp");
        return;
    }
%>
<html>
<head>
    <title>Edit Menu Item - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="admin-header">
        <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
        <div><span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Welcome, Manager</span><a href="LogoutServlet" class="btn-logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
    </div>

    <div class="admin-nav">
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp" class="active"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content animate-up">
        <a href="admin_menu.jsp" style="text-decoration: none; color: var(--text-muted); font-weight: bold;"><i class="fa-solid fa-arrow-left"></i> Back to Menu</a>
        <h2 style="color: var(--text-main); margin-top: 20px;"><i class="fa-solid fa-pen-to-square" style="color: var(--primary-color);"></i> Edit Menu Item</h2>

        <div class="glass-card" style="max-width: 600px; margin-top: 30px;">
            <form action="UpdateMenuItemServlet" method="POST">

                <input type="hidden" name="id" value="<%= item.getId() %>">

                <div class="form-group">
                    <label>Item Name</label>
                    <input type="text" name="name" class="form-control" value="<%= item.getName() %>" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" class="form-control">
                        <option value="Main Course" <%= item.getCategory().equals("Main Course") ? "selected" : "" %>>Main Course</option>
                        <option value="Appetizers" <%= item.getCategory().equals("Appetizers") ? "selected" : "" %>>Appetizers</option>
                        <option value="Desserts" <%= item.getCategory().equals("Desserts") ? "selected" : "" %>>Desserts</option>
                        <option value="Beverages" <%= item.getCategory().equals("Beverages") ? "selected" : "" %>>Beverages</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="text" name="price" class="form-control" value="<%= item.getPrice() %>" required>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="Available" <%= item.getStatus().equals("Available") ? "selected" : "" %>>Available</option>
                        <option value="Out of Stock" <%= item.getStatus().equals("Out of Stock") ? "selected" : "" %>>Out of Stock</option>
                    </select>
                </div>
                <div class="form-group mb-4">
                    <label>Image URL</label>
                    <input type="text" name="imageUrl" class="form-control" value="<%= item.getImageUrl() %>" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Save Changes</button>
            </form>
        </div>
    </div>
</body>
</html>
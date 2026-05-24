<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Add Menu Item - Admin</title>
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
        <h2 style="color: var(--text-main); margin-top: 20px;"><i class="fa-solid fa-plus" style="color: var(--primary-color);"></i> Add New Menu Item</h2>

        <div class="glass-card" style="max-width: 600px; margin-top: 30px;">
            <form action="AddMenuItemServlet" method="POST">
                <div class="form-group">
                    <label>Item Name</label>
                    <input type="text" name="name" class="form-control" placeholder="e.g. Chicken Fried Rice" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" class="form-control">
                        <option value="Main Course">Main Course</option>
                        <option value="Appetizers">Appetizers</option>
                        <option value="Desserts">Desserts</option>
                        <option value="Beverages">Beverages</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="text" name="price" class="form-control" placeholder="e.g. 1500.00" required>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="Available">Available</option>
                        <option value="Out of Stock">Out of Stock</option>
                    </select>
                </div>
                <div class="form-group mb-4">
                    <label>Image URL (Online Link)</label>
                    <input type="text" name="imageUrl" class="form-control" placeholder="e.g. https://cdn-icons-png.flaticon.com/.../burger.png" required>
                </div>
                <button type="submit" class="btn btn-success" style="width: 100%;">Save Item</button>
            </form>
        </div>
    </div>
</body>
</html>
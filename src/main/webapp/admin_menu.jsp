<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Menu Management - Admin</title>
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
        <a href="add_menu_item.jsp" class="btn btn-primary" style="float: right;"><i class="fa-solid fa-plus"></i> Add New Item</a>

        <h2 style="margin-top: 0; color: var(--text-main);"><i class="fa-solid fa-burger" style="color: var(--primary-color);"></i> Restaurant Menu</h2>
        <p style="color: var(--text-muted);">Manage your food and beverage offerings here.</p>

        <% if(request.getParameter("msg") != null) {
            if(request.getParameter("msg").equals("item_added")) { %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i> New Menu Item added successfully!
                </div>
        <%  } else if(request.getParameter("msg").equals("item_updated")) { %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-pen-to-square"></i> Menu Item updated successfully!
                </div>
        <%  } else if(request.getParameter("msg").equals("item_deleted")) { %>
                <div class="alert alert-danger">
                    <i class="fa-solid fa-trash-can"></i> Menu Item deleted successfully!
                </div>
        <%  }
        } %>

        <div class="table-container">
            <table class="table-custom">
                <thead><tr><th>Item Image</th><th>Item Name</th><th>Category</th><th>Price (Rs.)</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <%
                        MenuService ms = new MenuService();
                        List<MenuItem> menuItems = ms.getAllMenuItems();

                        if(menuItems.isEmpty()) {
                    %>
                        <tr><td colspan="6" style="text-align: center; padding: 40px; color: #777;">No menu items found. Please add a new item.</td></tr>
                    <%  } else {
                            for(MenuItem m : menuItems) {
                    %>
                        <tr>
                            <td><img src="<%= m.getImageUrl() %>" width="40" height="40" style="border-radius: 5px; object-fit: cover;"></td>
                            <td><strong><%= m.getName() %></strong></td>
                            <td><%= m.getCategory() %></td>
                            <td><%= m.getPrice() %></td>
                            <td>
                                <% if("Available".equals(m.getStatus())) { %>
                                    <span style="color: #28a745; font-weight: bold;"><i class="fa-solid fa-check-circle"></i> Available</span>
                                <% } else { %>
                                    <span style="color: #dc3545; font-weight: bold;"><i class="fa-solid fa-times-circle"></i> Out of Stock</span>
                                <% } %>
                            </td>
                            <td>
                                <div style="display: flex; gap: 10px;">
                                    <a href="edit_menu_item.jsp?id=<%= m.getId() %>" class="btn-action btn-edit" style="background: var(--primary-color); text-decoration: none; padding: 6px 12px; color:white; border-radius:4px; font-weight: bold; cursor:pointer; display: inline-block;">
                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                    </a>

                                    <a href="DeleteMenuItemServlet?id=<%= m.getId() %>" onclick="return confirm('Are you sure you want to delete this item?');" class="btn-action btn-danger" style="background: var(--danger-color); text-decoration: none; padding: 6px 12px; color:white; border-radius:4px; font-weight: bold; cursor:pointer; display: inline-block;">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <%      }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
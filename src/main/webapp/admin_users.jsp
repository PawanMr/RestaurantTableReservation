<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.User" %>
<%@ page import="com.reservation.service.UserService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>User Management - Admin Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <div class="admin-header">
        <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
        <div>
            <span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Welcome, Manager</span>
            <a href="LogoutServlet" class="btn-logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <div class="admin-nav">
        <a href="admin_dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp" class="active"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content animate-up">
        <h2 style="margin-top: 0; color: var(--text-main);"><i class="fa-solid fa-users-gear" style="color: var(--primary-color);"></i> User Management</h2>
        <p style="color: var(--text-muted); margin-bottom: 30px;">View and manage all registered customers in the system.</p>

        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("user_deleted")) { %>
            <div class="alert alert-success">
                <i class="fa-solid fa-trash-can"></i> User account permanently deleted!
            </div>
        <% } %>

        <div class="table-container">
            <table class="table-custom">
                <thead>
                    <tr>
                        <th><i class="fa-regular fa-user"></i> Full Name</th>
                        <th><i class="fa-regular fa-envelope"></i> Email Address</th>
                        <th><i class="fa-solid fa-phone"></i> Phone Number</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        UserService us = new UserService();
                        List<User> allUsers = us.getAllUsers();

                        if(allUsers.isEmpty()) {
                    %>
                        <tr><td colspan="4" style="text-align: center; padding: 30px;">No registered users found.</td></tr>
                    <%  } else {
                            for(User u : allUsers) {
                    %>
                        <tr>
                            <td style="color: var(--text-main);"><strong><%= u.getFullName() != null ? u.getFullName() : "User" %></strong></td>
                            <td style="color: var(--info-color);"><%= u.getEmail() %></td>
                            <td style="color: var(--text-muted);"><%= u.getPhoneNumber() != null ? u.getPhoneNumber() : "N/A" %></td>
                            <td>
                                <form action="DeleteUserServlet" method="POST" style="margin: 0;">
                                    <input type="hidden" name="userEmail" value="<%= u.getEmail() %>">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 13px;" onclick="return confirm('Are you sure you want to completely remove this user from the system?');">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </button>
                                </form>
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
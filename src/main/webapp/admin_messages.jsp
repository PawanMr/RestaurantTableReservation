<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Message" %>
<%@ page import="com.reservation.service.MessageService" %>
<%@ page import="java.util.List" %>
<%
    // Security Check (Admin Only)
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Messages - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
        <a href="admin_menu.jsp"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp" class="active"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content animate-up">
        <h2 style="margin-top: 0; color: var(--text-main);"><i class="fa-solid fa-envelope-open-text" style="color: var(--primary-color);"></i> Customer Feedback & Inquiries</h2>
        <p style="color: var(--text-muted); margin-bottom: 30px;">Read, manage and reply to messages from your website visitors.</p>

        <%
            MessageService ms = new MessageService();
            List<Message> allMessages = ms.getAllMessages();

            if(allMessages.isEmpty()) {
        %>
            <div style="text-align: center; padding: 40px; color: #777;"><i class="fa-regular fa-folder-open" style="font-size: 40px; margin-bottom: 15px; display: block; color: #ddd;"></i>No new messages found.</div>
        <%  } else {
                for(Message m : allMessages) {
                    boolean isPending = "Pending".equals(m.getStatus());
                    String borderColor = isPending ? "#f39c12" : "#28a745";
                    String badgeClass = isPending ? "badge-pending" : "badge-replied";
        %>
            <div class="msg-card delay-1 animate-up" style="border-left-color: <%= borderColor %>;">
                <div class="msg-header">
                    <strong style="color: var(--text-main);"><i class="fa-solid fa-user"></i> <%= m.getName() %> (<a href="mailto:<%= m.getEmail() %>" style="color: var(--info-color);"><%= m.getEmail() %></a>)
                        <span class="badge" style="background-color: <%= borderColor %>; color: white;"><%= m.getStatus() %></span>
                    </strong>
                    <span><i class="fa-solid fa-calendar-day"></i> <%= m.getDate() %></span>
                </div>
                <p style="margin: 0 0 15px 0; color: var(--text-main);"><%= m.getContent() %></p>

                <div style="display: flex; gap: 10px;">
                    <!-- Email කරන්න Link එකක් -->
                    <a href="mailto:<%= m.getEmail() %>" class="btn btn-primary" style="padding: 6px 15px; font-size: 13px; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Email Customer</a>

                    <% if (isPending) { %>
                    <form action="ReplyMessageServlet" method="POST" style="margin: 0;">
                        <input type="hidden" name="messageId" value="<%= m.getId() %>">
                        <button type="submit" class="btn btn-success" style="padding: 6px 15px; font-size: 13px; font-weight: bold;"><i class="fa-solid fa-check-double"></i> Mark as Replied</button>
                    </form>
                    <% } %>

                    <form action="DeleteMessageServlet" method="POST" style="margin: 0;">
                        <input type="hidden" name="id" value="<%= m.getId() %>">
                        <button type="submit" class="btn btn-danger" style="padding: 6px 15px; font-size: 13px; font-weight: bold;" onclick="return confirm('Are you sure you want to permanently delete this message?');">
                            <i class="fa-solid fa-trash-can"></i> Delete
                        </button>
                    </form>
                </div>
            </div>
        <%      }
            }
        %>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.has('deleted')) {
                Swal.fire({ icon: 'success', title: 'Deleted!', text: 'Message deleted successfully.', confirmButtonColor: '#d33' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
            else if (urlParams.has('replySuccess')) {
                Swal.fire({ icon: 'success', title: 'Updated!', text: 'Message marked as replied.', confirmButtonColor: '#28a745' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
            else if (urlParams.has('error')) {
                Swal.fire({ icon: 'error', title: 'Oops...', text: 'Something went wrong!', confirmButtonColor: '#3085d6' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
        });
    </script>
</body>
</html>
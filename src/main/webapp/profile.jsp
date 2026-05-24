<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.User" %>
<%@ page import="com.reservation.service.UserService" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserService userService = new UserService();
    User currentUser = userService.getUserByEmail(userEmail);
%>
<html>
<head>
    <title>My Profile - GrandEats</title>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-layout">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">

            <div class="welcome-header animate-up">
                <div>
                    <h2><i class="fa-solid fa-user-gear" style="color: var(--primary-color);"></i> My Profile Settings</h2>
                    <p style="color: var(--text-muted); margin-top: 5px;">View your account details and update your security preferences.</p>
                </div>
            </div>

            <div class="animate-up delay-1">
            <% if(request.getParameter("msg") != null) { %>
                <% if(request.getParameter("msg").equals("profile_updated")) { %>
                    <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Your profile details have been updated successfully!</div>
                <% } else if(request.getParameter("msg").equals("password_updated")) { %>
                    <div class="alert alert-success"><i class="fa-solid fa-shield-check"></i> Security updated! Your password has been changed.</div>
                <% } %>
            <% } %>

            <% if(request.getParameter("error") != null) { %>
                <% if(request.getParameter("error").equals("wrong_password")) { %>
                    <div class="alert alert-warning"><i class="fa-solid fa-triangle-exclamation"></i> The current password you entered is incorrect.</div>
                <% } else if(request.getParameter("error").equals("update_failed")) { %>
                    <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation"></i> System error: Could not update details. Please try again.</div>
                <% } %>
            <% } %>
            </div>

            <div style="display: flex; gap: 30px; align-items: flex-start; flex-wrap: wrap;" class="animate-up delay-2">

                <div class="avatar-card">
                    <div class="avatar-circle">
                        <i class="fa-regular fa-user"></i>
                    </div>
                    <h3><%= (currentUser != null) ? currentUser.getFullName() : "Valued Member" %></h3>
                    <p>Membership ID: <%= (currentUser != null) ? currentUser.getUserId() : "N/A" %></p>
                    <span class="badge-member"><i class="fa-solid fa-star"></i> GOLD MEMBER</span>
                </div>

                <div class="glass-card" style="flex: 2; min-width: 300px;">

                    <h3 style="font-size: 16px; color: var(--text-main); margin-top: 0; margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 10px; font-weight: 700; display: flex; align-items: center; gap: 8px;"><i class="fa-solid fa-address-card"></i> Personal Information</h3>
                    <form action="UpdateProfileServlet" method="POST">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="<%= (currentUser != null) ? currentUser.getFullName() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" name="phoneNumber" class="form-control" value="<%= (currentUser != null) ? currentUser.getPhoneNumber() : "" %>" pattern="[0-9]{10}" maxlength="10" required>
                            </div>
                        </div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                            <div class="form-group">
                                <label>Email Address (Primary)</label>
                                <input type="email" class="form-control" style="background-color: rgba(150,150,150,0.1); color: var(--text-muted); cursor: not-allowed;" value="<%= userEmail %>" readonly>
                            </div>
                            <div class="form-group">
                                <label>Account User ID</label>
                                <input type="text" class="form-control" style="background-color: rgba(150,150,150,0.1); color: var(--text-muted); cursor: not-allowed;" value="<%= (currentUser != null) ? currentUser.getUserId() : "" %>" readonly>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Save Changes</button>
                    </form>

                    <h3 style="font-size: 16px; color: var(--text-main); margin-top: 45px; border-top: 1px solid var(--border-color); padding-top: 30px; margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 10px; font-weight: 700; display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-shield-halved"></i> Security & Password
                    </h3>
                    <form action="ChangePasswordServlet" method="POST">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                            <div class="form-group">
                                <label>Current Password</label>
                                <input type="password" name="oldPassword" class="form-control" placeholder="Required for verification" required>
                            </div>
                            <div class="form-group">
                                <label>New Secure Password</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
                            </div>
                        </div>
                        <button type="submit" class="btn" style="background: var(--text-main); color: var(--bg-color);"><i class="fa-solid fa-lock"></i> Update Security</button>
                    </form>

                </div>
            </div>

        </div>
    </div>

</body>
</html>
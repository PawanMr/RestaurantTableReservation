<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password - GrandEats</title>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <div class="glass-card">
            <div class="auth-header">
                <h2>Secure Password Reset</h2>
                <p>Please enter the 6-digit code sent to your email along with your new password.</p>
            </div>

            <%-- Status Messages --%>
            <% if(request.getParameter("status") != null && request.getParameter("status").equals("sent")) { %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-check-circle"></i> Verification code sent successfully! Check your inbox.
                </div>
            <% } %>

            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <% if(request.getParameter("error").equals("invalid_otp")) { out.print("Incorrect verification code. Please try again."); } %>
                    <% if(request.getParameter("error").equals("update_failed")) { out.print("Failed to update password. Please try again later."); } %>
                </div>
            <% } %>

            <form action="ResetPasswordServlet" method="POST" class="auth-form">
                <div class="form-group">
                    <input type="text" name="otp" class="form-control" placeholder="Enter 6-Digit Code" maxlength="6" pattern="[0-9]{6}" required>
                </div>
                <div class="form-group mb-4">
                    <input type="password" name="newPassword" class="form-control" placeholder="Enter New Password" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Reset Password</button>
            </form>

            <div class="auth-links" style="margin-top: 15px;">
                <a href="login.jsp">Cancel and Back to Login</a>
            </div>
        </div>
    </div>

</body>
</html>
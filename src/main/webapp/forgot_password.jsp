<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password - GrandEats</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="auth-container animate-up">
        <div class="glass-card">
            <div class="auth-header">
                <h2>Forgot Password?</h2>
                <p>Enter your email to receive a 6-digit verification code.</p>
            </div>

            <form action="ForgotPasswordServlet" method="POST" class="auth-form">
                <div class="form-group mb-4">
                    <input type="email" name="email" class="form-control" placeholder="Enter Registered Email" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">Send Code</button>
            </form>
            <div class="auth-links" style="margin-top: 15px;">
                <a href="login.jsp">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
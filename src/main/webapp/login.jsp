<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - GrandEats</title>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <div class="glass-card">
            <div class="auth-header">
                <h2>Welcome Back</h2>
                <p>Login to manage your reservations.</p>
            </div>

            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation"></i> Invalid Email or Password!</div>
            <% } %>

            <form class="auth-form" action="LoginServlet" method="POST">
                <div class="form-group">
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <div class="flex-between mb-4">
                    <span></span>
                    <a href="forgot_password.jsp" style="font-size: 13px; color: var(--primary-color); font-weight: 600;">Forgot Password?</a>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Login</button>
            </form>

            <div class="auth-links">
                Don't have an account? <a href="signup.jsp">Sign Up Here</a>
            </div>
        </div>
    </div>

</body>
</html>
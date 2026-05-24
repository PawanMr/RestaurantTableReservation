<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.service.UserService" %>

<%
    UserService us = new UserService();
    String nextId = us.getNextUserId();
%>

<html>
<head>
    <title>Sign Up - GrandEats</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <div class="glass-card">
            <div class="auth-header">
                <h2>Create an Account</h2>
                <p>Join GrandEats to reserve your tables easily.</p>
            </div>

            <form class="auth-form" action="RegisterServlet" method="POST">
                <div class="form-group">
                    <label class="input-label">Your User ID (Auto-Generated):</label>
                    <input type="text" name="userId" value="<%= nextId %>" class="form-control" style="background-color: rgba(150,150,150,0.1); border-style: dashed; border-color: var(--primary-color); color: var(--primary-color); font-weight: bold; cursor: not-allowed;" readonly>
                </div>

                <div class="form-group">
                    <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
                </div>

                <div class="form-group">
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                </div>

                <div class="form-group">
                    <input type="text"
                           name="phoneNumber"
                           class="form-control"
                           placeholder="Phone Number (e.g. 0771234567)"
                           pattern="[0-9]{10}"
                           maxlength="10"
                           title="Please enter a valid 10-digit phone number"
                           required>
                </div>

                <div class="form-group mb-4">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-success" style="width: 100%;">Sign Up</button>
            </form>

            <div class="auth-links">
                Already have an account? <a href="login.jsp">Login Here</a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error')) {
                const errorMsg = urlParams.get('error');
                let title = "Registration Failed!";
                let text = "Please try again.";

                if (errorMsg === 'email_exists') {
                    text = "This email is already registered. Please login to your account.";
                } else if (errorMsg === 'failed') {
                    text = "Something went wrong while creating your account. Please try again.";
                }

                Swal.fire({
                    icon: 'error',
                    title: title,
                    text: text,
                    confirmButtonColor: '#dc3545'
                });
            }
        });
    </script>

</body>
</html>
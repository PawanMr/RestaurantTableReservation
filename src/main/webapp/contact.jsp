<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Us - GrandEats</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container animate-up">
        <h2 style="text-align: center; margin-bottom: 30px;">Get In Touch</h2>

        <div style="display: flex; gap: 30px; flex-wrap: wrap;">
            <div class="glass-card delay-1 animate-up" style="flex: 1; min-width: 300px;">
                <h3 style="color: var(--primary-color);">Contact Information</h3>
                <p style="color: var(--text-muted); margin-bottom: 30px;">Feel free to reach out to us for bulk reservations or special event inquiries.</p>

                <div class="info-item">
                    <i class="fa-solid fa-location-dot"></i>
                    <div>
                        <strong style="color: var(--text-main);">Address</strong>
                        <p style="margin:0; color: var(--text-muted);">No 123, Main Street, Colombo 03</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-phone"></i>
                    <div>
                        <strong style="color: var(--text-main);">Phone</strong>
                        <p style="margin:0; color: var(--text-muted);">+94 11 234 5678</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-envelope"></i>
                    <div>
                        <strong style="color: var(--text-main);">Email</strong>
                        <p style="margin:0; color: var(--text-muted);">reservationgrandeats@gmail.com</p>
                    </div>
                </div>
            </div>

            <div class="glass-card delay-2 animate-up" style="flex: 1; min-width: 300px;">
                <h3 style="color: var(--primary-color); margin-bottom: 20px;">Send a Message</h3>

                <%
                    String sName = session.getAttribute("userName") != null ? (String) session.getAttribute("userName") : "";
                    String sEmail = session.getAttribute("userEmail") != null ? (String) session.getAttribute("userEmail") : "";

                    String readOnlyAttr = !sName.isEmpty() ? "readonly style='background-color: rgba(150,150,150,0.1); cursor: not-allowed; color: var(--text-muted);'" : "";
                %>

                <form action="SubmitMessageServlet" method="POST">
                    <div class="form-group">
                        <input type="text" name="name" class="form-control" placeholder="Your Full Name" value="<%= sName %>" <%= readOnlyAttr %> required>
                    </div>
                    <div class="form-group">
                        <input type="email" name="email" class="form-control" placeholder="Your Email Address" value="<%= sEmail %>" <%= readOnlyAttr %> required>
                    </div>
                    <div class="form-group">
                        <input type="text" name="subject" class="form-control" placeholder="Subject">
                    </div>
                    <div class="form-group mb-4">
                        <textarea name="message" class="form-control" rows="5" placeholder="Write your message here..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;"><i class="fa-solid fa-paper-plane"></i> Send Message</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.has('success')) {
                Swal.fire({
                    icon: 'success',
                    title: 'Message Sent!',
                    text: 'Thank you for contacting GrandEats. We will get back to you soon!',
                    confirmButtonColor: '#f39c12'
                }).then(() => {
                    window.history.replaceState(null, null, window.location.pathname);
                });
            }
            else if (urlParams.has('error')) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Something went wrong. Please try again later.',
                    confirmButtonColor: '#dc3545'
                }).then(() => {
                    window.history.replaceState(null, null, window.location.pathname);
                });
            }
        });
    </script>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="java.util.List" %>
<%
    // Security Check
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard - GrandEats</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
        <a href="admin_dashboard.jsp" class="active"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content animate-up">
        <h2 style="margin-top: 0; color: var(--text-main);"><i class="fa-solid fa-chart-line" style="color: var(--primary-color);"></i> Dashboard Overview</h2>

        <%
            ReservationService rs = new ReservationService();
            List<Reservation> allBookings = rs.getAllReservations();

            int totalBookings = allBookings.size();
            int totalGuests = 0;
            for(Reservation r : allBookings) {
                if(!"Cancelled".equalsIgnoreCase(r.getStatus())) {
                    totalGuests += r.getGuests();
                }
            }
        %>

        <div class="stat-cards delay-1 animate-up">
            <div class="stat-card">
                <h3>Total Bookings (All Time)</h3>
                <p><i class="fa-solid fa-calendar-check" style="color: var(--primary-color);"></i> <%= totalBookings %></p>
            </div>
            <div class="stat-card">
                <h3>Total Guests Expected</h3>
                <p><i class="fa-solid fa-users" style="color: var(--info-color);"></i> <%= totalGuests %></p>
            </div>
        </div>

        <h3 style="margin-top: 40px; color: var(--text-main);"><i class="fa-solid fa-list" style="color: var(--primary-color);"></i> All Customer Reservations</h3>

        <div class="table-container">
            <table id="bookingsTable" class="table-custom">
                <thead>
                    <tr>
                        <th>Customer Email</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Guests</th>
                        <th>Table Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(!allBookings.isEmpty()) {
                            for(Reservation r : allBookings) {
                    %>
                        <tr>
                            <td><a href="mailto:<%= r.getUserEmail() %>" class="customer-email" style="color: var(--info-color); text-decoration: none;"><i class="fa-solid fa-envelope" style="color: var(--text-muted);"></i> <%= r.getUserEmail() %></a></td>
                            <td style="color: var(--text-main);"><strong><i class="fa-regular fa-calendar" style="color: var(--text-muted); margin-right: 5px;"></i> <%= r.getDate() %></strong></td>
                            <td style="color: var(--text-muted);"><i class="fa-regular fa-clock" style="color: var(--text-muted); margin-right: 5px;"></i> <%= r.getTime() %></td>
                            <td style="color: var(--text-muted);"><i class="fa-solid fa-user-group" style="color: var(--text-muted); margin-right: 5px;"></i> <%= r.getGuests() %> Persons</td>
                            <td style="color: var(--text-muted);"><%= r.getTableType() %></td>

                            <td>
                                <% if("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                    <span class="badge" style="background: #fff3cd; color: #856404; border: 1px solid #ffeeba;"><i class="fa-solid fa-clock"></i> Pending</span>
                                <% } else if("Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                    <span class="badge" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;"><i class="fa-solid fa-ban"></i> Cancelled</span>
                                <% } else { %>
                                    <span class="badge" style="background: #d4edda; color: #155724; border: 1px solid #c3e6cb;"><i class="fa-solid fa-check-double"></i> Confirmed</span>
                                <% } %>
                            </td>

                            <td>
                                <% if("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                    <div style="display: flex; gap: 5px;">
                                        <a href="ApproveReservationServlet?id=<%= r.getId() %>" class="btn-action btn-approve"><i class="fa-solid fa-check"></i> Approve</a>
                                        <a href="#" onclick="confirmReject(<%= r.getId() %>)" class="btn-action btn-reject"><i class="fa-solid fa-xmark"></i> Reject</a>
                                    </div>
                                <% } else if("Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                    <span style="color: #dc3545; font-weight: bold; font-size: 13px;"><i class="fa-solid fa-ban"></i> Rejected</span>
                                <% } else { %>
                                    <span style="color: #28a745; font-weight: bold; font-size: 13px;"><i class="fa-solid fa-check-circle"></i> Approved</span>
                                <% } %>
                            </td>
                        </tr>
                    <%      }
                        }
                    %>
                </tbody>
            </table>
        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#bookingsTable').DataTable({
                "pageLength": 5,
                "lengthMenu": [5, 10, 25, 50],
                "order": [[ 1, "desc" ]],
                "language": {
                    "emptyTable": "No reservations found in the system."
                }
            });
        });

        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('msg')) {
            const msg = urlParams.get('msg');
            if (msg === 'approved') {
                Swal.fire({
                    icon: 'success',
                    title: 'Approved!',
                    text: 'Reservation successfully approved!',
                    confirmButtonColor: '#28a745'
                });
            } else if (msg === 'cancelled') {
                Swal.fire({
                    icon: 'success',
                    title: 'Rejected!',
                    text: 'Reservation successfully rejected and cancelled!',
                    confirmButtonColor: '#dc3545'
                });
            }
        }

        function confirmReject(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You are about to reject this booking!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, reject it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'CancelReservationServlet?id=' + id;
                }
            })
        }
    </script>

</body>
</html>
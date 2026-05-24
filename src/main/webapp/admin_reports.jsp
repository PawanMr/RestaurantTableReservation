<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    ReservationService rs = new ReservationService();
    List<Reservation> allBookings = rs.getAllReservations();

    int total = allBookings.size();
    int confirmed = 0;
    int pending = 0;
    int cancelled = 0;

    for(Reservation r : allBookings) {
        if("Approved".equalsIgnoreCase(r.getStatus())) confirmed++;
        else if("Pending".equalsIgnoreCase(r.getStatus())) pending++;
        else if("Cancelled".equalsIgnoreCase(r.getStatus())) cancelled++;
    }
%>
<html>
<head>
    <title>Reports - Admin Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        <a href="admin_users.jsp"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp" class="active"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content animate-up">
        <h2 style="margin-top: 0; color: var(--text-main); margin-bottom: 30px;"><i class="fa-solid fa-chart-pie" style="color: var(--primary-color);"></i> System Reports & Analytics</h2>

        <div class="stat-cards delay-1 animate-up">
            <div class="stat-card" style="border-left-color: var(--info-color);">
                <h3>Total Bookings</h3>
                <p><%= total %></p>
            </div>
            <div class="stat-card" style="border-left-color: var(--success-color);">
                <h3>Approved</h3>
                <p><%= confirmed %></p>
            </div>
            <div class="stat-card" style="border-left-color: var(--warning-color);">
                <h3>Pending</h3>
                <p><%= pending %></p>
            </div>
            <div class="stat-card" style="border-left-color: var(--danger-color);">
                <h3>Cancelled</h3>
                <p><%= cancelled %></p>
            </div>
        </div>

        <div class="charts-container delay-2 animate-up">
            <!-- Pie Chart -->
            <div class="chart-card">
                <h3>Reservation Status Breakdown</h3>
                <div class="chart-wrapper">
                    <canvas id="statusPieChart"></canvas>
                </div>
            </div>
            <!-- Bar Chart -->
            <div class="chart-card">
                <h3>Bookings Overview</h3>
                <div class="chart-wrapper">
                    <canvas id="statusBarChart"></canvas>
                </div>
            </div>
        </div>

        <div class="report-card delay-3 animate-up">
            <i class="fa-solid fa-file-pdf"></i>
            <h3>Reservation Data Report</h3>
            <p>Download a complete list of all customer reservations, including pre-ordered food and special notes in PDF format.</p>
            <a href="DownloadReportServlet" class="btn btn-success"><i class="fa-solid fa-download"></i> Download Full Report (PDF)</a>
        </div>

    </div>

    <script>
        const confirmedData = <%= confirmed %>;
        const pendingData = <%= pending %>;
        const cancelledData = <%= cancelled %>;

        const pieCtx = document.getElementById('statusPieChart').getContext('2d');
        new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: ['Approved', 'Pending', 'Cancelled'],
                datasets: [{
                    data: [confirmedData, pendingData, cancelledData],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                    borderWidth: 1
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        const barCtx = document.getElementById('statusBarChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: ['Approved', 'Pending', 'Cancelled'],
                datasets: [{
                    label: 'Number of Reservations',
                    data: [confirmedData, pendingData, cancelledData],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
                plugins: { legend: { display: false } }
            }
        });
    </script>

</body>
</html>
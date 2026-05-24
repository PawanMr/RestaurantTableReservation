<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.*" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>My Bookings - GrandEats</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="dashboard-layout">
        <jsp:include page="includes/sidebar.jsp" />
        <div class="main-content">

            <%-- Notifications Section --%>
            <% if(request.getParameter("msg") != null) { %>
                <div class="animate-up">
                <% if(request.getParameter("msg").equals("booking_success")) { %>
                    <div class="alert alert-success">
                        <i class="fa-solid fa-circle-check"></i> Table Reserved Successfully! It is currently Pending admin approval.
                    </div>
                <% } else if(request.getParameter("msg").equals("cancelled")) { %>
                    <div class="alert alert-danger">
                        <i class="fa-solid fa-trash-can"></i> Reservation successfully cancelled!
                    </div>
                <% } else if(request.getParameter("msg").equals("booking_updated")) { %>
                    <div class="alert alert-success">
                        <i class="fa-solid fa-pen-to-square"></i> Reservation updated successfully! It is now Pending admin approval.
                    </div>
                <% } %>
                </div>
            <% } %>

            <div class="welcome-header animate-up">
                <div>
                    <h2><i class="fa-solid fa-list-check" style="color: var(--primary-color);"></i> My Reservations</h2>
                    <p style="color: var(--text-muted); margin-top: 5px;">View and manage your upcoming dining schedules below.</p>
                </div>
            </div>

            <div class="table-container animate-up delay-1">
                <table class="table-custom">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Table Type</th>
                            <th>Pre-Order</th>
                            <th>Special Note</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ReservationService rs = new ReservationService();
                            List<Reservation> myBookings = rs.getReservationsByUser(userEmail);

                            if(myBookings.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-calendar-xmark"></i>
                                        <h3>No upcoming reservations found</h3>
                                        <p>You haven't booked any tables yet. Let's plan your next meal!</p>
                                        <a href="book_table.jsp" class="btn btn-primary">Book a Table</a>
                                    </div>
                                </td>
                            </tr>
                        <%  } else {
                                for(Reservation r : myBookings) {
                        %>
                            <tr>
                                <td style="color: var(--text-main);"><strong><i class="fa-regular fa-calendar" style="color: var(--text-muted); margin-right: 5px;"></i> <%= r.getDate() %></strong></td>
                                <td style="color: var(--text-muted);"><i class="fa-regular fa-clock" style="color: var(--text-muted); margin-right: 5px;"></i> <%= r.getTime() %></td>
                                <td style="color: var(--text-muted);"><%= r.getTableType() %> (<%= r.getGuests() %> Pax)</td>

                                <td><span style="font-size: 13px; color: var(--info-color); font-weight: 500;"><%= r.getPreOrderedFood() != null ? r.getPreOrderedFood() : "None" %></span></td>
                                <td><span style="font-size: 13px; color: var(--text-muted); font-style: italic;"><%= r.getSpecialNote() != null ? r.getSpecialNote() : "None" %></span></td>

                                <td>
                                    <% if("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                        <span class="badge" style="background: #fff3cd; color: #856404; border: 1px solid #ffeeba;"><i class="fa-solid fa-clock"></i> Pending</span>
                                    <% } else if("Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                        <span class="badge" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;"><i class="fa-solid fa-ban"></i> Cancelled</span>
                                    <% } else { %>
                                        <span class="badge" style="background: #d4edda; color: #155724; border: 1px solid #c3e6cb;"><i class="fa-solid fa-check-double"></i> Confirmed</span>
                                    <% } %>
                                </td>

                                <%
                                    boolean canEdit = false;
                                    boolean isPassed = false;
                                    try {
                                        String timeStr = r.getTime();
                                        if(timeStr.length() == 5) timeStr += ":00";

                                        LocalDateTime bookingTime = LocalDateTime.parse(r.getDate() + "T" + timeStr);
                                        LocalDateTime now = LocalDateTime.now();

                                        if (bookingTime.isBefore(now)) {
                                            isPassed = true;
                                        } else {
                                            long hoursUntilBooking = Duration.between(now, bookingTime).toHours();
                                            if (hoursUntilBooking >= 2) {
                                                canEdit = true;
                                            }
                                        }
                                    } catch (Exception e) {
                                        canEdit = true;
                                    }
                                %>

                                <td>
                                    <% if(canEdit && !"Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                        <a href="edit_booking.jsp?id=<%= r.getId() %>" class="btn-action btn-edit">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="CancelReservationServlet?id=<%= r.getId() %>" class="btn-action btn-danger" style="background-color: var(--danger-color);" onclick="return confirm('Are you sure you want to cancel this reservation?');">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    <% } else if(isPassed) { %>
                                        <span style="color: #6c757d; font-size: 12px; font-weight: bold;"><i class="fa-solid fa-clock-rotate-left"></i> Passed</span>
                                    <% } else { %>
                                        <span style="color: #dc3545; font-size: 12px; font-weight: bold;" title="Cannot edit/cancel">
                                            <i class="fa-solid fa-lock"></i> Locked
                                        </span>
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
    </div>
</body>
</html>
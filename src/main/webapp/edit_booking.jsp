<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    String user = (String) session.getAttribute("userEmail");
    if (user == null) { response.sendRedirect("login.jsp"); return; }

    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("my_bookings.jsp");
        return;
    }

    int id = 0;
    try {
        id = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("my_bookings.jsp");
        return;
    }

    ReservationService rs = new ReservationService();
    Reservation res = rs.getReservationById(id);

    if (res == null || !res.getUserEmail().equals(user)) {
        response.sendRedirect("my_bookings.jsp");
        return;
    }
%>
<html>
<head>
    <title>Edit Booking - GrandEats</title>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-layout">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="welcome-header animate-up">
                <div>
                    <h2><i class="fa-solid fa-pen-to-square" style="color: var(--primary-color);"></i> Edit Reservation</h2>
                </div>
            </div>

            <div class="glass-card delay-1 animate-up" style="max-width: 700px; margin: 0 auto;">
                <form action="UpdateReservationServlet" method="POST">

                    <input type="hidden" name="id" value="<%= res.getId() %>">

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label>Reservation Date</label>
                            <input type="date" name="date" class="form-control" value="<%= res.getDate() %>" required min="<%= java.time.LocalDate.now() %>">
                        </div>
                        <div class="form-group">
                            <label>Reservation Time</label>
                            <input type="time" name="time" class="form-control" value="<%= res.getTime() %>" required>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label>Number of Guests</label>
                            <input type="number" name="guests" class="form-control" value="<%= res.getGuests() %>" min="1" max="20" required>
                        </div>
                        <div class="form-group">
                            <label>Table Preference</label>
                            <select name="tableType" class="form-control">
                                <option value="Standard" <%= res.getTableType().equals("Standard") ? "selected" : "" %>>Standard Table</option>
                                <option value="Window" <%= res.getTableType().equals("Window") ? "selected" : "" %>>Window Seat</option>
                                <option value="VIP" <%= res.getTableType().equals("VIP") ? "selected" : "" %>>VIP Private Room</option>
                            </select>
                        </div>
                    </div>

                    <div class="food-section">
                        <h4><i class="fa-solid fa-bell-concierge"></i> Pre-order Food (Optional)</h4>
                        <div class="food-grid">
                            <%
                                MenuService ms = new MenuService();
                                List<MenuItem> menuItems = ms.getAllMenuItems();
                                String currentFood = res.getPreOrderedFood();

                                for(MenuItem m : menuItems) {
                                    if("Available".equals(m.getStatus())) {
                                        boolean isChecked = currentFood != null && currentFood.contains(m.getName());
                            %>
                                    <label class="food-item">
                                        <input type="checkbox" name="foodItems" value="<%= m.getName() %>" <%= isChecked ? "checked" : "" %>>
                                        <%= m.getName() %> (Rs.<%= m.getPrice() %>)
                                    </label>
                            <%      }
                                }
                            %>
                        </div>
                    </div>

                    <div class="form-group mb-4">
                        <label><i class="fa-regular fa-comment-dots"></i> Special Instructions</label>
                        <textarea name="specialNote" class="form-control" style="resize: vertical; min-height: 80px;"><%= "None".equals(res.getSpecialNote()) ? "" : res.getSpecialNote() %></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" style="margin-top: 15px; width: 100%;">Update Reservation</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
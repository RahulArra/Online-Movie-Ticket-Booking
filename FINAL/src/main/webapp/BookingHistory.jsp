<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String uid = (String) session.getAttribute("uid");

    if (uid == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Fetch the booking history from the database
    List<Map<String, String>> bookingHistory = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

        String query = "SELECT MovieTitle, Showtime, Seat FROM movieBookings WHERE uid = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, uid);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> booking = new HashMap<>();
            booking.put("MovieTitle", rs.getString("MovieTitle"));
            booking.put("Showtime", rs.getString("Showtime"));
            booking.put("Seat", rs.getString("Seat"));
            bookingHistory.add(booking);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
        }

        nav {
            background-color: #007bff;
            padding: 10px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-right: 15px;
        }

        .container {
            padding: 20px;
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav>
        <a href="MainPageServlet">Home</a>
        <a href="Profile.jsp">Profile</a>
        <a href="BookingHistory.jsp">Booking History</a>
    </nav>

    <!-- Booking History Container -->
    <div class="container">
        <h1>Your Booking History</h1>
        
        <% if (bookingHistory.isEmpty()) { %>
            <p>You have no booking history yet.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Movie Title</th>
                        <th>Showtime</th>
                        <th>Seat</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, String> booking : bookingHistory) { %>
                        <tr>
                            <td><%= booking.get("MovieTitle") %></td>
                            <td><%= booking.get("Showtime") %></td>
                            <td><%= booking.get("Seat") %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <button onclick="window.location.href='MainPageServlet'">Back to Main Page</button>
    </div>

</body>
</html>

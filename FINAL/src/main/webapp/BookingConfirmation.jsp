<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Get the session attributes
    String uid = (String) session.getAttribute("Uid");
    String movieTitle = (String) session.getAttribute("movieTitle");
    String showtime = request.getParameter("showtime");
    String[] selectedSeats = request.getParameterValues("selectedSeats");

    if (uid == null || movieTitle == null || selectedSeats == null || selectedSeats.length == 0) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Store booking details in the database (optional step for confirmation)
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

        for (String seat : selectedSeats) {
            String query = "INSERT INTO Bookings (UserID, MovieTitle, Showtime, Seat) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, uid);
            ps.setString(2, movieTitle);
            ps.setString(3, showtime);
            ps.setString(4, seat);
            ps.executeUpdate();
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
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://wallpaperaccess.com/full/2063914.jpg');
            background-size: 100vw 100vh;
            margin: 0;
            color: white;
        }
        .container {
            margin-top: 100px;
            text-align: center;
        }
        h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }
        .details {
            font-size: 1.5em;
            margin-bottom: 40px;
        }
        .seats {
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 1.2em;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Booking Successful!</h1>

    <div class="details">
        <p>Movie: <%= movieTitle %></p>
        <p>Showtime: <%= showtime %></p>
        <p>User ID: <%= uid %></p>
    </div>

    <div class="seats">
        <h2>Your Selected Seats:</h2>
        <ul>
            <% for (String seat : selectedSeats) { %>
                <li><%= seat %></li>
            <% } %>
        </ul>
    </div>

    <button onclick="window.location.href='mainpage.jsp'">Go to Main Page</button>
</div>

</body>
</html>

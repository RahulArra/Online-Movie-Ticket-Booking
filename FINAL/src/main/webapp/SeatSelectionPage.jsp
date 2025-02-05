<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.HashSet" %>
<%
    String uid = (String) session.getAttribute("uid");
    String movieTitle = (String) session.getAttribute("movieTitle");
    String showtime = request.getParameter("showtime");

    if (uid == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    if (showtime != null) {
        session.setAttribute("showtime", showtime);
    }

    if (movieTitle == null) {
        response.sendRedirect("mainpage.jsp");
        return;
    }

    HashSet<String> bookedSeats = new HashSet<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

        // Query for booked seats based on movieTitle and showtime
        String query = "SELECT Seat FROM MovieBookings WHERE MovieTitle = ? AND Showtime = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, movieTitle);
        ps.setString(2, showtime);
        ResultSet rs = ps.executeQuery();

        // Add booked seats to the HashSet
        while (rs.next()) {
            bookedSeats.add(rs.getString("Seat"));
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
    <title>Select Seats for <%= movieTitle %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url(https://wallpaperaccess.com/full/2063914.jpg);
            background-size: cover;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: white;
            margin: 20px 0;
            font-family: "Libre Bodoni", serif;
            font-size: 40px;
        }

        .seat {
            width: 7vw;
            height: 8vh;
            margin: 10px;
            background-color: #4CAF50; /* Green for available seats */
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            text-align: center;
            font-size: 14px;
            transition: transform 0.2s, background-color 0.3s;
        }

        .seat.selected {
            background-color: #FFD700; /* Gold for selected seats */
        }

        .seat.booked {
            background-color: #808080; /* Gray for booked seats */
            cursor: not-allowed;
            pointer-events: none;
        }

        .seat:hover:not(.booked) {
            transform: scale(1.1);
        }

        .container {
            display: inline-block;
            text-align: left;
            margin: 20px auto;
        }

        .row {
            display: flex;
            justify-content: center;
        }

        button[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            width: 40vw;
            height: 10vh;
            border-radius: 3mm;
            background-color: #e4ece2;
            color: black;
            border: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        button[type="submit"]:hover {
            background-color: #d1e0d1;
            transform: scale(1.05);
        }

        button[type="submit"]:disabled {
            background-color: #e0d1d180;
            color: #e01c1c;
            cursor: not-allowed;
        }
    </style>
</head>

<body>
    <h1>Select Your Seats for <%= movieTitle %></h1>

    <div class="container">
        <%
            String[] rows = {"A", "B", "C", "D", "E"};
            int seatsPerRow = 8;

            for (String row : rows) {
        %>
        <div class="row">
            <%
                for (int i = 1; i <= seatsPerRow; i++) {
                    String seatId = row + i;
                    boolean isBooked = bookedSeats.contains(seatId); // Check if the seat is booked
            %>
            <button id="<%= seatId %>" 
                    class="seat <%= isBooked ? "booked" : "" %>" 
                    onclick="toggleSeat('<%= seatId %>')" 
                    <%= isBooked ? "disabled" : "" %> 
                    aria-label="Seat <%= seatId %>">
                <%= seatId %>
            </button>
            <% } %>
        </div>
        <% } %>
    </div>

    <form action="ConfirmBookingServlet" method="post">
        <input type="hidden" id="selectedSeatsInput" name="selectedSeats" value="">
        <input type="hidden" name="movieTitle" value="<%= movieTitle %>">
        <input type="hidden" name="showtime" value="<%= session.getAttribute("showtime") %>">
        <input type="hidden" name="uid" value="<%= session.getAttribute("uid") %>">
        <button type="submit" id="confirmButton" disabled>Confirm Booking</button>
    </form>

    <script>
        let selectedSeats = new Set();
        const MAX_SELECTION = 5;

        function toggleSeat(seatId) {
            const seatElement = document.getElementById(seatId);

            if (seatElement.classList.contains('booked')) {
                alert("This seat is already booked.");
                return;
            }

            if (seatElement.classList.contains('selected')) {
                seatElement.classList.remove('selected');
                selectedSeats.delete(seatId);
            } else {
                if (selectedSeats.size < MAX_SELECTION) {
                    seatElement.classList.add('selected');
                    selectedSeats.add(seatId);
                } else {
                    alert("You can only select up to " + MAX_SELECTION + " seats.");
                }
            }

            document.getElementById("selectedSeatsInput").value = Array.from(selectedSeats).join(",");
            document.getElementById("confirmButton").disabled = selectedSeats.size === 0;
        }
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Get session data
    String movieTitle = (String) session.getAttribute("movieTitle");
    String showtime = (String) session.getAttribute("showtime");
    String uid = (String) session.getAttribute("uid");
    
    // Retrieve the selected seats from the request parameter
    String selectedSeats = request.getParameter("selectedSeats");
    if (selectedSeats == null || selectedSeats.isEmpty()) {
        response.sendRedirect("SeatSelectionPage.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #bcfce7;
            color: #333;
            padding: 50px;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #535e95;
            font-size: 36px;
            margin-bottom: 30px;
            text-transform: uppercase;
            font-weight: 700;
            text-align: center;
        }

        .ticket-info {
            background-color: #9bf3bb;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
            width: 100%;
            max-width: 600px;
            border-left: 8px solid #457747;
            margin-bottom: 30px;
            box-shadow: 5px 10px 20px 10px rgb(72, 128, 102);

        }

        .ticket-info p {
            font-size: 18px;
            color: #555;
            margin: 12px 0;
        }

        .ticket-info p strong {
            color: #333;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            font-size: 18px;
            color: white;
            background-color: #429f45;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #88d2e2;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .ticket-info {
                padding: 25px;
                width: 90%;
            }

            h1 {
                font-size: 28px;
            }

            .btn {
                padding: 10px 20px;
                font-size: 16px;
            }
        }

    </style>
</head>
<body>

    <div class="ticket-info">
        <h1>Your Movie Ticket</h1>

        <p><strong>Movie Title:</strong> <%= movieTitle %></p>
        <p><strong>Showtime:</strong> <%= showtime %></p>
        <p><strong>Selected Seats:</strong> <%= selectedSeats %></p>
        <p><strong>User ID:</strong> <%= uid %></p>
		<a href="MainPageServlet" class="btn">Go to Homepage</a>
		
    </div>


</body>
</html>

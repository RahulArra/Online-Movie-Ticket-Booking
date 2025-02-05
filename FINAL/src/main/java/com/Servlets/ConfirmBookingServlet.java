package com.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get selected seats, movie title, showtime, and user ID from the request and session
        String[] selectedSeats = request.getParameterValues("selectedSeats");
        String movieTitle = request.getParameter("movieTitle");
        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("uid");
        String showtime = request.getParameter("showtime");
        session.setAttribute("uid",uid);
        session.setAttribute("movieTitle",movieTitle);
        session.setAttribute("showtime",showtime);

        // If no seats are selected, redirect back to seat selection
        if (selectedSeats == null || selectedSeats.length == 0) {
            response.sendRedirect("SeatSelectionPage.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

            // Insert the selected seats into the database and mark them as booked
            for (String seat : selectedSeats) {
                String query = "INSERT INTO MovieBookings (movieTitle, showtime, seat, uid, isBooked) " +
                               "VALUES (?, ?, ?, ?, 1)";
                ps = con.prepareStatement(query);
                ps.setString(1, movieTitle);  // Movie Title
                ps.setString(2, showtime);    // Showtime
                ps.setString(3, seat);        // Selected seat
                ps.setString(4, uid);         // User ID from session

                ps.executeUpdate();  // Execute the insert query
            }

            con.close();

            // Redirect to the booking confirmation page with the selected seats
            response.sendRedirect("Confirmation.jsp?selectedSeats=" + String.join(",", selectedSeats));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing your booking.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

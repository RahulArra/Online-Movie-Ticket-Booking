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
        String[] selectedSeats = request.getParameterValues("selectedSeats");
        String movieTitle = request.getParameter("movieTitle");
        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("uid");
        String showtime = request.getParameter("showtime");

        if (selectedSeats == null || selectedSeats.length == 0) {
            response.sendRedirect("SeatSelectionPage.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

            // Start transaction to ensure consistency
            con.setAutoCommit(false); 

            // Loop through selected seats and attempt to book them
            for (String seat : selectedSeats) {
                // Check if the seat is already booked by another user
                String checkQuery = "SELECT isBooked FROM MovieBookings WHERE movieTitle = ? AND showtime = ? AND seat = ?";
                ps = con.prepareStatement(checkQuery);
                ps.setString(1, movieTitle);
                ps.setString(2, showtime);
                ps.setString(3, seat);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    boolean isBooked = rs.getBoolean("isBooked");
                    if (isBooked) {
                        // If seat is already booked, rollback the transaction and show error
                        con.rollback();
                        response.getWriter().write("Seat " + seat + " is already booked by another user.");
                        return;
                    }
                }

                // If the seat is not booked, proceed with booking it
                String insertQuery = "INSERT INTO MovieBookings (movieTitle, showtime, seat, uid, isBooked) " +
                                     "VALUES (?, ?, ?, ?, 1)";
                ps = con.prepareStatement(insertQuery);
                ps.setString(1, movieTitle);
                ps.setString(2, showtime);
                ps.setString(3, seat);
                ps.setString(4, uid);
                ps.executeUpdate();
            }

            // Commit the transaction
            con.commit();
            response.sendRedirect("Confirmation.jsp?selectedSeats=" + String.join(",", selectedSeats));

        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback();  // Rollback in case of error
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
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

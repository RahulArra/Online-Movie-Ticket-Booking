package com.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.sql.*;
import java.util.*;
@WebServlet("/HistoryServlet")
public class HistoryServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession()
;        String uid = (String) session.getAttribute("Uid");



        List<Map<String, String>> bookingHistory = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root");

            String query = "SELECT MovieTitle, Showtime, Seat FROM Bookings WHERE UserID = ?";
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

        request.setAttribute("bookingHistory", bookingHistory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookingHistory.jsp");
        dispatcher.forward(request, response);
    }
}

package com.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/AddMovieServlet")  // Servlet annotation
public class AddMovieServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the parameters from the form
        String movieTitle = request.getParameter("movieTitle");
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");
        String duration = request.getParameter("duration");
        String releaseDate = request.getParameter("releaseDate");
        String posterImage = request.getParameter("posterurl");

        // Insert the movie into the database
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create a connection to the database
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root")) {

                String query = "INSERT INTO Movies (MovieTitle, Description, Genre, duration, ReleaseDate, posterurl) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, movieTitle);
                    ps.setString(2, description);
                    ps.setString(3, genre);
                    ps.setString(4, duration);
                    ps.setString(5, releaseDate);
                    ps.setString(6, posterImage);

                    int result = ps.executeUpdate();

                    // Redirect to the JSP page with a success or error message
                    if (result > 0) {
                        response.sendRedirect("Addmovie.jsp?status=success");
                    } else {
                        response.sendRedirect("Addmovie.jsp?status=error");
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("Addmovie.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Addmovie.jsp?status=error");
        }
    }
}

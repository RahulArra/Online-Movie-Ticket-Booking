package com.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/MoviesServlet")
public class MoviesServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movies = new ArrayList<>();
        
        // Fetch movies from the database
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root")) {

                String query = "SELECT * FROM Movies";
                try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

                    while (rs.next()) {
                        String title = rs.getString("MovieTitle");
                        String description = rs.getString("Description");
                        String genre = rs.getString("Genre");
                        String releaseDate = rs.getString("ReleaseDate");
                        String posterImage = rs.getString("PosterImage");

                        // Create Movie object and add it to the list
                        movies.add(new Movie(title, description, genre, releaseDate, posterImage));
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
                return;
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "JDBC driver not found");
            return;
        }

        // Set the movies list as a request attribute
        request.setAttribute("movies", movies);

        // Forward to the MainPage.jsp to display the movies
        RequestDispatcher dispatcher = request.getRequestDispatcher("MainPage.jsp");
        dispatcher.forward(request, response);
    }
}

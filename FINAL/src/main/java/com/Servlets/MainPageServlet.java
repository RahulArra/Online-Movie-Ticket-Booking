package com.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/MainPageServlet")  // The URL pattern that triggers this servlet
public class MainPageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the search query from the request parameter
        String searchQuery = request.getParameter("searchQuery");

        // Retrieve movies list from the database
        List<Movie> moviesList = getMoviesFromDatabase();

        // Filter movies based on the search query (if provided)
        if (searchQuery != null && !searchQuery.isEmpty()) {
            moviesList = filterMoviesBySearchQuery(moviesList, searchQuery);
        }

        // Set the movies list as a request attribute
        request.setAttribute("movies", moviesList);

        // Forward the request to MainPage.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("MainPage.jsp");
        dispatcher.forward(request, response);
    }

    private List<Movie> getMoviesFromDatabase() {
        List<Movie> movies = new ArrayList<>();

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create a connection to the database
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MovieBooking", "root", "root")) {

                String query = "SELECT * FROM Movies";
                try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

                    while (rs.next()) {
                        String title = rs.getString("MovieTitle");
                        String description = rs.getString("Description");
                        String genre = rs.getString("Genre");
                        String releaseDate = rs.getString("ReleaseDate");
                        String posterImage = rs.getString("Posterurl");

                        // Create Movie object and add it to the list
                        movies.add(new Movie(title, description, genre, releaseDate, posterImage));
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return movies;
    }

    private List<Movie> filterMoviesBySearchQuery(List<Movie> movies, String searchQuery) {
        List<Movie> filteredMovies = new ArrayList<>();
        for (Movie movie : movies) {
            // Check if the movie title or genre contains the search query (case-insensitive)
            if (movie.getMovieTitle().toLowerCase().contains(searchQuery.toLowerCase()) ||
                movie.getGenre().toLowerCase().contains(searchQuery.toLowerCase())) {
                filteredMovies.add(movie);
            }
        }
        return filteredMovies;
    }
}
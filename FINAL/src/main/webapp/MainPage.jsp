<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Servlets.Movie" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Booking - Main Page</title>
    <style>
        /* Styles here... */
                body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
        }

        /* Navbar Styles */
        nav {
            background-color: #007bff;
            padding: 10px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin-right: 15px;
            padding: 5px 10px;
            border-radius: 4px;
        }

        nav a:hover {
            background-color: #0056b3;
        }
nav .search-bar {
    width: 200px;
    padding: 8px;
    border-radius: 4px;
    border: none;
    outline: none;
    font-size: 14px;
}

nav .search-bar:focus {
    background-color: #e8f0fe;
}
        /* Main Container */
        .main-container {
            padding: 20px;
            text-align: center;
        }

        /* Movie Grid */
        .movie-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3 movies per row */
            gap: 30px;
            margin-top: 30px;
        }

        .movie-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .movie-card:hover {
            transform: scale(1.05);
        }

        .movie-card img {
            width: 100%;
            height: 350px;
            background-cover:
            object-fit: cover;
            border-bottom: 4px solid #007bff;
        }

        .movie-info {
            padding: 15px;
            background-color: #f4f7f6;
            text-align: left;
        }

        .movie-title {
            font-size: 20px;
            font-weight: bold;
            margin: 10px 0;
            color: #333;
        }

        .movie-description {
            font-size: 16px;
            color: #666;
        }

        .movie-card button {
            margin-top: 15px;
            padding: 12px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .movie-card button:hover {
            background-color: #0056b3;
        }

        /* Logout Button */
        .logout-btn {
            background-color: #dc3545;
            padding: 8px 15px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .movie-grid {
                grid-template-columns: repeat(2, 1fr); /* 2 movies per row on smaller screens */
            }
        }

        @media (max-width: 480px) {
            .movie-grid {
                grid-template-columns: 1fr; /* 1 movie per row on very small screens */
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
        <div>
            <a href="MainPage.jsp">Home</a>
            <a href="Profile.jsp">Profile</a>
            <a href="BookingHistory.jsp">Booking History</a>
        </div>
                <div>
            <input type="text" class="search-bar" placeholder="Search movies..." oninput="searchMovies()">
            <a href="LogoutServlet" class="logout-btn">Log Out</a>
        </div>

    </nav>

    <!-- Main Container -->
    <div class="main-container">
        <h1>Now Showing - Telugu & Hindi Movies</h1>

        <!-- Movie Grid -->
        <div class="movie-grid">
            <% 
                Object moviesObj = request.getAttribute("movies");
                
                // Check if the object is an instance of List<Movie>
                if (moviesObj instanceof List<?>) {
                    List<?> list = (List<?>) moviesObj;  // First cast to a raw List
                    // Type check for safety
                    if (list.size() > 0 && list.get(0) instanceof Movie) {
                        List<Movie> movies = (List<Movie>) list;  // Safe cast to List<Movie>
                        
                        for (Movie movie : movies) {
            %>

            <!-- Movie Card -->
            <div class="movie-card">
                <img src="<%= movie.getPosterImage() %>" alt="<%= movie.getMovieTitle() %>">
                <div class="movie-info">
                    <div class="movie-title"><%= movie.getMovieTitle() %></div>
                    <div class="movie-description"><%= movie.getDescription() %></div>
                    <form action="SelectMovieServlet" method="post">
                        <input type="hidden" name="movieTitle" value="<%= movie.getMovieTitle() %>">
                        <button type="submit">Book Tickets</button>
                    </form>
                </div>
            </div>

            <% 
                        }
                    }
                } else {
            %>

            <p>No movies available at the moment.</p>

            <% } %>
        </div>
    </div>
        <script>
        function searchMovies() {
            var input = document.querySelector(".search-bar").value.toLowerCase();
            var movieCards = document.querySelectorAll(".movie-card");

            movieCards.forEach(function(card) {
                var title = card.querySelector(".movie-title").textContent.toLowerCase();
                if (title.indexOf(input) > -1) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }
            });
        }
    </script>
    
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Booking - Booking Page</title>
    <style>
		<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Booking - Booking Page</title>
    <style>
    /* General Styling */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f7f6;
}

/* Navbar Styling */
nav {
    background-color: #007bff;
    padding: 10px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
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

/* Main Container */
.main-container {
    padding: 20px;
    text-align: center;
}

/* Heading Styling */
h1 {
    font-size: 2.5rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

/* Form Styling */
form {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    width: 60%;
    margin: 0 auto;
    text-align: left;
}

label {
    font-size: 16px;
    color: #333;
    display: block;
    margin-bottom: 8px;
}

select, input[type="number"] {
    width: 100%;
    padding: 12px;
    margin: 8px 0;
    border-radius: 6px;
    border: 1px solid #ddd;
    font-size: 16px;
}

select:focus, input[type="number"]:focus {
    border-color: #007bff;
    outline: none;
    background-color: #f4f7f6;
}

button {
    padding: 12px 20px;
    font-size: 16px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    width: 100%;
    margin-top: 20px;
}

button:hover {
    background-color: #0056b3;
}

/* Media Queries for Responsive Design */
@media (max-width: 768px) {
    .main-container {
        width: 90%;
    }

    form {
        width: 100%;
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
        <h1>Book Tickets for <%= request.getAttribute("movieTitle") %></h1>

  
        <!-- Movie Booking Form -->
        <form action="SeatSelectionPage.jsp" method="post">
            <input type="hidden" name="movieTitle" value="<%= request.getAttribute("movieTitle") %>">
            
<% 
    String uid = (String) session.getAttribute("uid");
	session.setAttribute("movieTitle", request.getAttribute("movieTitle"));

    if (uid == null) {
        response.sendRedirect("Login.jsp"); // Redirect to login page if uid is not set
        return;
    }
%>

            <div class="form-group">
                <label for="showtime">Select Showtime</label>
                <select id="showtime" name="showtime" required>
                    <option value="10:00 AM">10:00 AM</option>
                    <option value="01:00 PM">01:00 PM</option>
                    <option value="04:00 PM">04:00 PM</option>
                    <option value="07:00 PM">07:00 PM</option>
                </select>
            </div>


            <div class="form-group">
                <label for="payment">Payment Method</label>
                <select id="payment" name="payment" required>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="PayPal">PayPal</option>
                </select>
            </div>

            <button type="submit">Confirm Booking</button>
        </form>
    </div>

    <!-- JavaScript for search functionality -->
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

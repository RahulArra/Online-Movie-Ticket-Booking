<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Movie Booking</title>
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-image: url(https://media.istockphoto.com/id/1007557230/photo/movie-projector-on-dark-background.jpg?s=612x612&w=0&k=20&c=bPgXKrqKU4nrWgJ_RXgLe9KN4SIitgTIcRobxxBiXTo=);
            background-size: cover;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        /* Login Container */
        .login-container {
            background-color: rgba(71, 75, 76, 0.8); /* Slightly transparent for overlay effect */
            padding: 30px;
            border-radius: 7mm;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #cbc2c2;
        }

        /* Form Styling */
        .login-form input {
            width: 88%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #2e2828;
            border-radius: 4px;
            font-size: 16px;
            outline: none;
        }

        .login-form input:focus {
            border-color: #007bff;
            background-color: #f4f7f6;
        }

        .login-form button {
            width: 100%;
            padding: 12px;
            background-color: #38618c;
            color: rgb(226, 212, 212);
            border: none;
            border-radius: 3mm;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        .login-form button:hover {
            background-color: #3131a2;
        }

        /* Error Message */
        .error-message {
            color: #dc3545;
            margin-top: 10px;
            font-size: 14px;
        }

        /* Signup Link */
        .signup-link {
            margin-top: 20px;
            font-size: 14px;
            color: #26e2cf;
        }

        .signup-link a {
            color: #e2e5e8;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login to Movie Booking</h2>

        <!-- Display error message if login fails -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <!-- Login Form -->
        <form class="login-form" action="LoginServlet" method="post">
            <input type="text" name="uid" placeholder="User ID" required>
            <input type="password" name="pwd" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>

        <!-- Signup Link -->
        <div class="signup-link">
            Don't have an account? <a href="Register.jsp">Sign up here</a>.
        </div>
    </div>
</body>
</html>

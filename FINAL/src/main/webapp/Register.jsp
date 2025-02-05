<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #9f9999;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        h2 {
            font-size: 24px;
            color: #333;
        }
        .form-container {
            background-color: #d3cdcd;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        label {
            font-size: 16px;
            color: #052771;
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="tel"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        input[type="submit"] {
            width: 80%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .link {
            font-size: 14px;
            margin-top: 10px;
        }
        .link a {
            color: #007bff;
            text-decoration: none;
        }
        .link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Register</h2>
        <form action="RegisterServlet" method="post">
            <label for="uid">USER ID:</label>
            <input type="text" name="uid" id="uid" required><br>

            <label for="pwd">PASSWORD:</label>
            <input type="password" name="pwd" id="pwd" required><br>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required><br>

            <label for="phone">Phone Number:</label>
            <input type="tel" name="phn" id="phn" required pattern="\d{10}" title="Phone number should be 10 digits"><br>

            <input type="submit" value="Register">
        </form>
    </div>

    <div class="link">
        <p>Already have an account? <a href="Login.jsp">Login here</a></p>
    </div>

</body>
</html>

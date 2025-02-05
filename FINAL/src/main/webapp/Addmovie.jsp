<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Movie</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
        }

        form {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <h2 style="text-align:center;">Add New Movie</h2>

    <form action="AddMovieServlet" method="post">
        <label for="movieTitle">Movie Title:</label>
        <input type="text" id="movieTitle" name="movieTitle" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="genre">Genre:</label>
        <input type="text" id="genre" name="genre" required>

        <label for="duration">Duration:</label>
        <input type="text" id="duration" name="duration" required>

        <label for="releaseDate">Release Date:</label>
        <input type="date" id="releaseDate" name="releaseDate" required>

        <label for="posterImage">Poster Image URL:</label>
        <input type="text" id="posterurl" name="posterurl" required>

        <button type="submit">Add Movie</button>
    </form>

</body>
</html>

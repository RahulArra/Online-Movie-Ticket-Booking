package com.Servlets;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SelectMovieServlet")
public class SelectMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the movie title from the request
        String movieTitle = request.getParameter("movieTitle");
        String uid = request.getParameter("uid");

        System.out.println("Selected Movie Title: " + movieTitle);

        // Set the movie title as a request attribute
        request.setAttribute("movieTitle", movieTitle);

        request.setAttribute("uid",uid);
        // Forward the request to the booking page (BookingPage.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookingPage.jsp");
        dispatcher.forward(request, response);
    }
}
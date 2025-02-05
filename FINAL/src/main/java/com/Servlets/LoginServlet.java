package com.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        String pwd = request.getParameter("pwd");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviebooking", "root", "root");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE Uid=?");
            ps.setString(1, uid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPwd = rs.getString("Pwd");

                // Check if password matches (using BCrypt)
                if (BCrypt.checkpw(pwd, storedPwd)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("uid", uid);
                    response.sendRedirect("MainPageServlet"); // Redirect to movie selection page after successful login
                } else {
                    request.setAttribute("errorMessage", "Invalid password. Please try again.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response); // Display error message on login page
                }
            } else {
                request.setAttribute("errorMessage", "User ID not found. Please try again.");
                request.getRequestDispatcher("Login.jsp").forward(request, response); // Display error message on login page
            }
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}

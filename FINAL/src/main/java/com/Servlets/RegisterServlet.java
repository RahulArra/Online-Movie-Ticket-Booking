package com.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        String pwd = request.getParameter("pwd");
        String email = request.getParameter("email");
        String phone = request.getParameter("phn");

        // Hash the password before storing
        String hashedPwd = BCrypt.hashpw(pwd, BCrypt.gensalt());

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviebooking", "root", "root");

            PreparedStatement ps = con.prepareStatement("INSERT INTO users (Uid, Pwd, Email, phn) VALUES (?, ?, ?, ?)");
            ps.setString(1, uid);
            ps.setString(2, hashedPwd);
            ps.setString(3, email);
            ps.setString(4, phone);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("Login.jsp");
            } else {
                response.sendRedirect("Register.jsp"); 
            }
            System.out.println("Sucess");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

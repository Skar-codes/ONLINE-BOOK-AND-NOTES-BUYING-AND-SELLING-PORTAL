package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginForm")
public class UserLogin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String useremail = req.getParameter("email1");
        String userpass = req.getParameter("pass1");
        PrintWriter out = resp.getWriter();

        Connection co = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            co = DbConnection.getConnection();
            ps = co.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
            ps.setString(1, useremail);
            ps.setString(2, userpass);
            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("userName", rs.getString("firstname"));// + " " + rs.getString("lastname")
                session.setAttribute("userLastName", rs.getString("lastname"));
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("role", "user");
                RequestDispatcher rd = req.getRequestDispatcher("/users_home.jsp");
                rd.include(req, resp);
            } else {
                resp.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email id and password did not match! Please try again.');");
                out.println("window.location.href='user_login_register.html';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log exception for debugging
            resp.setContentType("text/html");
            out.println("<h3 style='color:red'> Exception occurred: " + e.getMessage() + "</h3>");
            RequestDispatcher rd = req.getRequestDispatcher("/user_login_register.html");
            rd.forward(req, resp);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (co != null) co.close();
            } catch (Exception e) {
                e.printStackTrace(); // Handle closing errors
            }
        }
    }
}

package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

@WebServlet("/adloginForm")
public class AdminLogin extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String adminemail = request.getParameter("email1");
		String adminpass = request.getParameter("pass1");
		PrintWriter out =response.getWriter();
		try
		{
			Connection co = DbConnection.getConnection();
			PreparedStatement ps = co.prepareStatement("Select * from admin where email= ? and password = ?");
			ps.setString(1, adminemail);
			ps.setString(2, adminpass);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				HttpSession session = request.getSession();
				session.setAttribute("role", "admin");
				RequestDispatcher rd = request.getRequestDispatcher("/adminhomepage.jsp");
				rd.include(request, response);
			}
			else
			{
				 response.setContentType("text/html");
				 out.println("<script type=\"text/javascript\">");
				 out.println("alert('Email id and password did not match!  Please enter a valid email and password');");
				 out.println("window.location.href='adminLogin.html';");
				 out.println("</script>");
				 
			}
			rs.close();
			ps.close();
			co.close();
			
		}
		catch (Exception e) {
			 out.print("<h3 style= 'color:red'> Exception occured " + e.getMessage()+ "</h3>");
			 response.setContentType("text/html");
			 RequestDispatcher rd = request.getRequestDispatcher("/adminLogin.html");
			 rd.include(request, response);
		
		}
	}
}

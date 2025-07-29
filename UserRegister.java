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

@WebServlet ("/regForm")
public class UserRegister extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 	String myFirstName = req.getParameter("name1");
	 	String myLastName = req.getParameter("name2");
		String myEmail = req.getParameter("email1");
		String myPass = req.getParameter("pass1");
		String mygender = req.getParameter("gender");
		String mycity = req.getParameter("city");
		String myphoneno = req.getParameter("phoneno");
		PrintWriter out = resp.getWriter();
		java.sql.Date todayDate = new java.sql.Date(System.currentTimeMillis());
		
		
		try
		{
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("Select * from users where email= ?");
			ps.setString(1, myEmail);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				 resp.setContentType("text/html");
				 out.println("<script type=\"text/javascript\">");
				 out.println("alert('This email id already registerd please try anothor email id!');");
				 out.println("window.location.href='user_login_register.html';");
				 out.println("</script>");
				 return;
			}
			con = DbConnection.getConnection();
			ps = con.prepareStatement("insert into users (firstname, lastname, email, phoneno, gender, city, password, registerdate )values(?, ?, ?, ?, ?, ?, ?, ? )");
			ps.setString(1, myFirstName);
			ps.setString(2, myLastName);
			ps.setString(3, myEmail);
			ps.setString(4, myphoneno);
			ps.setString(5, mygender);
			ps.setString(6, mycity);
			ps.setString(7, myPass);
			ps.setDate(8, todayDate);
			
			
			 int i = ps.executeUpdate();
			 
			 if(i > 0)
			 {
				 resp.setContentType("text/html");
				 out.println("<script type=\"text/javascript\">");
				 out.println("alert('User registered successfully');");
				 out.println("window.location.href='user_login_register.html';");
				 out.println("</script>");
				 
			 }
			 else
			 {
				 resp.setContentType("text/html");
				 out.println("<script type=\"text/javascript\">");
				 out.println("alert('User not registered due to some error');");
				 out.println("window.location.href='user_login_register.html';");
				 out.println("</script>");
			 }
			 ps.close();
			 con.close();
			
		}
		catch (Exception e) {
	  	req.setAttribute("errorMessage", e.getMessage());
	    RequestDispatcher rd = req.getRequestDispatcher("error.jsp");
	    rd.forward(req, resp);
			
		}
	}

}

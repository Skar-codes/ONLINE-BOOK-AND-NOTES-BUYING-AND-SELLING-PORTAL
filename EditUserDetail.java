package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editUserDetail")
public class EditUserDetail extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userId =Integer.parseInt( request.getParameter("user_id"));
		String firstName = request.getParameter("firstname").toString();
		String lastName = request.getParameter("lastname").toString();
		String city = request.getParameter("city").toString();
		String phoneno = request.getParameter("phoneno").toString();
		String email = request.getParameter("email").toString();
		PrintWriter out = response.getWriter();

		try {
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("UPDATE users SET firstname = ?, lastname = ?, city = ?, phoneno = ?, email = ? WHERE user_id = ?");
			 ps.setString(1, firstName);
			 ps.setString(2, lastName);
			 ps.setString(3, city);
			 ps.setString(4, phoneno);
			 ps.setString(5, email);
			 ps.setInt(6, userId);
			 
			 int update = ps.executeUpdate();
			 if(update == 0) {
				 	response.setContentType("text/html");
	                out.println("<script type=\"text/javascript\">");
	                out.println("alert('Something went wrong!!');");
	                out.println("window.location.href='profile.jsp?id="+userId+"';");
	                out.println("</script>");
	                      
			 }
			 else {
				 	response.setContentType("text/html");
	                out.println("<script type=\"text/javascript\">");
	                out.println("alert('Updated successfully');");
	                out.println("window.location.href='profile.jsp?id="+userId+"';");
	                out.println("</script>");
			 }
			 ps.close();
			 con.close();
		} catch (Exception e) {
			System.out.println(e);
			response.setContentType("text/html");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Something went wrong!!');");
            out.println("window.location.href='profile.jsp';");
            out.println("</script>");
			
		}
	}

}

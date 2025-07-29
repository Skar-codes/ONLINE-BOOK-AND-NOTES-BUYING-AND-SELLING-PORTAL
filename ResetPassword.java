package in.sp.dbcon;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/resetPassword")
public class ResetPassword extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	String email = request.getParameter("email");
	String NewPassword = request.getParameter("password");
	PrintWriter out = response.getWriter();
  try {
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = con.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
	ps.setString(1, NewPassword);
	ps.setString(2, email);
	
	int updated = ps.executeUpdate();
	if(updated > 0)
	{
		out.print("<script>alert('Password changed successfully!'); window.location.href='user_login_register.html';</script>");
	}
	else
	{
		out.print("<script>alert('Failed to update password.'); window.history.back();</script>");
	}
	con.close();
	ps.close();
	}catch (Exception e) {
		e.printStackTrace();
        out.print("<script>alert('Error occurred!'); window.history.back();</script>");
	}

 }
}


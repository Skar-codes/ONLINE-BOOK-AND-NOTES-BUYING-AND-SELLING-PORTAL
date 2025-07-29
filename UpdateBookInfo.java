package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateBookInfo")
public class UpdateBookInfo extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		String description = request.getParameter("description");
		double bookPrice = Double.parseDouble(request.getParameter("price"));
		String category = request.getParameter("category");
		String query = "UPDATE books SET summary = ?, book_price = ?, category = ? WHERE book_id = ?";
		PrintWriter out = response.getWriter();
		try {
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, description);
			ps.setDouble(2, bookPrice);
			ps.setString(3, category);
			ps.setInt(4, bookId);
			
			int update = ps.executeUpdate();
			
			if(update == 0) {
			 	response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Something went wrong!!');");
                out.println("window.location.href='updateBook.jsp?bookId="+ bookId+"';");
                out.println("</script>");
                      
		 }
		 else {
			 	response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated successfully');");
                out.println("window.location.href='updateBook.jsp?bookId="+ bookId+"';");
                out.println("</script>");
		 }
			
			
			
		}catch (Exception e) {
			System.out.println(e);
			response.setContentType("text/html");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Something went wrong!!');");
            out.println("window.location.href='updateBook.jsp?bookId="+ bookId+"';");
            out.println("</script>");
		}
	}
	
	

}

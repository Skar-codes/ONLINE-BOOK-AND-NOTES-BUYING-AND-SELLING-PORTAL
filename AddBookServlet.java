package in.sp.backend;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.mysql.cj.Session;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
(  
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 50, // 10MB
	    maxRequestSize = 1024 * 1024 * 100 // 50MB
)
@WebServlet("/bookAddedForm")
public class AddBookServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			String bookName = request.getParameter("bookName");
			String authorName = request.getParameter("authorName");
			String sellerName =  session.getAttribute("userName").toString() +" "+ session.getAttribute("userLastName").toString();
			int sellerId = (Integer) session.getAttribute("userId") ;
			String summary = request.getParameter("summary");
			String category = request.getParameter("category");
			double bookPrice = Double.parseDouble(request.getParameter("bookPrice"));
			Part coverImagePart = request.getPart("coverImage");
			Part uploadBookPart = request.getPart("uploadBook");
			String fileType = uploadBookPart.getContentType();
			if (!fileType.equals("application/pdf")) {
			    response.setContentType("text/html");
			    out.println("<script type=\"text/javascript\">");
			    out.println("alert('Only PDF files are supported for uploading books.');");
			    out.println("window.location.href='users_home.jsp';"); 
			    out.println("</script>");
			    return; 
			}
			Connection con = null;
	        PreparedStatement ps = null;
	    try {
			    
			    InputStream coverImageInputStream = coverImagePart.getInputStream();
			    InputStream uploadBookInputStream = uploadBookPart.getInputStream();
			    
			    byte[] coverImagedata = new byte[coverImageInputStream.available()];
			    byte[] uploadBookdata = new byte[uploadBookInputStream.available()];
			    
			    coverImageInputStream.read(coverImagedata);		    
			    uploadBookInputStream.read(uploadBookdata);
			    
		    	con = DbConnection.getConnection();
		    	String sql = "INSERT INTO books (book_name,seller_name,seller_id,author_name, summary,category, cover_image, uploaded_book, book_price) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, bookName);
		    	ps.setString(2, sellerName);
		    	ps.setInt(3, sellerId);
		    	ps.setString(4, authorName);
		    	ps.setString(5, summary);
		    	ps.setString(6, category);
		    	ps.setBytes(7, coverImagedata);
		    	ps.setBytes(8, uploadBookdata);
		    	ps.setDouble(9, bookPrice);
		    	int bookInserted  = ps.executeUpdate();
		    	
		    	if(bookInserted > 0)
		    	{
					 response.setContentType("text/html");
					 out.println("<script type=\"text/javascript\">");
					 out.println("alert('Book added successfully!');");
					 out.println("window.location.href='users_home.jsp';");
					 out.println("</script>");
		    	     
		    	}
		    	else {
		    		response.setContentType("text/html");
					 out.println("<script type=\"text/javascript\">");
					 out.println("alert('Faild to add book');");
					 out.println("window.location.href='users_home.jsp';");
					 out.println("</script>");
		    	}
				
		    	con.close();
		        ps.close();
			} catch (Exception e) {
				 response.setContentType("text/html");
				 out.println("<script type=\"text/javascript\">");
				 out.println("alert(e.getMessage());");
				 out.println("window.location.href='users_home.jsp';"); // Redirect after alert
				 out.println("</script>");
			
			}
			
	}
}



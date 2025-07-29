package in.sp.backend;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("Its Work");
		int bookId = Integer.parseInt(request.getParameter("id")); 
	try {
		Connection con = DbConnection.getConnection();
        String query = "SELECT cover_image FROM books WHERE book_id =?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, bookId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            byte[] imgData = rs.getBytes("cover_image"); // Get image bytes
            response.setContentType("image/jpg"); // Set image type
            OutputStream os = response.getOutputStream();
            os.write(imgData);
            os.close();
            pstmt.close();
            con.close();   
        }
//        if (rs.next()) {
//            byte[] imgData = rs.getBytes("cover_image"); // Get binary data
//            if (imgData != null) {
//                response.setContentType("image/png"); // Set content type
//                response.getOutputStream().write(imgData);
//            } else {
//                System.out.println("Image is null for book ID: " + bookId);
//            }
//        } else {
//            System.out.println("No image found for book ID: " + bookId);
//        }

    } catch (Exception e) {
    	System.out.println(e.getMessage());
        
    }

}
}

package in.sp.dbcon;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewPdf")
public class ViewPDFSevlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bookId = Integer.parseInt(request.getParameter("book_id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","1234");

            String sql = "SELECT uploaded_book FROM books WHERE book_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookId);
            rs = stmt.executeQuery();

            if (rs.next()) {
            	byte[] fullPdf  = rs.getBytes("uploaded_book");
            	
            	byte[] limitedPdf = PDFTrimmer.trimPdfToPages(fullPdf ,0.10); // 700KB
            	response.setContentType("application/pdf");
            	response.setContentLength(limitedPdf.length);


                OutputStream out = response.getOutputStream();
                out.write(limitedPdf);
                out.flush();
                out.close();
            } else {
                response.setContentType("text/html");
                response.getWriter().println("Book not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    
	}

}

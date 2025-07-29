package in.sp.dbcon;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DownloadPDFServlet")
public class DownloadPDFServlet extends HttpServlet {
   

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        InputStream inputStream = null;

        try {
            con = DbConnection.getConnection();
            ps = con.prepareStatement("SELECT uploaded_book, book_name FROM books WHERE book_id = ?");
            ps.setInt(1, bookId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String title = rs.getString("book_name");
                inputStream = rs.getBinaryStream("uploaded_book");

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + title + ".pdf\"");

                OutputStream out = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            } else {
                response.getWriter().println("No file found for the given ID.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (inputStream != null) inputStream.close(); } catch (Exception e) {}
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}


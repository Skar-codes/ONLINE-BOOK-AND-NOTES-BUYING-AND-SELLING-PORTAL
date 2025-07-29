package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.cj.Session;

import in.sp.dbcon.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String paymentId = request.getParameter("payment_id");
        String orderId = request.getParameter("order_id");
//      String signature = request.getParameter("signature");
        String buyerName = request.getParameter("buyerName");
        int buyerId = (Integer)session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
       // PrintWriter out = response.getWriter();
        
        
        try {
        	
        	  Connection con = DbConnection.getConnection();
        	  PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE book_id = ?");
        	  ps.setInt(1, bookId);
        	  ResultSet rs = ps.executeQuery();
        	  if(rs.next())
        	  {
        		  String bookName = rs.getString("book_name");
                  String sellerName = rs.getString("seller_name");
                  int sellerId = rs.getInt("seller_id");
                  
                  double price = rs.getDouble("book_price");
                  
                  
                  PreparedStatement insertPayment = con.prepareStatement(
                		  "INSERT INTO transactions (payment_id, order_id, status, book_id, book_name, seller_name, seller_id, buyer_name, buyer_id, book_price) " +
                                  "VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?)");
                  insertPayment.setString(1, paymentId);
                  insertPayment.setString(2, orderId);
                  insertPayment.setString(3, "success");	
                  insertPayment.setInt(4, bookId);
                  insertPayment.setString(5, bookName);
                  insertPayment.setString(6, sellerName);
                  insertPayment.setInt(7, sellerId);
                  insertPayment.setString(8, buyerName);
                  insertPayment.setInt(9, buyerId);
                  insertPayment.setDouble(10, price);
                  int i = insertPayment.executeUpdate();
                  if(i > 0)
                	  response.getWriter().print("Payment recorded successfully.");
                  else
                	  response.getWriter().print("something went wrong!!!");
                  insertPayment.close();
        	  }
        	  rs.close();
              ps.close();
        }catch (Exception e) {
        	 e.printStackTrace();
        	 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving payment");
		}
	}

}

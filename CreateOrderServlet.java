package in.sp.backend;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.*;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
	  @Override
	  protected void doPost(HttpServletRequest request, HttpServletResponse response)
	  		throws ServletException, IOException {
		  
              PrintWriter out =response.getWriter();
	          try {
	              RazorpayClient razorpay = new RazorpayClient("rzp_test_9708N9gqmfBXw3", "5P9ZZZHVnm0oGjomt3SzTyQZ");
	              int amount = Integer.parseInt(request.getParameter("amount")); 
	              int bookId = Integer.parseInt(request.getParameter("bookId"));
	              amount *=100;
	              JSONObject orderRequest = new JSONObject();
	              orderRequest.put("amount", amount);
	              orderRequest.put("currency", "INR");
	              orderRequest.put("receipt", "txn_" + System.currentTimeMillis());

	              Order order = razorpay.Orders.create(orderRequest);

	              String orderId = order.get("id");
	              request.setAttribute("order_id", orderId);
	              request.setAttribute("amount", amount); 
	              request.setAttribute("bookId", bookId);
	              RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
	              dispatcher.forward(request, response);

	          } catch (Exception e) {
	        	  response.setContentType("text/html");
	              out.println("<script type=\"text/javascript\">");
	              out.println("alert('something went wrong !!');");
	              out.println("window.history.back();");
	              out.println("</script>");
	              e.printStackTrace();
	              e.printStackTrace();
	          }
	      }
}

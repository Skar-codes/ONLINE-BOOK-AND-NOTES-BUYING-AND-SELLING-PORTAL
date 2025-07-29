<%@ page import="in.sp.dbcon.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    int bookId = Integer.parseInt( request.getParameter("bookId"));
    int userId = (Integer)session.getAttribute("userId");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSet resultSet = null;
    
    try {
        con = DbConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM books WHERE book_id = ?");
        ps.setInt(1,bookId);
        rs = ps.executeQuery();    
        if (rs.next()) {
        	
           
        	String  title = rs.getString("book_name");
        	String sellerName = rs.getString("seller_name");
            int price = rs.getInt("book_price");
       
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
<link rel="stylesheet" href="billing.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
  crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="nav-bar">
    <a href="#" style="color: black;" onclick="window.history.back();"><i class="fa-solid fa-circle-arrow-left"></i></a>
    <div class="logo">
  		<span class="logo1">BOOK </span>
  		<span class="logo2">STORE</span>
  	</div>
 </div>
 <div class="top">
 	 <header id="head1">Cart</header>
 </div>
 <hr class = "redline">
 <div class="shoppingDetails">
       <div class="headding">
 		<h3 id="div1">Shopping Bag</h3> 
 		<h3 >Seller Name</h3>
 		<h3>Price</h3>
 	  </div>
 	    <hr>
 		<div class="book-list">
				        
		  <div  class="book-item" id="div2">
			 <img src="ImageServlet?id=<%= bookId %>" alt="Book Cover">
			 <div class="bookName"> Book Name
			    <p><%=rs.getString("book_name") %></p>
			 </div>
		  </div>
		  <div class="sellerName"><%=sellerName %> </div>
		   <div class="price">Rs <%= price %></div>
		  
				         
	   </div>
  <%
 
    	
    	ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
    	ps.setInt(1, userId);
    	resultSet = ps.executeQuery();
    	if(resultSet.next())
    	{
    		
  
  %>
 <form class="billing-form" action="CreateOrderServlet" method="post" >
		 <div class="billing-container">
		   <!--  <h2>Billing Detail</h2> -->
		    
		    <div class="form-group">
		      <label for="name">Name</label>
		      <input type="text" id="name" name="name" value="<%=resultSet.getString("firstname") +" "+ resultSet.getString("lastname")%>" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label for="email">Email</label>
		      <input type="email" id="email" name="email" value="<%=resultSet.getString("email") %>" readonly >
		    </div>
		    <br> <br>
		    <div class="form-group">
		      <label for="address">Address</label>
		      <input type="text" id="address" name="address" value="<%=resultSet.getString("city") %>" readonly >
		    </div>
		    
		    <div class="form-group">
		      <label for="phone">Phone</label>
		      <input type="tel" id="phone" name="phoneNo" value="<%=resultSet.getString("phoneno") %>" readonly >
		    </div>
		    <input type="hidden" class="payamount" name="amount" value="<%= price %>">
		    <input type="hidden" name="bookId" value="<%=bookId%>">
		    
		    <button type="submit" class="pay">Continue </button>
		 </div>
		 <!--   onclick="window.location.href='CreateOrderServlet?amount='"-->
 </form>
 </div>
 
    
                       <%
    	}
        }   
        					rs.close();
        					ps.close();
        					con.close();
				            } catch (Exception e) {
				            	
				            	response.setContentType("text/html");
				                out.println("<script type=\"text/javascript\">");
				                out.println("alert('something went wrong !!');");
				                out.println("window.history.back();");
				                out.println("</script>");
				                e.printStackTrace();
				            }
				         %>
				         
 <div class="footer">
	 <h2 class="footeradd">Address</h2>
	 <hr class = whiteline>
	 <p class = address>IN</p>
	 <p class = address>(+91)9382185056</p>
	 <p class = address>bookstore6825@gmail.com<p>
	<!--   <div class="social-icons">
            <a href="#"><i class="fa-brands fa-facebook"></i></a>
            <a href="#"><i class="fab fa-whatsapp"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
      </div>-->
 </div>
 
 <script type="text/javascript">
 
    function matchWidth() {
        let referenceDiv = document.getElementById("div2");
        let targetDiv = document.getElementById("div1");

        targetDiv.style.width = referenceDiv.offsetWidth + "px";
    }
    function paymentSrarted() {
    	console.log("Payment started");
    	var amount = document.getElementById("priceAmount").value;
    	console.log(amount);
        if(amount == '' || amount == null)
        	{
        	 alert("Please enter the amount");
        	}
		
	}
    function checkempty() {
    	let name =document.getElementById("name").value;
    	let email =document.getElementById("email").value;
    	let address =document.getElementById("address").value;
    	let phone =document.getElementById("phone").value;
    	
    	if(name == '' || name == null)
    		{
    		  alert("Please enter name!");
    		  return false;
    		}
    	if(email == '' || email == null)
		{
		  alert("Please enter email!");
		  return false;
		}
    	if(address == '' || address == null)
		{
		  alert("Please enter address!");
		  return false;
		}
    	if(phone == '' || phone == null)
		{
		  alert("Please enter phone no.!");
		  return false;
		}
    	
    	return true;
		
	}
   
    window.onload = matchWidth();
  
    window.onresize = matchWidth();

</script>
</body>
</html>
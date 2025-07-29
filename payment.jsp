<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="in.sp.dbcon.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String orderId = (String) request.getAttribute("order_id");
	String amount = request.getAttribute("amount").toString();
    int bookId = (Integer)request.getAttribute("bookId");
    int UserId = (Integer)session.getAttribute("userId");
    String buyerName = session.getAttribute("userName").toString() +" "+ session.getAttribute("userLastName").toString();
    ResultSet resultSet = null;
    ResultSet rs = null;
    try{
    	Connection con = DbConnection.getConnection();
    	PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
    	ps.setInt(1, UserId);
    	resultSet = ps.executeQuery();
    	if(resultSet.next())
    	{
    		 ps = con.prepareStatement("SELECT * FROM books WHERE book_id = ?");
    	     ps.setInt(1,bookId);
    	     rs = ps.executeQuery();    
    	     if (rs.next()) {
    	    	   	     
    	    	    String  title = rs.getString("book_name");
    	        	String sellerName = rs.getString("seller_name");
    	            int price = rs.getInt("book_price");
    	       
  %>
<html>
<head>
    <title>OnlineBookBuyingAndSellingPortal</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
  	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
  	crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style type="text/css">
    * {
	margin: 0;
	padding: 0;
}
.nav-bar{
 display:flex;
 background: rgba(245, 0, 10, 0.8);
 align-items:center;
 justify-content: space-between;
 width:100%;
 height: 80px;
}
.nav-bar a {
    color: white;
    font-size: 20px;
    margin: 0 10px;
    text-decoration: none;
    display: flex;
    font-size: 25px;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}
.logo{
  text-align: center;
  flex-grow: 1;
}
.logo1{

 font-size: 25px;
 font-weight: 500;
 color: white;
}
.logo2{
 font-size: 25px;
 font-weight: 700;
 
}
.top{
 height: 90px;
 display:flex;
 justify-content:flex-start;
 background: rgba(0, 0, 0, 0.15);
}
.top header{
    color: black;
	font-size: 25px;
	align-self:center;
	font-weight: 700;
	margin-left: 40px;
}
.paymentsummary{
   display: flex;
   border-radius: 12px;
   box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
   width: 800px;
   margin: 20px;
}
.buyerDetail{
 margin: 20px;

}
.book-list {
  			margin:20px;
 			
        }
        .book-item {
            display: inline-flex;
        }
        .book-item img {
            width: 150px;
            height: 200px;
            object-fit: cover;
        }
        .book-item .bookName {
            margin-left:10px;
            font-family:arial;
            font-size:12px;
            display: flex;
            flex-direction: column;
        }
        .bookName p{
            font-size:15px;
            font-family:arial;
        }
        .price {
            font-size: 18px;
            font-weight: bold;
            color: red;
        }
        
        
 #rzp-pay{
    padding: 5px;
    width:150px;
    margin:20px;
    margin-left:60px;
    align-self:flex-end;
    border-radius: 5px;
    background: blue;
    color: white;
   }
    </style>
</head>
<body>
<div class="nav-bar">
    <a href="#" style="color: black;" onclick="confirmExit()"><i class="fa-solid fa-circle-arrow-left"></i></a>
    <div class="logo">
  		<span class="logo1">BOOK </span>
  		<span class="logo2">STORE</span>
  	</div>
 </div>
 <div class="top">
 	 <header id="head1">Payment Summary</header>
 </div>
<div class="paymentsummary">
	 <div class="buyerDetail">
	   <h3><%=resultSet.getString("firstname") +" "+ resultSet.getString("lastname") %></h3>
	   <span><%=resultSet.getString("city") + ", " + resultSet.getString("email")%></span><br>
	   <span><%=resultSet.getString("phoneno") %></span>
	 </div>
	 <br>
	 <div class="book-list">
					        
			  <div  class="book-item" id="div2">
				 <img src="ImageServlet?id=<%= bookId %>" alt="Book Cover">
				 <div class="bookName">
				    <p><%=rs.getString("book_name") %></p>
				    <p><%=rs.getString("summary") %></p>
				 </div>
			  </div><br><br>
			   <div class="price">Price : Rs <%= price %></div>	         
	 </div>
	 <button id="rzp-pay">Pay  Rs <%=price %></button>
 </div> 


<!--  -->
<script>
   
    var options = {
    	    "key": "rzp_test_9708N9gqmfBXw3", // test key
    	    "amount": "<%=amount%>", // in paise = ₹500
    	    "currency": "INR",
    	    "name": "Book Store",
    	    "description": "Payment for" + "<%=rs.getString("book_name")%>",
    	    "order_id": "<%=orderId%>", // From step 1
    	    "handler": function (response){
    	        //alert("Payment successful! Payment ID: " + response.razorpay_payment_id);
    	        window.location.href = "DownloadPDFServlet?id=" + <%=bookId%>;
    	       
    	        fetch("PaymentSuccessServlet", {
    	            method: "POST",
    	            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    	            body: new URLSearchParams({
    	                payment_id: response.razorpay_payment_id,
    	                order_id: response.razorpay_order_id,
    	                bookId: "<%= bookId %>",
    	                buyerName: "<%= buyerName %>",
    	            })
    	        }) .then(response => response.text())
    	        .then(data => {
    	        	window.location.href = "users_home.jsp";
    	        })
    	    },
    	    "prefill": {
    	        "name":"<%=resultSet.getString("firstname") +" "+ resultSet.getString("lastname") %>",
    	        "email": "<%=resultSet.getString("email")%>",
    	        "contact": "<%= resultSet.getString("phoneno")%>"
    	    },
    	    "theme": {
    	        "color": "#3399cc"
    	    }
    	};
    var rzp1 = new Razorpay(options);
    document.getElementById('rzp-pay').onclick = function (e) {
        rzp1.open();
        e.preventDefault();
    }
    
    function confirmExit() {
    	  if (confirm("Are you sure you want to Exit?")) {
    	    window.history.back();
    	  }
    	}
</script>
<%

 	}
    	     }
    rs.close();
    resultSet.close();
    ps.close();
    con.close();
    		
    }catch(Exception e)
    {
    	response.setContentType("text/html");
        out.println("<script type=\"text/javascript\">");
        out.println("alert('something went wrong !!');");
        out.println("window.history.back();");
        out.println("</script>");
        e.printStackTrace();
    }
    %>

</body>
</html>

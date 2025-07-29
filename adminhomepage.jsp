<%@ page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="in.sp.dbcon.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
 <link rel="stylesheet" href="adminhomepage.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>
	<nav class = "nav">
		<div class = "nav-logo">
			<p class="logo1">BOOK</p>	 
			<p class="logo2">STORE</p> 
		</div>
		<div class="nav-menu">
		  <ul>
		  		<li> <a href="#" class="link active" onclick="home()" id="homeBtn">Home </a> </li>
		  		<li> <a href="books.jsp" class="link" id ="bookBtn">Books </a> </li>
		  		<li> <a href="notes.jsp" class="link" id ="noteBtn">Notes </a> </li>
		  		<li> <a href="usersview.jsp" class="link" id ="userBtn">Users </a> </li>
		  		<li> <a href="#" class="link" id ="transactionBtn" onclick="transaction()">Transactions </a> </li> 
		  		<li> <a href="logout" onclick="return confirmLogout()" class="link" id = "logoutBtn">Logout </a> </li>	  
		  </ul>	
		</div>
 	</nav>
    <div class="wrapper">
	
		<!-- --------View Content ----------------------->
	  <div  class="adminhomeview">
	  
	       <!-- ------  AdminHome ------->
	        <div  class="home" id="home">
	              <div class="top">
	    			 <header>Admin Home</header>
	    		  </div>
	    		  <div class = bodyview>
						<p class="note">Online Book Buying and Selling Portals carrying out the traditional selling process in an electronic form, 
						using the internet. An object of the present invention to provide an electronic reselling system that reduces the amount of money spend,
		 				and at the same time, that identifies the real users who needs the book and have offered the contract price, and moreover, to gain revenue to the Original Book seller.
		 				</p>
		 
        				<p class="note">Online stores are usually available 24 hours a day, and many consumers have Internet access both at work and at home. </p> 
         				<p class="note">Searching or browsing an online catalog can be faster than browsing the aisles of a physical store.
         				</p>
    			 </div>
	        </div> 
	       
	       
	        
	        <!-- ------  Transactions ------->
	        <div class="transactions" id="transactions">
	              <div class="top">
	    			 <header>Transaction</header>
	    		  </div>
	    		  
	    
	    		  <table class="transactionstable">
	    		     <tr>
	    		     	<th>Book Id </th>
	    		     	<th>Book Name </th>
	    		     	<th>Price</th>
	    		     	<th>Book Seller </th>
	    		     	<th>Book Buyer </th>
	    		     	<th>Date Purchased </th>
	    		     	<th>Action </th>
	    		     </tr>
	    		     <%
	    		      String trquery = "SELECT * FROM transactions";
	    		     try{
	    		      Connection con = DbConnection.getConnection();
	    		      PreparedStatement ps = con.prepareStatement(trquery);
	    		      ResultSet rs = ps.executeQuery();
	    		      while(rs.next())
	    		      {
	    		    	%>  
	    		    <tr>
	    		    <td><%=rs.getInt("book_id")%></td>
	    		    <td><%=rs.getString("book_name") %></td>
	    		    <td><%=rs.getDouble("book_price") %></td>
	    		    <td><%=rs.getString("seller_name") %></td>
	    		    <td><%=rs.getString("buyer_name") %></td>
	    		    <td><%=rs.getTimestamp("purchased_date") %></td>
	    		    <td><a href="transactionDetails.jsp?id=<%=rs.getInt("id")%>">More Info</a></td>
	    		    
	    		    </tr>	
	    		    	
	    		    	 <% 
	    		      }
	    		      //rs.close();
	    		      ps.close();
	    		      con.close();
	    		     }catch(Exception e)
	    		     {
	    		    	 out.print(e);
	    		     }
	    		       
	    		     %>
	    		    	
	    		  </table>    		     
	        </div> 
	      
	</div>
	
 </div>
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
      </div>
	-->
        <div class="footer-links">
            <a href="#">Home</a>
            <a href="books.jsp">Books</a>
            <a href="notes.jsp">Notes</a>
            <a href="usersview.jsp">Users</a>
            <a href="#" onclick="transaction()">Transactions</a>
            <a  href="logout" onclick="return confirmLogout()">Logout</a>
        </div>
 </div>
 <script type="text/javascript">
 	var hb = document.getElementById("homeBtn");
 	var tb = document.getElementById("transactionBtn");
 	var lb = document.getElementById("logoutBtn");
 	var hv = document.getElementById("home");
 	var tv = document.getElementById("transactions");
 	
 	
 	function home() {
 		hv.style.left = "1px";
 		tv.style.left = "100%";
 		hb.className += " active";
 		tb.className = "link";
 		lb.className = "link";
	}
	function transaction() {
		hv.style.left = "100%";
  		tv.style.left = "1px";
 		tb.className += " active";
 		hb.className = "link";
 		lb.className = "link";
	}
	
	function confirmLogout() {
		if(confirm("Are you sure you want to logout?"))
			return true;
		else
			return false;
		
	}
	    
 	
</script>
</body>
</html>
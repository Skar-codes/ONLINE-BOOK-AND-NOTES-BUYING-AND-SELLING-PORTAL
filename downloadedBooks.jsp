<%@ page import="in.sp.dbcon.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%  
    int UserId = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
<link rel="stylesheet" href="books.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
 	  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
  	  crossorigin="anonymous" referrerpolicy="no-referrer" />
 <style type="text/css">
.space{
height:100px;
background-color: rgba(0, 0, 0, 0.5);

}
.btn-download{
			cursor:pointer;
            margin-left: 10px;
 			border-radius: 5px;
 			padding: 5px;
            background-color: green;
            color: white;
}

 </style>
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
 	 <header>Download Books & Notes</header>
 </div>
 <hr class = "redline">
  <div class="buy-view">
	    		   <!--  <form  action="books.jsp">
	    		    	<input type="text" class="searchBox" name="query" id="searchBox" placeholder="Search Book">
	    		    	<button type="submit" >Search</button>
	    		    	 <%
								       
	    		    	// if ("admin".equals(role) == false)
						 //{
						  %>
	    		    			<a href="books.jsp?myBooks=true" id="MyBooks">My Books</a>
	    		    			
	    		    			<a href="books.jsp?myBooks=true" id="MyBooks">Downloaded Books</a>
	    		    			
	    		    	  <%
						  // }
						   %>
	    		     </form>  -->
	    		  
    			   <div class="booksview">
	    			  <div class="book-list">
				        <%  
	                        UserId = (Integer) session.getAttribute("userId");     	
				        	String query ;
				        	query = "SELECT * FROM books WHERE book_id IN(SELECT book_id FROM transactions T WHERE T.buyer_id = ? AND T.status = 'success')";
				        	
				            try {
				            	Connection con = DbConnection.getConnection();
				    	     	PreparedStatement ps = con.prepareStatement(query);
				    	     	ps.setInt(1, UserId);
				    	     	ResultSet rs = ps.executeQuery();
				    	     	 
				
				                while (rs.next()) {
				                    int bookId = rs.getInt("book_id");
				                    String title = rs.getString("book_name");
				                    double price = rs.getDouble("book_price");
				                    
				                   
				          %>
				                    <div  class="book-item">
				                        <img src="ImageServlet?id=<%= bookId %>" alt="Book Cover">
				                        <h3><%= title %></h3>
				                        <div class="price">Rs <%= price %></div>
				                        <button  class="btn-download" onclick="location.href='DownloadPDFServlet?id=<%=bookId%>'">Download</button>
				                    </div>
				         <%
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
				     </div>
				</div>
  </div>
  <div class="space">
  
  </div>
   <div class="footer">
		 <h2 class="footeradd">Address</h2>
		 <hr class = whiteline>
		 <p class = address>IN</p>
		 <p class = address>(+91)9382185056</p>
		 <p class = address>bookstore6825@gmail.com<p>
		<!--  <div class="social-icons">
	            <a href="#"><i class="fa-brands fa-facebook" ></i></a>
	            <a href="#"><i class="fab fa-whatsapp"></i></a>
	            <a href="#"><i class="fab fa-twitter"></i></a>
	            <a href="#"><i class="fab fa-instagram"></i></a>
	      </div> -->
 </div> 
 
</body>
</html>
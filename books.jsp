<%@ page import="in.sp.dbcon.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%  
	String role = (String) session.getAttribute("role"); 
    int UserId = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
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
 align-items:center;
 background: rgba(0, 0, 0, 0.15);
}
.top header{
    color: black;
	font-size: 35px;
	text-align: left;
	padding: 40px 20px 40px 100px;
	font-weight: 700;
}
.redline {
	border: 3px solid red;
}
.seller{
	height: 120px;
	align-items: center;
}
.seller header{
	color: black;
	font-size: 35px;
	text-align: left;
	padding: 40px 20px 40px 100px;
	font-weight: 700;
}
.buy-view{
  width: 100%;
  min-height: 60vh;
  height:auto;
  background: rgba(0, 0, 0, 0.29); 
}
.searchBox{
 width: 300px;
 padding: 5px;
 margin-left: 100px;
 margin-top: 30px;
 border-radius: 5px;
}
.searchButton{
  cursor: pointer;
  padding: 5px;
  border-radius: 5px;
}
.booksview{
 background: rgba(0, 0, 0, 0.29);
 padding-left: 20px;
 padding-right: 10px;
 height: auto;
 overflow: auto;
}
#MyBooks{
 background: rgba(0, 255, 0, 1);
 padding: 8px;
 border-radius: 30px;
 cursor: pointer;
 margin-left:100px;
 }
 #MyBooks:hover {
	background: rgba(0, 255, 0, 0.33);
}
 #Downloads{
 background: rgba(0, 255, 0, 1);
 padding: 8px;
 border-radius: 30px;
 cursor: pointer;
 margin-left:50px;
 }
 #Downloads:hover {
	background: rgba(0, 255, 0, 0.33);
}
.book-list {
            gap: 25px;
            min-height:50vh;
 			height: auto;
 			display: flex;
 			flex-wrap:wrap;
 			overflow: auto;
            
        }
        .book-item {
            width: 200px;
            text-align: center;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 10px;
            background: #f9f9f9;
        }
        .book-item img {
            width: 150px;
            height: 200px;
            object-fit: cover;
            border-radius: 5px;
        }
        .book-item h3 {
            font-size: 16px;
            margin: 10px 0;
        }
        .price {
            font-size: 18px;
            font-weight: bold;
            color: red;
            margin-bottom: 10px; 
        }
        .btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn-info {
            cursor:pointer;
       	    margin-right: 10px;
 			border-radius: 5px;
 			padding: 5px;
            background-color: black;
            color: white;
        }
        .btn-buy {
            cursor:pointer;
            margin-left: 10px;
 			border-radius: 5px;
 			padding: 5px;
            background-color: green;
            color: white;
        }
        .btn-delete{
        	cursor:pointer;
            margin-left: 10px;
 			border-radius: 5px;
 			padding: 5px;
            background-color: red;
            color: white;
        }
 .space{
	height:100px;
	background-color: rgba(0, 0, 0, 0.5);

}

        
      /*--- Footer---*/
      .footer{
position:absolute;
	background-color: black;
	height: 300px;
	width: 100%;
	align-items: center;
	display:flex;
	flex-direction: column;
	overflow: hidden;
}
.footeradd {
	color: white;
	align-items: center;
	padding-top: 40px;
	padding-bottom:5px;
	font-family: Arial;
	font-weight: 100;
	font-size: 30px;
}

.whiteline {
	color: white;
	width: 700px;
	margin-bottom: 20px;
}
.address{
	padding-top:10px;
	display: flex;
	align-items: center;
	color: white;
	font-family: Arial;
	font-weight: 100;
}
.social-icons {
    margin-top: 10px;
}

.social-icons a {
    color: white;
    font-size: 20px;
    margin: 0 10px;
    text-decoration: none;
    font-size: 25px;
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
 	 <header>Books</header>
 </div>
 <hr class = "redline">
  <div class="buy-view">
	    		    <form  action="books.jsp">
	    		    	<input type="text" class="searchBox" name="query" id="searchBox" placeholder="Search Book">
	    		    	<button type="submit" class="searchButton">Search</button>
	    		    	 <%
								       
	    		    	 if ("admin".equals(role) == false)
						 {
						  %>
	    		    			<a href="books.jsp?myBooks=true" id="MyBooks">My Books</a>
	    		    			<a href="downloadedBooks.jsp" id="Downloads">Downloads</a>
	    		    			
	    		    	  <%
						   }
						   %>
	    		     </form>
	    		   <div class="seller"> 
    			  		 <header>Best Seller</header>
    			   </div>
    			   <div class="booksview">
	    			  <div class="book-list">
				        <%  
				       	    if ("admin".equals(role) == false) {
	                             UserId = (Integer) session.getAttribute("userId");     	
				       	    }
				        	String myBooks = request.getParameter("myBooks");
				        	String searchQuery = request.getParameter("query");
				        	String query ;
				        	boolean searchSuccessfull = false ;
				        	
				        	if (searchQuery != null) {
				        	    query = "SELECT * FROM books WHERE category NOT IN(?) AND book_name LIKE ?";
				        	} else if (myBooks != null && myBooks.equals("true")) {
				        	    query = "SELECT * FROM books WHERE category NOT IN(?) AND seller_id = ?";
				        	} else if("admin".equals(role) == false) {
				        	    query = "SELECT * FROM books WHERE category NOT IN(?) AND seller_id NOT IN(?)";
				        	}
				        	else{
				        		query = "SELECT * FROM books WHERE category NOT IN(?)";
				        	}

				            
				            
				           // out.println("<h3>Search results for: " + searchQuery + "</h3>");
				            try {
				            	Connection con = DbConnection.getConnection();
				    	     	PreparedStatement ps = con.prepareStatement(query);
				    	    	ps.setString(1, "Study Guides");
				    	     	if (searchQuery != null) {
				    	     	    ps.setString(2, "%" + searchQuery + "%");
				    	     	} else if ("admin".equals(role) == false && (myBooks != null && myBooks.equals("true"))) {
				    	     	    ps.setInt(2, UserId); 
				    	     	}else if("admin".equals(role) == false)
				    	     	{
				    	     		ps.setInt(2, UserId);
				    	     	}
				   
				    	     	ResultSet rs = ps.executeQuery();
				    	     	 
				
				                while (rs.next()) {
				                    int bookId = rs.getInt("book_id");
				                    String title = rs.getString("book_name");
				                    double price = rs.getDouble("book_price");
				                    int SellerId = rs.getInt("seller_id");
				                    searchSuccessfull = true;
				          %>
				                    <div  class="book-item">
				                        <img src="ImageServlet?id=<%= bookId %>" alt="Book Cover">
				                        <h3><%= title %></h3>
				                        <div class="price">Rs <%= price %></div>
				                        <button  class="btn-info" onclick="location.href='bookinfo.jsp?bookId=<%=bookId%>'">Info</button>
								    <%
								       
								        if (role == null || !role.equals("admin")) {
								        	if (SellerId != UserId)
								        	{
								    %>     
								          		<button class="btn-buy" onclick="location.href='billing.jsp?bookId=<%=bookId%>'">Buy</button>
								         <%  }
								        }
								         	
				                       %>
				                       
				                    </div>
				         <%
				                }
				                ps.close();
				                
				                if(searchQuery != null && searchSuccessfull){
				                	ps = con.prepareStatement("UPDATE users SET lastsearch = ? WHERE user_id = ?");
					                ps.setString(1, searchQuery);
					                ps.setInt(2, UserId);
					                int update = ps.executeUpdate();
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
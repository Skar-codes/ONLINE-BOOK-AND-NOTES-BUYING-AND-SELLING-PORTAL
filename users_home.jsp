<%@ page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="in.sp.dbcon.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
 @charset "UTF-8";
* {
	margin: 0;
	padding: 0;
}
.profile-icon {
  margin-top:10px;
  width: 35px;
  height: 35px;
  background-color: black;       
  border-radius: 50%;          
  display: flex;
  align-self:center;
  align-items: center;
  justify-content: center;
  border: 2px solid white;      
  color: red;                   
  font-size: 20px;      
}
.nav {
	display: flex;
	justify-content: space-around;
	width: 100%;
	height: 80px;
	line-height: 100px;
	background: rgba(245, 0, 10, 0.8);
	z-index: 100;
}

.nav-logo {
	display: inline-flex;
}

.nav-logo .logo1 {
	color: white;
	font-size: 25px;
	font-weight: 500;
}

.nav-logo .logo2 {
	color: black;
	font-size: 25px;
	font-weight: 700;
}

.nav-menu ul {
	display: flex;
}

.nav-menu ul li {
	list-style-type: none;
}
.nav-menu ul li .link {
	text-decoration: none;
	font-weight: 500;
	color: #fff;
	padding-bottom: 15px;
	margin: 0 25px;
}

.link:hover, .active {
	border-bottom: 2px solid #fff;
}
.wrapper {
    position:relative;
	justify-content: center;
	align-items: center;
	width: 100%;
	min-height:180vh;
	height: auto;
	overflow: hidden;
}
.userhomeview{
	width: 100%;
	min-height:155vh;
	height: auto;
	overflow: hidden;
}
.home{
	position:absolute;
	left: 0px;
	width: 100%;
	height:auto;
	transition: .09s ease-in-out;
}
.recommendedBooks{
 background: white;
 padding-left: 20px;
 padding-right: 10px;
 height: auto;
 overflow: auto;
}
.book-list {
            gap: 30px;
            min-height:50vh;
 			height: auto;
 			display: flex;
 			/*flex-wrap:wrap;*/
 			overflow: scroll;
            
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
       	    margin-left: 10px;
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
        
.sale{
	position:absolute;
	left: 100%;
	width: 100%;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
	overflow: hidden;
	overflow: hidden;
	
}
.history{
	position:absolute;
	left: 100%;
	width: 100%;
	min-height:150vh;
	height:auto;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
	overflow: hidden;
	
}
.buyerInfo{
	position:absolute;
	left: 100%;
	width: 100%;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
	overflow: hidden;
}


.top{
	display: flex;
	width: 100%;
	height: 100px;
	justify-content:flex-start;
	background: rgba(0, 0, 0, 0.15);
    }
header{
	color: black;
	font-size: 35px;
	align-self:center;
	margin-left:100px;
	font-weight: 700;
}

/* ------ Table ------   */
table {
            width: 100%;
            border-collapse: collapse;
            background-color: #001a22; /* Dark background */
            color: white; /* Text color */
            margin-top: 40px;
            margin-left: 30px;
            margin-right: 30px;
        }
 th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

  th {
            background-color: #001a22; /* Header background */
            color: gold; /* Header text color */
      }

  tr:hover {
            background-color: #003844; /* Hover effect */
           }

   td {
            color: #f1f1f1;
       }

/* ------ home------*/
.bodyview{
	width: 100%;
	min-height:80vh;
	height: auto;
	align-items: flex-start;
	display: inline-flex;
	padding-top: 50px;
	padding-left: 100px;
	padding-right: 20px;
    }
img{
	width: 400px;
}  
.note{
	margin-left:40px;
	font-size: 15px;
	font-weight: normal;
	font-family: cursive;
	padding-right:230px;
}

/*-------Sale--------*/
.vaddbook{
  	padding-left: 100px;
  	padding-top: 15px;
  	font-size: 20px;
}
.addbook{
	 margin-bottom:20px;
	 padding-top:15px;
	 text-align: center;
	 font-size: 20px;
}
.form-box{
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 50vh;
    }
.addbookview{
	display:flex;
	flex-direction: column;
	width: 850px;
}
.input-field{
    margin-bottom: 20px;
    margin-top: 5px;
    padding-top: 10px;	
    padding-bottom: 10px;
    border:2px solid red;
}
.input-field-submit{
	width:100px;
	height:30px;
	align-self:center;
	margin-top: 30px;
	
	border-radius: 10px;
	}
.input-field-submit:hover{
    background: rgba(0, 255, 0, 0.52)
}


/*------Footer--------*/
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

.footer-links {
    margin-top: 15px;
}

.footer-links a {
    color: #fff;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
}

.footer-links a:hover, .social-icons a:hover {
    color: #1e90ff;
}

</style>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
<!-- <link rel="stylesheet" href="users_home.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
 	  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
  	  crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

   <nav class = "nav">
        <div class="profile-icon">
          <a href="profile.jsp?id=<%=session.getAttribute("userId")%>" style="color: white;"><i class="fa-solid fa-user"></i></a>
        </div>
		<div class = "nav-logo">
			<p class="logo1">BOOK</p>	 
			<p class="logo2">STORE</p> 
		</div>
		<div class="nav-menu">
		  <ul>
		  		<li> <a href="#" class="link active" onclick="home()" id="homeBtn">Home </a> </li>
		  		<li> <a href="books.jsp" class="link" id ="bookBtn">View Books </a> </li>
		  		<li> <a href="notes.jsp" class="link" id ="buyBtn">View Notes </a> </li>
		  		<li> <a href="#" class="link" id ="saleBtn" onclick="sale()">Sale </a> </li> 
		  		<li> <a href="#" class="link" id = "historyBtn" onclick="history()">History </a> </li>	
		  		<li> <a href="#" class="link" id = "buyerinfoBtn" onclick="buyerInfo()">Buyer Info </a> </li>	
		  		<li> <a href="logout" onclick="return confirmLogout()" class="link" id = "logoutBtn">Logout </a> </li>	  
		  </ul>	
		</div>
 	</nav>
 <div class="wrapper">
 	 <div  class="userhomeview">
	  
	  <!-- ------------Profile----------- -->
	  
	       <!-- ------  UsersHome ------->
   <div  class="home" id="home">
	              <div class="top">
	    			 <header>Welcome <%=session.getAttribute("userName") %></header>
	    		  </div>
	    		  <div class = bodyview>
	    		    	<img src="books.png">
        				<div class="note">Online Book Buying and Selling Portals carrying out the traditional selling
        				 process in an electronic form, using the internet. An object of the present invention to 
        				 provide an electronic reselling system that reduces the amount of money spend, and at the same time,
        				  that identifies the real users who needs the book and have offered the contract price, and moreover, 
        				  to gain revenue to the Original Book seller. <br> <br>
                         <p>Online stores are usually available 24 hours a day, and many consumers have Internet access both at work and at home. </p>  <br>
                         <p>Searching browsing an online catalog can be faster than browsing the aisles of a physical store. </p>
                        </div> 
    			   </div>
    			 <div class="recommendedBooks">
    			    <h3 style="background: rgba(255, 0, 0, 0.57);">Recommended Books</h3>
    			    <div class="book-list">
				        <%
                            int UserId = (Integer) session.getAttribute("userId");
				        	String lastSearch = null;
				            Connection con = null;
				            PreparedStatement ps = null;
				            ResultSet result = null;
				            ResultSet rs = null;
				        	String query = null ;
				            
				            
				           // out.println("<h3>Search results for: " + searchQuery + "</h3>");
				            try {
				            	
				            	con = DbConnection.getConnection();
				            	ps = con.prepareStatement("SELECT * FROM users WHERE user_id=?");
				            	ps.setInt(1, UserId);
				            	result = ps.executeQuery();
				            	if(result.next()){
				            		 lastSearch = result.getString("lastsearch");
				            		 
				            	}
				            	result.close();
				            	ps.close();
				            	
				                if(lastSearch != null)
					            	 query = "SELECT * FROM books WHERE seller_id NOT IN(?) AND book_name LIKE ?";
					            else
					            	 query = "SELECT * FROM books WHERE seller_id NOT IN(?)";
				    	     	ps = con.prepareStatement(query);
				    	     	ps.setInt(1, UserId);
				    	     	if(lastSearch != null)
				    	     		ps.setString(2, "%" + lastSearch + "%");
				    	        rs = ps.executeQuery();
				    	     	 
				
				                while (rs.next()) {
				                    int bookId = rs.getInt("book_id");
				                    String title = rs.getString("book_name");
				                    double price = rs.getDouble("book_price");
				          %>
				                    <div  class="book-item">
				                        <img src="ImageServlet?id=<%= bookId %>" alt="Book Cover">
				                        <h3><%= title %></h3>
				                        <div class="price">Rs <%= price %></div>
				                        <button  class="btn-info" onclick="location.href='bookinfo.jsp?bookId=<%=bookId%>'">Info</button>
								    <%
								        String role = (String) session.getAttribute("role");
								        if (role == null || !role.equals("admin")) {
								    %>
								        <button class="btn-buy" onclick="location.href='billing.jsp?bookId=<%=bookId%>'">Buy</button>
								    <%
								        }
								    %>
				                    </div>
				         <%
				                }
				                rs.close();
				                ps.close();
				            } catch (Exception e) {
				                response.setContentType("text/html");
				                out.println("<script type=\"text/javascript\">");
				                out.println("alert('something went wrong !!');");
				                e.getMessage();
				                out.println("window.history.back();");
				                out.println("</script>");
				                e.printStackTrace();
				            }
				         %>
				     </div>
    			   </div>
	 </div>
   
	        <!-- -------Sale----------- -->
   <div class="sale" id="sale">
	        	<div class="top">
	    			 <header>Sale a Book</header>
	    		</div>
	    		<div class="saleview">
	    			<div class="vaddbook">
	    			   View added Books / Notes 
	    			</div>
	    			<div class="addbook">
	    				 Add Books / Notes
	    			</div>
	    			<div class="form-box">
		    			<form action="bookAddedForm" onsubmit="return IsCategory()" method="post" class="addbookview" id="addbooks" enctype="multipart/form-data">
						            <input class="input-field" type="text" name="bookName" placeholder="Book Name" required>
						            <input class="input-field" type="text" name="authorName" placeholder="Author Name" required>
						            <textarea class="input-field"  name="summary" placeholder="Summary" required></textarea>
                                    <select class="input-field"   name="category" id="bookType"  required>
										  <option >Select Category</option>
										  <option value="Textbooks">Textbooks</option>
										  <option value="Study Guides">Study Guides(Notes)</option>		  
									</select>
						            <label>Cover Image</label>
						            <input class="input-field" type="file" name="coverImage" required>
						            <label>Upload Book</label>
						            <input class="input-field" type="file" name="uploadBook" required>
						            <input class="input-field" id="bookPrice" type="number" name="bookPrice" placeholder="Book Price" required>
						            <button class="input-field-submit" type="submit">Add Book</button>
						 </form>
	    			</div>
					    
	    		
	    		</div>
	        
	         </div>
 
	    
	  <!---------- History ----------->
    <div class="history" id="history">
		              <div class="top">
		    			 <header>History</header>
		    		  </div>
		  	
		    		  <table class="usertable">
		    		     <tr>
		    		     	<th>Book Id </th>
		    		     	<th>Book Name </th>
		    		     	<th>Price</th>
		    		     	<th>Book Seller</th>
		    		     	<th>Book Buyer </th>
		    		     	<th>Date Purchased </th>
		    		     </tr>
		    		     <%
		    		    int buyerId = (Integer) session.getAttribute("userId") ;
	    		      String history = "SELECT * FROM transactions WHERE buyer_id = ?";
	    		     try{
	    		      ps = con.prepareStatement(history);
	    		      ps.setInt(1, buyerId);
	    		      rs = ps.executeQuery();
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
	    		       
	    		    </tr>	
	    		    	
	    		    	 <% 
	    		      }
	    		      rs.close();
	    		      ps.close();
	    		      
	    		     }catch(Exception e)
	    		     {
	    		    	 out.print(e);
	    		     }
	    		       
	    		     %>
		    		  </table>
		     
		     </div>
	     <!-- --------BuyerInfo ----->
	<div class="buyerInfo" id="buyerInfo">
	              <div class="top">
	    			 <header>Buyer Info</header>
	    		  </div>
	    
	    		  <table class="usertable">
	    		     <tr>
	    		     	<th>Book Id </th>
	    		     	<th>Book Name </th>
	    		     	<th>Price</th>
	    		     	<th>Book Seller</th>
	    		     	<th>Book Buyer </th>
	    		     	<th>Date Purchased </th>
	    		     	<th>Action</th>
	    		     </tr>
	    		     <%
	    		      
	    		      String buyerinfo = "SELECT * FROM transactions WHERE seller_id = ? ";
	    		     try{
	    		      ps = con.prepareStatement(buyerinfo);
	    		      ps.setInt(1, buyerId);
	    		      rs = ps.executeQuery();
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
	    		      rs.close();
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
	      </div>-->
	        <div class="footer-links">
	            <a href="#">Home</a>
	            <a href="books.jsp">View Books</a>
	            <a href="books.jsp">Buy</a>
	            <a href="#" onclick="sale()">Sale</a>
	            <a href="#" onclick="history()">History</a>
	            <a href="#"  onclick="buyerInfo()">Buyer Info</a>
	            <a href="logout" onclick="return confirmLogout()">Logout</a>
	        </div>
 </div> 
	  <!-- ------- -->
  
 
  <script type="text/javascript">
 	var hb = document.getElementById("homeBtn");
 	var saleb = document.getElementById("saleBtn");
 	var hisb = document.getElementById("historyBtn");
 	var bib = document.getElementById("buyerinfoBtn");
 	var hv = document.getElementById("home");
 	var salev = document.getElementById("sale");
 	var hisv = document.getElementById("history");
    var buyerv = document.getElementById("buyerInfo");
 	
 	
 	
 	function home() {
 		hv.style.left = "0px";
 		salev.style.left = "100%";
 	    hisv.style.left = "100%";
 	    buyerv.style.left = "100%";
 		hb.className += " active";
 		saleb.className = "link";
 		hisb.className = "link";
 		bib.className = "link";
	}
	function sale() {
		hv.style.left = "100%";
 		salev.style.left = "0px";
 		hisv.style.left = "100%";
  	    buyerv.style.left = "100%";
 		hb.className = "link";
 		saleb.className += " active";
 		hisb.className = "link";
 		bib.className = "link";
	}
	function history() {
		hv.style.left = "100%";
 		salev.style.left = "100%";
 		hisv.style.left = "0px";
  	    buyerv.style.left = "100%";
 		hb.className = "link";
 		saleb.className = "link";
 		hisb.className += " active";
 		bib.className = "link";
	}
	function buyerInfo() {
		hv.style.left = "100%";
 		salev.style.left = "100%";
 		hisv.style.left = "100%";
  	    buyerv.style.left = "0px";
 		hb.className = "link";
 		saleb.className = "link";
 		hisb.className = "link";
 		bib.className += " active";
	}
	
	function confirmLogout() {
		if(confirm("Are you sure you want to logout?"))
			return true;
		else
			return false;
		
	}
	function IsCategory() {
		var bookType = document.getElementById("bookType").value;
		var bookPrice = document.getElementById("bookPrice").value;
		if(bookType == "Select Category"){
			alert("Please select book category!!");
			return false;
		}
		else if(( bookPrice > 300) && (bookType == "Textbooks")) {
			alert("Books price is maximum Rs. 300  !!");
			return false;
		}else if(( bookPrice > 300) && (bookType == "Study Guides")){
			alert("Notes price is maximum Rs. 300  !!");
			return false;
		}else
			return true;		    
		
	}
 	
</script>
</body>
</html>
<%@page import="java.sql.ResultSet"%>
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
<!--  <link rel="stylesheet" href="index.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
  crossorigin="anonymous" referrerpolicy="no-referrer" />
  <style type="text/css">
  @charset "UTF-8";

* {
	margin: 0;
	padding: 0;
}

.nav {
	top: 0;
	display: flex;
	justify-content: space-around;
	width: 100%;
	height: 90px;
	line-height: 100px;
	background: linear-gradient(rgba(39, 39, 39, 0.6), transparent);
	z-index: 100;
	background-color: rgba(255, 0, 0, 0.77);
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
.homeview{
	position: relative;
	display: flex;
	align-items: flex-start;
	width: 100%;
	height: 100%;
	overflow: hidden;
	z-index: 2; 
}
.home{
	position:relative;
	left: 4px;
	width: 100%;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
}
.aboutus{
	position:absolute;
	left: 100%;
	width: 100%;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
}
.top{
	display: flex;
	width: 100%;
	height: 160px;
	align-items: flex-start;
	background: rgba(0, 0, 0, 0.15);
    }
header{
	color: black;
	font-size: 35px;
	text-align: left;
	padding: 60px 0 0 170px;
	font-weight: 700;
}
.bodyview{
	width: 100%;
	height: 160px;
	align-items: flex-start;
	display: inline-flex;
	padding-top: 50px;
	padding-left: 170px;
    }
img{
	width: 400px;
}  
.scopetxt{
	padding-top:100px;
	margin-left:40px;
	font-size: 35px;
	font-weight: 700;
	padding-right:230px;
}
.note{
	font-size: 15px;
	font-weight: normal;
	font-family: cursive;
	padding-top: 10px;
}
.wrapper {
	background-image: url("home.jpg");
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 90vh;
	overflow: hidden;
}
.appheaddiv{
	margin-top:200px;
	height: 300px;
	width: 100%;
	align-items: center;
	display:flex;
	flex-direction: column;
	overflow: hidden;
	color: white;
	font-size: 50px;
}
.secondindexpage {
	height:370px;
	width: 100%;
}

.abstract {
	font-family: Arial;
	font-size: 30px;
	padding-left: 50px;
	padding-right: 50px;
	padding-top: 50px;
}

.aboutabstract {
	font-family: Arial;
	font-size: 15px;
	padding-left: 50px;
	padding-right: 50px;
	padding-top: 10px;
}

.redline {
	border: 3px solid red;
	width: 100%;
	margin-top: 50px;
}

.ourbooks {
	font-family: Arial;
	padding-left: 50px;
	padding-right: 50px;
	padding-top: 30px;
	font-size: 30px;
}
/*.space{
	display: flex;
	width: 100%;
	height: 160px;
	align-items: flex-start;
	background: rgba(0, 0, 0, 0.15);
    overflow: hidden;
}*/
.space{
 background: rgba(0, 0, 0, 0.29);
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
        
.footer{
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
	/*display: block;
	width: 33.3%;
	margin: 12px auto;
	margin-top: 80px;
	margin-left: 550px;*/
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
    margin: 10px 0;
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
</head>
<body>
    <nav class = "nav">
			<div class = "nav-logo">
				<p class="logo1">BOOK</p>	 
				<p class="logo2">STORE</p> 
			</div>
			<div class="nav-menu">
			  <ul>
			  		<li> <a href="#" class="link active" id="homeBtn" onclick="home()">Home </a> </li>
			  		<li> <a href="adminLogin.html" class="link" id ="adminBtn" >Admin </a> </li>
			  		<li> <a href="user_login_register.html" class="link" id ="userBtn" >Users </a> </li>
			  		<li> <a href="#" class="link" id="aboutusBtn" onclick="aboutus()">About Us </a> </li> 	  
			  </ul>	
			</div>
    </nav>
<!-- -------------------------HomePage View  --------- -->
<div class="homeview">

<!------------------ Home ---------------->
	  <div class="home" id="home">
	   	<div class="wrapper">
			<div class="appheaddiv" >
				Online Book Buying and Selling Portal
			</div>
	 	</div>
	 
	 	 <div class = secondindexpage>
			<h2 class="abstract">Abstract</h2>
			<p class="aboutabstract">In this project, we develop Online Book Buying and Selling Portal in Java. This project is like an e- bookstore website where books can be bought from the comfort of home through the Internet. A user can buy the books or can upload their books to resell them on the online. An online bookstore is a virtual store on the Internet where customers can browse the catalog and select books of interest. User can select many books and those books stored in cart. At checkout time, the items in the shopping cart will be presented as an order. At that time, more information will be needed to complete the transaction. Usually, the customer will be asked to fill the basic details or select a billing address, a shipping address, a shipping option, and payment option such as cash on delivery or online payment etc.</p>
			<hr class = redline>
			<h2 class="ourbooks">Our Books</h2>
		 </div>
		 <div class="space">
		 	<div class="book-list">
				        <%
                           
				            String query = "SELECT * FROM books";
				            
				            
				           // out.println("<h3>Search results for: " + searchQuery + "</h3>");
				            try {
				            	Connection con = DbConnection.getConnection();
				    	     	PreparedStatement ps = con.prepareStatement(query);
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
				                        <button  class="btn-info" onclick="location.href='user_login_register.html'">Info</button>
								        <button class="btn-buy" onclick="location.href='user_login_register.html'">Buy</button>
								  <!-- <button  class="btn btn-buy" onclick="location.href='billing.jsp?bookId=<%=bookId%>'">Buy</button>-->
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
	  
<!-- -----------About Us --------------- -->
     <div  class="aboutus" id="aboutus">
	              <div class="top">
	    			 <header>About</header>
	    		  </div>
	    		  <div class = bodyview>
	    		    	<img src="books.png">
	    		    	<div class="scopetxt">Scope
        				<p class="note">Online Book Buying and Selling Portals carrying out the traditional 
        				selling process in an electronic form, using the internet. An object of the present 
        				invention to provide an electronic reselling system that reduces the amount of money 
        				spend, and at the same time, that identifies the real users beeds the book and have 
        				offered the contract price, and moreover, to gain revenue to the Original Book seller. 
                        </p> 
         				</div>
    			 </div>
	  </div> 
 </div>
 
<!-- - -->
 <div class="footer">
	 <h2 class="footeradd">Address</h2>
	 <hr class = whiteline>
	 <p class = address>IN</p>
	 <p class = address>(+91)9382185056</p>
	 <p class = address>bookstore6825@gmail.com<p>
	 <!--  <div class="social-icons">
            <a href="#"><i class="fa-brands fa-facebook"></i></a>
            <a href="#"><i class="fab fa-whatsapp"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
      </div>-->
        <div class="footer-links">
            <a href="#">Home</a>
            <a href="adminLogin.html">Admin</a>
            <a href="user_login_register.html">Users</a>
            <a href="#" onclick="aboutus()">About Us</a>
        </div>
 </div>
 
 <script type="text/javascript">
 	var hb = document.getElementById("homeBtn");
 	var ab = document.getElementById("aboutusBtn");
 	var hv = document.getElementById("home");
 	var av = document.getElementById("aboutus");
 	
 	
 	function home() {
 		hv.style.left = "4px";
 		av.style.left = "100%";
 		hb.className += " active";
 		ab.className = "link";
	}
 	function aboutus() {
 		hv.style.left = "100%";
 		av.style.left = "4px";
 		ab.className += " active";
 		hb.className = "link";
	}
</script>
 
</body>
</html>
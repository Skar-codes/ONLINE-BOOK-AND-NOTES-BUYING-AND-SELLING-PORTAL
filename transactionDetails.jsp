<%@page import="java.sql.Date"%>
<%@page import="in.sp.dbcon.DbConnection"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>OnlineBookBuyingAndSellingPortal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
    integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
	crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
    
  body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            overflow: hidden;
      }
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
 height: 60px;
 display:flex;
 justify-content:center;
 background: rgba(0, 0, 0, 0.15);
}
.top header{
    color: black;
	font-size: 25px;
	align-self:center;
	font-weight: 700;
	margin-left: 20px;
}
 .container {
           height: 70vh;
           width: 100%;
           margin: 20px;
           display: flex;
           justify-content: center;
            overflow: hidden;
        }
        .buyer-image {
            height:250px;
            width:200px;
            border: 1px solid  black;
            padding: 30px;
            border-radius: 5px;
            display:flex;
            flex-direction:column;
            justify-content:space-between;
            margin-right: 30px;
        }
        .buyer-image img{
         height: 200px;
         width: 200px;
        }
        .buyer-image p{
         align-self: center;
        }
        .details  {
            min-height: 60vh;
            width:400px;
            padding:20px;
            border-radius: 5px;
            border: 1px solid  black;
           
            font-family: Arial, sans-serif;
        }
      .details .row {
      display: flex;
      justify-content: space-between;
      padding: 10px 0;
      
    }
    .line{
    margin-bottom: 10px;
      margin-top: 10px;
    }
    .details .row:last-child {
      border-bottom: none;
    }
        
    .label {
      font-size:12px;
      color: #333;
    }

    .value {
      font-size:12px;
      color: #555;
    }
    
       
    </style>
</head>
<body>
<%
    int transactionsId =Integer.parseInt(request.getParameter("id"));
    String bookName = "", sellerName = "", sellerEmail = "", buyerName = "", buyerEmail = "", buyerGender = "", buyerPhone = "", buyerAddress = "";
    int price = 0 , buyerId = 0;
    
    Timestamp purchasedDate = Timestamp.valueOf("2025-05-10 15:30:00");
    try {
        Connection con = DbConnection.getConnection();

        PreparedStatement ps = con.prepareStatement("SELECT * FROM transactions WHERE id=?");
        ps.setInt(1, transactionsId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            bookName = rs.getString("book_name");
            price = rs.getInt("book_price");
            sellerName = rs.getString("seller_name");
            buyerId = rs.getInt("buyer_id");
            buyerName = rs.getString("buyer_name"); 
            purchasedDate = rs.getTimestamp("purchased_date");
            
             ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
             ps.setInt(1,buyerId);
             ResultSet result = ps.executeQuery();
             if(result.next())
             {
                 buyerEmail = result.getString("email");
                 buyerPhone = result.getString("phoneno");
                 buyerAddress = result.getString("city");
                 buyerGender = result.getString("gender");
                 
             }
             }

         con.close();
     } catch(Exception e) {
         out.println("Error: " + e.getMessage());
     }
%>
<div class="nav-bar">
    <a href="#" style="color: black;" onclick="window.history.back();"><i class="fa-solid fa-circle-arrow-left"></i></a>
    <div class="logo">
  		<span class="logo1">BOOK </span>
  		<span class="logo2">STORE</span>
  	</div>
 </div>
 <div class="top">
 	 <header id="head1">Buyer Details</header>
 </div>
<div class="container">
    <div class="buyer-image">
    <%
       if(buyerGender.equals("Male")){
    %>
       <img src="userboy.png" alt="User Icon" />
      <%
       }
       else if(buyerGender.equals("Female")){
      %> 
           <img src="usergirl.png" alt="User Icon" />
           
      <%
          }
       else{
    	%>
    	<img src="userother.png" alt="User Icon" />
    	<%
         }
       %>
        <p><%=buyerName %></p>
    </div>

    <div class="details">
        
              <div class="row"><span class="label">Book Name</span><span class="value"><%=bookName %></span></div>
              <hr class="line">
			  <div class="row"><span class="label">Seller Name</span><span class="value"><%=sellerName %></span></div>
			  <div class="row"><span class="label">Price</span><span class="value"><%=price %></span></div>
			    <hr class="line">
			  <div class="row"><span class="label">Buyer Mail</span><span class="value"><%=buyerEmail %></span></div>
			  <div class="row"><span class="label">Buyer Phone</span><span class="value"><%=buyerPhone %></span></div>
			   <hr class="line">
			  <div class="row"><span class="label">Buyer Address</span><span class="value"><%=buyerAddress %></span></div>
			  <div class="row"><span class="label">Date Purchased</span><span class="value"><%=purchasedDate %></span></div>
     
    </div>
</div>
</body>
</html>

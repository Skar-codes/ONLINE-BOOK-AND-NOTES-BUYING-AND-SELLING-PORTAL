<%@ page import="in.sp.dbcon.DbConnection"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int bookId = Integer.parseInt( request.getParameter("bookId"));
	String role = (String) session.getAttribute("role"); 
	int UserId = 0;
	if ("admin".equals(role) == false) {
    	UserId = (Integer) session.getAttribute("userId");     	
  	}
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = DbConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM books WHERE book_id = ?");
        ps.setInt(1,bookId);
        rs = ps.executeQuery();    
        if (rs.next()) {
        	
           
            String title = rs.getString("book_name");
            double price = rs.getDouble("book_price");
            int book_Id = rs.getInt("book_id");
            int seller_id = rs.getInt("seller_id");
            String category = rs.getString("category");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
<style type="text/css">
.nav-bar{
 display:flex;
 background: rgba(245, 0, 10, 0.8);
 justify-content: center;
 width:100%;
 height: 80px;
}
.logo{
  display: inline-flex;
  align-items: center;
}
.logo1{

 font-size: 25px;
 font-weight: 600;
 color: white;
}
.logo2{
 font-size: 25px;
 font-weight: 600;
 
}
.top{
 height: 90px;
 width: 100%;
 background: rgba(0, 0, 0, 0.15);
 display: flex;
 justify-content: center;
}
.top header{
 display:flex;
 align-items: center;
 font-size: 35px;
 font-weight: 600;
}
.book-info{
 width: 100%;
 min-height: 80vh;
 height:auto;
 background: rgba(0, 0, 0, 0.05);
 display: flex;
 justify-content: center;
}
.book-details{
 margin-top: 30px;
 width:800px;
 height: 80vh;
 background: rgba(0, 0, 0, 0.15);
 display: flex;
 flex-direction:row;
  align-items: flex-start;
 
}
.book-details img{
width: 400px;
height: 80vh;
}
.details{
 	flex: 1;
    padding: 20px;
    background-color: #d3d3d3; 
}
.btn-back {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: black;
            color: white;
        }
       
 .btn-buy {
        	padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: green;
            color: white;
        }
   .btn-preview{
   			padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: green;
            color: white;
   }
   .btn-download{
   			padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: green;
            color: white;
   }
   .btn-update{
   			padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: green;
            color: white;
   }
</style>
</head>
<body>

 <div class="nav-bar">
    <div class="logo">
  		<div class="logo1">BOOK </div>
  		<div class="logo2">STORE</div>
  	</div>
 </div>
 <div class="top">
     <%
     if("Study Guides".equals(category) == false )
     {
     %>
 	 	<header>Books Info</header>
 	<%}else{
 	 %>
 		<header>Notes Info</header>
 	 <% 	
 	    }
 	  %>
 </div>
 
<div class="book-info">
	<div class="book-details">
	    <img src="ImageServlet?id=<%=book_Id%>" alt="Book Cover">
	    <div class="details">
                <h2>Description</h2>
                <p><%= rs.getString("summary") %></p>
                <p><strong>Current Price:</strong> Rs <%= rs.getString("book_price") %></p>
                <p><strong>Seller Name:</strong> <%= rs.getString("seller_name") %></p>
                <p><strong>Author Name:</strong> <%= rs.getString("author_name") %></p>
                <p><strong>Category:</strong> <%= rs.getString("category") %></p>
                <button class="btn-back"  onclick="window.history.back();">Back</button>         
                <%
                if ("admin".equals(role) == false) {
                	if(seller_id != UserId ){
                %>
                <button class="btn-buy" onclick="location.href='billing.jsp?bookId=<%=book_Id%>'">Buy</button>
                <%
                	}
                }
                %>
                <button class="btn-preview" onclick="location.href='previewBooks.jsp?bookId=<%=book_Id%>'">Preview</button>
                 <%if(seller_id == UserId) 
                 {
                %>
                	<button  class="btn-download" onclick="location.href='DownloadPDFServlet?id=<%=book_Id%>'">Download</button>  
                	<button  class="btn-update" onclick="location.href='updateBook.jsp?bookId=<%=book_Id%>'">Update</button>
               <%
                 }
               %>
            </div>
	</div>
</div>
</body>
</html>
<%
        } else {
            out.println("Book not found.");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
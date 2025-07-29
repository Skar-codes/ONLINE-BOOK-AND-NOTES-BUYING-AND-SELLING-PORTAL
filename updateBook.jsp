<%@ page import="in.sp.dbcon.DbConnection"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    int bookId = Integer.parseInt( request.getParameter("bookId"));
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
 min-height:80vh;
 height: auto;
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
 flex-wrap:wrap;
 flex-direction:row;
 
}
.book-details img{
width: 400px;
height: 80vh;
}
.details{
margin: 30px;
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
   .btn-update{
   			padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            background-color: green;
            color: white;
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
 .details .row{
 display: flex;
 justify-content: space-between;
 flex-direction: column;
 margin-bottom: 20px;
}

.row .view {
    border:none;
	/*border-bottom: 1px solid black;*/
	outline: none;
	background: rgba(0, 0, 0, 0);
	width: 300px;
}
.row .edit {
    
	/*border-bottom: 1px solid black;*/
	outline: none;
}
.row label{
 color: blue;
}
.details .update{
 border-radius: 15px;
 padding: 5px;
 color: blue;
 cursor: pointer;
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
 
<div class="book-info">
	<div class="book-details">
	    <img src="ImageServlet?id=<%=book_Id%>" alt="Book Cover">
	    <form class="details" onsubmit="return checkPrice()" action="updateBookInfo" method="post">
	    			<input type="text" style="display: none ;" name="bookId" value="<%=book_Id%>" >
	    			<div class="row"><label>Book Name:</label> <input type="text" id="bookName" class="view" name="bookName" value="<%=title%> " readonly></div>
	   				<div class="row"><label>Seller Name:</label> <input type="text" id="sellerName" class="view" name="sellerName" value="<%=rs.getString("seller_name")%> " readonly></div>
  	   				<div class="row"><label>Author Name:</label> <input type="text" id="authorName" class="view" name="authorName" value="<%=rs.getString("author_name")%> " readonly></div>                  
                    <div class="row"><label>Description</label> <input type="text" id="description"class="edit" name="description" value="<%=rs.getString("summary")%>" ></div>
 	      			<div class="row"><label>Price</label> <input type="text" id="price" "class="edit" name="price" value="<%=rs.getDouble("book_price")%>" ></div>
 	      			
				    <%
					    String selectedCategory = rs.getString("category");
					%>
					<div class="row" >
					<label>Category</label>
					<select name="category" id="bookType" "class="edit" >
					        <option value="Textbooks" <%= "Textbooks".equals(selectedCategory) ? "selected" : "" %>>Textbooks</option>
					        <option value="Study Guides" <%= "Study Guides".equals(selectedCategory) ? "selected" : "" %>>Study Guides(Notes)</option>
					</select> </div>

                	<button  class="btn-update" type="submit">Update</button>
                	<a class="btn-back"  onclick="window.history.back();">Back</a>
               
          </form>
	</div>
</div>
<script type="text/javascript">
function checkPrice() {
	var bookType = document.getElementById("bookType").value;
	var bookPrice = document.getElementById("bookPrice").value;
	if(( bookPrice > 300) && (bookType == "Textbooks")) {
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
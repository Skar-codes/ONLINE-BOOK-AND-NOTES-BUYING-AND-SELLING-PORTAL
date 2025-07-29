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
 height: 80px;
 align-items: center;
 background: rgba(0, 0, 0, 0.15);
}
.top header{
    color: black;
	font-size: 35px;
	text-align: left;
	padding: 20px 20px 40px 100px;
	font-weight: 700;
}
.users{
	width: 100%;
    min-height: 90vh;
    height:auto;
	display: flex;
	flex-direction: column;
	transition: .09s ease-in-out;
	overflow: hidden;
}
.searchBox{
 width: 300px;
 padding: 5px;
 margin-left: 100px;
 margin-top: 30px;
 border-radius: 5px;
}
.users button{
 padding: 5px;
 background: black;
 color: white;
 margin-left: 10px;
 border-radius: 5px;
}
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
	    <header>User Details</header>
	 </div>
 <div class="users" id="users">
	 <form  action="usersview.jsp">
	    		    	<input type="text" class="searchBox" name="query" id="searchBox" placeholder="Search user name">
	    		    	<button type="submit" >Search</button>
	  </form>
	 
	    	<table class="usertable">
	    		     <tr>
	    		        <th>ID </th>
	    		     	<th>Name </th>
	    		     	<th>Mail </th>
	    		     	<th>Phone</th>
	    		     	<th>Gender </th>
	    		     	<th>Address </th>
	    		     	<th>Date Registered </th>
	    		     </tr>
	    		     
	    		     <%
	    		     	String searchQuery = request.getParameter("query");
			        	String query ;
			        	
			            if(searchQuery != null)
			            	 query = "SELECT * FROM users WHERE firstname LIKE ?";
			            else
			            	 query = "SELECT * FROM users";
	    		     try
	    		     {
	    		     	Connection co = DbConnection.getConnection();
	    		     	PreparedStatement ps = co.prepareStatement(query);
	    		     	if(searchQuery != null)
	    	     			ps.setString(1, "%" + searchQuery + "%");
	    		     	ResultSet rs = ps.executeQuery();
	    		     	
	    		     	while(rs.next())
	    		     	{
	    		     	%>
	    		     	<tr>
	    		     	    <td> <%=rs.getInt(1) %> </td>
	    		     	 	<td> <%=rs.getString(2) %> <%=rs.getString(3) %> </td>
	    		     	 	<td> <%=rs.getString(4) %> </td>
	    		     	 	<td> <%=rs.getString(5) %> </td>
	    		     	 	<td> <%=rs.getString(6) %> </td>
	    		     	 	<td> <%=rs.getString(7) %> </td>
	    		     	 	<td> <%=rs.getDate(9) %> </td>
	    		        </tr>
	    		        <%
	    		     	 }
	    		     	
	    		     	
	    		     	ps.close();
	    		     	co.close();
	    		     	%>
	    		    </table>
	    		    <%
	    		     	
	    		     }
	    		     catch (Exception e) {
	    		     	 out.print(e);
	    		     }
	    		     
	    		     %>
	    		  

</div>	  

	        
</body>
</html>
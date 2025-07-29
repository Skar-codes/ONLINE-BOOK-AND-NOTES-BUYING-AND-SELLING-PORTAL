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
body
{
 overflow: hidden;
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
.container{
 width: 100%;
 height: 70vh;
 display: flex;
 justify-content: center;
 margin: 30px;
 font-family: 'Roboto', sans-serif;
}
.container .image{
 padding: 50px;
 margin-right: 20px;
 border: 1px solid black;
 
}
.container .details{
 width: 400px;
 height: 65vh;
 padding: 20px;
 border: 1px solid black;

}
.details .row{
 display: flex;
 justify-content: space-between;
 flex-direction: column;
 margin-bottom: 20px;
}

.row input {
    border:none;
	
	border-bottom: 1px solid black;
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
.row-update{
 display: none;
 justify-content:flex-end;
 align-content: flex-end;
}
.nav-bar .edit-white {
      color: white;
    }

.nav-bar .edit-blue {
      color: blue;
    }
 
</style>
</head>
<body>
<%
 int userId = Integer.parseInt(request.getParameter("id"));
 String buyerGender="";

  try{
	  
	  Connection con = DbConnection.getConnection();
	  PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
	  ps.setInt(1,userId );
	  ResultSet result = ps.executeQuery();
	  if(result.next())
	  {
		  buyerGender = result.getString("gender");
	%>

 <div class="nav-bar">
    <a href="#" style="color: black;" onclick="window.history.back();"><i  class="fa-solid fa-circle-arrow-left"></i></a>
    <div class="logo">
  		<span class="logo1">BOOK </span>
  		<span class="logo2">STORE</span>
  	</div>
  	<a href='#' style="margin-right: 60px;" class="edit-white" id="editIcon" onclick="toggleEdit()"><i class="fa-solid fa-user-pen"></i></a>
 </div>
   <div class="container">
 	<div class="image">
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
 	</div>
 	<form action="editUserDetail" method="post" class="details">
 	     <div class="row"><label>First Name</label> <input type="text" id="firstName" name="firstname" value="<%=result.getString("firstname")%> " readonly></div>
 	      <div class="row"><label>Last Name</label> <input type="text" id="lastName" name="lastname" value="<%=result.getString("lastname") %>" readonly></div>
 	      <div class="row"><label>City</label> <input type="text" id="city" name="city" value="<%=result.getString("city")%>"readonly></div>
 	      <div class="row"><label>Mobile Number</label> <input type="text" id="mobile" name="phoneno" value="<%=result.getString("phoneno")%>" readonly></div>
 	      <div class="row"><label>Email ID</label> <input type="text" id="email" name="email" value="<%=result.getString("email")%>"readonly></div>
 	      <input style="display: none ;" name="user_id" value="<%=userId%>">
 	      <br><br>
 	      <div class="row-update" id="submit"><button type="submit" class="update">SUBMIT</button></div>
 	</form>
 
 </div>
 <% 
 	  }
  }catch(Exception e)
  {
	  
  }
%>
<script type="text/javascript">
let isEditable = false;

function toggleEdit() {
  isEditable = !isEditable;
  const icon = document.getElementById("editIcon");
  const update = document.getElementById("submit");
    if(isEditable == false)
	  {
	   icon.className = "edit-white";
	   update.style.display="none";
	   
	  }else{
		  icon.className = "edit-blue";
		  update.style.display="flex";
	  }
  
  const fields = ['firstName', 'lastName', 'city', 'mobile', 'email'];
  fields.forEach(id => {
    document.getElementById(id).readOnly = !isEditable;
  });
}


</script>
</body>
</html>
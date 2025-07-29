<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.sp.dbcon.DbConnection"%>
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

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=title %></title>

</head>
<body>
 <iframe src="viewPdf?book_id=<%=bookId%>" width="100%" height="600px"></iframe>
 <script type="text/javascript">
        window.onload = function() {
            alert("For read full book Buy Now.");
        };
   </script>
</body>

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

</html>
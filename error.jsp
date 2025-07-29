<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnlineBookBuyingAndSellingPortal</title>
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<script>
    alert("⚠️ Error: <%= errorMessage %>");
    window.location.href = "user_login_register.html";
</script>
</body>
</html>
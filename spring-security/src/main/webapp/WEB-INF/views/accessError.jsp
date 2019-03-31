<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import = "java.util.*" %><!-- 아래에서 getMessage() 뽑아 내려고 만든 것. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Access Denied Page</title>
</head>
<body>

	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
	<h2><c:out value="${msg}"/></h2>
	
</body>
</html>
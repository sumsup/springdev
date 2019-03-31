<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Custom Login Page</h1>
	<h2><c:out value="${error}"/></h2>
	<h2><c:out value="${logout}"/></h2>
	
	<!-- action이 login으로 지정되있음.
	Spring Security에서는 login 컨트롤러를 자동으로 구현해놨음.
	따로 컨트롤러에서 구현하지 않아도. -->
	<!-- 아이디나 패스워드를 틀리면 다시 로그인 화면으로 이동함. -->
	<form method='post' action="/test/login">
		
		<div>
			<!-- 아이디는 username으로 사용함. -->
			<input type='text' name='username' value='admin'>
		</div>
		<div>
			<!-- 비밀번호는 password로 사용함. -->
			<input type='password' name='password' value='admin'>
		</div>
		<div>
			<input type='submit'>
		</div>
		<!-- csrf 속성을 지정해줌. Cross-site request forgery -->
		<!-- 임의로 변경되는 token 값을 생성해서 csrf 공격을 방어함. -->
		<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}' />
	
	</form>

</body>
</html>
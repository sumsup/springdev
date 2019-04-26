<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<form method='post' action='/rest/register' id='userForm'>
	<label for='userid'>아이디</label>
	<input type='text' id='userid' name='userid'>
	<label for='contents'>내용</label>
	<input type='text' id='contents' name='contents'>
	<button type='submit'>제출</button>
</form>
</body>
<script>

	function sendXHR(formData) {
		
		var request = new XMLHttpRequest();
		request.open('post', '/rest/register');
		request.send(formData);
		
	}
	
	var form = document.querySelector('#userForm');
		
	function onsubmit() {
		
		event.preventDefault();
		
		var userid = document.querySelector('#userid').value;
		var contents = document.querySelector('#contents').value;
		
		formData = new FormData();
		
		formData.append('userid',userid);
		formData.append('contents',contents);
		
		sendXHR(formData);
		
	}
	
	form.addEventListener('submit',onsubmit);
	
	
	
	
	
</script>

</html>

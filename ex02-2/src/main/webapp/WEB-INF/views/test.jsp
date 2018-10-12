<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax Test Page</h2>
	
	<!-- 리플 등록 구간 -->
	<div>
		<div>
			REPLYER<input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT <input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>	
	
	<ul id="replies">
	</ul>
	
	<ul class='pagination'>
	</ul>
	
	<!-- 리플 수정을 위한 모달창 -->
	<div id='modDiv' style="display:none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id='closeBtn'>Close</button>
		</div>
	</div>
	
</body>

	<!-- 스크립트 임포트 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script src="/resources/scripts/Functions.js"></script>
	<script src="/resources/scripts/Events.js"></script>
	
	<!-- 스타일 임포트 -->
	<style type="text/css">
		@import url("/resources/css/style.css");
	</style>
	
</html>
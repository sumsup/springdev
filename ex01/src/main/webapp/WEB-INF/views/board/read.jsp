<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<%-- <form role="form" method="post">
	<input type='hidden' name='bno' value="${boardVO.bno}">
</form> --%>

<div class="box-body">
	<div class="form-group">
		<label for="exampleInputEmail1">Title</label>
		<input type="text" name='title' class="form-control" value="${boardVO.title }" readonly="readonly" >
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">Content</label>
		<textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content}</textarea>
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">Writer</label>
		<input type="text" name="writer" class="form-control" value="${boardVO.writer }" readonly="readonly">
	</div>
</div>

<div class="box-footer">
	<button type="submit" class="btn btn-warning btn-modify">Modify</button>
	<button type="submit" class="btn btn-danger btn-remove">REMOVE</button>
	<button type="submit" class="btn btn-primary btn-listall">LIST ALL</button>
</div>

<!-- submit 할때 같이 넘겨지는 정보들을 담을때 hidden을 사용한다. -->
<form role="form" action="modifyPage" method="post">
	<input type='hidden' name='bno' value="${boardVO.bno }">
	<input type='hidden' name='page' value="${cri.page }">
	<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
</form>

<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$(".btn-modify").on("click",function(){
			formObj.attr("action","/board/modify");
			formObj.attr("method","get");
			formObj.submit();
		});
		
		$(".btn-remove").on("click",function(){
			formObj.attr("action","/board/remove");
			formObj.submit();
		});
		
		$(".btn-listall").on("click",function(){
			formObj.attr("method","get");
			formObj.attr("action","/board/listPage");
			formObj.submit();
		});
	
	});
</script>

<%@include file="../include/footer.jsp"%>
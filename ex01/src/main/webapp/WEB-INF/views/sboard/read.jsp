<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

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

<div class="row">
	<div class="col-md-12">
		<div class="box box=success">
			
			<div class="box-header">
				<h3 class="box-title">ADD NEW REPLY</h3>
			</div>
			<div class="box-body">
				<label for="newReplyWriter">Writer</label>
				<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter">
				<label for="newReplyText">ReplyText</label>
				<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
			</div>
			<div class="box-footer">
				<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
			</div>
		
		</div>
	</div>
</div>

<ul class="timeline">
	<li class="time-label" id="repliesDiv"><span class="bg-green"></span></li>
</ul>
<div class='text-center'>
	<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
</div>

<!-- modify 페이지로 POST submit 할때 같이 넘겨지는 정보들을 담을때 hidden을 사용한다. -->
<form role="form" action="modifyPage" method="post">
	<!-- input type 이 hidden 이라는게  숨겨진 '입력'값이라는 것. 그걸 수정페이지로 전달한다. -->
	<input type='hidden' name='bno' value="${boardVO.bno }">
	<input type='hidden' name='page' value="${cri.page }">
	<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
	<input type='hidden' name='searchType' value="${cri.searchType }">
	<input type='hidden' name='keyword' value="${cri.keyword }">
</form>

<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$(".btn-modify").on("click",function(){
			formObj.attr("action","/sboard/modify");
			formObj.attr("method","get");
			formObj.submit();
		});
		
		$(".btn-remove").on("click",function(){
			formObj.attr("action","/sboard/remove");
			formObj.submit();
		});
		
		$(".btn-listall").on("click",function(){
			formObj.attr("method","get");
			formObj.attr("action","/sboard/list");
			formObj.submit();
		});
	
	});
</script>

<%@include file="../include/footer.jsp"%>
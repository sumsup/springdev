<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify</h1>
	</div><!-- col-lg-12 -->
</div><!-- row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Modify Page</div>
			<div class="panel-body">
				<form action="${pageContext.request.contextPath}/board/modify" role='form' method='post'>
				
				<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token }' />
				
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>' >
				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>' >
				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>' >
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>' >
								
					<div class='form-group'>
						<label>Bno</label><input class='form-control' name='bno' value='<c:out value="${board.bno }"/>'
							readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name='title' value='<c:out value="${board.title }"/>'>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'><c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly='readonly'>
					</div>
					<div class='form-group'>
						<label>RegDate</label>
						<input class='form-control' name='regDate' value='<fmt:formatDate pattern='yyyy/MM/dd' value="${board.regdate }" />' 
							readonly='readonly'>
					</div>
					<div class='form-group'>
						<label>updateDate</label>
						<input class='form-control' name='regDate' value='<fmt:formatDate pattern='yyyy/MM/dd' value="${board.updateDate }" />' 
							readonly='readonly'>
					</div>
					
					<sec:authentication property='principal' var='pinfo'/>
					<sec:authorize access='isAuthenticated()'>
						<c:if test='${pinfo.username eq board.writer }'>
							<button type='submit' data-oper='modify' class='btn btn-default'>Modify</button>
							<button type='submit' data-oper='remove' class='btn btn-danger'>Remove</button>
						</c:if>
					</sec:authorize>
					
					<a href='${pageContext.request.contextPath}/board/list'><button data-oper='list' class='btn btn-default'>List</button></a>
				</form>
			</div><!-- panel-body -->		
		</div>
	</div><!-- col-lg-12 -->
</div><!-- row -->

<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper"); // data-oper 의 값을 가지고 온다.
		
		console.log(operation);
		
		if(operation === 'remove') {
			formObj.attr("action","${pageContext.request.contextPath}/board/remove"); // form 속성중 action을 remove로 가게 한다.
		} else if(operation === 'list') {
			//move to list
			formObj.attr("action","${pageContext.request.contextPath}/board/list").attr("method","get"); // 리스트 겟 방식으로.
			
			// 리스트로 돌아갈 때는 나머지 입력 값이 필요가 없으므로.
			var pageNumTag = $("input[name='pageNum']").clone(); // 페이지 쪽 수랑.
			var amountTag = $("input[name='amount']").clone(); // 페이지 양만 남기고.
			var typeTag = $("input[name='keyword']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			 
			formObj.empty(); // 입력값을 다 지운다.
			formObj.append(pageNumTag); // 페이지 쪽수를 넣고 
			formObj.append(amountTag); // 페이지 양을 넣고
			formObj.append(typeTag); // 검색 타입 넣고
			formObj.append(keywordTag); // 검색 키워드 넣고
			
		}
		formObj.submit(); // 보낸다.
	});
	
});
</script>

<%@ include file="../includes/footer.jsp" %>
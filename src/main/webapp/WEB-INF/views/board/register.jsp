<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div><!-- col-lg-12 -->
</div><!-- row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="${pageContext.request.contextPath}/board/register" method="post">
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name='title'>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="10" name='content'></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<!-- Writer에 현재 사용자 아이디를 추가. -->
						<input class="form-control" name='writer' 
							value='<sec:authentication property="principal.username"/>' readonly='readonly'>
					</div>
					<div>
					
						<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }" />
						
					</div>
					
					<button type='submit' class='btn btn-default'>Register</button>
					<button type='reset' class='btn btn-default goList'>List Page</button>
				</form>
				
				<form id="listForm" role="form" action="${pageContext.request.contextPath}/board/list" method="get">
					<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type="hidden" name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type="hidden" name='type' value='<c:out value="${cri.type }"/>'>
					<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'>
				</form>
			</div><!-- panel-body -->		
		</div>
	</div><!-- col-lg-12 -->
</div><!-- row -->

<script>
	
	var goList = document.getElementsByClassName("goList");
	var listForm = document.getElementById("listForm");
	
	goList[0].addEventListener("click", function(e){
		e.preventDefault();
		
		listForm.submit();
		
	});
	
</script>

<%@ include file="../includes/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

<!-- 스크립트를 맨 위에 적으면 작동하는데 그 외의 자리에서는 작동을 하지 않는다. -->
<script>
	
				
</script>
    
<form id="jobForm">
	<input type='hidden' name='page' value=${pageMaker.cri.page }>
	<input type='hidden' name='perPageNum' value=${pageMaker.cri.perPageNum }>
</form>

<%@include file="../include/header.jsp" %>

	<div class='box-body'>
		<select name="searchType">
			<option value="n" <c:out value="${cri.searchType == null?'selected':'' }"/>>---</option>	
			<option value="t" <c:out value="${cri.searchType == 't'? 'selected':'' }"/>>Title</option>	
			<option value="c" <c:out value="${cri.searchType == 'c'?'selected':'' }"/>>Content</option>	
			<option value="w" <c:out value="${cri.searchType == 'w'?'selected':'' }"/>>Writer</option>	
			<option value="tc" <c:out value="${cri.searchType == 'tc'?'selected':'' }"/>>Title OR Content</option>	
			<option value="cw" <c:out value="${cri.searchType == 'cw'?'selected':'' }"/>>Content OR Writer</option>	
			<option value="tcw" <c:out value="${cri.searchType == 'tcw'?'selected':'' }"/>>Title OR Content OR Writer</option>	
		</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }' >
		<button id='searchBtn'>검색</button>
		<button id='newBtn'>새글 등록</button>
	</div>
	
	<table class="table table-bordered">
		
		<tr>
			<th style="width: 10px">BNO</th>
			<th>TITLE</th>
			<th>WRITER</th>
			<th>REGDATE</th>
			<th style="width: 40px">VIEWCNT</th>
		</tr>
		
	<c:forEach items="${list}" var="boardVO">
		
		<tr>
			<td>${boardVO.bno }</td>
			<td><a href='/sboard/read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno}'>${boardVO.title }</a>
			<td>${boardVO.writer }</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
			<td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
		</tr>
	
	</c:forEach>
		
	</table>
	
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li><a href="list${pageMaker.makeSearch(1)}">&laquo;&laquo;</a></li>
			</c:if>
			<c:if test="${pageMaker.prev }" >
				<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1 )}">&laquo;</a></li>
			</c:if>
			
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<li <c:out value="${pageMaker.cri.page == idx?'class=active' : '' }" />>
				<a href="list${pageMaker.makeSearch(idx)}">${idx }</a>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1 )}">&raquo;</a></li>
			</c:if>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
				<li><a href="list${pageMaker.makeSearch(pageMaker.tempEndPage)}">&raquo;&raquo;</a></li>
			</c:if>
		
		</ul>
	</div>
	
<script>
	
	$(document).ready(
		function() {
			$('#searchBtn').on("click",function(event) {
				self.location = "list"
						+'${pageMaker.makeQuery(1)}'
						+"&searchType="
						+$("select option:selected").val()
						+"&keyword="+ encodeURIComponent($('#keywordInput').val());
			});
			
			$('#newBtn').on("click", function(evt){
				self.location = "register"
								+'${pageMaker.makeSearch(pageMaker.cri.page)}';
				
			});
			

			var result = '${msg}';
			
			if(result == 'success') {
				alert("처리가 완료되었습니다.");
			}
			
			$(".pagination li a").on("click", function(event){
				
				event.preventDefault();
				
				var targetPage = $(this).attr("href");
				
				var jobForm = $("#jobForm");
				jobForm.find("[name='page']").val(targetPage);
				jobForm.attr("action","/sboard/list").attr("method","get");
				jobForm.submit();
				
			});
		
	});

</script>
	
<%@include file="../include/footer.jsp" %>
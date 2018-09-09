<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

<!-- 스크립트를 맨 위에 적으면 작동하는데 그 외의 자리에서는 작동을 하지 않는다. -->
<script>
	
		var result = '${msg}';
		
		if(result == 'success') {
			alert("처리가 완료되었습니다.");
		}
	
</script>
    
<%@include file="../include/header.jsp" %>
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
			<td><a href='/board/read?bno=${boardVO.bno }'>${boardVO.title }</a>
			<td>${boardVO.writer }</td>
			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
			<td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
		</tr>
	
	</c:forEach>
		
	</table>
	
<%@include file="../include/footer.jsp" %>
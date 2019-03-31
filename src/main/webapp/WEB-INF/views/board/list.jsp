<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>

<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board List Page
				<button id='regBtn' type='button' class='btn btn-xs pull-right'>Register New Board</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>

						<c:forEach items="${list }" var="board">
							<tr>
								<td><c:out value="${board.bno }" /></td>
								<td><a class='move' href='<c:out value="${board.bno }" />'>
									<c:out value="${board.title }" />&nbsp;<b>[${board.replyCnt}]</b></a></td>
								<td><c:out value="${board.writer }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" /></td>
							</tr>
						</c:forEach>

					</table>
					
					<div class='row'>
						<div class="col-lg-12">
							<form action="${pageContext.request.contextPath}/board/list" id='searchForm' method='get'>
								<select name='type'>
									<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>---</option>								
									<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>								
									<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>								
									<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>								
									<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>								
									<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>								
									<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>제목 or 내용 or 작성자</option>								
								</select>
								<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
								<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
								<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
								<button class='btn btn-default'>Search</button>
							</form>
						</div>
					</div>

					<div class='pull-right'>
						<ul class="pagination">
							
							<c:if test='${pageMaker.prev }'>
								<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">Previous</a></li>
							</c:if>
							
							<c:forEach var='num' begin='${pageMaker.startPage }' end='${pageMaker.endPage }'>
								<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }' >
									<a href="${num}">${num}</a> <!-- 여기서 num은 바로위 forEach에서 하나씩 뽑아낸 num 임. var='num' -->
								</li>
							</c:forEach>
							
							<c:if test='${pageMaker.next }'>
								<li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
							</c:if>
							
						</ul>
					</div>
					
					<!-- 페이징 정보를 input에 담아두었다가 조회 페이지로 정보를 넘겨준다. -->
					<form id='actionForm' action="${pageContext.request.contextPath}/board/list" method='get' >
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }' >
						<input type='hidden' name='amount' value='${pageMaker.cri.amount }' >
						<input type='hidden' name='type' value='${pageMaker.cri.type }' >
						<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }' >
					</form>
					

					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">등록 성공</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>

				</div>
				<!-- /.table-responsive -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<script>
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';
			
			checkModal(result);
			
			history.replaceState({}, null, null);
			
			function checkModal(result) {
				if (result === '' || history.state) {
					return;
				}
				
				if (parseInt(result) > 0) {
					$(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
				}
				
				$("#myModal").modal("show");
			}
			
			$("#regBtn").on("click", function(e) {
				e.preventDefault();
				actionForm.attr("action","${pageContext.request.contextPath}/board/register");
				actionForm.submit();
			});
			
			var actionForm = $("#actionForm");
			
			$('.paginate_button a').on("click", function(e) {
				e.preventDefault();
				
				console.log('click');
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href")); 
				// form 태그에 현재 눌려진 href 숫자값을 넣어서 전송.
				actionForm.submit();
				
			});
			
			$(".move").on("click", function(e){
				
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"' >");
				actionForm.attr("action","${pageContext.request.contextPath}/board/get");
				actionForm.submit();
				
			});
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e){
				
				if(!searchForm.find("option:selected").val()) { // 검색 종류를 선택 안했으면 중지
					alert("검색종류를 선택하세요");
					return false;
				}
				
				if(!searchForm.find("input[name='keyword']").val()) { // 검색어를 입력 안했어도 중지
					alert("키워드를 입력하세요.");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1"); // hidden으로 넣어둔 pageNum을 1로 변경
				e.preventDefault(); // 이벤트 기본 값을 막고.
				
				searchForm.submit(); // 제출.
				
			});
			
		});
	</script>

	<%@ include file="../includes/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- col-lg-12 -->
</div>
<!-- row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<div class='form-group'>
					<label>Bno</label><input class='form-control' name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly='readonly'>
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content'
						readonly='readonly'><c:out value="${board.content }" /></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly='readonly'>
				</div>
				
				<!-- principal을 pinfo라는 변수로 사용하기. -->
				<sec:authentication property="principal" var="pinfo" />
					
					<sec:authorize access="isAuthenticated()"> <!-- 인증받은 사용자만 영향을 받기 위해서 사용. -->
					
						<c:if test="${pinfo.username eq board.writer }">
							<button data-oper='modify' class='btn btn-default'>
								<%-- 
									<a href='/test/board/modify?bno=<c:out value="${board.bno }"/>'> --%>
								Modify
								<!-- </a> -->
							</button>
						</c:if>
					</sec:authorize>
					
				<button data-oper='list' class='btn btn-default'>
					<!-- <a href='/test/board/list'> -->
					List
					<!-- </a> -->
				</button>

				<form id='operForm'
					action="/${pageContext.request.contextPath}/board/modify"
					method='get'>
					<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'> 
					<input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
					<input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount }"/>'> 
					<input type='hidden' id='type' name='type' value='<c:out value="${cri.type }"/>'> 
					<input type='hidden' id='keyword' name='keyword' value='<c:out value="${cri.keyword }"/>'>
				</form>

			</div>
			<!-- panel-body -->
		</div>
	</div>
	<!-- col-lg-12 -->
</div>
<!-- row -->

<div class='row'>
	<div class="col-lg-12">

		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				
				<sec:authorize access="isAuthenticated()">
					<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
				</sec:authorize>
				
			</div>

			<div class="panel-body">
				<ul class="chat">
				</ul>
			</div>

			<div class="panel-footer"></div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Reply Modify</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> 
					<input class="form-control" name='reply' value='new Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> 
					<input class="form-control" name='replyer' value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label> 
					<input class="form-control" name='replyDate' value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reply.js"></script>

<script type="text/javascript">
	console.log("GET PAGE ==============");

	// var bnoValue = '<c:out value="${board.bno}"/>';

	replyService.get(3, function(data) {
		console.log(data);
	});

	/* replyService.update(
		{
			rno : 3,
			bno : bnoValue,
			reply : "Modified Reply.............."
		}, 
		function(result) {
			alert("수정 완료......");			
		},
		function(error) {
			alert("수정 실패...... : "+error);
		}
	); */

	//23번 댓글 삭제 테스트
	/* replyService.remove(23, function(count){
		
		console.log(count);
		
		if (count === "success") {
				alert("REMOVED");
			}
		},
		function(err) {
			alert('ERROR...');
		}
	); */

	// list test
	/* replyService.getList({bno:bnoValue, page:1}, function(list) {
		
		for(var i = 0, len = list.length||0; i < len; i++) {
			console.log(list[i]);
		}
		
	}); */

	//for replyService add test
	/* replyService.add(
		{reply: "JS Test", replyer:"tester", bno: bnoValue}, // add 메서드의 첫번째 파라미터.
		
		function(result) { // add 메서드의 콜백함수.
			alert("RESULT: "+ result);
		},
		
		function(error) {
			alert("ERROR: "+ error);
		}
	); */

	$(document).ready(function() {

						var bnoValue = '<c:out value="${board.bno}"/>';
						var replyUL = $(".chat");

						showList(1);

						function showList(page) {

							console.log("show list " + page);

							replyService.getList(
											{
												bno : bnoValue,
												page : page || 1
											},
											function(replyCnt, list) {

												console.log("replyCnt: " + replyCnt);
												console.log("list: " + list);

												if (page == -1) {
													pageNum = Math.ceil(replyCnt / 10.0);
													showList(pageNum);

													return;
												}

												var str = "";

												if (list == null || list.length == 0) {
													return;
												}

												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class='left clearfix' data-rno = '"+list[i].rno+"'>";
													str += "<div><div class='header'><strong class='primary-font'>"
															+ list[i].replyer
															+ "</strong>";
													str += "<small class='pull-right text-muted'>"
															+ replyService.displayTime(list[i].replyDate)
															+ "</small></div>";
													str += "<p>"
															+ list[i].reply
															+ "</p></div></li>";
												}

												replyUL.html(str);

												showReplyPage(replyCnt);
											});

						} // end showList

						var modal = $(".modal");
						var modalInputReply = modal.find("input[name='reply']");
						var modalInputReplyer = modal.find("input[name='replyer']");
						var modalInputReplyDate = modal.find("input[name='replyDate']");

						var modalModBtn = $("#modalModBtn");
						var modalRemoveBtn = $("#modalRemoveBtn");
						var modalRegisterBtn = $("#modalRegisterBtn");
						
						var replyer = null;
						
						<sec:authorize access="isAuthenticated()">
							replyer = '<sec:authentication property="principal.username"/>';
						</sec:authorize>

						console.log("replyer = " + replyer);
						
						$("#addReplyBtn").on("click", function(e) {

							modal.find("input").val("");
							modal.find("input[name='replyer']").val(replyer);
							modalInputReplyDate.closest("div").hide();
							modal.find("button[id != 'modalCloseBtn']").hide();

							modalRegisterBtn.show();

							$(".modal").modal("show");

						});

						console.log(replyService);

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");

						function showReplyPage(replyCnt) {
							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum - 9;

							var prev = startNum != 1;
							var next = false;

							if (endNum * 10 >= replyCnt) {
								endNum = Math.ceil(replyCnt / 10.0);
							}

							if (endNum * 10 < replyCnt) {
								next = true;
							}

							var str = "<ul class='pagination pull-right'>";

							if (prev) {
								str += "<li class='page-item'><a class='page-link' href='"
										+ (startNum - 1)
										+ "'>Previous</a></li>";
							}

							for (var i = startNum; i <= endNum; i++) {
								var active = pageNum == i ? "active" : "";
								str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"
										+ i + "</a></li>";

								if (next) {
									str += "<li class='page-item'><a class='page-link' href='"
											+ (endNum + 1) + "'>Next</a><li>";
								}

							}
							str += "</ul></div>";

							console.log(str);

							replyPageFooter.html(str);

						}

						replyPageFooter.on("click", "li a", function(e) {
							e.preventDefault();
							console.log("page click");

							var targetPageNum = $(this).attr("href");

							console.log("targetPageNum: " + targetPageNum);

							showList(targetPageNum);
						});
						
						//Ajax spring security header...
						//Ajax 전송시 CSRF 토큰을 같이 전송하도록 셋팅.
						var csrfHeaderName = "${_csrf.headerName}";
						var csrfTokenValue = "${_csrf.token}";
						
						// ajax 전송시 항상 토큰 값을 같이 보내도록 설정.
						$(document).ajaxSend(function(e, xhr, options) {
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						});

						modalModBtn.on("click", function(e) {
							
							var originalReplyer = modalInputReplyer.val();
							
							var reply = {
								rno : modal.data("rno"),
								reply : modalInputReply.val(),
								replyer : originalReplyer
							};
							
							if(!replyer) {
								alert("로그인 후 수정이 가능합니다.");
								modal.modal("hide");
								return;
								
							}
							
							console.log("original Replyer: " + originalReplyer);
							
							if(replyer != originalReplyer) {
								alert("자신이 작성한 댓글만 수정이 가능합니다.");
								modal.modal("hide");
								return;
							}

							replyService.update(reply, function(result) {

								alert(result);
								modal.modal("hide");
								showList(pageNum);

							});
						});
						
						modalRemoveBtn.on("click", function(e) {
							var rno = modal.data("rno");
							
							console.log("RNO : " + rno);
							console.log("REPLYER : " + replyer);
							
							if(!replyer) {
								alert("로그인 후 삭제가 가능합니다.");
								modal.modal("hide");
								return;
							}
							
							var originalReplyer = modalInputReplyer.val();
							
							console.log("Original Replyer: " + originalReplyer);
							
							if(replyer != originalReplyer) {
								
								alert("자신이 작성한 댓글만 삭제가 가능합니다.");
								modal.modal("hide");
								return;
								
							}

							replyService.remove(rno, originalReplyer, function(result) {

								alert(result);
								modal.modal("hide");
								//showList(pageNum);
								
								// data-set이 rno 인 node 를 가져와서 DOM 상에서 삭제 해주면
								// 삭제된 리플이 제거 되겠지.
								let dataRno = '[data-rno="'+rno+'"]';
								let rnoElement = document.querySelector(dataRno);
								let parent = rnoElement.parentNode;
								parent.removeChild(rnoElement);

							});
						});
						
						/* modalRemoveBtn.on("click", function(e) {

							var rno = modal.data("rno");

							replyService.remove(rno, function(result) {

								alert(result);
								modal.modal("hide");
								showList(1);

							});
						}); */

						modalRegisterBtn.on("click", function(e) {

							var reply = {
								reply : modalInputReply.val(),
								replyer : modalInputReplyer.val(),
								bno : bnoValue
							};
							alert(reply);

							replyService.add(reply, function(result) {

								alert(result);

								modal.find("input").val("");
								modal.modal("hide");

								showList(-1);

							});

						});

						$(".chat").on("click", "li", function(e) {

							var rno = $(this).data("rno");

							console.log(rno);

							replyService.get( rno,
											function(reply) {

												modalInputReply.val(reply.reply);
												modalInputReplyer.val(reply.replyer);
												modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
												modal.data("rno",reply.rno);

												modal.find("button[id != 'modalCloseBtn']").hide();
												modalModBtn.show();
												modalRemoveBtn.show();

												$(".modal").modal("show");

											});

						});

						var operForm = $("#operForm");

						$("button[data-oper='modify']").on("click",
										function(e) {
											operForm.attr("action",	"${pageContext.request.contextPath}/board/modify").submit();
										});

						$("button[data-oper='list']").on("click",
										function(e) {
											operForm.find("#bno").remove();
											operForm.attr("action",	"${pageContext.request.contextPath}/board/list").submit();
											
						});

					});
</script>

<%@ include file="../includes/footer.jsp"%>
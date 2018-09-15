<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>

	#modDiv {
		width:300px;
		height:100px;
		background-color: gray;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;		
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
			REPLYER <input type='text' name='replyer' id='newReplyWriter'>
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
	
	<div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">MODIFY</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id="closeBtn">CLOSE</button>
		</div>
	</div>
	
</body>

<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	
	var bno = 20;
	var replyPage = 1;
	getPageList(1);
		
	function getPageList(page) {
		
		$.getJSON("/replies/"+bno+"/"+page, function(data){ // 여기서 data는 entity 객체에 담겨있는 map 객체를 의미하는 듯.
			console.log(data.list.length);
			var str = "";
			
			$(data.list).each(function(){
				str += "<li data-rno='"+this.rno+"' class='replyLi'>"+this.rno+":"+this.replytext+"<button>MOD</button></li>";
				// 여기에서 this는 data를 의미한다.
			});
			
			$("#replies").html(str);
			
			printPaging(data.pageMaker); 
			/* 
			data에 pageMaker가 들어있는데.
			- pageMaker에 있는 정보 : 
			private int totalCount; // 전체 데이터 갯수
			private int startPage;
			private int endPage;
			private boolean prev;
			private boolean next;
			private int displayPageNum = 10; // number of showing page of bottom.
			private int tempEndPage;
			private Criteria cri;
			
			- Creteria에 있는 정보 :
			private int page; // 지금 몇 페이지에 있냐. 
			private int perPageNum; // 페이지당 보여줄 게시물 갯수를 정하는 인스턴스 변수.
			*/
		});
	}
	
	function printPaging(pageMaker) { // pageMaker 를 받아와서.
		var str = "";
		if(pageMaker.prev) {
			str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage, len= pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.next) {
			str += "<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
		}
		
		$('.pagination').html(str);
	}
	
	function getAllList() {
		$.getJSON("/replies/all/"+bno, function(data) { // json으로 /replies/all/bno 값으로 요청을 하면 function으로 data를 받아와서 아래 작업을 실행한다.
			
			var str = "";
			console.log(data.length);
			
			$(data).each(
				function() {
					// view 그려주는 단계.
					str += "<li data-rno='"+this.rno+"' class='replyLi'>" // rno나 replytext는 ajax 요청에서 받아오는 데이터들.
						+ this.rno + ":" + this.replytext
						+ "<button>MOD</button></li>";
				}	
			);
			
			$("#replies").html(str);
			
		});
	}
	
	$(".pagination").on("click","li a",function(event) {
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getPageList(replyPage);
	});
		
	$("#replyAddBtn").on("click", function() {
		
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		
		$.ajax({
			type: 'post', // post = 보낸다.
			url: '/replies',
			headers: {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST"
			},
			dataType : 'text',
			data : JSON.stringify({ // 보내는 데이터. 문자열화 해서 보낸다.
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) { // 보내는데 성공하면.
				if(result == 'success') {
					alert("등록 되었습니다.");
					getAllList();
				}
			}
						
		});
		
	});
	
	$("#replies").on("click",".replyLi button", function() { // 아직은 만들어지지 않은 Li에 이벤트를 적용하는 방식은 ul에 이벤트를 걸어놓고 발생을
															// replyLi에서 하게끔 하는 것.
		
		var reply = $(this).parent(); // reply변수는 button의 부모인 Li
		var rno = reply.attr("data-rno"); // data-rno의 속성값 
		var replytext = reply.text(); // li 요소 안에 있는 text 값.
		
		$(".modal-title").html(rno);
		$("#replytext").val(replytext);
		$("#modDiv").show("slow");
				
	});
	
	$("#replyDelBtn").on("click" , function(){
		var rno = $(".modal-title").html(); // 숫자를 가지고 오겠네.
		var replytext = $('#replytext').val();
		
		$.ajax({
			type : 'DELETE',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if(result == 'success') {
					alert("삭제 되었습니다.");
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
			
		});
	});
	
	$("#replyModBtn").on("click", function() {
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type:'put',
			url:'/replies/'+rno,
			headers: {
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"PUT"
			},
			data: JSON.stringify({replytext:replytext}),
			dataType: 'text',
			success: function(result) {
				
				console.log("result: "+ result);
				if(result == 'success') {
					alert("수정 되었습니다.");
					$("#modDiv").hide("slow");
					getAllList();					
				}
			}						
		});
	});
	
	$('#closeBtn').on("click",function(){
		$("#modDiv").hide("slow");
	});
	
</script>

</html>
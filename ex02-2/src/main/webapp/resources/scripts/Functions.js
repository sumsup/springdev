		var bno = 20;
		var replyPage = 1;
		
		//getAllList();
		getPageList(1);
		
		function getAllList() {
			$.getJSON("/replies/all/"+bno, function(data) {
				console.log(data.length);
				
				var str = "";

				$(data).each(function(){
					str += "<li data-rno='"+this.rno+"' class='replyLi'>"+ 
						this.rno + ":" + this.replytext + "<button>MOD</button></li>";
				});
				
				$("#replies").html(str);
			});
		}
		
		function getPageList(page) {
			$.getJSON("/replies/"+bno+"/"+page, function(data){
				console.log(data.list.length);
				
				var str = "";
				
				$(data.list).each(function(){
					str += "<li data-rno='"+this.rno+"' class='replyLi'>"
						+ this.rno + ":"+ this.replytext +
						"<button>MOD</button></li>";
				});
				
				$("#replies").html(str);
				
				printPaging(data.pageMaker);
			});
		}
		
		function printPaging(pageMaker) {
			var str = "";
			if(pageMaker.prev) {
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			}
			
			for(var i=pageMaker.startPage; i <= pageMaker.endPage; i++) {
				var strClass = pageMaker.cri.page == i?'class=active':'';
				str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
			}
			
			if(pageMaker.next) {
				str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
			}
			
			$('.pagination').html(str);
		}
		
		$("#replyAddBtn").on("click", function(){
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					if ( result == 'success' ) {
						alert("등록 되었습니다.");
						getAllList();
					}
				}
			});
		});
		
		$("#replies").on("click",".replyLi button", function(){ // replyLi button은 MOD를 말함.
			var reply = $(this).parent();
			
			var rno = reply.attr("data-rno");
			var replytext = reply.text();
			
			$(".modal-title").html(rno);
			$("#replytext").val(replytext);
			
			$("#modDiv").show("slow");
			
		});
		
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override": "delete"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result : "+result);
					if (result == 'success') {
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		$("#replyModBtn").on("click",function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: {
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"PUT"
				},
				data:JSON.stringify({replytext:replytext}),
				dataType:'text',
				success:function(result) {
					console.log("result : "+result);
					if(result == 'success') {
						alert("수정 되었습니다!");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		$("#closeBtn").on("click",function(){
			$("#modDiv").hide("slow");
		});
		
		$(".pagination").on("click","li a", function(){
			
			event.preventDefault();
			
			replyPage = $(this).attr("href");
			
			getPageList(replyPage);
		});
		
		
		
		
		
		
		
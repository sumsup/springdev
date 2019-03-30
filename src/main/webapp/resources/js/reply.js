console.log("Reply Module......................");

var replyService = (function(){
	
	function add(reply, callback, error) { // 함수 선언
		console.log("add reply...................");
		console.log("contextPath : "+contextPath);
		
		$.ajax({
			type : 'post',
			url : contextPath+'/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON(contextPath+"/replies/pages/"+bno+"/"+page+".json",
			function(data) {
				if (callback) {
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
				if (error) {
					error();
				}	
			});
		
	}
	
	function remove(rno, replyer, callback, error) {
		$.ajax({
			type : 'delete',
			url : contextPath+'/replies/'+rno ,
			data : JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error) {
		console.log("RNO: "+ reply.rno);
		
		$.ajax({
			type: 'put',
			url: contextPath+'/replies/'+reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	function get(rno, callback, error) {
		
		$.get(contextPath+"/replies/"+ rno + ".json", function(result) {
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function displayTime(timeValue) {
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue); // 현재 시간 객체.
		var str = "";
		
		if (gap < (1000 * 60 * 60 * 24)) { // 갭이 하루 보다 작으면.
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			var dateOutput = [ (hh > 9 ? '' : '0') + hh , ':' , (mi > 9 ? '' : '0') + mi , 
				":" , (ss > 9 ? '' : '0') + ss	].join('');
			
			console.log(dateOutput);
			
			return dateOutput;
			// 시간이 두자리로 표기 되야 하면 비워놓고 아니면 앞에 0을 붙인다. 10 이면 10 그대로 표시. 9면 09 이렇게.
			// join('') 은 뭐지? 다 합치는거 같은데? 콘솔에 띄워보자 결과물을.
			
		} else {
			
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy , '/' , (mm > 9 ? '' : '0') + mm , '/' , (dd > 9 ? '' : '0') + dd ].join('');
			// 삼항 연산자는 이렇게 아무대서나 쓸수가 있구나.
			
		}
	}
	
	return { 
			add : add ,
			getList : getList,
			remove : remove,
			update : update,
			get : get,
			displayTime : displayTime
		   };
	
})();





















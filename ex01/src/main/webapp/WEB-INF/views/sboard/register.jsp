<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

    <form role="form" action="register" method="post">
		
    	<div class="box-body">
    		<div class="form-group">
    			<label for="exampleInputEmail1">Title</label>
    			<input type="text" name='title' class="form-control" placeholder="Enter Title">
    		</div>
    		<div class="form-group">
    			<label for="exampleInputPassword1">Content</label>
    			<textarea class="form-control" name="content" rows="3" placeholder="Enter ....."></textarea>
    		</div>
    		<div class="form-group">
    			<label for="exampleInputEmail1">Writer</label>
    			<input type="text" name="writer" class="form-control" placeholder="Enter Writer">
    		</div>
    	</div>
    	
    </form>
    
<div class="box-footer">
	<button type="submit" class="btn btn-primary btn-submit">Submit</button>
	<button type="submit" class="btn btn-cancel">Cancel</button>
</div>

<%@include file="../include/footer.jsp"%>
<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$(".btn-submit").on("click",function(){
			event.preventDefault();
			
			var title = $("input[name=title]").val();
			var content = $("textarea[name=content]").val();
			var writer = $("input[name=writer]").val();
			
			if(title == "") {
				alert("제목을 입력해주세요.");
				return;
			} else if(content == "") {
				alert("내용을 입력해주세요.");
				return;
			} else if(writer == "") {
				alert("글쓴이를 입력해주세요.");
				return;
			}
			
			formObj.submit();
		});
		
		$(".btn-cancel").on("click",function(){
			self.location="/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
				+"&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});
		
	});

</script>
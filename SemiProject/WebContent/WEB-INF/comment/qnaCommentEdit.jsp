<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<jsp:include page="../header.jsp" />


<style type="text/css">

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnGoEdit").click(function(){ // 수정할 글정보를 작성하고 수정하기 버튼을 클릭하면 작동하는 이벤트처리
			
			// alert("수정하기 완료단계 submit 작동됨");
			
 			if( $("input[name=comment_content]").val().trim() == "" ){
				alert("댓글내용을 입력해야합니다!");
				return;
			}
			
			if( $("input[name=comment_content]").val().length > 50  ) {
				alert("댓글내용은 50글자까지 가능합니다!");
				return;
			}
			
			
			var frm = document.noticeEditFrm;
			frm.action="<%= ctxPath%>/comment/QnACommentEditEnd.sh";
			frm.method="POST";
			frm.submit();
			
			
		});// end of $("button#btnGoInsert").click(function(){})---------------------------------
		
		
		
	});// end of $(document).ready(function(){})------------------------------------
	

</script>


<div class="container table-responsive py-3">

	<%-- 댓글수정하기 폼태그 --%>
	<form name="noticeEditFrm">
	
		<input type="hidden" name="boardno" value="${requestScope.cvo.fk_boardno}" />
		<input type="hidden" name="commentno" value="${requestScope.cvo.commentno}" />
		
		<table class="table table-dark my-2">
			<tr>
				<td>답변 작성자</td> 
			</tr>
			
			<tr>
				<td><input type="text" name="fk_commenter" value="${requestScope.cvo.fk_commenter}" readonly /></td>
			</tr>
			
			<tr>
				<td>답변 내용</td>
			</tr>
			
			<tr>
				<td><input type="text" name="comment_content" size="50" maxlength="50" placeholder="${requestScope.cvo.comment_content}" autofocus autocomplete="off" required /></td>
			</tr>
		</table>
	</form>
	<%-- 댓글수정하기 폼태그 --%>
	
	<p class="text-center">
		<button id="btnGoEdit" type="button" class="btn btn-dark btn-md">수정하기</button>
		<button type="button" class="btn btn-dark btn-md" onclick="javascript:history.back()">취소하기</button>
	</p>
	
</div>

<jsp:include page="../footer.jsp" />
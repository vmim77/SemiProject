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
			
 			if( $("input[name=fk_writer]").val().trim() == "" ){
				alert("글쓴이를 입력해야합니다!");
				return;
			}
			
			if(  $("input[name=title]").val().trim() == ""  ){
				alert("글제목을 입력해야합니다!");
				return;
			}
			
			if(  $("textarea[name=content]").val().trim() == ""  ){
				alert("글내용을 입력해야합니다!");
				return;
			}
			
			if( parseInt($("input[name=title]").val().length) > 100  ){
				alert("글제목은 100글자까지 가능합니다.!");
				return;
			}
			
			
			if( parseInt($("textarea[name=content]").val().length) > parseInt(200)  ) {
				alert("글내용은 200글자까지 가능합니다!");
				return;
			}
			
			
			var frm = document.noticeEditFrm;
			frm.action="<%= ctxPath%>/board/noticeEditEnd.sh";
			frm.method="POST";
			frm.submit();
			
			
		});// end of $("button#btnGoInsert").click(function(){})---------------------------------
		
		
		
	});// end of $(document).ready(function(){})------------------------------------
	

</script>

<%-- 상단 이미지 --%>
<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/main.jpg');" data-stellar-background-ratio="0.5">
	<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-end justify-content-center">
			<div class="col-md-9 ftco-animate mb-5 text-center">
				<h2 class="mb-0 bread">${requestScope.bvo.boardno} 번 공지사항 수정하기</h2>
				<br><br>
			</div>
		</div>
	</div>
</section>
<%-- 상단 이미지 --%>


<div class="container table-responsive py-3">

	<%-- 글수정하기 폼태그 --%>
	<form name="noticeEditFrm">
	
		<input type="hidden" name="boardno" value="${requestScope.bvo.boardno}" />
		
		<table class="table table-dark my-2">
			<tr>
				<td>글쓴이</td> <%-- 나중에는 value를 ${sessionScope.loginuser.userid}로 잡아준다. 만약 'admin'이 아니면 안되게 유효성검사 --%>
			</tr>
			
			<tr>
				<td><input type="text" name="fk_writer" value="${requestScope.bvo.fk_writer}" readonly /></td>
			</tr>
			
			<tr>
				<td>글제목</td>
			</tr>
			
			<tr>
				<td><input type="text" name="title" maxlength="100" placeholder="${requestScope.bvo.title}" autofocus required /></td>
			</tr>
			
			<tr>
				<td>글내용</td>
			</tr>
			<tr>
				<td><textarea name="content" rows="5" cols="80" maxlength="190" placeholder="${requestScope.bvo.content}" wrap="hard" required style="resize: none; width: 90%;" ></textarea></td>
			</tr>
		</table>
	</form>
	<%-- 글수정하기 폼태그 --%>
	
	<p class="text-center">
		<button id="btnGoEdit" type="button" class="btn btn-dark btn-md">수정하기</button>
		<button type="button" class="btn btn-dark btn-md" onclick="javascript:history.back()">취소하기</button>
	</p>
	
</div>

<jsp:include page="../footer.jsp" />
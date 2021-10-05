<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<jsp:include page="../header.jsp" />


<style type="text/css">

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnGoInsert").click(function(){ // 버튼을 클릭하면 글쓰기를 위해서 폼을 전송합니다.
			
			
			if( $("input[name=fk_writer]").val().trim() == "" ){
				alert("글쓴이를 입력해야합니다!");
				return;
			}
			
			if( $("input[name=fk_writer]").val() != "admin") {
				
				alert("운영자만 공지사항을 쓸 수 있습니다!");
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
			
			
			var frm = document.noticeWriteFrm;
			frm.action="<%= ctxPath%>/board/noticeWrite.sh";
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
				<h2 class="mb-0 bread">공지사항 글쓰기</h2>
				<br><br>
			</div>
		</div>
	</div>
</section>
<%-- 상단 이미지 --%>


<div class="container table-responsive py-3">

	<%-- 글쓰기 폼태그 --%>
	<form name="noticeWriteFrm">
		<table class="table table-dark my-2">
			<tr>
				<td>글쓴이</td> <%-- 나중에는 value를 ${sessionScope.loginuser.userid}로 잡아준다. 만약 'admin'이 아니면 안되게 유효성검사 --%>
			</tr>
			
			<tr>
				<td><input type="text" name="fk_writer" required autocomplete="off" autofocus /></td>
			</tr>
			
			<tr>
				<td>글제목</td>
			</tr>
			
			<tr>
				<td><input type="text" name="title" required /></td>
			</tr>
			
			<tr>
				<td>글내용</td> <%-- 글내용은 200글자 제한이다. --%>
			</tr>
			<tr>
				<td><textarea name="content" rows="5" cols="80" maxlength="200" required style="resize: none;"></textarea></td>
			</tr>
		</table>
	</form>
	<%-- 글쓰기 폼태그 --%>
	
	<p class="text-center">
		<button id="btnGoInsert" type="button" class="btn btn-dark btn-md">글쓰기</button>
		<button type="button" class="btn btn-dark btn-md" onclick="javascript:history.back()">취소하기</button>
	</p>
	
</div>

<jsp:include page="../footer.jsp" />
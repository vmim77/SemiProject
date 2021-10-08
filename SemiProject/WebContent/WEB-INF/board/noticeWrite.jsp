<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<jsp:include page="../header.jsp" />


<style type="text/css">
	td.title{
		vertical-align: middle;
		text-align: center;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnGoInsert").click(function(){ // 버튼을 클릭하면 글쓰기를 위해서 폼을 전송합니다.
			
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
			
			
			if( parseInt($("textarea[name=content]").val().length) > 200 ) {
				alert("글내용은 200글자까지 가능합니다!");
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
		<table class="table table-dark my-2" style="width: 100%">
			
			<tr>
				<td class="title">글제목</td>
				<td><input type="text" name="title" maxlength="100" required autofocus /></td>
			</tr>
			<tr>
				<td class="title">글쓴이</td> <%-- 나중에는 value를 ${sessionScope.loginuser.userid}로 잡아준다. 만약 'admin'이 아니면 안되게 유효성검사 --%>
				<td><input type="text" name="fk_writer" value="${sessionScope.loginuser.userid}" readonly /></td>
			</tr>
			
			<tr>
				<td class="title">내용</td> <%-- 글내용은 200글자 제한이다. --%>
				<td><textarea name="content" rows="5" cols="80" maxlength="190" wrap="hard" required  style="resize: none; width: 90%; border: none;"></textarea></td>
			</tr>
			
			<tr>
				<td class="title">파일첨부</td>
				<td><input type="file" name="imgfilename" accept=".jpg, .png" /></td>
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
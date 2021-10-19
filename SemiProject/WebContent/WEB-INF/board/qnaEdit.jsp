<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
		
		$("select#fk_pnum").val("${requestScope.bvo.fk_pnum}");
		
		$("button#btnGoEdit").click(function(){ // 수정할 글정보를 작성하고 수정하기 버튼을 클릭하면 작동하는 이벤트처리
			
			// alert("수정하기 완료단계 submit 작동됨");
			
			if(  $("input[name=title]").val().trim() == ""  ){
				alert("글제목을 입력해야합니다!");
				return;
			}
			
			if(  $("textarea[name=content]").val().trim() == ""  ){
				alert("글내용을 입력해야합니다!");
				return;
			}
			
			if ( $("select[name=fk_pnum]").val() == 'selectX' ){
				alert("문의하실 상품을 고르셔야 합니다!");
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
			
			
			var frm = document.noticeEditFrm;
			frm.action="<%= ctxPath%>/board/QnAEditEnd.sh";
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
				<h2 class="mb-0 bread">${requestScope.bvo.boardno} 번 문의사항 수정하기</h2>
				<br><br>
			</div>
		</div>
	</div>
</section>
<%-- 상단 이미지 --%>


<div class="container table-responsive py-3">

	<%-- 글수정하기 폼태그 --%>
	<form name="noticeEditFrm" enctype="multipart/form-data">
	
		<input type="hidden" name="boardno" value="${requestScope.bvo.boardno}" />
		
		<table class="table table-dark my-2">
			<tr>
				<td class="title">글제목</td>
				<td><input type="text" name="title" maxlength="100" size="105" placeholder="${requestScope.bvo.title}" autofocus /></td>
			</tr>
			<tr>
				<td class="title">글쓴이</td>
				<td><input type="text" name="fk_writer" value="${sessionScope.loginuser.userid}" readonly /></td>
			</tr>
			
			<tr>
				<td class="title">제품명</td>
				<td>
					<select id="fk_pnum" name="fk_pnum">
						<c:if test="${not empty requestScope.pvoList}">
								<option value="selectX">문의할 상품을 선택하세요</option>
							<c:forEach var="pvo" items="${requestScope.pvoList}">
								<option value="${pvo.pnum}">${pvo.pname}</option>
							</c:forEach>
						</c:if>
						<c:if test="${empty requestScope.pvoList}">
							<span>준비된 상품이 없습니다!</span>
						</c:if>
					</select>
				</td>
			</tr>
			
			
			<tr>
				<td class="title">내용</td> <%-- 글내용은 200글자 제한이다. --%>
				<td><textarea name="content" rows="5" cols="80" maxlength="190" wrap="hard" placeholder="${requestScope.bvo.content}" required  style="resize: none; width: 90%; border: none;"></textarea></td>
			</tr>
			
			<tr>
				<td class="title">기존 이미지</td>
				<td> <%-- 기존 글에 등록된 이미지가 있었다면 표시해준다. --%>
					<c:choose>
						<c:when test="${not empty requestScope.bvo.imgfilename}">
							<img src="<%= ctxPath%>/images/${requestScope.bvo.imgfilename}" class="my-5" style="width: 300px; height: 300px;" />
						</c:when>
						
						<c:otherwise>
							<span>없음</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<td class="title">파일첨부</td>
					<td>
						<input type="file" name="imgfilename" accept=".jpg, .png"/>
						<p class="mt-2" style="font-size: 8pt; color:red;">※기존 이미지를 사용하시려면 다시 첨부해주세요!</p>
					</td>
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
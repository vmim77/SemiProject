<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<jsp:include page="../header.jsp" />

<style>
	#board > thead > tr th{ font-size: 13pt; font-weight: bold;}

</style>
	
<script type="text/javascript">
	
	$(document).ready(function(){
		
		
	});
	
	
	function goEdit(){ // 문의사항 글 수정하기
		
		var frm = document.boardEditFrm
		frm.action = "<%= ctxPath%>/board/QnAEdit.sh";
		frm.method = "POST";
		frm.submit();
		
	}// end of function goEdit()----------------------------------------------------------
	
	function goDelete(){ // 문의사항 글 삭제하기
		
		var boardno = "${requestScope.bvo.boardno}";
		var fk_writer = "${requestScope.bvo.fk_writer}";
		
	    var pop_width = 600;
	    var pop_height = 300;
	    
	    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
	    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
		
     	var url = "<%= ctxPath%>/board/QnADelete.sh?boardno="+boardno+"&fk_writer="+fk_writer;
			
        window.open(url, "checkDelete",
	    		         "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
		
		
	}// function goDelete()---------------------------------------------------------------
	

</script>	
	
	

	<%-- 상단 이미지 --%>
	<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/main.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-end justify-content-center">
				<div class="col-md-9 ftco-animate mb-5 text-center">
					<h2 class="mb-0 bread">${requestScope.bvo.boardno}번 문의사항</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	
	
	<div class="container my-3 px-0 py-0" >
		
		<%-- 문의사항 내용부 --%>
		<section>
			<h2 class="pt-3">문의내용</h2>
			<hr>
			<table id="board" class="table-dark px-1 py-1" style="width: 100%;">
				<thead>
					<tr>
						<th class="px-3 pt-3" colspan="6">문의번호  : ${requestScope.bvo.boardno}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">문의상품명  : ${requestScope.bvo.pname}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">글제목  : ${requestScope.bvo.title}</th>
					</tr>
						<th class="px-3 pt-1"  colspan="6">글쓴이   : ${requestScope.bvo.fk_writer}</th>
					<tr>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">작성시간 : ${requestScope.bvo.writetime}</th>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${requestScope.bvo.feedbackYN eq 0}">
								<th class="px-3 pt-1"  colspan="6">답변여부   : X</th>
							</c:when>
							<c:otherwise>
								<th class="px-3 pt-1"  colspan="6">답변여부   : O</th>
							</c:otherwise>
						</c:choose>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td colspan="6"><hr style="border: solid 1px white"></td>
					</tr>
					<tr>
						<td class="px-3"  colspan="6">
							<p class="py-3" style="font-size: 14pt;">${requestScope.bvo.content}</p>
							<c:choose>
								<c:when test="${not empty requestScope.bvo.imgfilename}">
									<p class="text-center">
										<img src="<%= ctxPath%>/images/${requestScope.bvo.imgfilename}" class="my-5" style="width: 300px; height: 300px;" />
									</p>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
		</section>
		<%-- 문의사항 내용부 --%>
		
	 	<%-- 답변 내용부 --%>
			<hr>
			<h2 class="pt-3">답변</h2>
			<hr>
			<table class="table-dark py-3" style="width: 100%;">
	
				<c:if test="${empty requestScope.commentList}">
					<tr>
						<td class="pl-3 py-3" colspan="6" style="font-weight: bold; color:orange;">관리자가 확인중에 있습니다! 잠시만 기다려주세요...</td>
					</tr>
				</c:if>
	
				<c:if test="${not empty requestScope.commentList}">
					<c:forEach var="cvo" items="${requestScope.commentList}">
						<tr style="border-bottom:solid 1px white;">
							<td style="display: none;">${cvo.commentno}</td>
							<td class="pl-3 py-3" style="width: 100px; border-right:solid 1px white;">${cvo.fk_commenter}</td>
							<td class="pl-3 py-3" style="text-align: left;">${cvo.comment_content}</td>
							<td class="pr-3 py-3" style="font-size: 10pt; text-align: right;">${cvo.registerdate}</td>
							<%-- 수정하기, 삭제하기 버튼 --%>
							<td style="width: 20px;"><span class="badge badge-pill badge-primary ml-2" id="commentEdit">수정하기</span></td>
							<td style="width: 20px;"><span class="badge badge-pill badge-danger  mx-2" id="commentDelete">삭제하기</span></td>
							<%-- 수정하기, 삭제하기 버튼 --%>
						<tr>
					</c:forEach>
				</c:if>
			</table>
			<%-- 답변 내용부 --%>
		 
		 <%-- 답변작성부 --%>
		 <c:if test="${sessionScope.loginuser.userid eq 'admin'}">
				<hr>
				<h2 class="pt-3">답변하기</h2>
				<hr>
				<div style="background-color: #343a40;">
					<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
						<form name="commentFrm" class="text-center py-3 px-2" style="width: 100%; display: flex;">
							<input type="hidden" name="fk_boardno" value="${requestScope.bvo.boardno}" />
							<input type="text" name="fk_commenter" value="${sessionScope.loginuser.userid}"class="flex-item" style="maring: auto;" readonly /> 
							<input type="text" name="comment_content" placeholder="답변내용" maxlength="50" class="flex-item mx-5" style="width: 65%;" />
							<button class="btn btn-light btn-md flex-item mx-1" type="button" onclick="goInsertComment()">답변작성</button>
						</form>
					</c:if>
				</div>
			
		 </c:if>
		<%-- 답변작성부 --%>
		
		<hr>
		
		<p class="text-right">
			<button type="button" class="btn btn-dark btn-md" onclick="javascript:location.href='<%= ctxPath%>/board/QnA.sh'">글목록</button>
			<c:if test="${sessionScope.loginuser.userid eq requestScope.bvo.fk_writer}">
				<button class="btn btn-dark btn-md my-2 mx-1" onclick="goEdit()">수정하기(작성자)</button>
			</c:if>
			<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
				<button class="btn btn-dark btn-md my-2" onclick="goDelete()">삭제하기(운영자)</button> 
			</c:if>
		</p>
	</div>
	
	<%-- 글 수정하기를 위해서 보내는 기존 글정보  폼 정보입니다. --%>
	<%-- 글 수정하기를 누르면 이 폼이 전송된다. --%>
	<form name="boardEditFrm" enctype="multipart/form-data">
		<input type="hidden" name="boardno" value="${requestScope.bvo.boardno}" />
		<input type="hidden" name="fk_writer" value="${requestScope.bvo.fk_writer}" />
		<input type="hidden" name="title" value="${requestScope.bvo.title}" />
		<input type="hidden" name="content" value="${requestScope.bvo.content}" />
		<input type="hidden" name="imgfilename" value="${requestScope.bvo.imgfilename}" />
		<input type="hidden" name="fk_pnum" value="${requestScope.bvo.fk_pnum}" />
		<input type="hidden" name="pname" value="${requestScope.bvo.pname}" />
	</form>
	<%-- 글 수정하기를 위해서 보내는 기존 글정보 폼 정보입니다. --%>
	
	
	<%-- 댓글 수정하기를 위해서 보내는 기존 댓글정보  폼 정보입니다. --%>
	<form name="commentEditFrm">
		<input class="forSubmit"  type="hidden" name="boardno" value="${requestScope.bvo.boardno}" />
		<input class="forSubmit"  type="hidden" name="commentno" />
		<input class="forSubmit"  type="hidden" name="fk_commenter"  />
		<input class="forSubmit"  type="hidden" name="comment_content" />
	</form>
	<%-- 댓글 수정하기를 위해서 보내는 기존 댓글정보 폼 정보입니다. --%>

<jsp:include page="../footer.jsp" />
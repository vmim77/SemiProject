<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<jsp:include page="../header.jsp" />

<style type="text/css">

	.effect { /* 문의사항 게시글 목록에서 특정항목에 마우스를 올리면 효과를 줍니다. */
			background-color: white;
			color: black;
			font-weight: bold;
			cursor: pointer;
		}
		
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(document).on("click","tr.board",function(){ // 글 목록중 한 개를 클릭하면 글번호를  GET방식으로 전송됩니다. 이후 그 글번호의 자세한 내용을 보여줍니다.
			
			var boardno = $(this).find("td:first-child").text(); // 글번호를 따옵니다.
			var fk_writer = $(this).find("td:nth-child(3)").text(); // 작성자를 따옵니다.
			
			// alert("boardno => " + boardno);
			// alert("fk_writer => " + fk_writer);
			
			location.href="<%= ctxPath%>/board/QnADetail.sh?boardno="+boardno+"&fk_writer="+fk_writer;
			
		});// end of $(document).on("click","tr.board",function(){})-----------------------------------
		
		
		$(document).on("mouseover", "tr.board", function(){ // 행에 mouseover가 되면 나오는 CSS 효과
			$("tr.memberInfo").removeClass("effect");
			$(this).addClass("effect");
		});// end of $(document).on("mouseover", "tr.memberInfo", function(){})-------------------------------
		
		
		$(document).on("mouseout", "tr.board", function(){ // 행에 mouseout이 되면 사라지는 CSS 효과
			$(this).removeClass("effect");
		});// end of $(document).on("mouseout", "tr.memberInfo", function(){})--------------------------------
		
		
	});// end of $(document).ready(function(){})-----------------------------------
	

</script>


	<%-- 상단 이미지 --%>
	<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/main.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-end justify-content-center">
				<div class="col-md-9 ftco-animate mb-5 text-center">
					<h2 class="mb-0 bread">문의사항 게시판</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	<%-- 문의사항 글목록 --%>
	<div class="container table-responsive py-3">
	
		<table class="table table-dark my-2 text-center">
			<thead>
				<tr>
					<th>글번호</th>
					<th>문의사항 제목</th>
					<th>글쓴이</th>
					<th>작성시간</th>
					<th>답변여부</th>
					
					<c:if test="${sessionScope.loginuser.userid eq 'admin'}"> <%-- 처리여부는 운영자로 로그인했을때만 보입니다. 답변이 필요하면 답변필요!, 답변이 완료됐다면 처리완료로 뜹니다. --%>
						<th>처리여부</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bvo" items="${requestScope.list}">
					<tr class="board">
						<td>${bvo.boardno}</td>
						<td>${bvo.title}</td>
						<td>${bvo.fk_writer}</td>
						<td>${bvo.writetime}</td>
						<td>
							<c:choose>
								<c:when test="${bvo.feedbackYN eq 0}"> <%-- 답변을 안했다면 X 표시를 --%>
									X
								</c:when>
								<c:otherwise> <%-- 답변이 완료됐다면 O 표시를 합니다. --%>
									O
								</c:otherwise>
							</c:choose>
						</td>
						
						 <%-- 처리여부는 운영자로 로그인했을때만 보입니다. 답변이 필요하면 답변필요!, 답변이 완료됐다면 처리완료로 뜹니다. --%>
						<c:if test="${sessionScope.loginuser.userid eq 'admin' && bvo.feedbackYN eq 0}">
							<td>
								<span class="badge badge-pill badge-warning ml-2">답변필요!</span>
							</td>
						</c:if>
						
						<c:if test="${sessionScope.loginuser.userid eq 'admin' && bvo.feedbackYN eq 1}">
							<td>
								<span class="badge badge-pill badge-success ml-2">처리완료</span>
							</td>
						</c:if>
						 <%-- 처리여부는 운영자로 로그인했을때만 보입니다. 답변이 필요하면 답변필요!, 답변이 완료됐다면 처리완료로 뜹니다. --%>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.userid != 'admin' }"> <%-- 문의사항은 유저만 쓸 수 있으며, 로그인을 반드시 해야한다. --%>
			<p class="text-right">
				<button class="btn btn-dark btn-md my-2" onclick="javascript:location.href='<%= ctxPath%>/board/QnAWrite.sh'">문의사항 쓰기</button> 
			</p>
		</c:if>
	</div>
	<%-- 문의사항 글목록 --%>


<jsp:include page="../footer.jsp" />
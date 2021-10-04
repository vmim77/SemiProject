<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<jsp:include page="../header.jsp" />

<style type="text/css">

	.effect {
			background-color: white;
			color: black;
			font-weight: bold;
			cursor: pointer;
		}
		
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(document).on("click","tr.board",function(){ // 글 목록중 한 개를 클릭하면 해당 글의 자세한 내용으로 GET방식으로 전송됩니다.
			
			var boardno = $(this).find("td:first-child").text();
			
			// alert("boardno => " + boardno);
			
			location.href="<%= ctxPath%>/board/noticeDetail.sh?boardno="+boardno;
			
		});// end of $(document).on("click","tr.board",function(){})-----------------------------------
		
		
		$(document).on("mouseover", "tr.board", function(){ // 행에 hover가 되면 나오는 CSS 효과
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
					<h2 class="mb-0 bread">Notice</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	<%-- 공지사항 글목록 --%>
	<div class="container table-responsive py-3">
		<table class="table table-dark my-2 text-center">
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>글내용</th>
					<th>글쓴이</th>
					<th>작성시간</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bvo" items="${requestScope.list}">
					<tr class="board">
						<td>${bvo.boardno}</td>
						<td>${bvo.title}<span class="ml-2" style="font-size: 10pt;">[${bvo.commentCnt}]</span></td>
						<td>${bvo.content}</td>
						<td>${bvo.fk_writer}</td>
						<td>${bvo.writetime}</td>
						<td>${bvo.viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<p class="text-right">
			<button class="btn btn-dark btn-md my-2">글 쓰기[미구현]</button> <%-- tbl_notice_board insert --%>
		</p>
	</div>
	<%-- 공지사항 글목록 --%>


<jsp:include page="../footer.jsp" />
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
		
		$(document).on("click","tr.board",function(){ 
			// 글 목록중 한 개의 글을 선택하면 그 글의 자세한 내용을 보여준다.
			
			var boardno = $(this).find("td:first-child").text(); 
			// 게시글 번호를 추출해온다.
			
			location.href="<%= ctxPath%>/board/noticeDetail.sh?boardno="+boardno;
			// GET 방식으로 전송하여 게시글의 자세한 내용을 조회한다.
			
		});// end of $(document).on("click","tr.board",function(){})-----------------------------------
		
		// 행에 mouseover가 되면 CSS 효과를 추가한다.
		$(document).on("mouseover", "tr.board", function(){
			$("tr.memberInfo").removeClass("effect");
			$(this).addClass("effect");
		});// end of $(document).on("mouseover", "tr.memberInfo", function(){})-------------------------------
		
		// 행에 mouseout이 되면 CSS 효과를 없앤다.
		$(document).on("mouseout", "tr.board", function(){ 
			$(this).removeClass("effect");
		});// end of $(document).on("mouseout", "tr.memberInfo", function(){})--------------------------------
		
	});// end of $(document).ready(function(){})-----------------------------------
	
	// Function Declaration 
	// 게시글 검색하기 - 제목, 내용 / 작성자는 'admin'만 있기 때문에 제외한다.
	function goSearch() { 
		
		if($("input#searchWord").val() == "") { // 만약 검색어가 빈 칸이라면 새로고침을 시킨다.
			location.reload(true);
		}
		
		var frm = document.noticeFrm;
	
		frm.action = "<%= ctxPath%>/board/noticeSearch.sh";
		frm.method = "get";
		frm.submit();
		
		window.reload(true);
		
	}// end of function goSearch()---------------------------


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
	<div class="container table-responsive p-1">
	
		<table class="table table-dark my-2 text-center">
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>글쓴이</th>
					<th>작성시간</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bvo" items="${requestScope.list}">
					<tr class="board">
						<td>${bvo.boardno}</td>
						<td>${bvo.title}
							<c:choose>
								<c:when test="${bvo.commentCnt != 0}">
									<span class="ml-2" style="font-size: 10pt;">[${bvo.commentCnt}]</span>
								</c:when>
							</c:choose>
						</td>
						<td>${bvo.fk_writer}</td>
						<td>${bvo.writetime}</td>
						<td>${bvo.viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${sessionScope.loginuser.userid eq 'admin' }"> <%-- 공지사항은 운영자만 쓸 수 있습니다. --%>
			<p class="text-right">
				<button class="btn btn-dark btn-md my-2" onclick="javascript:location.href='noticeWrite.sh'">글쓰기</button> <%-- tbl_notice_board insert --%>
			</p>
		</c:if>
		
		<form name="noticeFrm" class="text-center my-5"> 
			<select id="searchType" name="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" id="searchWord" name="searchWord" />
			<input type="text" style="display: none;" />
			   
			<button type="button" class="btn btn-dark" onclick="goSearch();" style="margin-right: 30px;">검색</button>
		</form>
	</div>
	<%-- 공지사항 글목록 --%>


<jsp:include page="../footer.jsp" />
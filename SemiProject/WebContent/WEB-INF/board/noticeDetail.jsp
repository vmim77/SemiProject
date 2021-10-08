<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<jsp:include page="../header.jsp" />

<style>
	.badge {
		cursor: pointer;
	}
	
	h2{
		display:inline-block;
		vertical-align: middle;
	}
</style>
	
<script type="text/javascript">
	
	$(document).ready(function(){
			
		var commentno = 0;
		var loginuser = "${sessionScope.loginuser.userid}";
		
		$(document).on("click","span#commentDelete", function(){ // 댓글 삭제하기
			
			commentno = $(this).parent().parent().find("td:first-child").text(); // 댓글번호뽑기
			var fk_commenter = $(this).parent().parent().find("td:nth-child(2)").text();
			
			
			if(loginuser == "admin"){
				alert("운영자 접근확인, 일반회원 및 본인의 댓글 삭제가 가능합니다.");
			}
			else if(loginuser != fk_commenter ){
				alert("다른 사용자의 댓글을 삭제할 수 없습니다.");
				return;
			}
			
		    var pop_width = 600;
		    var pop_height = 300;
		    
		    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
		    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
			
	     	var url = "<%= ctxPath%>/comment/noticeCommentDelete.sh?commentno="+commentno;
				
	        window.open(url, "checkDelete",
		    		         "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
			
		});
		
		$(document).on("click","span#commentEdit", function(){ // 댓글 수정하기
			
			
			
			commentno = $(this).parent().parent().find("td:first-child").text(); // 댓글번호뽑기
			var fk_commenter = $(this).parent().parent().find("td:nth-child(2)").text();
			var comment_content = $(this).parent().parent().find("td:nth-child(3)").text();
			
			
			
			if(loginuser == "admin"){
				alert("운영자 접근확인, 일반회원 및 본인의 댓글 수정이 가능합니다.");
			}
			else if(loginuser != fk_commenter ){
				alert("다른 사용자의 댓글을 수정할 수 없습니다.");
				return;
			}
			
			// alert(fk_commenter);
			
			$("input.forSubmit[name=commentno]").val(commentno);
			$("input.forSubmit[name=fk_commenter]").val(fk_commenter);
			$("input.forSubmit[name=comment_content]").val(comment_content);
			
			var frm = document.commentEditFrm;
			frm.action = "<%= ctxPath%>/comment/noticeCommentEdit.sh";
			frm.method = "post";
			frm.submit();
			
		});
		
		
	});// end of $(document).ready(function(){})---------------------------------------------
	
	// function declaration
	function goInsertComment(){ // 댓글쓰기
		
		if( $("input[name=fk_commenter]").val().trim() == '' ){
			alert("비회원은 댓글작성이 불가능합니다!");
			return;
		}
	
		if( $("input[name=comment_content]").val().trim() == '' ){
			alert("글내용을 반드시 써야합니다.");
			return;
		}
		
		if( $("input[name=comment_content]").val().length > 50 ){
			alert("댓글은 50글자 미만으로 써야합니다.");
			return;
		}
		
		var frm = document.commentFrm;
		frm.action="<%= ctxPath%>/board/noticeComment.sh";
		frm.method="post";
		frm.submit();
		
	}// end of function goInsertComment(){}--------------------------------
	
	
	//Function Declaration
	
	function goEdit(){ // 공지사항 글 수정하기
		
		var frm = document.boardEditFrm
		frm.action = "<%= ctxPath%>/board/noticeEdit.sh";
		frm.method = "POST";
		frm.submit();
		
	}// end of function goEdit()----------------------------------------------------------
	
	// Function Declaration
	
	function goDelete(){ // 공지사항 글 삭제하기
		
		var boardno = ${requestScope.boardno};
		
	    var pop_width = 600;
	    var pop_height = 300;
	    
	    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
	    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
		
     	var url = "<%= ctxPath%>/board/noticeDelete.sh?boardno="+boardno;
			
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
					<h2 class="mb-0 bread">${requestScope.boardno}번 공지글</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	
	
	<div class="container my-3 px-0 py-0" >
		
		<%-- 글내용부 --%>
		<section>
			<h2 class="pt-3">글내용</h2>
			<hr>
			<table id="board" class="table-dark px-1 py-1" style="width: 100%;">
				<thead>
					<tr>
						<th class="px-3 pt-3" colspan="6">글번호  : ${requestScope.bvo.boardno}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">글제목  : ${requestScope.bvo.title}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">글쓴이   : ${requestScope.bvo.fk_writer}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">작성시간 : ${requestScope.bvo.writetime}</th>
					</tr>
					<tr>
						<th class="px-3 pt-1"  colspan="6">조회수    : ${requestScope.bvo.viewcnt}</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td colspan="6"><hr style="border: solid 1px white"></td>
					</tr>
					<tr>
						<td class="px-3"  colspan="6">
							<p class="py-3">${requestScope.bvo.content}</p>
							<c:choose>
								<c:when test="${not empty requestScope.bvo.imgfilename}">
									<p class="text-center">
										<img src="<%= ctxPath%>/images/${requestScope.bvo.imgfilename}" class="my-5" style="width: 300px; height: 300px;" />
										<%-- 경로는 반드시 /SemiProject/images 에 있는 파일이여야 한다. --%>
									</p>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
		</section>
		 <%-- 글내용부 --%>
		
	 	<%-- 댓글내용부 --%>
		<section>
			<hr>
			<h2 class="pt-3">댓글</h2>
			<hr>
			<table class="table-dark py-3" style="width: 100%;">
	
				<c:if test="${empty requestScope.commentList}">
					<tr>
						<td class="pl-3 py-3" colspan="6" style="font-weight: bold">댓글 없음</td>
					</tr>
				</c:if>
	
				<c:if test="${not empty requestScope.commentList}">
					<c:forEach var="cvo" items="${requestScope.commentList}">
						<tr style="border-bottom:solid 1px white;">
							<td style="display: none;">${cvo.commentno}</td>
							<td class="pl-3 py-3" style="width: 100px; border-right:solid 1px white;">${cvo.fk_commenter}</td>
							<td class="pl-3 py-3" style="text-align: left;">${cvo.comment_content}</td>
							<td class="pr-3 py-3" style="font-size: 10pt; text-align: right;">${cvo.registerdate}</td>
							<td style="width: 20px;"><span class="badge badge-pill badge-primary ml-2" id="commentEdit">수정하기</span></td>
							<td style="width: 20px;"><span class="badge badge-pill badge-danger  mx-2" id="commentDelete">삭제하기</span></td>
							<%-- 나중에는 ${loginuser.userid} == fk_commenter 인 댓글에만 수정하기, 삭제하기를 보여주게 한다. --%>
							<%-- <c:if test="${sessionScope.loginuser.userid eq ${cvo.fk_commenter}"> --%>
							<%-- 수정하기, 삭제하기 버튼 --%>
						<tr>
					</c:forEach>
				</c:if>
			</table>
		<%-- 댓글내용부 --%>
		 
		 
		<%-- 댓글작성부 --%>
			<hr>
			<h2 class="pt-3">댓글 쓰기</h2>
			<hr>
			<div style="background-color: #343a40;">
				<c:if test="${empty sessionScope.loginuser}">
					<div class="alert alert-warning" role="alert">
					  	비회원은 댓글을 달 수 없습니다!
					</div>
				</c:if>
				
				<c:if test="${not empty sessionScope.loginuser}">
					<form name="commentFrm" class="text-center py-3 px-2" style="width: 100%; display: flex;">
						<input type="hidden" name="fk_boardno" value="${requestScope.bvo.boardno}" />
						<input type="text" name="fk_commenter" value="${sessionScope.loginuser.userid}" placeholder="로그인을해야 사용할 수 있습니다." class="flex-item" style="maring: auto;" readonly /> 
						<input type="text" name="comment_content" placeholder="댓글내용" maxlength="50" class="flex-item mx-5" style="width: 65%;" />
						<button class="btn btn-light btn-md flex-item mx-1" type="button" onclick="goInsertComment()">댓글작성</button>
					</form>
				</c:if>
			</div>
		</section>
		<%-- 댓글작성부 --%>
		
		<hr>
		
		<p class="text-right">
			<button type="button" class="btn btn-dark btn-md" onclick="javascript:location.href='<%= ctxPath%>/board/notice.sh'">글목록</button>
			<c:if test="${sessionScope.loginuser.userid eq 'admin' }">
				<button class="btn btn-dark btn-md my-2 mx-1" onclick="goEdit()">글 수정하기</button> <%-- tbl_notice_board update / 조건은 운영자만 수정할 수 있음 --%>
				<button class="btn btn-dark btn-md my-2" onclick="goDelete()">글 삭제하기</button> <%-- tbl_notice_board delete / 조건은 운영자만 삭제할 수 있음, 또한 댓글도 다 삭제됨 --%>
			</c:if>
		</p>
	</div>
	
	<%-- 글 수정하기를 위해서 보내는 기존 글정보  폼 정보입니다. --%>
	<form name="boardEditFrm">
		<input type="hidden" name="boardno" value="${requestScope.bvo.boardno}" />
		<input type="hidden" name="fk_writer" value="${requestScope.bvo.fk_writer}" />
		<input type="hidden" name="title" value="${requestScope.bvo.title}" />
		<input type="hidden" name="content" value="${requestScope.bvo.content}" />
		<input type="hidden" name="imgfilename" value="${requestScope.bvo.imgfilename}" />
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Spectral:ital,wght@0,200;0,300;0,400;0,500;0,700;0,800;1,200;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/animate.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/owl.theme.default.min.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/magnific-popup.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/flaticon.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/style.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 


<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<!--  jQuery -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style type="text/css">


	
	
</style>


<script type="text/javascript">

	$(document).ready(function(){ // 마지막으로 글을 삭제할지 안할지 확인 메세지를 띄운다.
		
		$("button#yesDelete").click(function(){ // 삭제를 눌렀다면
			var frm = document.goToDeleteFrm;
			frm.action = "<%= ctxPath%>/board/noticeDelete.sh";
			frm.method = "post";
			frm.submit();
		});
		
		$("button#noDelete").click(function(){ // 삭제 취소를 눌렀다면
			self.close();
			opener.location.href="<%= ctxPath%>/board/noticeDetail.sh?boardno="+${requestScope.boardno};
		});
		
	});// end of $(document).ready(function(){})------------------------------------------------

</script>



</head>
<body>
	
	<div class="container my-5 text-center">
		<h4>정말로 <span style="color:red;">${requestScope.boardno}</span>번 글을 삭제하시겠습니까?</h4>
		<div class="text-center my-5">
			<button type="button" class="btn btn-danger btn-md" id="yesDelete">예</button>
			<button type="button" class="btn btn-primary btn-md" id="noDelete">아니요</button>
		</div>
	</div>
	<%-- 삭제를 위해서 해당 공지사항 게시글번호를 보내준다. --%>
	<form name="goToDeleteFrm">
		<input type="hidden" name="boardno" value="${requestScope.boardno}">
	</form>
	<%-- 삭제를 위해서 해당 공지사항 게시글번호를 보내준다. --%>
</body>
</html>
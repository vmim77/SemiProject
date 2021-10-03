<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정하기[운영자]</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


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

	$(document).ready(function(){
		
		$("button#btnEditUserInfo").click(function(){ // 수정하기 버튼을 클릭하면
			
			// update 를 위한 Action.java로 보냅니다.
			
			var frm = document.adminEditUser;
			frm.action="<%= ctxPath%>/admin/memberEditEnd.sh";
			frm.method="POST"
			frm.submit();
			
		});// end of $("button#btnEditUserInfo").onclick(function(){})----------------------------------
		
	});

</script>


</head>
<body>
		
			<div class="justify-content-center" style="border:solid 1px red;">
				<form name="adminEditUser" class="my-3">
					<table class="table-dark mx-auto" style="border:solid 1px blue; width: 100%;">
						<tr>
							<td>성명</td>
							<td>
								<input type="hidden" name="userid" value="${requestScope.userid}" />
								<input type="text" name="name" value="${requestScope.member.name}" required />
							</td>
						</tr>
					
						<!-- 		
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="text" name="pwd" value="" required />
							</td>
						</tr>
					
						<tr>
							<td>비밀번호 확인</td>
							<td>
								<input type="text" name="pwd2" value="" required />
							</td>
						</tr> 
						-->
						<tr>
							<td>이메일</td>
							<td>
								<input type="text" name="email" value="${requestScope.member.email}" required />
							</td>
						</tr>
						<tr>
							<td>휴대폰</td>
							<td>
								<input type="text" name="hp1" value="010" size="3" />-
								<input type="text" name="hp2" value="${fn:substring(requestScope.member.mobile, 3, 7)}" required size="4" />-
								<input type="text" name="hp3" value="${fn:substring(requestScope.member.mobile, 7, -1)}" required size="4"/>
							</td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td>
								<input type="text" name="postcode" value="${requestScope.member.postcode}" required />
							</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>
								<input type="text" name="address" value="${requestScope.member.address}" required size="40" />
							</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td>
								<input type="text" name="detailaddress" value="${requestScope.member.detailaddress}" required size="40" />
							</td>
						</tr>
						<tr>
							<td>기타주소</td>
							<td>
								<input type="text" name="extraaddress" value="${requestScope.member.extraaddress}" required size="40" />
							</td>
						</tr>
					</table>
			</form>
		</div>
		<button id="btnEditUserInfo">수정하기</button>
</body>

<script src="<%= ctxPath%>/js/jquery.min.js"></script>
<script src="<%= ctxPath%>/js/jquery-migrate-3.0.1.min.js"></script>
<script src="<%= ctxPath%>/js/popper.min.js"></script>
<script src="<%= ctxPath%>/js/bootstrap.min.js"></script>
<script src="<%= ctxPath%>/js/jquery.easing.1.3.js"></script>
<script src="<%= ctxPath%>/js/jquery.waypoints.min.js"></script>
<script src="<%= ctxPath%>/js/jquery.stellar.min.js"></script>
<script src="<%= ctxPath%>/js/owl.carousel.min.js"></script>
<script src="<%= ctxPath%>/js/jquery.magnific-popup.min.js"></script>
<script src="<%= ctxPath%>/js/jquery.animateNumber.min.js"></script>
<script src="<%= ctxPath%>/js/scrollax.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="<%= ctxPath%>/js/google-map.js"></script>
<script src="<%= ctxPath%>/js/main.js"></script>

</html>
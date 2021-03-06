<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
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

	.title{
		font-weight: bold;
		font-size: 16pt;
	}
	
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnEditUserInfo").click(function(){ // 수정하기 버튼을 클릭하면
			
			// update 를 위한 Action.java로 보냅니다.
			
			if( $("input[name=point]").val() == "" || !Number($("input[name=point]").val()) ){
				alert("숫자만 입력하세요!");
				return;
			}
			$("input#onlyinfo").val("onlyinfo");
			var frm = document.adminEditUser;
			frm.action="<%= ctxPath%>/admin/memberEditEnd.sh";
			frm.method="POST";
			frm.submit();
			
		});// end of $("button#btnEditUserInfo").onclick(function(){})----------------------------------
		
		$(window).on('beforeunload', function() { // 팝업창에서 수정하기를 누르지않고 X표시를 눌러서 끄면 부모창을 새로고침 해줍니다.
			opener.location.reload(true); 
		});
		
		
		
		$("button#coupon").click(function(){
			
			$("input#onlycoupon").val("onlycoupon");
			
			
			var frm = document.adminEditUser;
			frm.action="<%= ctxPath%>/admin/memberEditEnd.sh";
			frm.method="POST";
			frm.submit();		
			
			alert("추가되었습니다.");
			
		});//end of $("button#goCoupon").click(function()
				
		
		
		
	});// end of $(document).ready(function(){})------------------------------------------------

</script>


</head>
<body>
		
	<div class="container">
		<div class="row justify-content-center">
				<form name="adminEditUser" class="my-3">
				<input type="hidden" name="onlycoupon" id="onlycoupon" value="test"/>
				<input type="hidden" name="onlyinfo" id="onlyinfo" value="test"/>
					<input type="hidden" name="userid" value="${requestScope.member.userid}"/> <%-- where절에 쓸 userid --%>
					<table class="table-dark" >
						<tr>
							<td class="title"><h4 style="color:white;">${requestScope.member.userid} 님의 회원정보 변경하기</h4></td>
						</tr>
						<tr>
							<td class="title">포인트</td>
							<td>
								<input type="text" style="display: none;"> <%-- 인풋태그가 한 개면 엔터만 눌러도 submit이 되어지는 걸 막기 위해서이다. --%>
								<input type="text" name="point" value="${requestScope.member.point}" size="6" autocomplete="off" /><span> 원</span>
							</td><%-- <fmt:formatNumber value='${requestScope.member.point}' pattern="###,###" />  --%>
						</tr>
						<tr>
							<td class="title">회원상태</td>
							<td>
								<select name="status"> <%-- DB에서 1이라면 '사용가능'이 먼저 올라와져있습니다. --%>
									<c:choose>
										<c:when test="${requestScope.member.status eq 1}">
											<option selected="selected" value="1">사용가능</option>
											<option value="0">탈퇴</option>
										</c:when>
										<c:otherwise>
											<option value="1">사용가능</option>
											<option selected="selected" value="0">탈퇴</option>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">휴면처리</td> <%-- DB에서 0이라면 '활동중'이 먼저 올라와져있습니다. --%>
							<td>
								<select name="idle">
									<c:choose>
										<c:when test="${requestScope.member.idle eq 0}">
											<option selected="selected" value="0">활동중</option>
											<option value="1">휴면처리</option>
										</c:when>
										<c:otherwise>
											<option selected="selected" value="1">휴면처리</option>
											<option value="0">활동중</option>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
						</tr>
						<tr>
						<td class="title">쿠폰</td>
							<td>
						   <select name="couponname">
								<c:choose>
									<c:when test="${requestScope.couponname eq 0}">
										<option selected="selected" value="0">쿠폰없음</option>
										<option value="1">사용완료</option>
									</c:when>
									<c:otherwise>
										<option selected="selected" value="1">추천인쿠폰/3000원</option>
										<option value="2">신규가입쿠폰/5000원</option>
										<option value="3">이벤트쿠폰/10000원</option>
										<option value="4">이벤트쿠폰(VIP)/20000원</option>
									</c:otherwise>
								</c:choose>
							</select>
						  <button id="coupon">추가</button>
						</td>
					</tr>
					</table>
			</form>
		</div>

		<p class="text-center">
			<button id="btnEditUserInfo" class="btn btn-dark btn-md">수정하기</button>
		</p>
	</div>
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
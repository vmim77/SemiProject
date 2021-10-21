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

<script type="text/javascript">
	$(document).ready(function(){
		
		$("button#submit").click(function(){
			
			var frm = document.changeStatusFrm;
			frm.action = "<%= ctxPath%>/admin/orderChangeEnd.sh";
			frm.method = "post";
			frm.submit();
			
		});
		
	});
</script>


<title>[운영자]주문상태 변경하기</title>
</head>
<body>
	<div class="container">
		<h1 class="text-center">${requestScope.map.userid} 님의 현재 주문정보</h1>
		<table class="table table-dark text-center">
			<thead>
				<tr>
					<th>아이디</th>
					<th>주문번호</th>
					<th>제품번호</th>
					<th>현재 배송상태</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${requestScope.map.userid}</td>
					<td>${requestScope.map.odrcode}</td>
					<td>${requestScope.map.pnum}</td>
					<td>${requestScope.map.status}</td>
				</tr>
				<tr>
					<td colspan="3" style="font-weight: bold; font-size: 15pt;">주문상태 변경하기</td>
					<td colspan="3">
						<form name="changeStatusFrm">
							<input type="hidden" name="odrcode"  value="${requestScope.map.odrcode}" />
							<input type="hidden" name="pnum"  value="${requestScope.map.pnum}" />
							<select name="changeStatus">
								<c:if test="${requestScope.map.status eq '배송준비중'}">
									<option value="1">배송시작</option>
									<option value="2">배송완료</option>
								</c:if>
								<c:if test="${requestScope.map.status eq '배송시작'}">
									<option value="2">배송완료</option>
								</c:if>
							</select>
						</form>
					</td>
				</tr>
				<tr>
				<td colspan="6"><button class="btn btn-md btn-light" id="submit">변경하기</button></td>
				</tr>
			</tbody>
		</table>
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
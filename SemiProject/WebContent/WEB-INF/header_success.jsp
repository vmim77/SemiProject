<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>  
    
<% String ctxPath= request.getContextPath(); %>

<!DOCTYPE html>
	<head>
		<title>세미프로젝트 2조</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<link href="https://fonts.googleapis.com/css2?family=Spectral:ital,wght@0,200;0,300;0,400;0,500;0,700;0,800;1,200;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="/Subject/css/animate.css">
		<link rel="stylesheet" href="/Subject/css/owl.carousel.min.css">
		<link rel="stylesheet" href="/Subject/css/owl.theme.default.min.css">
		<link rel="stylesheet" href="/Subject/css/magnific-popup.css">
		<link rel="stylesheet" href="/Subject/css/flaticon.css">
		<link rel="stylesheet" href="/Subject/css/style.css">
	</head>
	
	<body style='font-family:맑은고딕;'> <%-- CSS에 글씨체들이 너무 섞여있어서 여기에 직접 쓰시면 우선순위 높아서 가장 먼저 적용됩니다!! --%>

		<div>
    	<%-- 네비게이션 시작 --%>
		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
			<div class="container">
				<a class="navbar-brand" href="<%= ctxPath%>/index.sh">THIS MAN</a>

	
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="oi oi-menu"></span> Menu <%-- 너비가 작아지면 나타납니다. --%>
				</button>
				
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a href="<%= ctxPath%>/about.sh" class="nav-link">About</a></li>
						<li class="nav-item dropdown"  style="opacity: 0.8;">
							<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Category</a>
							<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
								<a class="dropdown-item" href="#">Shoes A</a>
								<a class="dropdown-item" href="#">Shoes B</a>
								<a class="dropdown-item" href="#">Shoes C</a>
							</div>
						</li>
						<li class="nav-item dropdown" style="opacity: 0.8;">
							<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
							<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
								<a class="dropdown-item" href="<%=ctxPath%>/login/logout.sh">로그아웃  </a>
								<a class="dropdown-item" href="#">장바구니  </a>
								<a class="dropdown-item" href="#">주문조회  </a>
								<a class="dropdown-item" href="#">배송조회   </a>
								<a class="dropdown-item" href="#">내정보</a>
								<a class="dropdown-item" href="#">내정보수정</a>
							</div>
						</li>
						<li class="nav-item"><a href="#" class="nav-link">Contact</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<%-- 네비게이션 끝 --%>
		</div>

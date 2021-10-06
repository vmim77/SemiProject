<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath= request.getContextPath(); %>
    
<!DOCTYPE html>
	<%-- Bootstrap, JS, CSS --%>
	<head>
		<title>세미프로젝트 2조</title>
		<meta charset="utf-8">
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

	div#kakaodiv{ /* 카카오버튼 CSS 입니다. */ 
		
		position: fixed;
		right: 60px;
		bottom: 41px;
		border-radius: 50px;
		background-color: #f7e000;
		color: #231916;
		font-size: 11px;
		font-weight: bold;
	    letter-spacing: -1px;
	    padding: 0 17px;
	    box-shadow: -1px 2px 4px 2px rgb(0 0 0 / 7%);
	
	}
	
	img#kakaoimg { /* 카카오이미지 CSS 입니다. */ 
		width: 17px;
		margin: auto;
	
	}
	
	div#toTop{ /* 위로가기 버튼 CSS 입니다. */ 
		position: fixed;
		right: 20px;
		bottom: 38px;
		
	}

</style>
		
		
<script type="text/javascript">

	$(document).ready(function(){ // 화면 하단에 따라다니는 '카카오톡'을 클릭하면 상담용 채널 URL로 이동합니다. 현재는 '로맨틱무브'에 연결해놨습니다.
		
		$("div#kakaodiv").click(function(){
			location.href="https://accounts.kakao.com/login?continue=http%3A%2F%2Fpf.kakao.com%2F_xeplFV%2Ffriend";
		});
	
	});
	
    //== 나의 정보 수정하기 == //
	   function goEditPersonal(userid) {
	   
	    var url = "<%= request.getContextPath()%>/member/memberEdit.sh?userid="+userid; 
	     
	    var pop_width = 800;
	    var pop_height = 600;
	    var pop_left = Math.ceil( (window.screen.width - pop_width)/2 );
	    var pop_top = Math.ceil( (window.screen.height - pop_height)/2 );
	    
	     window.open(url, "memberEdit",
	                "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
	   }     
</script>	
	
	
		
	</head>
	<%-- Bootstrap, JS, CSS --%>
	
	<body style='font-family: 맑은고딕;'> <%-- CSS에 글씨체들이 너무 섞여있어서 여기에 직접 쓰시면 우선순위 높아서 가장 먼저 적용됩니다!! --%>

    	<%-- 네비게이션 시작 --%>
		<div>
		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar ftco-navbar-light" id="ftco-navbar">
			<div class="container">
				<a class="navbar-brand" href="<%= ctxPath%>/index.sh">THIS MAN</a>

				 <%-- 너비가 작아지면 나는 메뉴입니다. --%>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
					<span class="oi oi-menu"></span> Menu
				</button>
				 <%-- 너비가 작아지면 나는 메뉴입니다. --%>
				 
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
					
						<%-- 회사소개 메뉴입니다. --%>
						<li class="nav-item"><a href="<%= ctxPath%>/about.sh" class="nav-link">ABOUT</a></li>
						
						<%-- 공지사항 메뉴입니다. --%>
						<li class="nav-item"><a href="<%= ctxPath%>/board/notice.sh" class="nav-link">NOTICE</a></li>
						
						
						<%-- 카테고리 메뉴입니다. --%>
						<li class="nav-item dropdown"  style="opacity: 0.8;">
							<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">SHOP</a>
							<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
								<a class="dropdown-item" href="#">Derby</a>
								<a class="dropdown-item" href="#">Mule</a>
								<a class="dropdown-item" href="#">Boots</a>
								<a class="dropdown-item" href="#">Loafer</a>
								<a class="dropdown-item" href="#">Oxford</a>
								<a class="dropdown-item" href="#">Monk</a>
							</div>
						</li>
						
						<%-- 회원 메뉴입니다. --%>
						<!-- 로그인 전-->
						<c:if test="${empty sessionScope.loginuser}">
							<li class="nav-item dropdown" style="opacity: 0.8;">
								<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">My Menu</a>
								<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
									<a class="dropdown-item" href="<%= ctxPath%>/login/login.sh">로그인     </a>
									<a class="dropdown-item" href="<%= ctxPath%>/member/memberRegister.sh">회원가입  </a>
									<a class="dropdown-item" href="#">장바구니  </a>
									<a class="dropdown-item" href="#">주문조회  </a>
									<a class="dropdown-item" href="#">배송조회   </a>
									<a class="dropdown-item" href="#">내정보수정</a>
								</div>
							</li>	
						</c:if>
						
						<!-- 로그인 후 -->
						<c:if test="${not empty sessionScope.loginuser}">
							<li class="nav-item dropdown" style="opacity: 0.8;">
								<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">로그인됨</a>
								<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
									<a class="dropdown-item" href="<%= ctxPath%>/login/logout.sh">로그아웃  </a>
									<a class="dropdown-item" href="#">장바구니  </a>
									<a class="dropdown-item" href="#">주문조회  </a>
									<a class="dropdown-item" href="#">배송조회   </a>
									<a class="dropdown-item" href="<%= ctxPath%>/member/mypage.sh">마이페이지</a>
								</div>
							</li>
						</c:if>
						
						<%-- 관리자 메뉴입니다. --%>
						<c:if test="${sessionScope.loginuser.userid eq 'admin' }">
							<li class="nav-item dropdown" style="opacity: 0.8;">
								<a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">ADMIN MENU</a>
								<div class="dropdown-menu" aria-labelledby="dropdown04" style="text-align:center;">
									<a class="dropdown-item" href="<%= ctxPath%>/admin/memberList.sh">회원목록      </a>
									<a class="dropdown-item" href="#">제품등록      </a>
									<a class="dropdown-item" href="#">전체주문내역</a>
								</div>
							</li>
						</c:if>
						
						<%-- 오프라인 메장 메뉴입니다. --%>
						<li class="nav-item"><a href="<%= ctxPath%>/store.sh" class="nav-link">STORE</a></li>
						
						<c:if test="${not empty sessionScope.loginuser}">
							<li class="nav-item" >
								<a href="#" class="nav-link" style="color:#fff; font-size: 10pt;">${sessionScope.loginuser.name} 님</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
			
		</nav>
		</div>
		<%-- 네비게이션 끝 --%>

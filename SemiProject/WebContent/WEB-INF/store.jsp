<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>        

<jsp:include page="/WEB-INF/header_success.jsp" />

<style type="text/css">

	.card-body { 
		margin-top: 10px;
	}
	
	.col-md-4 {
		padding: 0;
	}

</style>
	

	<%-- 상단 이미지 --%>
	<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/backimage1.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-end justify-content-center">
				<div class="col-md-9 ftco-animate mb-5 text-center">
					<h2 class="mb-0 bread">Store List</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	
	<%-- 오프라인 매장들을 넣어둔 카드들이 있습니다. 지도사진을 클릭하며 네이버지도로 이동합니다. --%>
	<section class="container">
		<div class="row justify-content-center" style="margin:50px 0;">
				<div class="card-deck mb-2">
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/entry/place/13433636?c=14128680.7475840,4517362.7469254,15,0,0,0,dh" target="_blank">    
						  	<img src="<%= ctxPath%>/images/store1.jpg" class="card-img-top">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">HONGDAE STORE (MAIN)</h5>
						    <p>서울시 마포구 등교동 153-16 1층<br>
							TEL. 070-8884-6853<br>
							Mon~Sun. 11:00-am~21:00pm</p>
						  </div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/entry/place/1241868576?c=14345403.3765337,4195344.6525626,15,0,0,0,dh" target="_blank">  
						  	<img src="<%= ctxPath%>/images/store2.jpg" class="card-img-top"">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">GIMHAE STORE</h5>
						    <p>경상남도 김해시 전하로 304번길 19 101호<br>
							TEL. 055-724-4142<br>
							Reservation System</p>
						  </div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/search/%EB%A1%9C%EB%A7%A8%ED%8B%B1%EB%AC%B4%EB%B8%8C%20%EC%9A%B8%EC%82%B0%EC%A0%90/place/1170602864?c=14395500.0750932,4239610.9005536,15,0,0,0,dh" target="_blank">
						  	<img src="<%= ctxPath%>/images/store3.jpg" class="card-img-top">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">ULSAN STORE</h5>
							<p>울산시 중구 성남동 30-5번지 1층<br>
							TEL. 052-911-6965<br>
							Mon~Sun. 11:00am~20:30pm</p>
						  </div>
						</div>
					</div>
				</div>
		</div>
		
		<div class="row justify-content-center" style="margin:50px 0;">
				<div class="card-deck mb-2">
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/search/%EB%A1%9C%EB%A7%A8%ED%8B%B1%EB%AC%B4%EB%B8%8C%20%EC%B6%98%EC%B2%9C%EC%A0%90/place/186698877?c=14219496.9470212,4561761.5528170,15,0,0,0,dh" target="_black"> 
						  	<img src="<%= ctxPath%>/images/store4.jpg" class="card-img-top">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">CHUNCHEON STORE</h5>
						    <p>강원도 춘천 효자동 612-10 1층<br>
							TEL. 033-251-2101<br>
							Mon~Sat. 10:30am~20:30pm</p>
						  </div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/search/%EB%A1%9C%EB%A7%A8%ED%8B%B1%EB%AC%B4%EB%B8%8C%20%EA%B4%91%EC%A3%BC%EC%A0%90/place/1761014815?c=14120677.8446756,4194027.4411588,15,0,0,0,dh" target="_blank">
						  	<img src="<%= ctxPath%>/images/store5.jpg" class="card-img-top">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">GWANGJU STORE</h5>
						    <p>광주광역시 광산구 쌍암동 688-4 폭스존 227호<br>
							TEL. 07-4548-4361<br>
							Mon~Sun. 11:00-am~20:00pm</p>
						  </div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card border-light">
						  <a href="https://map.naver.com/v5/search/%EB%A1%9C%EB%A7%A8%ED%8B%B1%EB%AC%B4%EB%B8%8C%20%EC%A0%9C%EC%A3%BC%EC%A0%90/place/35372977?c=14084149.0662165,3963694.8097262,15,0,0,0,dh" target="_blank">
						  	<img src="<%= ctxPath%>/images/store6.jpg" class="card-img-top">
						  </a>
						  <div class="card-body">
						    <h5 class="card-title">JEJU STORE</h5>
   						    <p>제주시 일도1동 1379번지 레이앤솔트<br>
							TEL. 070-4548-4361<br>
							Mon~Sun. 10:00-am~22:00pm</p>
						  </div>
						</div>
					</div>
				</div>
		</div>
	</section>
	<%-- 오프라인 매장들을 넣어둔 카드들이 있습니다. 지도사진을 클릭하며 네이버지도로 이동합니다. --%>
  
<jsp:include page="/WEB-INF/footer.jsp" />
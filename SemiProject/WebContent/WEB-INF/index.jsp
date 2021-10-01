<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/header_success.jsp" />

<%-- 메인페이지 입니다. --%>

	
		<%-- 상단 이미지 시작 --%>
			<div class="hero-wrap" style="background-image: url('<%= ctxPath%>/images/main.jpg');" data-stellar-background-ratio="0.5">
				<div class="overlay"></div>
				<div class="container">
					<div class="row no-gutters slider-text align-items-center justify-content-center">
						<div class="col-md-8 ftco-animate d-flex align-items-end">
							<div class="text w-100 text-center">
								<h1 class="mb-4"><span>THIS MAN</span></h1><P>
								<h1>NEW COLLECTION</h1>
								
								<br>
								<br>
								<a href="#" class="btn btn-primary mx-3 py-2 px-4" style="opacity: 0.8;">VIEW MORE</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		<%-- 상단 이미지 끝 --%>
		<div class="index">
		
			<div class="mx-5"> <%-- x축 margin용 div입니다. --%>
			
				<%-- 이벤트 배너  2개 --%>
				<div class="row justify-content-center my-5" style="border:solid 0px gray;">
					<div class="col-sm-6">
						<div class="card border-light">
						  <img src="<%= ctxPath%>/images/event1.jpg" class="card-img-top" alt="...">
						  <div class="card-body">
						    <h4>EVENT1<br>
						    	EVENT1 SUB1
						    </h4>
						    <p>EVENT1
						  </div>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="card border-light">
						  <img src="<%= ctxPath%>/images/event2.jpg" class="card-img-top" alt="...">
						  <div class="card-body">
						    <h4>EVENT2<br>
						    	EVENT SUB2
						    </h4>
						    <p>EVENT2</p>
						  </div>
						</div>
					</div>
				</div>
				<%-- 이벤트 배너 2개  --%>
			
			
				<%-- 추천 신발 4개 이미지 --%>
				<h2>RECOMMENDATION</h2>
					<div class="row justify-content-center my-5">
						<div class="card-deck">
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product1.jpg" class="card-img-top" alt="...">
								  <div class="card-body">
								  	<p>Product1</p>
								    <h4>Product1<br>
								    </h4>
								  </div>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product2.jpg" class="card-img-top" alt="...">
								  <div class="card-body">
								  	<p>Product2</p>
								    <h4>Product2</h4>
								  </div>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product3.jpg" class="card-img-top" alt="...">
								  <div class="card-body">
								  	<p>Product3</p>
								    <h4>Product3<br>
								    </h4>
								  </div>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product4.jpg" class="card-img-top" alt="...">
								  <div class="card-body">
								  	<p>Product4</p>
								    <h4>Product4<br>
								    </h4>
								  </div>
								</div>
							</div>
						</div>
					</div>
					
				<%-- 추천 신발 4개 이미지 --%>
				
							
				<%-- NEW 신발 4개 이미지 --%>
				<h2>NEW</h2>
					<div class="row justify-content-center my-5">
						<div class="card-deck">
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product5.jpg" class="card-img-top">
								  <div class="card-body">
								  	<p>Product5</p>
								    <h4>Product5<br>
								    </h4>
								  </div>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product6.jpg" class="card-img-top">
								  <div class="card-body">
								  	<p>Product6</p>
								    <h4>Product6</h4>
								  </div>
								</div>
							</div>
						
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product7.jpg" class="card-img-top">
								  <div class="card-body">
								  	<p>Product7</p>
								    <h4>Product7<br>
								    </h4>
								  </div>
								</div>
							</div>
							
							<div class="col-md-3">
								<div class="card border-light">
								  <img src="<%= ctxPath%>/images/product8.jpg" class="card-img-top">
								  <div class="card-body">
								  	<p>Product8</p>
								    <h4>Product8<br>
								    </h4>
								  </div>
								</div>
							</div>
						
						</div>
					</div>
				<%-- NEW 신발 4개 이미지 --%>
			</div> <%-- x축 margin용 div입니다. --%>
		</div>
			
    	<%-- 하단 이미지 시작 --%>
		<div class="hero-wrap" style="background-image: url('<%= ctxPath%>/images/backimage1.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-center justify-content-center">
					<div class="col-md-8 ftco-animate d-flex align-items-end">
						<div class="text w-100 text-center">
							<h1 class="mb-4"><span>FOOTER IMAGE</span></h1><P>
							<h1>FOOTER IMAGE</h1>
							<br>
							<br>
							<a href="#" class="btn btn-primary mx-3 py-2 px-4" style="opacity: 0.8;">VIEW MORE</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- 하단 이미지 끝 --%>
		
		
<jsp:include page="/WEB-INF/footer.jsp" />


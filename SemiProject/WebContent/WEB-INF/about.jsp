<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>    
    

<jsp:include page="/WEB-INF/header_success.jsp" />
	

	<%-- 상단 이미지 --%>
	<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/main.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-end justify-content-center">
				<div class="col-md-9 ftco-animate mb-5 text-center">
					<h2 class="mb-0 bread">About us</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	<%-- 회사소개 --%>
    <section class="ftco-section ftco-no-pb">
		<div class="container">
			<div class="row">
				<div class="col-md-6 img img-3 d-flex justify-content-center align-items-center" style="background-image: url(<%= ctxPath%>/images/about.jpg);">
				</div>
				<div class="col-md-6 wrap-about pl-md-5 ftco-animate py-5">
					<div class="heading-section">
						<span class="subheading" style="color:black;">Since 2021</span>
						<h2 class="mb-4">THISMAN</h2>
						
						<p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
						<p>On her way she met a copy. The copy warned the Little Blind Text, that where it came from it would have been rewritten a thousand times and everything that was left from its origin would be the word "and" and the Little Blind Text should turn around and return to its own, safe country.</p>
					</div>
				
				</div>
			</div>
		</div>
	</section>
	<%-- 회사소개 --%>
	
	<%-- 판매하는 제품군 이미지 --%>	
	<section class="ftco-section">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Derby.jpg);"></div>
						<h3>Derby</h3>
					</div>
				</div>
				
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Mule.jpg);"></div>
						<h3>Mule</h3>
					</div>
				</div>
				
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Boots.jpg);"></div>
						<h3>Boots</h3>
					</div>
				</div>
				
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Loafer.jpg);"></div>
						<h3>Loafer</h3>
					</div>
				</div>
				
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Oxford.jpg);"></div>
						<h3>Oxford</h3>
					</div>
				</div>
				
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(<%= ctxPath%>/images/Monk.jpg);"></div>
						<h3>Monk</h3>
					</div>
				</div>
				
			</div>
		</div>
	</section>
	<%-- 판매하는 제품군 이미지 --%>	

  

		
<jsp:include page="/WEB-INF/footer.jsp" />
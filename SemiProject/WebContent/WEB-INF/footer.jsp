<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% String ctxPath = request.getContextPath(); %>    

    <footer class="ftco-footer">
      <div class="container">
      
      	<%-- FOOTER 행 --%>
        <div class="row mb-5">
         <%-- 사업자 정보 --%>
          <div class="col-sm-12 col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Company</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span>CEO : Seo yeonghak</span></li>
	                <li><span>Address : 서울특별시 마포구 서교동 447-5 2,3,4층</span></li>
	                <li><span>Phone : 010-1234-4567</span></li>
	                <li><span>email : Thisman@naver.com</span></li>
	              </ul>
	            </div>
            </div>
          </div>
          <%-- 사업자 정보 --%>
        </div>
        <%-- FOOTER 행 --%>
        
      </div>
      
      <%-- 카피라이터 --%>
      <div class="container-fluid px-0 py-5 bg-black">
      	<p class="text-center">&copy;&nbsp;THISMAN</p>
      </div>
     <%-- 카피라이터 --%>
     
     <%-- 카카오톡 링크 --%>
     <div id="kakaodiv" class="py-2">
     	<span><img id="kakaoimg"  src="<%= ctxPath%>/images/kakao.png" /></span><span class="ml-2">카카오톡</span>
     </div>
     <div id="toTop" style="border-radius:80%; background-color:white;"><a href="#"><h4>↑</h4></a></div>
    </footer>
     <%-- 카카오톡 링크 --%>
     
     
     
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


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
    
  </body>
</html>
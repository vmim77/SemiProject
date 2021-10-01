<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% String ctxPath = request.getContextPath(); %>    

    <footer class="ftco-footer">
      <div class="container">
      
      	<%-- FOOTER 행 --%>
        <div class="row mb-5">
        <%-- 우리회사 소개 적기 --%>
          <div class="col-sm-12 col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Information</h2>
              <ul class="list-unstyled">
                <li><a href="<%= ctxPath%>/about.sh"><span class="fa fa-chevron-right mr-2"></span>About us</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Catalog</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Contact us</a></li>
              </ul>
            </div>
          </div>
        <%-- 우리회사 소개 적기 --%>
        
         <%-- 사업자 정보 --%>
          <div class="col-sm-12 col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Company</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon fa fa-map marker"></span><span class="text">서울특별시 마포구 서교동 447-5 풍성빌딩 2,3,4층</span></li>
	                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">강사님 전화번호</span></a></li>
	                <li><a href="#"><span class="icon fa fa-paper-plane pr-4"></span><span class="text">강사님 이메일</span></a></li>
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
      	<div class="container">
      		<div class="row">
	          <div class="col-md-12">
		
	            <p class="mb-0" style="color: rgba(255,255,255,.5);"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
	  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib.com</a>
	  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
	          </div>
	        </div>
      	</div>
      </div>
     <%-- 카피라이터 --%>
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="/Subject/js/jquery.min.js"></script>
  <script src="/Subject/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/Subject/js/popper.min.js"></script>
  <script src="/Subject/js/bootstrap.min.js"></script>
  <script src="/Subject/js/jquery.easing.1.3.js"></script>
  <script src="/Subject/js/jquery.waypoints.min.js"></script>
  <script src="/Subject/js/jquery.stellar.min.js"></script>
  <script src="/Subject/js/owl.carousel.min.js"></script>
  <script src="/Subject/js/jquery.magnific-popup.min.js"></script>
  <script src="/Subject/js/jquery.animateNumber.min.js"></script>
  <script src="/Subject/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/Subject/js/google-map.js"></script>
  <script src="/Subject/js/main.js"></script>
    
  </body>
</html>
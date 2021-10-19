<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%>    

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">    
    
    
<style type="text/css">
	
	

</style>

<script src="../js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
	});//end of $(docunment).ready(function(){
		

	
</script>
<!-- 
모달 내부에 내용물이 많으면 웹페이지에 스크롤바를 추가하지 않고 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다.
		<br>		
		Button trigger modal
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal_scrolling_2">
		  Open Scrolling Modal-2
		</button>
		
		Modal
		Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다.
		<div class="modal fade" id="exampleModal_scrolling_2">
		  <div class="modal-dialog modal-dialog-scrollable">
		  .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다.
		    <div class="modal-content">
		      
		      Modal header
		      <div class="modal-header">
		        <h5 class="modal-title">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      Modal body
		      <div class="modal-body">
		        <h3>Some text to enable scrolling..</h3>
                <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>

                <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		      </div>
		      
		      Modal footer
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<br><br>
 -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel" style="text-align: right;">쿠폰내역</h4>
      </div>
      
      <div class="modal-body">
        	<table border="1">
        	 <tr>
				<th scope="col" class="" style="height: 50px; width: 350px">쿠폰발급일자</th>
                <th scope="col" class="" style="height: 50px; width: 350px">쿠폰명</th>
                <th scope="col" class="" style="height: 50px; width: 150px">할인율</th>
                <th scope="col" class="" style="height: 50px; width: 500px; text-align: center;" >유효기간</th>
                <th scope="col" class="" style="height: 50px; width: 250px">상태</th>
            </tr>
            
            <tr>
            	<td>${requestScope.mvo.coupondate}</td>
            	<td>${mvo.couponname}</td>
            	<td>${mvo.coupondiscount}</td>
            	<td style="text-align: center;">${mvo.couponlastday}</td>
            	<td>사용가능</td>
            </tr>
       
            
        	</table>
      </div>
     		<div class="modal-footer">
       		 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	  </div>
	</div>












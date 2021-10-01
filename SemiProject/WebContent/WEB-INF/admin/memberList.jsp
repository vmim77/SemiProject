<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<% String ctxPath=request.getContextPath(); %>


<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

	table, tr, th, td {
		border: solid 1px gray;
	}
	
	tr, th, td {
		width: 100px;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(document).on("click", "tr.memberInfo", function(){
			
			// alert("행 클릭함");
			
			var userid = $(this).find("td:nth-child(2)").text();
			
			
			// alert("userid 확인용 => " + userid);
			
			$.ajax({
				url:"<%=ctxPath%>/admin/memberDetail.sh",
				type:"post",
				data:{"userid":userid},
				dataType:"json",
				success:function(json) {
					
					// alert(json.name);
					
					var html = "<ol>"+
	           		"<li>아이디 : "+json.userid+"</li>" +
	           		"<li>회원명 : "+json.name+"</li>" +
	           		"<li>이메일 : "+json.email+"</li>" +
	           		"<li>휴대폰 : "+json.mobile.substring(0, 3)+"-"+json.mobile.substring(3, 7)+"-"+json.mobile.substring(7)+"</li>" +
	           		"<li>우편번호 : "+json.postcode+"</li>" +
	           		"<li>주소 : "+json.address+" "+json.detailaddress+"</li>" +
	           		"<li>성별 : "+ json.gender +"</li>" +
	           		"<li>생년월일 : "+ json.birthday +"</li>" +
	           		"<li>나이 : "+ json.age +"</li>" +
	           		"<li>포인트 : "+ json.point +"</li>" +
	           		"<li>추천인 : "+ json.referral +"</li>" +
	           		"<li>가입일자 : "+ json.registerday +"</li>" +
	              	"</ol>";
	              	
	              	$("div.modal-body").html(html);
	              	$("#exampleModalLabel").html("<span>"+userid+"님의 회원 상세정보</span>");
					
				},
				error: function(request, status, error) {
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});
			
			$("button#modalBtn").click();
			
		});// end of $(document).on("click", "tr.memberInfo", function(){})----------------------
		
		
	});// end of $(document).ready(function(){})--------------------------------------------------
	
	
	// Function Declaration
	function sendToMsg() { // 상세보기를 한 회원에게 메세지를 전송하는 기능입니다. (추후에 강사님한테 배우면 추가하겠습니다.)
		
		alert("구현예정!");
		
	}// end of function sendToMsg()---------------------------
	
	
	// Function Declaration 
	function goSearch() {
		
		var frm = $(document).memberFrm;
		
		frm.action = "<%= ctxPath%>/admin/memberSearch.sh";
		frm.method = "get";
		frm.submit();
		
		window.reload(true);
		
	}


</script>


	<%-- 상단 이미지 --%>
	<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/about.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
			<div class="container">
				<div class="row no-gutters slider-text align-items-end justify-content-center">
				<div class="col-md-9 ftco-animate mb-5 text-center">
					<h2 class="mb-2 bread">관리자메뉴<br><br>전체회원 조회하기</h2>
					<br><br>
				</div>
			</div>
		</div>
	</section>
	<%-- 상단 이미지 --%>
	
	 <form name="memberFrm">
		<select id="searchType" name="searchType">
         <option value="name">성명</option>
         <option value="userid">아이디</option>
      </select>
      <input type="text" id="searchWord" name="searchWord" />
      
      <button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>
      </form>
		
<div class="container">
	<table class="table table-dark my-5 text-center justify-content-center" >
		<thead>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>성명</th>
				<th>성별</th>
				<th>가입일자</th>
				<th>회원상태</th>
				<th>휴면상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="mbr" items="${requestScope.mbrList}" varStatus="status">
				<tr class="memberInfo">
					<td>${status.index}</td>
					<td>${mbr.userid}</td>
					<td>${mbr.name}</td>
					
					<c:if test="${mbr.gender == 1}">
						<td>남자</td>
					</c:if>
					<c:if test="${mbr.gender == 2}">
						<td>여자</td>
					</c:if>
					
					<td>${fn:substring(mbr.registerday, 0, 10)}</td> <%-- 시간은 짜르고 날짜만 가져옵니다. --%>
					
					<c:if test="${mbr.status == 1}">
						<td>사용가능</td>
					</c:if>
					<c:if test="${mbr.status == 0}">
						<td>탈퇴</td>
					</c:if>
					
					<c:if test="${mbr.idle == 0}">
						<td>활동</td>
					</c:if>
					<c:if test="${mbr.idle == 1}">
						<td>휴면</td>
					</c:if>
				<tr>
			</c:forEach>			
		</tbody>
	</table>
	
	<p class="text-center my-5">
		<button type="button" class="btn btn-dark mx-5">회원정보 수정하기<br>(update)</button><%-- 운영자가 정보 수정해주기? --%>
		<button type="button" class="btn btn-dark">회원정보 삭제하기[미정]<br>(update or delete)</button><%-- 휴면처리가 오래된 회원은 운영자가 정책에 따라 탈퇴로 바꾸게 하는 것?> --%>
	</p>
	
	<!-- Button trigger modal -->
	<button type="button" id="modalBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" style="display: none;">
		회원상세정보
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title " id="exampleModalLabel"></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" onclick="javascript:sendToMsg()">문자발송하기</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">나가기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>

<jsp:include page="/WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<% String ctxPath=request.getContextPath(); %>


<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

	tr, th, td {
		width: 100px;
	}
	
	.effect {
		background-color: white;
		color: black;
		font-weight: bold;
		cursor: pointer;
	}
	
	a.page-link {
		color: #fff;
		background-color: #343a40;
	}
	
	.page-item.active .page-link {
		color: black;
		background-color: #fff;
		border-color: black;
	}
	
	.page-link:hover {
		color: black;
	}
	
	ol#oneMemberInfo{
		list-style-type: none;
	}
	
	span.title {
		font-weight: bold;
		font-size: 12pt;
		color: blue;
	}
	li.list-group-item{ background-color: #343a40; color: #fff; }
	

</style>

<script type="text/javascript">

	var userid = ""; // 특정 회원을 클릭하면 유저아이디를 받아놓기위한 전역변수
	
	
	$(document).ready(function(){
		
		
		if("${requestScope.searchWord}" != "" ){ // 무언가 검색하고 다른 페이지로 갔다면 계속해서 검색했던 것을 보여주기 위해서 값을 찍어줍니다.
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		
		if("${requestScope.sizePerPage}" != "") { // sizePerPage를 받아왔다는 것은 인원수 선택하고 다음페이지로 갔다는 것이여서 값을 찍어줍니다.
			// sizePerPage가 뭔가 받아온 경우
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		// 1. 특정회원의 상세정보를 조회하기 위해서 행을 클릭하면 이벤트가 발생한다.
		$(document).on("click", "tr.memberInfo", function(){ 
			
			userid = $(this).find("td:nth-child(1)").text(); // 2. 해당 행의 첫번째에 있는 td에서 조회를 위해서 userid를 가져온다.
			
			$.ajax({ 
				url:"<%=ctxPath%>/admin/memberDetail.sh",
				type:"post",
				data:{"userid":userid}, // 3. Action에 추출한 userid를 전송해서 조회기능을 하도록 한다.
				dataType:"json",
				success:function(json) { // 4. 성공적으로 SQL로 조회를 했다면 모달에 출력한다.
					
					var html = "<ol id='oneMemberInfo' class='list-group'>"+
		           		"<li class='list-group-item'><span class='title'>아이디</span> : "+json.userid+"</li>" +
		           		"<li class='list-group-item'><span class='title'>회원명</span> : "+json.name+"</li>" +
		           		"<li class='list-group-item'><span class='title'>이메일</span> : "+json.email+"</li>" +
		           		"<li class='list-group-item'><span class='title'>휴대폰</span> : "+json.mobile.substring(0, 3)+"-"+json.mobile.substring(3, 7)+"-"+json.mobile.substring(7)+"</li>" +
		           		"<li class='list-group-item'><span class='title'>우편번호</span> : "+json.postcode+"</li>" +
		           		"<li class='list-group-item'><span class='title'>주소</span> : "+json.address+" "+json.detailaddress+"</li>" +
		           		"<li class='list-group-item'><span class='title'>성별</span> : "+ json.gender +"</li>" +
		           		"<li class='list-group-item'><span class='title'>생년월일</span> : "+ json.birthday +"</li>" +
		           		"<li class='list-group-item'><span class='title'>나이</span> : "+ json.age +" 세</li>" +
		           		"<li class='list-group-item'><span class='title'>포인트</span> : "+ json.point.toLocaleString('en') +" 원</li>" +
		           		"<li class='list-group-item'><span class='title'>추천인</span> : "+ json.referral +"</li>" +
		           		"<li class='list-group-item'><span class='title'>가입일자</span> : "+ json.registerday +"</li>" +
	              	"</ol>";
	              	
	              	$("div.modal-body").html(html); // 5. 모달창에 html 변수를 넣어준다.
	              	$("#exampleModalLabel").html("<span style='font-weight:bold; font-size:16pt;'>"+userid+"님의 회원 상세정보</span>"); // 모달 상단에 제목이다.
					
				},
				error: function(request, status, error) {
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
			$("button#modalBtn").click();
			// 공용으로 쓰는 모달에 값을 넣었으니, 출력하기 위해 모달을 클릭한다.
			
		});// end of $(document).on("click", "tr.memberInfo", function(){})----------------------
		
		// 행에 hover가 되면 나오는 CSS 효과이다.
		$(document).on("mouseover", "tr.memberInfo", function(){ 
			$("tr.memberInfo").removeClass("effect");
			$(this).addClass("effect");
		});// end of $(document).on("mouseover", "tr.memberInfo", function(){})-------------------------------
		
		// 행에 mouseout이 되면 CSS효과를 제거한다.
		$(document).on("mouseout", "tr.memberInfo", function(){ 
			$(this).removeClass("effect");
		});// end of $(document).on("mouseout", "tr.memberInfo", function(){})--------------------------------
		
		// 몇명씩 볼지만 선택해도 알아서 검색되도록한다.
		$("select#sizePerPage").change(function(){ 
			goSearch();
		})// end of $("select#sizePerPage").change(function(){})-----------------------------------		
		
	});// end of $(document).ready(function(){})--------------------------------------------------
	
	
	// Function Declaration
	// 상세정보 조회에서 회원의 정보를 수정하는 함수
	function goEdit() {
		
		 // 상세정보 조회용 모달창을 끈다.
		$("button#modalClose").click();
		
		 // GET 방식으로 해당 유저의 아이디를 팝업창으로 넘긴다.
	    var url = "<%= ctxPath%>/admin/memberEdit.sh?userid="+userid; 
	    
	    var pop_width = 600; 
	    var pop_height = 300;
	    
	    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
	    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
			
	    window.open(url,   "memberEdit",
          				   "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
		
	}// end of function goEdit()---------------------------
	
	
	// Function Declaration 
	// 특정 회원들을 검색하는 함수
	function goSearch() { // 검색창에 검색타입과 검색어를 입력하면 해당 회원들을 조회해서 찾아줍니다.
		
		var frm = document.memberFrm;
		
		frm.action = "<%= ctxPath%>/admin/memberList.sh";
		frm.method = "get";
		frm.submit();
		
		window.reload(true);
		
	}// end of function goSearch()---------------------------


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
		
		
		<div class="container">
			<%-- 검색을 위한 정보를 보냅니다. --%>
			<form name="memberFrm" class="text-center my-5"> 
				<select id="searchType" name="searchType">
					<option value="name">성명</option>
					<option value="userid">아이디</option>
				</select>
				<input type="text" id="searchWord" name="searchWord" />
				<input type="text" style="display: none;" />
				   
				<button type="button" class="btn btn-dark" onclick="goSearch();" style="margin-right: 30px;">검색</button>
				
				<span style="font-weight: bold; font-size: 14pt;">페이지당 회원명수-</span>
				<select id="sizePerPage" name="sizePerPage">
				   <option value="0" selected>인원수 선택</option>
				   <option value="3">3</option>
				   <option value="5">5</option>
				   <option value="10">10</option>
				</select>
			</form>
			<%-- 검색을 위한 정보를 보냅니다. --%>
			<%-- 검색어를 넣지 않고 검색하면 전체회원 조회 // 검색어를 넣고 검색하면 특정회원들 조회 --%>
			
			<%-- Action에서 조회해온 전체 회원을 출력해준다. --%>
			<table class="table table-dark p-1 my-3 text-center justify-content-center">
			
				<thead>
					<tr>
						<th>아이디</th>
						<th>성명</th>
						<th>성별</th>
						<th>가입일자</th>
 						<th>회원상태</th>
						<th>휴면상태</th> 
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${not empty requestScope.mbrList}">
						<c:forEach var="mbr" items="${requestScope.mbrList}" varStatus="status">
							<tr class="memberInfo">
								<td>${mbr.userid}</td>
								<td>${mbr.name}</td>
								<td>${mbr.gender}</td>
								
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
					</c:if>
					<c:if test="${empty requestScope.mbrList}">
						<tr>
							<td colspan="6" style="font-weight: bold; color: red;">조회된 회원이 없습니다!</td>
						</tr>
					</c:if>
				</tbody>
				
			</table>
			<%-- Action에서 조회해온 전체 회원을 출력해준다. --%>
		
		
		 <%-- Pagination 버튼 --%>		
	     <nav class="my-5 text-center">
	     	<div style="display: flex; width: 100%;">
	     		<%-- 여기에 페이징처리 while 반복문으로 차곡차곡 쌓아온 <li>들이 들어온다. --%>
				<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
	    	</div>
	     </nav>	
		 <%-- Pagination 버튼 --%>
			
		<%-- 회원상세정보용 모달 --%>
		<button type="button" id="modalBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" style="display: none;">
			회원상세정보 출력하기
		</button>
		
		<!-- 회원의 상세정보를 띄워주는 Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" style="width: 100%;">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title " id="exampleModalLabel"></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body"></div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" onclick="javascript:goEdit()">회원정보 수정하기</button> <%-- 운영자가 상세정보보기를 한 회원의 정보를 수정하는 함수를 호출한다. --%>
		        <button type="button" id="modalClose" class="btn btn-danger" data-dismiss="modal">나가기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<%-- 회원상세정보용 모달 --%>
		
	</div>

<jsp:include page="/WEB-INF/footer.jsp" />
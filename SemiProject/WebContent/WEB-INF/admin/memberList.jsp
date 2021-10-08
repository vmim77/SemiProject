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
		font-size: 11pt;
		color: blue;
	}

</style>

<script type="text/javascript">

	var userid = ""; // 특정 회원을 클릭하면 유저아이디를 받아놓기위한 전역변수
	
	
	$(document).ready(function(){
		
		
		if("${requestScope.searchWord}" != "" ){
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		
		if("${requestScope.sizePerPage}" != "") {
			// sizePerPage가 뭔가 받아온 경우
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		$(document).on("click", "tr.memberInfo", function(){ // 특정 회원의 행을 클릭하면 모달창으로 그 회원의 자세한 정보를 출력해줍니다. 비동기식처리로 정보를 가져옴
			
			// alert("행 클릭함");
			
			userid = $(this).find("td:nth-child(2)").text(); // 전체목록에서 특정 행을 클릭했다면 그 행의 유저아이디를 받아놓는다.
			
			
			// alert("userid 확인용 => " + userid);
			
			$.ajax({
				url:"<%=ctxPath%>/admin/memberDetail.sh",
				type:"post",
				data:{"userid":userid}, // JSON에 전송을해서 select where에서 조건절로 userid를 사용하도록 보내준다.
				dataType:"json",
				success:function(json) {
					
					// alert(json.name);
					
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
	              	
	              	$("div.modal-body").html(html);
	              	$("#exampleModalLabel").html("<span style='font-weight:bold; font-size:16pt;'>"+userid+"님의 회원 상세정보</span>");
	              	
	              	
					
				},
				error: function(request, status, error) {
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});
			
			$("button#modalBtn").click();
			
		});// end of $(document).on("click", "tr.memberInfo", function(){})----------------------
		
		
		
		$(document).on("mouseover", "tr.memberInfo", function(){ // 행에 hover가 되면 나오는 CSS 효과
			$("tr.memberInfo").removeClass("effect");
			$(this).addClass("effect");
		});// end of $(document).on("mouseover", "tr.memberInfo", function(){})-------------------------------
		
		$(document).on("mouseout", "tr.memberInfo", function(){ // 행에 mouseout이 되면 사라지는 CSS 효과
			$(this).removeClass("effect");
		});// end of $(document).on("mouseout", "tr.memberInfo", function(){})--------------------------------
		
		
		$("select#sizePerPage").change(function(){ // 몇명씩 볼지만 선택해도 알아서 검색되도록한다.
			goSearch();
		})// end of $("select#sizePerPage").change(function(){})-----------------------------------		
		
		
	});// end of $(document).ready(function(){})--------------------------------------------------
	
	
	// Function Declaration
	function goEdit() { // 상세정보 조회를 한 회원의 정보를 수정합니다.
		
		$("button#modalClose").click(); // 상세정보 조회용 모달창을 끕니다.
	
	    var url = "<%= ctxPath%>/admin/memberEdit.sh?userid="+userid; 
	    // GET 방식으로 해당 유저의 아이디를 넘깁니다.
	    
	    var pop_width = 600;
	    var pop_height = 300;
	    
	    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
	    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
	    
			
	    window.open(url,   "memberEdit",
          				   "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
		
	}// end of function goEdit()---------------------------
	
	
	// Function Declaration 
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
	
	<div class="container table-responsive">
	
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
	
		

	
			<table class="table table table-dark my-5 text-center justify-content-center" style="width: 100%;">
				<thead>
					<tr>
						<th scope="col">INDEX</th>
						<th scope="col">아이디</th>
						<th scope="col">성명</th>
						<th scope="col">성별</th>
						<th scope="col">가입일자</th>
						<th scope="col">회원상태</th>
						<th scope="col">휴면상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="mbr" items="${requestScope.mbrList}" varStatus="status">
						<tr class="memberInfo">
							<td scope="row">${status.count}</td>
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
				</tbody>
			</table>
			
     <nav class="my-5 text-center">
     	<div style="display: flex; width: 100%;">
     		<%-- 여기에 페이징처리 while 반복문으로 차곡차곡 쌓아온 <li>들이 들어온다. --%>
			<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
    	</div>
     </nav>	
			
		
		<!-- Button trigger modal -->
		<button type="button" id="modalBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" style="display: none;">
			회원상세정보
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
		        <button type="button" class="btn btn-primary" onclick="javascript:goEdit()">회원정보 수정하기</button> <%-- 운영자가 상세정보보기를 한 회원의 정보를 수정하게 합니다. --%>
		        <button type="button" id="modalClose" class="btn btn-danger" data-dismiss="modal">나가기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 회원의 상세정보를 띄워주는 Modal -->
		
	</div>

<jsp:include page="/WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<% String ctxPath=request.getContextPath(); %>


<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

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
	
	
	

</style>

<script type="text/javascript">

	var userid = ""; // 특정 회원을 클릭하면 유저아이디를 받아놓기위한 전역변수
	
	
	$(document).ready(function(){

		// 행에 hover가 되면 나오는 CSS 효과이다.
		$(document).on("mouseover", "tr.orderInfo", function(){ 
			$("tr.memberInfo").removeClass("effect");
			$(this).addClass("effect");
		});// end of $(document).on("mouseover", "tr.memberInfo", function(){})-------------------------------
		
		// 행에 mouseout이 되면 CSS효과를 제거한다.
		$(document).on("mouseout", "tr.orderInfo", function(){ 
			$(this).removeClass("effect");
		});// end of $(document).on("mouseout", "tr.memberInfo", function(){})--------------------------------
		
		$(".orderInfo").click(function(){
			
			var odrcode = $(this).find("td:first-child").text();
			var userid = $(this).find("td:nth-child(4)").text();
			var pnum = $(this).find("span.pnum").text();
			var status = $(this).find("td:nth-child(7)").text().trim(); // 배송완료, 교환, 환불인 경우에는 더 이상 처리가 불가능하게 한다.
			
			
			if(status == '배송준비중' || status == '배송시작'){
				
				
				
			    var url = "<%= ctxPath%>/admin/orderChange.sh";
			    
			    var pop_width = 600; 
			    var pop_height = 400;
			    
			    var pop_left = Math.ceil((window.screen.width - pop_width)/2);
			    var pop_top = Math.ceil((window.screen.height - pop_height)/2); 
					
			    window.open(url,   "orderStatusEdit",
       				   "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
				
				var frm = document.changeStatusFrm;
				$("input[name=odrcode]").val(odrcode);
				$("input[name=userid]").val(userid);
				$("input[name=pnum]").val(pnum);
				$("input[name=status]").val(status);
				
				frm.target="orderStatusEdit"
				frm.action="<%= ctxPath%>/admin/orderChange.sh";
				frm.method="POST";
				frm.submit();
			}
			else{
				alert("해당 주문건은 배송상태가 <"+status+"> 이여서 처리가 더 이상 불가능합니다!");
				return;
			}
		});// end of $(".orderInfo").click(function(){})---------------------------------------------
		
		
		
	});// end of $(document).ready(function(){})--------------------------------------------------
	
	
	



</script>

		<%-- 상단 이미지 --%>
		<section class="hero-wrap hero-wrap-2" style="background-image: url('<%= ctxPath%>/images/about.jpg');" data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
				<div class="container">
					<div class="row no-gutters slider-text align-items-end justify-content-center">
					<div class="col-md-9 ftco-animate mb-5 text-center">
						<h2 class="mb-2 bread">관리자메뉴<br><br>주문내역 관리</h2>
						<br><br>
					</div>
				</div>
			</div>
		</section>
		<%-- 상단 이미지 --%>
		
		<div class="container">

			<%-- Action에서 조회해온 전체 회원을 출력해준다. --%>
			<table class="table table-dark p-1 my-3 justify-content-center">
			
				<thead>
					<tr>
						<th>주문번호</th>
						<th>제품사진</th>
						<th>제품정보</th>
						<th>구매자   </th>
						<th>적립금   </th>
 						<th>구매일자</th>
						<th>배송상태</th> 
					</tr>
				</thead>
				
				<tbody>
					<%-- 주문내역이 있다면 다음과 같이 표기한다. --%>
					<c:if test="${not empty requestScope.orderList}">
						<c:forEach var="map" items="${requestScope.orderList}" varStatus="status">
							<tr class="orderInfo">
								<td>${map.jumun_bunho}</td>
								<td>
									<span style="display: flex; vertical-align: middle;"><img src="${map.fk_pimage3}" style="margin: auto; width: 100px; height: 100px;" /></span>
								</td>
								<td>
									<span style="text-align:left; font-size: 11pt;">
										제품번호: <span class="pnum">${map.pnum}</span><br>
										제품명: ${map.pname}<br>
										기본가: <fmt:formatNumber value="${map.buy_pro_price}" pattern="###,###" /><br>
										
										 
										옵션가: <fmt:formatNumber value="${map.buy_opt_price}" pattern="###,###" /><br>
										총가격: <fmt:formatNumber value="${map.saleprice}" pattern="###,###" /><br>
									</span>
								</td>
								<td>
									<c:if test="${empty map.fk_userid}">
										비회원
									</c:if>
									<c:if test="${not empty map.fk_userid}">
										${map.fk_userid}
									</c:if>
								</td>
								<td>${map.buy_jeokrib_money}</td>
								<td>${map.buy_date}</td>
								<td class="status">
									<c:if test="${map.baesong_sangtae eq 0}"><span style="font-weight: bold; ">배송준비중</span></c:if>
									<c:if test="${map.baesong_sangtae eq 1}"><span style="font-weight: bold; color: green;">배송시작</span></c:if>
									<c:if test="${map.baesong_sangtae eq 2}"><span style="font-weight: bold; color: red;">배송완료</span></c:if>
									<c:if test="${map.baesong_sangtae eq 3}"><span style="font-weight: bold; color: blue;">교환</span></c:if>
									<c:if test="${map.baesong_sangtae eq 4}"><span style="font-weight: bold; color: red;">환불</span></c:if>
								</td>
							<tr>
						</c:forEach>			
					</c:if>
					
					<%-- 주문내역이 없다면 다음과 같이 표기한다. --%>
					<c:if test="${empty requestScope.orderList}">
						<tr>
							<td colspan="6" style="font-weight: bold; color: red;">주문내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
				</tbody>
				
			</table>
			
	</div>
	
	 <%-- === 페이지바 === --%>
     <nav class="my-5 text-center">
        <div style='display:flex; width:100%;'>
          <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
       </div>
    </nav>
    
    
    <form name="changeStatusFrm">
    	<input type="hidden" name="odrcode" />
    	<input type="hidden" name="userid"/>
    	<input type="hidden" name="pnum"/>
    	<input type="hidden" name="status"/>
    
    </form>

<jsp:include page="/WEB-INF/footer.jsp" />
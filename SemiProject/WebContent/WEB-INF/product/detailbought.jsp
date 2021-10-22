<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %> 
<%
   String ctxPath = request.getContextPath();
%>    

<%
	// *** 현재시각을 알아오기 ***
	Date now = new Date();
	
	SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdformat.format(now);
%>
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

	span, table, tr, td{
		/*  border:solid 1px red;   */
	}

</style>

<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
					
	$(document).ready(function(){
		document.onkeydown = noRefresh ;
	}); //end of $(document).ready(function(){-----------------------------------
		
	// 새로고침 방지
	function noRefresh(){
	    /* CTRL + N키 막음. */
	    if ((event.keyCode == 78) && (event.ctrlKey == true)) {
	        event.keyCode = 0;
	        return false;
	    }
	    /* F5 번키 막음. */
	    if(event.keyCode == 116) {
	        event.keyCode = 0;
	        return false;
	    }
	}//end of function noRefresh(){------------------------------------------------

	
		
</script>

<div id="container" style="width:1000px; height:1100px; margin-left:300px; font-family:맑은 고딕;">
	<table style="width:1000px; margin-top:50px;">
		<tr>
			<td colspan="8" style="text-align:center; height:80px; font-weight:bold; font-size:12pt; color:black;">ORDER</td>
		</tr>
		<tr>
			<td colspan="2" style="height:40px; width:1000px; font-size:14pt; text-align:left;">
				결제 정보
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				최종결제금액
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				<fmt:formatNumber value="${requestScope.cartfinopt + cartprice - jibulpoint - coupon}" pattern="###,###" />원
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2; border-bottom:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				결제수단
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				카드결제
			</td>
		</tr>
	</table>
	<!-- 주문정보 -->
	<table style="width:1000px; margin-top:50px;">
		<tr>
			<td colspan="2" style="height:40px; width:1200px; font-size:14pt; text-align:left;">
				주문번호
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				주문일자
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				<%= today%>
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				주문자
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				${requestScope.name}
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2; border-bottom:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				주문처리상태
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				배송준비중
			</td>
		</tr>
	</table>	
 
	<table style="width:1000px; margin-top:30px;">
		<tr>
			<td colspan="7" style="height:40px; width:1000px; font-size:14pt; text-align:left;">
				주문 상품 정보
			</td>
		</tr>	
		<tr style="background-color:#f5f5ef; border-bottom:solid 1px #d0d0e2; border-top:solid 1px #d0d0e2;">						
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				상품이미지
			</td>
			<td style="width:400px; height:50px; font-size:9pt; color:black; text-align:center;">
				상품정보
			</td >
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				수량
			</td>
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				가격
			</td>
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				옵션 가격
			</td>
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				적립금
			</td>
			<td style="width:100px; height:50px; font-size:9pt; color:black; text-align:center;">
				배송구분
			</td>
		</tr>
		<tr style="border-bottom:solid 1px #d0d0e2;">						
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				<img style="height:150px; width:100px;" id="chun" src="${requestScope.product_front_p1}"/>
			</td>
			<td style="width:400px; height:150px; font-size:9pt; color:black; text-align:left; padding-left:30px;">
				${requestScope.cartname}<br>
				${requestScope.cartopt123}<br>
				${requestScope.cartopt4}
			</td >
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				${requestScope.cartnum}
			</td>
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				<fmt:formatNumber value="${requestScope.cartprice}" pattern="###,###" />원
			</td>
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				<fmt:formatNumber value="${requestScope.cartfinopt}" pattern="###,###" />원
			</td>
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				<fmt:formatNumber value="${requestScope.jukrib}" pattern="###,###" />원
			</td>
			<td style="width:100px; height:150px; font-size:9pt; color:black; text-align:center;">
				[기본배송]<br>
				배송비 : 무료
			</td>
		</tr>
	</table>
	<!-- 주문정보 -->
	<table style="width:1000px; margin-top:50px;">
		<tr>
			<td colspan="2" style="height:40px; width:1200px; font-size:14pt; text-align:left;">
				배송지정보
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				받으시는분
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				${requestScope.name}
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				우편번호
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				${requestScope.postcode}
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				주소
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				${requestScope.address}${requestScope.detailAddress}
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2;">
			<td style="width:150px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				휴대전화
			</td>
			<td style="font-size:9pt; padding-left:10px;">
				${requestScope.hp1}-${requestScope.hp2}-${requestScope.hp3}
			</td>
		</tr>
		<tr style="border-top:solid 1px #d0d0e2; border-bottom:solid 1px #d0d0e2;">
			<td style="width:100px; height:40px; text-align:left; padding-left:20px; font-size:9pt; color:black; background-color:#f5f5ef;">
				배송메시지
			</td>
			<td style="font-size:9pt; padding-left:10px; border-bottom:solid 1px #d0d0e2;">
				${requestScope.text}
			</td>
		</tr>
	</table>
</div>

<jsp:include page="/WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>   
<jsp:include page="../header.jsp" />

<!-- Bootstrap CSS -->
		<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 


<style type="text/css">

   span, table, tr, td, div{
        border:solid 1px red;   
   }

</style>

    
<div id="contents">

            
<div class="titleArea">
    <h2>MY PAGE</h2>
</div>
<div class="container">
  <div class="row">
    <div class="col">
      <span><a href="">정보수정</a></span> &nbsp;&nbsp;
      <span><a href="">주문내역</a></span> &nbsp;&nbsp;
      <span><a href="">적립금 내역</a></span> &nbsp;&nbsp;
      <span><a href="">출석체크</a></span> &nbsp;&nbsp;
      <span><a href="">장바구니</a></span> &nbsp;&nbsp;
      <span><a href="">할인쿠폰</a></span> &nbsp;&nbsp;
      <span><a href="">내가쓴게시물</a></span> &nbsp;&nbsp;
      <span><a href="">배송주소록</a></span> &nbsp;&nbsp;
    </div>
  </div>
</div>

<table>
	<tr>
		<td colspan="4" style="text-align:left; height:80px; font-weight:bold; font-size:16pt; color:black;"></td>
	</tr>
	<tr>
			<td>
				송동준님의 회원등급은 화이트입니다.<br>
				0원 이상 구매시 0원을 추가할인없음 받으실 수 있습니다.<br>
				<button>회원정보수정</button>
			</td>
			<td>
				총 주문금액<br>
				0원
			</td>
			<td>
				적립금<br>
				0원
			</td>
			<td>
				쿠폰<br>
				0장
			</td>
	</tr>
</table>
</div>

<table>
	<tr>
		<td colspan="2" style="text-align:left; height:80px; font-weight:bold; font-size:16pt; color:black;">최근주문정보</td>
	</tr>
	<tr>
		<td>주문일자 [주문번호]</td>
		<td>이미지</td>
		<td>상품정보</td>
		<td>수량</td>
		<td>상품구매금액</td>
		<td>주문처리상태</td>
		<td>취소/교환/반품</td>
	</tr>
	<tr>
	  <td></td>
	</tr>
</table>




    
<%-- <jsp:include page="../footer.jsp" /> --%>
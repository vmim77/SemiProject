<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
 
%>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
<style>

	
   div#contents {
   	
   	margin-left: 150px;
   	margin-right:150px;
   	
  
   }
   
   button {
/*    		background-color: white; */
   		
   }
   
	.titleArea h2 {
    padding: 5% 25% 12px;
    color: #000;
    font-size: 30px;
    font-family: "arimo",mg;
    font-weight: 700;
    letter-spacing: .05em; 
}
</style>
<script>

	var flag = false;

	function gocancle() {
		
		if($("select#changetr").val() == "제품의 하실 것을 선택하시오." ){
			flag = false;			
		}
		else {
			flag = true;
		}
	}
	
	function change(){
		
		if(flag == false) {
			alert("옵션을 제대로 선택해주세요.");	
		}
		else {
			
			
			if($("select#changetr").val() == "교환"){
				alert("교환되었습니다.");
				$("input#can").val("교환");
				var frm = document.changetrade;
				frm.action = "<%= ctxPath%>/delivery/orderchange.sh";
				frm.method = "post";
				frm.submit();
			}
		}
	}
	
	function cancelPay() {

		if(flag == false) {
			alert("옵션을 제대로 선택해주세요.");	
		}
		else {
			
			if($("select#changetr").val() == "환불·취소"){
				alert("환불되었습니다.");
				$("input#can").val("환불·취소");
				var frm = document.changetrade;
				frm.action = "<%= ctxPath%>/delivery/orderchange.sh";
				frm.method = "post";
				frm.submit();
			}
		}
	}
	
	
	

	$(document).ready(function(){
		
		$("div#hide1").hide();
		$("div#hide2").hide();
		$("button#change").hide();
		
		$("select#changetr").click(function(){
	
			if($(this).val() == "제품의 하실 것을 선택하시오."){
				$("div#hide1").hide();
				$("div#hide2").hide();
				$("button#change").hide();
			}
			else if($(this).val() == "환불·취소"){
				$("div#hide1").show();
				$("div#hide2").hide();
				$("button#change").hide();
			}
			else if($(this).val() == "교환") {
				$("div#hide1").hide();
				$("div#hide2").show();
				$("button#change").show();
			}
			
			
		});//end of $("select#slt").click(function()
				
		$("select#sizeChange").change(function(){
			var size = $(this).val();
			
		//	alert(size);
			
			var origin = $("td#size").text();
			
		//	alert(origin);
			
			origin = origin.replace(origin.substring(0,3), size);
			
		//	alert(origin);
			
			$("td#size").html(origin);
			
			$("input[name=chan]").val(origin);
			
			
			
		});	
			
			
		
	});// end of $(document).ready(function()
	
	
	
	
</script>
<div id="contents">
<div class="titleArea" style="text-align: center; margin-top: 40px; margin-bottom: 40px;">
    <h2 style="font-wei">취소·반품·교환 제품</h2>
</div>
	
      <table>
                  <tr style="font-size:13pt; font-weight:bold; height:50px; text-align:left; padding-bottm:15px;">
    
    
                     <td colspan="7" style="padding-left:15px;">
                        상품정보
                     </td>
                  </tr>
                  <tr style="background-color:#f5f5ef; border-bottom:solid 1px #d0d0e2; border-top:solid 1px #d0d0e2;">                  
                     <td style="width:200px; height:30px; font-size:10pt; color:black; text-align:center;">
                        상품이미지
                     </td>
                     <td style="width:600px; font-size:10pt; color:black; text-align:center;">
                        상품정보
                     </td >
                     <td style="width:200px; font-size:10pt; color:black; text-align:center;">
                        수량
                     </td>
                     <td style="width:200px; font-size:10pt; color:black; text-align:center;">
                        총 가격
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        주문번호
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        주문상태
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        환불/교환
                     </td>
	<c:if test="${not empty requestScope.orderList && requestScope.checkidnull ne 'no'}">
                     <c:forEach var="orderList" items="${requestScope.orderList}">
                        <tr style="border-bottom:solid 1px gray;">                     
                           <td style="width:200px; height:150px; font-size:10pt; color:black; text-align:center;">
                              <img style="width:200px; height:150;" id="chun" src="${orderList.fk_pimage3}"/>
                           </td>
                           <td id="size" style="width:600px; font-size:10pt; color:black; text-align:left; padding-left:30px;">${orderList.buy_opt_info}</td >
                           <td style="width:200px; font-size:10pt; color:black; text-align:center;">
                              ${orderList.buy_qty}
                           </td>
                           <td style="width:200px; font-size:10pt; color:black; text-align:center;">
                              <fmt:formatNumber value="${orderList.buy_opt_price + orderList.buy_pro_price}" pattern="###,###" />원
                           </td>
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              ${orderList.jumun_bunho}
                           </td>
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              <c:choose>
                                 <c:when test="${orderList.baesong_sangtae eq 0}">배송준비</c:when>
                                 <c:when test="${orderList.baesong_sangtae eq 1}">배송중</c:when>
                                 <c:when test="${orderList.baesong_sangtae eq 2}">배송완료</c:when>
                                 <c:when test="${orderList.baesong_sangtae eq 3}">환불</c:when>
                                 <c:when test="${orderList.baesong_sangtae eq 4}">교환</c:when>
                                 <c:otherwise>환불</c:otherwise>
                              </c:choose>
                           </td>
                            <td style="width:100px; font-size:9pt; color:black; text-align:center;">
                             		<input type="hidden" value="${orderList.jumun_bunho}">
                           </td>
                           
                           </tr>
                           </c:forEach>
                           </c:if>
                           </tr>
                          
</table>

<div style="font-size:25px;">취소·반품·교환 여부 선택</div>

<table style=" border: 2px solid gray;background-color:white; width: 100%;  margin-top: 30px; margin-bottom: 70px;">

		<tr>
			<td>
				<select id="changetr" style="width:100%; height:30px; margin-right:5px; padding-right:5px; padding-bottom:5px; text-align:left;" onclick="gocancle();">
					<option disabled="disabled">제품의 하실 것을 선택하시오.</option>
					<option>환불·취소</option>
					<option>교환</option>	
				</select>
	     	</td>   
		</tr>	
	
</table>


<div id="hide1">
	<h1 style="font-size:25px;">환불 제품</h1>
	<button id="cancel" style=" border: 2px solid gray;background-color:white;  margin-top: 50px; margin-bottom: 70px; " onclick="cancelPay()" >취소/환불하기</button>
</div>



<div id="hide2">
	<h1 style="font-size:25px;">교환할 제품</h1>
	<table style=" border: 2px solid gray;background-color:white; width: 100%;  margin-top: 50px; margin-bottom: 50px;">		
		<tr>
			<td>
				<select id="sizeChange" style="width:100%; height:30px; margin-right:5px; padding-right:5px; padding-bottom:5px; text-align:left;">
					<option>교환할 제품을 선택하세요.</option>
					<option>240</option>
					<option>250</option>
					<option>260</option>
					<option>270</option>
					<option>280</option>
					<option>290</option>
				</select>
	     	</td>   
		</tr>	
	</table>
</div>

<form name="changetrade">
	<input type="hidden" name="can" value="" id="can" />
	<input type="hidden" name="retry_jumun_bunho" value="${requestScope.jumun_bunho }" />
	<input type="hidden" name="chan"  />
</form>


<button style=" border: 2px solid gray;background-color:white;  margin-top: 50px; margin-bottom: 50px; " id="change" onclick="change()">교환하기</button>
</div>
<jsp:include page="../footer.jsp" />
    
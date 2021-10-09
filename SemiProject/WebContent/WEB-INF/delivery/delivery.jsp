<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
 
%>   
<jsp:include page="../header.jsp" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

<style>

	
   div#contents {
   	
   	margin-left: 150px;
   	margin-right:150px;
   	
  
   }
   
   button {
   		background-color: white;
   		
   }
   
	.titleArea h2 {
    padding: 5% 43% 12px;
    color: #000;
    font-size: 30px;
    font-family: "arimo",mg;
    font-weight: 700;
    letter-spacing: .05em; 
}
   

   	
   	
  

}
	
</style>


<div id="contents">
<div class="titleArea" style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
    <h2 style="font-wei">배송 조회</h2>
</div>

<table id="" style=" border: 1px solid gray;background-color:#d3d3d3; width: 100%; margin-bottom: 30px;">
	<tr>
	 	<td style="font-size:20pt; text-align :center; font-style:font-wei;">
	 		배달 상세 정보
	 	</td>	
	 </tr>
	 <tr>
	 	<td style="text-align:center; height:50px; background-color:white;">
			배달 업체 :한진 택배	
		</td>
	 </tr>
	<tr>
		<td style="text-align:center; height:40px; background-color:white;">
			시간  위치:  10.08 오후 8:00 신정동(집) 배달완료		
		</td>	
	</tr>
	<tr>
		<td style="text-align :center; background-color:white; ">
			송장번호 : <span style="color:blue; font-size:15pt;"><a>4100546791349</a></span>
		</td>	
	</tr> 
	
</table>			


<table id="" style=" border: 1px solid gray;background-color:#d3d3d3; width: 100%; align:center;">
	<tr>
	 	<td style="font-size:20pt; text-align :center">
	 		2021.10.08 주문내역
	 	</td>	
	 </tr>
	<tr>
		<td style="text-align:center; height:120px; background-color:white;">
			
		<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_1.png"/>	
			대복 소보루앙빵 35g x 50개 1박스(무료배송), 50개입19,500원 1개&nbsp;   <button> 장바구니 담기</button>
		</td>
	</tr>
	<tr>
		<td style="text-align :center; background-color:white; ">
			<button> 교한,반품 신청</button>
		</td>	
	</tr> 

</table>			

<table id="" style=" border: 1px solid gray;background-color:#d3d3d3; width: 100%; margin-top: 30px; margin-bottom: 30px;">
	<tr>
	 	<td style="font-size:20pt; text-align :center">
	 		주소
	 	</td>	
	 </tr>
	<tr>
		<td style="text-align:center; height:120px; background-color:white;">
			
			<h2 style="font-size:15pt;">고객명 : ${(sessionScope.loginuser).name}</h2>
      		<h1 style="font-size:15pt;">주소 : ${(sessionScope.loginuser).address}</h1>
      		<h1 style="font-size:15pt;">연락처 : ${(sessionScope.loginuser).mobile}</span></h1>
      	</td>	
	</tr>
	
</table>	
</div>

<br>
<jsp:include page="../footer.jsp" /> 
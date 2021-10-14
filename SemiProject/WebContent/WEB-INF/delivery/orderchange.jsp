<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
 
%>   
<jsp:include page="../header.jsp" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
<style>

	
   div#contents {
   	
   	margin-left: 150px;
   	margin-right:150px;
   	
  
   }
   
   button {
   		background-color: white;
   		
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
	function change(){
		
		alert("교환되었습니다.");
		
	}
	
	function cancelPay(){
		
		alert("환불되었습니다.");
		
	}

	$(document).ready(function(){
		
		$("div#hide1").hide();
		$("div#hide2").hide();
		$("button#change").hide();
		
		$("select#slt").click(function(){
	
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
			
			
		});
		
	});
	
	
	
	
</script>
<div id="contents">
<div class="titleArea" style="text-align: center; margin-top: 40px; margin-bottom: 40px;">
    <h2 style="font-wei">취소·반품·교환 제품</h2>
</div>
<table style=" border: 2px solid gray;background-color:white; width: 100%; margin-bottom: 50px;">
	
     <thead>
     	<tr>
			<th scope="col" class="number" style="height: 100px; width: 150px">주문일자 </th>
			<th scope="col" class="number" style="height: 100px; width:250px">주문번호</th>
            <th scope="col" class="" style="height: 100px; width: 300px">이미지</th>
            <th scope="col" class="" style="height: 100px; width: 600px">상품정보</th>
            <th scope="col" class="quantity" style="height: 100px; width: 150px">수량</th>
            <th scope="col" class="price" style="height: 100px; width: 150px">상품구매금액</th>
        </tr>
     </thead>
	<tbody >
		<tr class=""style=" border: 2px solid gray;">
			<td style="height: 200px; width: 150px"> </td>
			<td style="height: 200px; width: 250px"></td>
          	<td style="height: 200px; width: 300px"><a href=""><img src="" alt=""></a></td>
            <td style="height: 200px; width: 600px"> </td> 
            <td style="height: 200px; width: 150px"></td>
            <td style="height: 200px; width: 150px">  </td>
			
                
        </tr>
        
	</tbody>
</table>

<div style="font-size:25px;">취소·반품·교환 여부 선택</div>

<table style=" border: 2px solid gray;background-color:white; width: 100%;  margin-top: 30px; margin-bottom: 70px;">

		<tr>
			<td>
				<select id="slt" style="width:100%; height:30px; margin-right:5px; padding-right:5px; padding-bottom:5px; text-align:left;">
					<option>제품의 하실 것을 선택하시오.</option>
					<option>환불·취소</option>
					<option>교환</option>	
				</select>
	     	</td>   
		</tr>	
	
</table>


<div id="hide1">
	<h1 style="font-size:25px;">환불 제품</h1>
	<button style=" border: 2px solid gray;background-color:white;  margin-top: 50px; margin-bottom: 70px; "	onclick="cancelPay()">취소/환불하기</button>
</div>



<div id="hide2">
	<h1 style="font-size:25px;">교환할 제품</h1>
	<table style=" border: 2px solid gray;background-color:white; width: 100%;  margin-top: 50px; margin-bottom: 50px;">		
		<tr>
			<td>
				<select style="width:100%; height:30px; margin-right:5px; padding-right:5px; padding-bottom:5px; text-align:left;">
					<option>교환할 제품을 선택하세요.</option>
					<option style="color:red;">화이트 250(품절)</option>
					<option>화이트 240</option>
					<option style="color:red;">화이트 230(품절)</option>
					<option>화이트 220</option>
					<option>화이트 210</option>
				</select>
	     	</td>   
		</tr>	
	</table>
</div>


<button style=" border: 2px solid gray;background-color:white;  margin-top: 50px; margin-bottom: 50px; " id="change" onclick="change()">교환하기</button>
</div>
<jsp:include page="../footer.jsp" />
    
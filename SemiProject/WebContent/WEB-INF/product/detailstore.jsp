<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
<%
   String ctxPath = request.getContextPath();
%>    
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

	span, table, tr, td{
		/*  border:solid 1px red;   */
	}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
					
	// 값 넣었는지 확인해주는 변수
	var flagname = false;
	var flagpostcode = false;
	var flagaddress = false;
	var flagdetailAddress = false;
	var flagh2 = false;
	var flagh3 = false;
	var flagfirstemail = false;
	var flagsecondemail = false;
					
	$(document).ready(function(){
		
		// 시작시 주소 이메일사이트 입력은 불가로 바꾼다.
		$("input#postcode").prop("disabled", true);
		$("input#address").prop("disabled", true);
		$("input#secondemail").prop("disabled", true);
		
		// 에러메시지 잠시 숨김
		$("span#error").hide();
		
		$("input#name").blur(function(){
				
			var regExp = /^[가-힣]{2,4}$/;		
			var name = $(this).val();
				
			var bool = regExp.test(name);
			
			if(!bool){
				$("div#container:input").prop("disabled",true);
				$(this).prop("disabled", false);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagname = true;
			}
			
		});//end of $("input#name").blur(function(){-------------------------------
		
		///////////////////////////////////////////////////////////////////////////
		
		// 상세주소 지역변수 방지
		var detailAdd = "";
		
		$("span#searchadd").click(function(){
				
			new daum.Postcode({
	           
				oncomplete: function(data) {
					
	               	var addr = '';
	
	               	if (data.userSelectedType === 'R') { 
	                   	addr = data.roadAddress;
	               	} else { 
	                   	addr = data.jibunAddress;
	               	}
	               	
	               	if(data.userSelectedType === 'R'){
	                   	
	               		if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	               			detailAdd += data.bname;
	                   	}
	                   	if(data.buildingName !== '' && data.apartment === 'Y'){
	                   		detailAdd += (detailAdd !== '' ? ', ' + data.buildingName : data.buildingName);
	                   	}
	                   	if(detailAdd !== ''){
	                   		detailAdd = ' (' + detailAdd + ')';
	                   	}
	                   	document.getElementById("detailAddress").value = detailAdd;
	               
	               	} else {
	                   	document.getElementById("detailAddress").value = '';
	               	}
	               	
	               	document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;

	           	}	   
			}).open();

			flagpostcode = true;
			flagaddress = true;

		});//end of $("button#searchadd").click(function(){---------------------
		
		////////////////////////////////////////////////////////////////////////
		
		$("input#detailAddress").blur(function(){
			
			var bool = $(this).val()
			
			if(bool == detailAdd){
				$("div#container:input").prop("disabled",true);
				$(this).prop("disabled", false);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagdetailAddress = true;
			}
			
		});//$("input#detailAddress").blur(function(){--------------------------------	
			
		////////////////////////////////////////////////////////////////////////
		
		$("input#hp2").blur(function(){
			
		    var regExp = /^[1-9][0-9]{3}$/i;
			var hp2 = $(this).val();
			
			var bool = regExp.test(hp2);
			
			if(!bool){
				$("div#container:input").prop("disabled",true);
				$(this).prop("disabled", false);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagh2 = true;
			}
			
		});//end of $("input#hp2").blur(function(){--------------------------------
		
		///////////////////////////////////////////////////////////////////////////
		
		$("input#hp3").blur(function(){
			
		    var regExp = /^\d{4}$/i;
			var hp3 = $(this).val();
			
			var bool = regExp.test(hp3);
			
			if(!bool){
				$("div#container:input").prop("disabled",true);
				$(this).prop("disabled", false);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagh3 = true;
			}
			
		});//end of $("input#hp3").blur(function(){--------------------------------
			
		///////////////////////////////////////////////////////////////////////////
		
		$("input#firstemail").blur(function(){
			
		    var regExp = /^[0-9a-zA-Z]{2,20}$/i;
			var email = $(this).val();
			
			var bool = regExp.test(email);
			
			if(!bool){
				$("div#container:input").prop("disabled",true);
				$(this).prop("disabled", false);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagfirstemail = true;
			}
			
		});//end of $("input#firstemail").blur(function(){----------------------
			
		////////////////////////////////////////////////////////////////////////
		
		// 이메일 사이트 클릭시 자동으로 값 넣어주기
		$("select#autoemail").click(function(){
		
			$("input#secondemail").val($(this).val());
			
			if($("input#secondemail").val() == "자동입력"){
				$("div#container:input").prop("disabled",true);
				$(this).focus();
				$("span#error").show();
			}
			else{	
				$("table#container:input").prop("disabled",false);
				$("span#error").hide();
				flagsecondemail = true;
			}
			
		});//end of $("select#autoemail").click(function(){---------------------
			
		////////////////////////////////////////////////////////////////////////
		
		<%-- // 데이터베이스에 내 정보 불러오기
		$("input#introduce").click(function(){
			
			// 체크하면
			if($(this).prop("checked",true)){
				location.href="<%= request.getContextPath()%>/introduce.sh";
			}
			// 체크취소
			else{
				$("table#container:input").val("");
			}
			
		});//end of $("input#introduce").click(function(){ --%>
			
		////////////////////////////////////////////////////////////////////////	
		
		// 리뷰 작성시 글자수 보여주기	
		$("textarea#text").keyup(function(){
			
			var wordcount = $(this).val();
			$("span#insertreviewword").text(wordcount.length); 
			
			// 100글자 넘어가면
			if(wordcount.length > 100){
				alert("최대 100글자 까지 작성 가능합니다");
				return;
			}
			
		});//end of $("input#text").keyup(function(){----------------------------
		
	});//end of $(document).ready(function(){------------------------------------
			
	/////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////
		
	function godetailbought(){
		
		var flag = false;
		
		// 필수 입력사항을 다 기재했다면
		if(flagname == true && flagpostcode == true && flagaddress == true && flagdetailAddress == true && flagh2 == true && flagh3 == true && flagfirstemail == true && flagsecondemail == true){
			// 아임포트 결제 팝업창 띄우기 
	       	var url = "<%= request.getContextPath()%>/product/coinPurchaseEnd.sh";  
	      	window.open(url, "coinPurchaseEnd", "left=350px, top=100px, width=1000px, height=600px");
			flag = true;
		}
		else{
			alert("필수기재 사항을 입력해야합니다.");
			$("input#name").focus();
		}
		
		if(flag){
			
			// 값을 보내기 위해 꺼놨던 인풋을 다시 켜준다.
			$("input#postcode").prop("disabled", false);
			$("input#address").prop("disabled", false);
			$("input#secondemail").prop("disabled", false);	
		
			var frm = document.fordetailbought;
			frm.action = "<%= ctxPath%>/detailbought.sh";
			frm.method = "get";
			frm.submit();
		}
		
	}//end of function godetailbought(){-----------------------------------------
		
</script>

<div id="container" style="width:1200px; height:1600px; margin-left:200px; font-family:맑은 고딕;">
	<form name="fordetailbought"> 
		<!-- 내정보 -->
		<table style="width:1200px; height:100px; margin-top:30px;">
			<tr>
				<td colspan="2" style="text-align:center; height:80px; font-weight:bold; font-size:12pt; color:black;">ORDER</td>
			</tr>
			<tr>
				<td style="text-align:left; height:120px; background-color:#f5f5ef;">
					<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:600px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
						<img style="height:80px; padding-right:10px;" id="profile" src="/SemiProject/images/profile.PNG"/>
						님은 [화이트] 회원입니다
					</span>
				</td>
				<td style="background-color:#f5f5ef; height:120px; text-algin:center;">
					<table style="background-color:#f5f5ef; height:100px; width:600px;">
						<tr>
							<td style="text-align:center; width:300px;">
								<img style="height:20px;" id="jukrib" src="/SemiProject/images/jukrib.png"/>
								<div style="font-size:9pt; margin-top:7px;">
									내 적립금
								</div>
								<div style="font-size:12pt; font-weight:bold;">
									4,500원
								</div>
							</td>
							<td style="text-align:center; width:300px;">
								<img style="height:20px;" id="coopon" src="/SemiProject/images/coopon.png"/>
								<div style="font-size:9pt; margin-top:7px;">
									내 쿠폰
								</div>
								<div style="font-size:12pt; font-weight:bold;">
									3장
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!-- 컬럼명 -->
		<table style="margin-top:30px;">
			<tr style="background-color:#f5f5ef; border-bottom:solid 1px #d0d0e2; border-top:solid 1px #d0d0e2;">						
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					상품이미지
				</td>
				<td style="width:500px; height:50px; font-size:10pt; color:black; text-align:center;">
					상품정보
				</td >
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					수량
				</td>
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					가격
				</td>
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					옵션 가격
				</td>
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					적립금
				</td>
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					배송구분
				</td>
				<td style="width:100px; height:50px; font-size:10pt; color:black; text-align:center;">
					합계
				</td>
			</tr>
			<tr>						
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					<img style="height:150px; width:100px;" id="chun" src="${requestScope.product_front_p1}"/>
				</td>
				<td style="width:500px; height:150px; font-size:10pt; color:black; text-align:left; padding-left:30px;">
					${requestScope.cartname}<br>
					${requestScope.cartopt123}<br>
					${requestScope.cartopt4}
				</td >
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					${requestScope.cartnum}
				</td>
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					<fmt:formatNumber value="${requestScope.cartprice}" pattern="###,###" />원
				</td>
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					<fmt:formatNumber value="${requestScope.cartfinopt}" pattern="###,###" />원
				</td>
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					<fmt:formatNumber value="${requestScope.jukrib}" pattern="###,###" />원			
				</td>
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					[기본배송]<br>
					배송비 : 무료
				</td>
				<td style="width:100px; height:150px; font-size:10pt; color:black; text-align:center;">
					<fmt:formatNumber value="${requestScope.cartfinopt + cartprice}" pattern="###,###" />원
				</td>
			</tr>
			<tr style="border-bottom:solid 1px gray; border-top:solid 1px gray;">
				<td colspan="8" style="height:50px; font-size:8pt; text-align:left; color:gray;">
					<img style="height:24px; padding-left:5px;" src="/SemiProject/images/jui1.PNG"/>
					상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
				</td>
			</tr>
		</table>
		<!-- 주문정보 -->
		<table style="width:1200px; margin-top:50px;">
			<tr>
				<td colspan="2" style="height:40px; width:1200px;">
					<span style="font-size:14pt; text-align:left;">
						주문정보
					</span>
					<span id="error" style="margin-left:20px; color:red; font-size:10pt;">
						v표시는 필수 입력사항 입니다.
					</span>
				</td>
			</tr>
			<tr style="border-top:solid 1px #d0d0e2;">
				<td style="width:150px; height:50px; text-align:left; padding-left:20px; font-size:10pt; color:black; background-color:#f5f5ef;">
					주문하시는분
					<span style="color:red; font-size:9pt;">v</span>
				</td>
				<td>
					<input id="name" name="name" type="text" style="height:35px; width:160px; border:solid 1px #c0c0d8; margin-left:10px;"/>
					<input id="introduce" type="checkbox" style="margin-left:5px;"/>
					<span style="font-size:8pt;">내 정보 불러오기</span>
				</td>
			</tr>
			<tr style="border-top:solid 1px #d0d0e2;">
				<td style="width:150px; height:140px; text-align:left; padding-left:20px; font-size:10pt; color:black; background-color:#f5f5ef;">
					주소
					<span style="color:red; font-size:9pt;">v</span>
				</td>
				<td>
					<div>
						<input id="postcode" name="postcode" type="text" style="height:35px; width:75px; border:solid 1px #c0c0d8; margin-left:10px;"/>
						<span id="searchadd" style="font-size:10pt; background-color:white; border:solid 1px #c0c0d8; margin-left:4px; padding-left:3px;">
							주소
							<span style="color:red; font-size:10pt;">&nbsp;&gt;</span>
						</span>
					</div>
					<div style="margin-top:6px;"><input id="address" name="address" type="text" style="height:35px; width:600px; border:solid 1px #c0c0d8; margin-left:10px;"/><span style="margin-left:8px; font-size:11px; color:blackl;">기본 주소</span></div>
					<div style="margin-top:6px;"><input id="detailAddress" name="detailAddress" type="text" style="height:35px; width:600px; border:solid 1px #c0c0d8; margin-left:10px;"/><span style="margin-left:8px; font-size:11px; color:blackl;">상세 주소</span></div>
				</td>
			</tr>
			<tr style="border-top:solid 1px #d0d0e2;">
				<td style="width:150px; height:50px; text-align:left; padding-left:20px; font-size:10pt; color:black; background-color:#f5f5ef;">
					휴대전화
					<span style="color:red; font-size:9pt;">v</span>
				</td>
				<td>
					<select id="hp1" name="hp1" style="height:35px; width:70px; border:solid 1px #c0c0d8; margin-left:10px; font-size:10pt;">
						<option>010</option><option>011</option><option>016</option><option>017</option><option>018</option><option>019</option>
					</select>
					-
					<input id="hp2" name="hp2" type="text" style="height:35px; width:80px; border:solid 1px #c0c0d8;"/>
					-
					<input id="hp3" name="hp3" type="text" style="height:35px; width:80px; border:solid 1px #c0c0d8;"/>
				</td>
			</tr>
			<tr style="border-top:solid 1px #d0d0e2;">
				<td style="width:150px; height:100px; text-align:left; padding-left:20px; font-size:10pt; color:black; background-color:#f5f5ef;">
					이메일
					<span style="color:red; font-size:9pt;">v</span>
				</td>
				<td>
					<div>
						<input name="firstemail" id="firstemail" type="text" style="height:35px; width:160px; border:solid 1px #c0c0d8; margin-left:10px;"/>
						@
						<input name="secondemail" id="secondemail" type="text" style="height:35px; width:160px; border:solid 1px #c0c0d8;"/>
						<select id="autoemail" style="height:35px; width:140px; margin-left:5px; border:solid 1px #c0c0d8; font-size:10pt;">
							<option>자동입력</option><option>naver.com</option><option>daum.net</option><option>nate.com</option><option>hotmail.com</option><option>yahoo.com</option><option>gmail.com</option>
						</select>
					</div>
					<div style="margin-left:10px; margin-top:5px; color:gray; font-size:9pt;">
						이메일을 통해 주문처리과정을 보내드립니다.
					</div>
					<div style="margin-left:10px; margin-top:3px; color:gray; font-size:9pt;">
						이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요
					</div>
				</td>
			</tr>
			<tr style="border-top:solid 1px #d0d0e2; border-bottom:solid 1px #d0d0e2;">
				<td style="width:100px; height:130px; text-align:left; padding-left:20px; font-size:10pt; color:black; background-color:#f5f5ef;">
					배송메시지
				</td>
				<td>
					<textarea id="text" name="text" style="resize:none; height:100px; width:600px; border:solid 1px #c0c0d8; margin-left:10px;"></textarea>
					<span id="insertreviewword" style="font-size:12pt; color:gray;">
									
					</span>
				</td>
			</tr>
		</table>
		
		<!-- 결제예정금액 -->
		<table id="buy" style="width:1200px; height:300px; margin-top:50px;">
			<tr>
				<td style="height:40px; width:1200px; font-size:14pt; text-align:left;">
					결제 예정금액
				</td>
			</tr>
			<tr>
				<td style="width:300px;">
					<table style="width:1200px; height:240px; font-size:9.5pt; border:solid 1px #d0d0e2;">
						<tr style="border:solid 1px #d0d0e2;">
							<td style="text-align:center; width:300px; height:40px; background-color:#efeff5;">
								주문 금액
							</td>
							<td style="text-align:center; width:300px; height:40px; background-color:#efeff5; border:solid 1px #d0d0e2;">
								할인 금액
							</td>
							<td style="text-align:center; width:300px; height:40px; background-color:#efeff5; border:solid 1px #d0d0e2;">
								부가결게 금액
							</td>
							<td style="text-align:center; width:300px; height:40px; background-color:#efeff5; border:solid 1px #d0d0e2;">
								총 할인 + 부가결게 금액
							</td>
							<td style="text-align:center; width:300px; height:40px; background-color:#efeff5;">
								최종결제 금액
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:19pt;">
								<fmt:formatNumber value="${requestScope.cartprice}" pattern="###,###" />원
							</td>
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:19pt; border:solid 1px #d0d0e2;">
								-0
							</td>
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:19pt; border:solid 1px #d0d0e2;">
								<fmt:formatNumber value="${requestScope.cartfinopt}" pattern="###,###" />원
							</td>
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:19pt; border:solid 1px #d0d0e2;">
								+50,000
							</td>
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:19pt;">
								=159,000
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">
							<td colspan="4" style="padding-left:15px; font-size:10pt; height:40px; width:150px; border:solid 1px #d0d0e2;">
								이용약관
							</td>	
							<td id="buynow" style="height:40px; font-size:12pt; text-align:center; background-color:black; color:white; border:solid 1px black;" onclick="godetailbought();">
								BUY NOW
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">	
							<td colspan="4" rowspan="2" style="height:40px; width:150px; border:solid 1px #d0d0e2;">
								<div style="padding-left:10px; font-size:8pt;">
									- 무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.
								</div>
								<div style="padding-left:10px; margin-top:3px; font-size:8pt;">
									- 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.
								</div>
							</td>	
							<td style="height:40px; text-align:center; background-color:#efeff5;">
								포인트적립금
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">	
							<td colspan="4" style="text-align:center; height:40px; width:150px; border:solid 1px #d0d0e2;">
								<fmt:formatNumber value="${requestScope.jukrib}" pattern="###,###" />원
							</td>	
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<!-- 구매내역 전송을 위함 -->
		<input type="hidden" name="product_front_p1" value="${requestScope.product_front_p1}"/>
		<input type="hidden" name="cartname" value="${requestScope.cartname}"/>
		<input type="hidden" name="cartopt123" value="${requestScope.cartopt123}"/>
		<input type="hidden" name="cartopt4" value="${requestScope.cartopt4}"/>
		<input type="hidden" name="cartnum" value="${requestScope.cartnum}"/>
		<input type="hidden" name="cartprice" value="${requestScope.cartprice}"/>
		<input type="hidden" name="jukrib" value="${requestScope.jukrib}"/>
		<input type="hidden" name="cartfinopt" value="${requestScope.cartfinopt}"/>
	</form> 
</div>

	


<jsp:include page="/WEB-INF/footer.jsp" />
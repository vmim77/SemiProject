<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
	String finish = (String)request.getAttribute("finish");
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
	// 내가 얼마나 사용했는지 보이는 포인트
	var jibulpoint = 0;
	// 남은포인트
	var nampoint = 0;
	// 포인트 사용을 위한 깃발
	var pointfalg = false;
	// db에 저장을 위한 point 값
	var dbpoint = 0;
					
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
		
		// 데이터베이스에 내 정보 불러오기
		$("input#introduce").click(function(){
			
			// 체크여부
			var bool = $(this).is(":checked");
			
			if(bool){
				// 값 넣기
				$("input#name").val("${paraMap.name}");
				$("input#postcode").val("${paraMap.postcode}");
				$("input#address").val("${paraMap.address}");
				$("input#detailAddress").val("${paraMap.detailAddress}");
				$("input#hp1").val("${paraMap.hp1}");
				$("input#hp2").val("${paraMap.hp2}");
				$("input#hp3").val("${paraMap.hp3}");
				$("input#firstemail").val("${paraMap.firstemail}");
				$("input#secondemail").val("${paraMap.secondemail}");
				// true 로 바꿔 전송을 위함
				flagname = true;
				flagpostcode = true;
				flagaddress = true;
				flagdetailAddress = true;
				flagh2 = true;
				flagh3 = true;
				flagfirstemail = true;
				flagsecondemail = true;
			}
			// 체크취소
			else{
				// 값 초기화
				$("input#name").val("");
				$("input#postcode").val("");
				$("input#address").val("");
				$("input#detailAddress").val("");
				$("input#hp1").val("");
				$("input#hp2").val("");
				$("input#hp3").val("");
				$("input#firstemail").val("");
				$("input#secondemail").val("");
				// false로 다시 바꿔 전송을 막는다
				flagname = false;
				flagpostcode = false;
				flagaddress = false;
				flagdetailAddress = false;
				flagh2 = false;
				flagh3 = false;
				flagfirstemail = false;
				flagsecondemail = false;
			}
			
		});//end of $("input#introduce").click(function(){----------------------
			
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
		
		/////////////////////////////////////////////////////////////////////////////
		///////////////////////////  여기서부터 부트스트랩 모달창 기능  /////////////////////////
		
		// 일단 숨기기
		$("div#thishide").hide();
		// 매 클릭마다 이벤트 처리를 위함
		var udcnt = 0;
		// 자세히 보기 이벤트처리
		$("div#updown").click(function(){
			
			// 0일때 보이기
			if(udcnt == 0){
				$("div#thishide").show();
				udcnt = 1;
				// 이름 바꿔주기
				$("div#updown").text("자세히 보기 △");
			}
			// 1일때 보이기
			else{
				$("div#thishide").hide();
				udcnt = 0;
				// 이름 바꿔주기
				$("div#updown").text("자세히 보기 ▽");
			}
			
		});//end of $("div#updown").click(function(){
		
		//////////////////////////////////////////////////////////////////////////////	
		
		// 포인트 모달창 띄우기
		$("button#btnpoint").click(function(){
			
			// 이 플래그는 사용하기 버튼을 누르고 재 사용을 위해 다시 들어오는
			// 고객을 위해 작성한 깃발이다
			if(pointfalg){
				$("div#mypoint").text(nampoint+"P");
				$("div#errmsg").text("");
				$("input#howmany").val("");
			}
			else{
				// 만약을 대비하여 다시 열었을 때 다 지워주기
				$("div#mypoint").text("${requestScope.mypoint}" + "P");
				jibulpoint = 0;
				dbpoint = 0;
				$("input#dbpoint").val("0");
				$("input#jibulpoint").val("0");
				$("div#errmsg").text("");
				$("input#howmany").val("");
			}
			
		});//end of $("button#btnpoint").click(function(){---------------------------	
			
		/////////////////////////////////////////////////////////////////////////////	
		
		// 포인트 사용 버튼 클릭시	
		$("button#jibul").click(function(){
			
			// 포인트는 10000포인트를 모았을 때 부터 사용 가능하다
			if("${requestScope.mypoint}"<10000){
				$("div#errmsg").text("10000포인트 부터 이용 가능합니다.");
			}
			// 포인트 변수에 담아두기
			else{
				// 담기
				nampoint = $("div#mypoint").text().replace("P","")*1 - $("input#howmany").val()*1;
				$("div#mypoint").text(nampoint);
				// 전송을 위해 담기
				// 내 잔액 포인트
				dbpoint = nampoint;
				
				// 보유 포인트 보다 많이 사용시
				if(nampoint<0){
					$("div#errmsg").text("보유 포인트금액을 초과 하셨습니다.");
					$("div#mypoint").text("${requestScope.mypoint}"+"P");
					$("input#howmany").val("");
					// 사용포인트 지우기
					$("td#pthis").text("");
					$("td#pthis2").html("<fmt:formatNumber value='${requestScope.cartfinopt}' pattern='###,###' />원");
					$("td#pthis3").html("<fmt:formatNumber value='${requestScope.cartprice + cartfinopt}' pattern='###,###' />원");	
					// 저장한 값들 다 초기화
					jibulpoint = 0;
					dbpoint = 0;
					$("input#dbpoint").val("0");
					$("input#jibulpoint").val("0");
				}
				// 성공적인 사용
				else if(nampoint>=0){
					$("div#mypoint").text(nampoint+"P");
					$("div#errmsg").text("");
					// 사용한 포인트 담아주기
					jibulpoint += $("input#howmany").val()*1;
					$("input#howmany").val("");
					pointfalg = true;
					// 전송을 위한 값 담아주기
					$("input#dbpoint").val(dbpoint);
					$("input#jibulpoint").val(jibulpoint);
					// 콤마 넣기
					var regexp = /\B(?=(\d{3})+(?!\d))/g;
					var pthis = jibulpoint.toString().replace(regexp, ',');
					// 내 포인트 얼마나 썻는지
					$("td#pthis").text("-"+pthis+"원");
					// 부가옵션 - 내 포인트
					var minuspoint = "${requestScope.cartfinopt}"-jibulpoint;
					// 콤마 넣기
					var regexp = /\B(?=(\d{3})+(?!\d))/g;
					var mpoint = minuspoint.toString().replace(regexp, ',');
					// 값 넣어주기
					$("td#pthis2").text(mpoint+"원");
					// 전체 결제금액
					// 지역변수 방지
					var finalpoint = 0;
					// 우선-인지 아닌지 보기
					if(minuspoint<=0){
						finalpoint = "${requestScope.cartprice}" - jibulpoint;
						var regexp = /\B(?=(\d{3})+(?!\d))/g;
						var finpoint = finalpoint.toString().replace(regexp, ',');
						$("td#pthis3").text(finpoint+"원");
					}
					else{
						finalpoint = "${requestScope.cartprice}"*1 + "${requestScope.cartfinopt}"*1 - jibulpoint;
						var regexp = /\B(?=(\d{3})+(?!\d))/g;
						var finpoint = finalpoint.toString().replace(regexp, ',');
						$("td#pthis3").text(finpoint+"원");
					}//end of if(minuspoint<=0){---------------------------------- 

					// 구매 가격보다 포인트 많이 사용시
					if(finalpoint < 0){
						$("div#errmsg").text("구매 가격을 초과 하셨습니다");
						$("div#mypoint").text("${requestScope.mypoint}"+"P");
						$("input#howmany").val("");
						// 사용포인트 지우기
						$("td#pthis").text("");
						$("td#pthis2").html("<fmt:formatNumber value='${requestScope.cartfinopt}' pattern='###,###' />원");
						$("td#pthis3").html("<fmt:formatNumber value='${requestScope.cartprice + cartfinopt}' pattern='###,###' />원");	
						// 저장한 값들 다 초기화
						jibulpoint = 0;
						dbpoint = 0;
						$("input#dbpoint").val("0");
						$("input#jibulpoint").val("0");
					}//end of if(finalpoint < 0){---------------------------------------
						
				}
				// 문자 입력시
				else{
					$("div#errmsg").text("숫자만 입력 해주세요");
					$("div#mypoint").text("${requestScope.mypoint}"+"P");
					$("input#howmany").val("");
					// 사용포인트 지우기
					$("td#pthis").text("");
					$("td#pthis2").html("<fmt:formatNumber value='${requestScope.cartfinopt}' pattern='###,###' />원");
					$("td#pthis3").html("<fmt:formatNumber value='${requestScope.cartprice + cartfinopt}' pattern='###,###' />원");	
					// 저장한 값들 다 초기화
					jibulpoint = 0;
					dbpoint = 0;
					$("input#dbpoint").val("0");
					$("input#jibulpoint").val("0");
					
				}//end of if(nampoint<0){----------------------------
					
			}//end of if("${requestScope.mypoint}"<10000){-----------
			
		});//end of $("button#jibul").click(function(){------------------------------
		
		/////////////////////////////////////////////////////////////////////////////
		
		// 사용취소 버튼 클릭시
		$("button#cancle").click(function(){
			
			// 포인트 원래금액으로 돌려두기
			$("div#mypoint").text("${requestScope.mypoint}"+"P");
			// 에러메시지 숨기기
			$("div#errmsg").text("");
			// 작성한 포인트 지우기
			$("input#howmany").val("");
			// 사용포인트 지우기
			$("td#pthis").text("");
			$("td#pthis2").html("<fmt:formatNumber value='${requestScope.cartfinopt}' pattern='###,###' />원");
			$("td#pthis3").html("<fmt:formatNumber value='${requestScope.cartprice + cartfinopt}' pattern='###,###' />원");	
			// 저장한 값들 다 초기화
			jibulpoint = 0;
			dbpoint = 0;
			$("input#dbpoint").val("0");
			$("input#jibulpoint").val("0");
			
		});//end of $("button#jibul").click(function(){------------------------------
			
		/////////////////////////////////////////////////////////////////////////////
		
		// 여기서부터 쿠폰사용 시작
		
		// 쿠폰은 한번에 한번만 사용 가능하므로 cnt를 줘서 몇번 썻는지 확인한다.
		var cucnt = 0;
		// 지워주는 키값 지역변수방지
		var delindex = 0;
		
		// 쿠폰 사용시
		$("span#cuuse").click(function(){
			
			// 사용횟수 올려주기
			cucnt++;
			// 한번만 사용시
			if(cucnt == 1){
				// 쿠폰금액
				var cuprice = $(this).next().val();
				// 지워주는 키값
				delindex = $(this).next().next().val();
				// 숨겨주기
				$("tr#"+delindex).hide();
				// 쿠폰 사용금액 보여주기
				$("span#cushow").text(cuprice + "원 쿠폰을 적용 하셨습니다.");
				// 얼마의 쿠폰을 썻는지 값을 넘기기 위해 전송용 인풋에 값 넣어주기
				$("input#coupon").val(cuprice);
			}
			else{
				// 혹시 모르니
				cucnt=1;
				alert("쿠폰적용은 1개만 가능합니다.");
			}
			
			
		});//end of $("span#cuse").click(function(){
		
		$("button#cancle").click(function(){
			
			// 숨겨놨던 tr 보여주기
			$("tr#"+delindex).show();
			// 쿠폰 사용금액 내리기
			$("span#cushow").text("");
			// 사용횟수 내리기
			cucnt = 0;
			// 얼마의 쿠폰을 썻는지 값을 넘기기 위해 전송용 인풋에 값 넣은거 지우기
			$("input#coupon").val("0");
			
		});//end of $("button#cancle").click(function(){ 	
		
			
	});//end of $(document).ready(function(){------------------------------------		
			
	/////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////
		
	function godetailbought(){
		
		// 필수 입력사항을 다 기재했다면
		if(flagname == true && flagpostcode == true && flagaddress == true && flagdetailAddress == true && flagh2 == true && flagh3 == true && flagfirstemail == true && flagsecondemail == true){
			
			// 아임포트 결제 팝업창 띄우기 
	       	var url = "<%= request.getContextPath()%>/product/coinPurchaseEnd.sh";  
	      	var test = window.open(url, "coinPurchaseEnd", "left=350px, top=100px, width=1000px, height=600px");
		
	      	// 팝업창이 닫힌다면
	      	test.addEventListener('beforeunload', function(){
				
      			$("input#postcode").prop("disabled", false);
				$("input#address").prop("disabled", false);
				$("input#secondemail").prop("disabled", false);	
				
				var frm = document.fordetailbought;
				frm.action = "<%= ctxPath%>/detailbought.sh";
				frm.method = "post";
				frm.submit();
			
			});//end of test.addEventListener('beforeunload', function() {
	      	
		}
		else{
			alert("필수기재 사항을 입력해야합니다.");
			$("input#name").focus();
		}
			
	}//end of function godetailbought(){-----------------------------------------
		
</script>

<div id="container" style="width:1200px; height:1600px; margin-left:200px; font-family:맑은 고딕;">
	<form name="fordetailbought"> 
		<table style="margin-top:80px;">
			<tr style="font-size:14pt; height:40px; text-align:left; padding-bottom:5px;">
				<td>
					상품정보
				</td>
			</tr>
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
				<td style="width:1200px;">
					<table style="width:1200px; height:240px; font-size:9.5pt; border:solid 1px #d0d0e2;">
						<tr style="border:solid 1px white; border-bottom:solid 1px #d0d0e2;">
							<td colspan='5' style="width:1200px; height:50px;">
								<button id="btnpoint" type="button" style="font-size:10pt; background-color:#efeff5; width:118px; height:40px; text-align:center;" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">POINT</button>
								<button id="gobtn"    type="button" style="font-size:10pt; background-color:#efeff5; width:118px; height:40px; text-align:center;" class="btn btn-outline-secondary" data-toggle="modal" data-target="#myModal">COUPON</button>
								<span id="cushow" style="margin-left:10pt; font-size:10pt; color:red;"></span>
							</td>
						</tr>
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
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:17pt;">
								<fmt:formatNumber value="${requestScope.cartprice}" pattern="###,###" />원
							</td>
							<td id="pthis" style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:17pt; border:solid 1px #d0d0e2;">
								
							</td>
							<td style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:17pt; border:solid 1px #d0d0e2;">
								<fmt:formatNumber value="${requestScope.cartfinopt}" pattern="###,###" />원
							</td>
							<td id="pthis2" style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:17pt; border:solid 1px #d0d0e2;">
								<fmt:formatNumber value="${requestScope.cartfinopt}" pattern="###,###" />원
							</td>
							<td id="pthis3" style="text-align:center; width:300px; height:80px; font-weight:bold; font-size:17pt;">
								<fmt:formatNumber value="${requestScope.cartprice + cartfinopt}" pattern="###,###" />원
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">
							<td colspan="4" style="width:1200px; padding-left:15px; font-size:10pt; height:40px; width:150px; border:solid 1px #d0d0e2;">
								이용약관
							</td>	
							<td id="buynow" style="width:300px; height:40px; font-size:12pt; text-align:center; background-color:black; color:white; border:solid 1px black;" onclick="godetailbought();">
								BUY NOW
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">	
							<td colspan="4" rowspan="2" style="height:40px; width:1200px; border:solid 1px #d0d0e2;">
								<div style="padding-left:10px; font-size:8pt;">
									- 무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.
								</div>
								<div style="padding-left:10px; margin-top:3px; font-size:8pt;">
									- 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.
								</div>
							</td>	
							<td style="height:40px; width:300px; text-align:center; background-color:#efeff5;">
								포인트적립금
							</td>
						</tr>
						<tr style="border:solid 1px #d0d0e2;">	
							<td colspan="4" style="text-align:center; height:40px; width:300px; border:solid 1px #d0d0e2;">
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
		<!-- 값 대입을 위하여 아이디 지정 -->
		<input id="dbpoint" type="hidden" name="dbpoint" value="0"/>
		<input id="jibulpoint" type="hidden" name="jibulpoint" value="0"/>
		<input id="coupon" type="hidden" name="coupon" value="0"/>
	</form> 
</div>

<!-- 모달 꾸미기 -->
<!-- //////////////////////////////////////////////////////////////////////// -->		
<div class="modal fade" id="exampleModal">
	<div class="modal-dialog">
		<div class="modal-content">      
			<!-- Modal header -->
		    <div class="modal-header">
		    	<h5 class="modal-title">내 포인트 조회</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		    </div>
		    <!-- Modal body -->
		    <div class="modal-body">
		    	<div id="container" style="text-align:center;">
			    	<!-- 여기서부터 디자인 시작 -->
			    	<div id="phere" style="font-size:10pt;">
			    		MY 포인트 : ${requestScope.mypoint}P
			    	</div>
			    	<div id="mypoint" style="font-size:20pt; margin-bottom:10px;">
			    	</div>
			    	<div>
			    		<input id="howmany" type="text" style="width:100px;"/>
			    		<div id="errmsg" style="margin:10px 0px 10px 0px; color:red; font-size:10pt;"></div>
			    		<button id="jibul" style="font-size:10pt; border:solid 1px black; background-color:black; color:white;">
			    			사용하기
			    		</button>&nbsp;
			    		<button id="cancle" style="font-size:10pt; border:solid 1px black; background-color:white; color:black;">
			    			사용취소
			    		</button>
			    	</div>
			    	<div id="updown" style="font-size:9pt; margin:30px 0px 0px 10px; text-align:left;">
			    		자세히 보기 ▽
			    	</div>
			    	<!-- 하이드로 숨겨둔 곳 -->
			    	<div id="thishide" style="font-size:8pt; text-align:left; margin-top:10px;">
			    		<div style="padding-left:20px; border-top:solid 1px gray; border-bottom:solid 1px gray;">
			    			이용약관
			    		</div>	
						<ul style="border-bottom:solid 1px gray;">
							<li>포인트는 총구매 액(옵션가 제외)의 10%가 적립됩니다</li>	
		    				<li>포인트 사용은 10,000포인트 부터 사용 가능합니다</li>
		    				<li>그말은 즉슨 최소 100,000원을 써라 그런말입니다</li>
		    				<li>뭐 어쩌겠습니까 저희도 먹고살자고 그러는겁니다</li>
		    				<li>아무튼 구두나 많이 구매좀 해주십쇼</li>
		    			</ul>
			    	</div>
		    		<span style="font-size:11pt;">출석체크 하셨나요?</span>
		    		<a href="<%= request.getContextPath()%>/memberCalendar.sh">
		    			<img src="/SemiProject/images/choolcheck.jpeg" style="width:50px; height:50px;">
		    		</a>
		    	</div>
	    	</div>
		    <!-- 여기서부터 디자인 끝 -->
		</div>
	</div>
</div>	
<!-- //////////////////////////////////////////////////////////////////////// -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
    	<div class="modal-content" style="width:600px; margin-left:0px">
      		<div class="modal-header">
        		<h4 class="modal-title" id="myModalLabel" style="text-align: right;">쿠폰내역</h4>
      		</div>
      		<div class="modal-body">
        		<table border="1" style="text-align:center;">
        	 	<tr style="font-size:11pt; color:white; background-color:black;">
					<td scope="col" class="" style="height: 35px; width: 300px">쿠폰발급일자</td>
                	<td scope="col" class="" style="height: 35px; width: 400px; text-align: center;">쿠폰명</td>
                	<td scope="col" class="" style="height: 35px; width: 200px; text-align: center;">할인금액</td>
                	<td scope="col" class="" style="height: 35px; width: 300px; text-align: center;" >유효기간</td>
                	<td scope="col" class="" style="height: 35px; width: 200px; text-align: center;" >사용하기</td>
            	</tr>
        		<c:forEach  var= "mvo" items="${requestScope.libo}" varStatus="index">
					<tr id="${index.index}" style="font-size:9pt;">
						<td class="" style="height: 30px; width: 300px;">${mvo.coupondate}</td>
		                <td style="height: 30px; width: 400px; text-align: center;">${mvo.couponname}</td> 
		                <td class="" style="height: 30px; width: 200px; text-align: center;"> <a href=""></a>${mvo.coupondiscount}원</td>
		                <td class="" style="height: 30px; width: 300px; text-align: center;">${mvo.couponlastday}</td>
		                <td class="" style="height: 30px; width: 200px; text-align: center;">
		                	<span id="cuuse">
		                		사용
		                	</span>
		                	<!-- 해당금액 -->
		                	<input type="hidden" value="${mvo.coupondiscount}" id="cudis" />
		                	<!-- 사용했다면 보기에서 지워줘야 하기 때문에 -->
		                	<!-- 키값을 위해 넣어줌 -->
		                	<input type="hidden" value="${index.index}" />
		                	</td>		                
            		</tr>
				</c:forEach>
        		</table>
      		</div>
     		<div class="modal-footer">
       			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
       			<button type="button" id="cancle" class="btn btn-default" data-dismiss="modal">사용취소</button>
	      	</div>
	    </div>
	  </div>
</div>



<jsp:include page="/WEB-INF/footer.jsp" />
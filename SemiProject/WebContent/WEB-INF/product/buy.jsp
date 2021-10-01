<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%>    
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">
	
	table, tr, td{
		  /*  border:solid 1px red;  */
	}
	
	span#num1,span#num2,span#num3{
		display:inline-block;
		border:solid 1px gray;
		width:40px;
		height:40px;
		text-align:center;
		font-size:13pt;
		padding:2px 0px;
	}
	
	div#writer,div#writeday{
		text-align:left;
		border-bottom:solid 1px gray;
		height:70px;
		padding:25px 0px;
		width:200px;
		color:black;
		font-size:10pt;
	}
	
	div#writewhat{
		text-align:left;
		height:70px;
		padding:25px 0px;
		width:200px;
		color:black;
		font-size:10pt;
	}
	
	/*
	클릭 시 바뀔 내용
	span#newreview,span#goodreview{
		font-size:14pt;
		font-weight:bold;
		color:black;
	}
	*/

	span#newreview,span#goodreview{
		font-size:10pt;
		color:black;
	}
	
	div#5stars,div#4stars,div#3stars,div#2stars,div#1stars{
		font-size:5pt;
		color:red;
	}
	
	

</style>

<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	// 구매를 할 수 있게 해주는 깃발
	var buynow = false;
	// 수량
	var num = 1;
	// 옵션 기본값
	var org = "- [필수]옵션을 선택 해주세요 -";
	// 옵션 각각의 기본값
	var opt1 = "";
	var opt2 = "";
	var opt3 = "";
	var opt4 = "";
	// 옵션을 바로 넣기를 금지하는 깃발
	var fg1 = false;
	var fg2 = false;
	var fg3 = false;
	var fg4 = false;
	// tr 아이디를 잡아주기 위함
	var cnt = 0;
	// 옵션 선택시 실행해주는 메소드
	function flag1(){
		opt1 = $("select#optselect1").val();
		fg1 = true;
	}
	function flag2(){
		opt2 = $("select#optselect2").val();
		fg2 = true;
	}
	function flag3(){
		opt3 = $("select#optselect3").val();
		fg3 = true;
	}
	function flag4(){
		opt4 = $("select#optselect4").val();
		fg4 = true;
	}
	// 수량 늘려주기
	function flag5(){
		num = $("input#num").val();
		// 할인 가격이 얼마인지
		var orgpcd = $("span#product_ceil_price").html();
		// 변경작업
		var pcd = orgpcd.replace(",",""); 
		$("div#upprice").html(num * pcd+"원");
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
		
	$(document).ready(function(){
		
		// 초기 가격 설정해주기
		var orgpcd = $("span#product_ceil_price").html();
		var pcd = orgpcd.replace(",","");
		
		// 추가하기 버튼 눌렀을 때
		$("img#plus").click(function(){
			
			// 각각 옵션을 선택한 경우
			if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
				
				cnt++;
				
				var html = "<td colspan='2' style='height:70px; width:350px;'>"
						  	+"<table>"
								+"<tr>"
									+"<td style='width:300px;'>"
										+"<div style='text-align:left; font-size:9pt; color:black;'>"
											+"<div style='font-weight:bold;'>"+ $("span#product_name").html() +"</div>"
											+"<div>"+opt1+"/"+opt2+"/"+opt3+"</div>"
											+"<div>/"+opt4+"</div>"
										+"</div>"
									+"</td>"
									+"<td style='width:140px; text-align:right; font-size:10pt;'>"
										+"<input id='num' type='number' min='1' value='1' max='20' style='width:40px; height:20px; text-align:left;' onclick='flag5();'/>"
										+"<img id='close' src='/SemiProject/images/close.png' style='width:15px; height:15px; margin-left:5px'/>"
										+"<input class='delnum' type='hidden' value='"+cnt+"'/>"
										+"<div id='upprice'>"+num*pcd+"원</div>"
										+"<div>+ 45,000원</div>"
									+"</td>"	
								+"</tr>"
							+"</table>"
						  +"</td>";
				
				$("tr#"+cnt).html(html);	
				
			}
			else{
				alert("옵션을 모두 선택 후 추가 해주세요.");
			}//end of if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){

			// 제품 4개가 꽉차면
			if(cnt>4){
				alert("최대 4개까지 담을 수 있습니다.");
				cnt = 4;
			}
			
			////////////////////////////////////////////
			// 나중에 추가되는 태그므로 도큐멘트.레디에서 못잡는다           //
			// 버튼 클릭시 나오는 태그이므로 버튼클릭 메소드 안에 잡아준다  //
			////////////////////////////////////////////
			// 옵션 지우기를 눌렀을 떄 //
			$("img#close").click(function(){
				
				// 지운만큼 추가하게 해준다
				cnt--;
				// 지우는 tr id
				var delnum = $(this).next().val();
				// 우선 해당태그 내용 지우기
				$("tr#"+delnum).html("");
				// 차곡차곡 내려오게 하기
				// 지운 숫자가 어떤 것인가
				if(delnum == 1){
					$("tr#"+delnum).html( $("tr#"+delnum+1).html() );
					$("tr#"+delnum+1).html( $("tr#"+delnum+2).html() );
					$("tr#"+delnum+2).html( $("tr#"+delnum+3).html() );
					$("tr#"+delnum+3).html("");
				}
				else if(delnum == 2){
					$("tr#"+delnum).html( $("tr#"+delnum+1).html() );
					$("tr#"+delnum+1).html( $("tr#"+delnum+2).html() );
					$("tr#"+delnum+2).html("");
				}
				else if(delnum == 3){
					$("tr#"+delnum).html( $("tr#"+delnum+1).html() );
					$("tr#"+delnum+1).html("");
				}
				
			});//end of $("img#close").click(function(){--------------------------
			
		});//end of $("img#plus").click(function(){-------------------------------
		
		
		$("button#gg").click(function(){
			
			alert("dd"); 
			
		});
		
		
		
		
		
	});//end of $(docunment).ready(function(){
		
	
</script>
<button id="gg">fgsfds</button>
<button id="hh">fgsfds</button>
<!-- 리뷰 및 게시판 들어가는 곳 -->
<div id="container" style="width:1000px; margin:100px 300px; font-family:맑은 고딕;">
	<!-- 구매창 넣기 -->
	<table id="buy" style="margin:50px 0px;">
		<tr>
			<td id="insertimg"><img style="height:800px;" id="chun" src="http://www.romanticmove.com/web/product/extra/big/20200310/7b5003d754dc86e763e2550bc98192ae.jpg"/></td>
			<td id="buy" style="width:700px; height:800px;">
				<table id="inbuy" style="width:420px; height:800px; margin-left:50px;">
					<tr style="height:80px;">
						<td colspan="2" style="padding:0px 5px; width:450px; height:60px; text-align:left; font-size:14pt; font-weight:bold; color:black; border-bottom:solid 1px gray;">
							<span id="product_name">제품명</span><br>
							<span id="product_ceil_price" style="font-size:13pt; color:red;">140,000</span>&nbsp;
							<span style="font-size:10pt; color:gray;">/</span>
							<span id="product_price" style="font-size:10pt; color:gray;">180,000</span>
							<span><img id="plus" src="/SemiProject/images/plus.png" style="width:30px; height:30px; margin-left:165px;"/></span>
							<span><img id="cart" src="/SemiProject/images/cart.jpg" style="width:50px; height:50px;"></span>
						</td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:10pt; color:black; padding-left:7px; border-bottom:solid 1px gray;">적립금</td>
						<td style="width:300px; font-size:10pt; padding-left:20px; border-bottom:solid 1px gray;"><span>1,800원 (10%)</span><span style="margin-left:145px; font-size:9pt; color:gray;">포인트사용<img src="/SemiProject/images/point.png" style="width:40px; height:35px;"></span></td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;">사이즈</td>
						<td style="width:300px; padding:0px 10px;">
							<select id="optselect1" style="border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;" onclick="flag1();">
								<option>- [필수]옵션을 선택 해주세요 -</option>
								<option disabled="disabled">---------------------</option>
								<option>240</option>
								<option>250</option>
								<option>260</option>
								<option>270</option>
								<option>280</option>
								<option>290</option>
								
							</select>
						</td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;">볼너비</td>
						<td style="width:300px; padding:0px 10px;">
							<select id="optselect2" style="border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;" onclick="flag2();">
								<option>- [필수]옵션을 선택 해주세요 -</option>
								<option disabled="disabled">---------------------</option>
								<option>보통</option>
								<option>넓음</option>
							</select>
						</td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;">키높이</td>
						<td style="width:300px; padding:0px 10px;">
							<select id="optselect3" style="border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;" onclick="flag3();">
								<option>- [필수]옵션을 선택 해주세요 -</option>
								<option disabled="disabled">---------------------</option>
								<option>선택안함</option>
								<option>안굽 1cm추가 (+5,000원)</option>
							</select>
						</td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:8pt; color:black; padding-left:7px;">아웃솔변경</td>
						<td style="width:300px; padding:0px 10px;">
							<select id="optselect4" style="border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin-left:5px;" onclick="flag4();">
								<option>- [필수]옵션을 선택 해주세요 -</option>
								<option disabled="disabled">---------------------</option>
								<option>선택안함</option>
								<option>워커창(러버솔) 변경(교환불가옵션 +10,000원)</option>
								<option>가죽창(레더솔) 변경(교환불가옵션 +40,000원)</option>
							</select>
						</td>
					</tr>
					<tr style="height:50px;">
						<td colspan="2" style="text-align:center; background-color:black; color:white;">BUY NOW</td>
					</tr>
					<tr id="1" style="height:105px; border-bottom:solid 1px gray;">
						<!-- 구매목록이 들어가는 곳 -->
					</tr>
					<tr id="2" style="height:105px; border-bottom:solid 1px gray;">
						<!-- 구매목록이 들어가는 곳 -->
					</tr>
					<tr id="3" style="height:105px; border-bottom:solid 1px gray;">
						<!-- 구매목록이 들어가는 곳 -->
					</tr>
					<tr id="4" style="height:105px; border-bottom:solid 1px gray;">
						<!-- 구매목록이 들어가는 곳 -->
					</tr> 
				</table>
			</td>
		</tr>	
	</table>	
</div>
	
<hr style="border:solid 1px gray; width:1000px; margin:0px 300px;">	
	
	<!-- 제품 긴 사진 들어가는 곳 -->
<div id="picture" style="margin:50px 300px;">
	<img class="chun" src="http://www.romanticmove.com/web/2020/R14M008/R14M008%20smart_navy_2.jpg"/>
</div>
	
	
<div id="container2" style="width:1000px; margin:100px 300px; font-family:맑은 고딕;">	
	<hr style="border:solid 1px gray; margin:0px 0px 80px 0px;">
	
	<!-- 리뷰넣기 -->
	<div style="font-size:10pt; color:black;">
		REVIEW | 문의글 혹은 악의적인 비방글은 무통보 삭제됩니다
	</div>
	<input id="text" type="text" style="width:1000px; height:150px; border:solid 1px gray;"/>
	<!-- 버튼 -->	
	<div id="buttons" style="margin:20px 0px 15px 0px;">
		<input type="file" id="insertpicture" style="display:inline-block; width:200px; height:30px; margin-right:5px; border:solid 1px gray; font-size:10pt;"/>
		<select id="insertstar" style="width:550px; height:30px; margin-right:5px; padding:0px 5px; text-align:left;">
			<option>★★★★★&nbsp;매우만족해요</option>
			<option>★★★★☆&nbsp;만족해요</option>
			<option>★★★☆☆&nbsp;보통이에요</option>
			<option>★★☆☆☆&nbsp;불만족해요</option>
			<option>★☆☆☆☆&nbsp;매우불만족해요</option>
		</select>
		<span id="insertreview" style="display:inline-block; width:150px; height:30px; margin:0px 5px 0px 0px; border:solid 1px gray; text-align:center; font-size:12pt; color:white; background-color:black;">
Confirm</span>
		<span id="insertreviewword"></span>
	</div>
	
	<!-- 리뷰관련 -->
	<table id="review" style="border:solid 1px gray;">
		<tr>
			<td id="ofreview1" style="width:150px; text-align:center; font-size:10pt;">
				<div id="percent" style="background-color:black; color:white; font-size:35pt; width:100px; height:80px; margin:10px 30px 0px 30px; text-align:center;">0.0</div>
				<div id="jumsu" style="text-align:center; font-size:10pt; color:black;">n개의 리뷰평점</div>
			</td>
			<td id="ofreview2" style="width:500px; margin:0px 10px; color:black;">
				<div id="5stars">5 Stars<img><br><span></span></div>
				<div id="4stars">4 Stars<img><br><span></span></div>
				<div id="3stars">3 Stars<img><br><span></span></div>
				<div id="2stars">2 Stars<img><br><span></span></div>
				<div id="1stars">1 Stars<img><br><span></span></div>
			</td>
			<td id="ofreview3" style="width:350px;">
				<img><img><img><img><br>
				<img><img><img><img>
				<div id="reviewandphoto" style="text-align:center;">이 상품의 포토/동영상 모아보기</div>
			</td>
		</tr>
	</table>
	
	<hr style="border:solid 1px gray; margin:80px 0px 80px 0px;">
	
	<table style="width:1000px;">
		<tr>
			<td colspan="2" style="height:40px; border-bottom:solid 1px gray;"><span id="newreview">최신순리뷰</span>&nbsp;|&nbsp;<span id="goodreview">추천순리뷰</span></td>
		</tr>
		<tr style="border-bottom:solid 1px gray;">
			<td style="height:210px; width:800px;">
				<div style="font-size:10pt; color:black;">
					리뷰내용 호호호 잘썻어요
				</div>
				<div style="font-size:10pt; color:black;">
					| 1개의 댓글이 있습니다. |
				</div>
			</td>
			<td>
				<div id="writer">작성자 : 누구</div>
				<div id="writeday">작성일자 : 언제</div>
				<div id="writewhat"">제품속성 : 무엇</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center; height:100px;"><span id="num1">1</span>&nbsp;<span id="num2">2</span>&nbsp;<span id="num3">3</span></td>
		</tr>
	</table>
</div>	
	
	





<jsp:include page="/WEB-INF/footer.jsp" />
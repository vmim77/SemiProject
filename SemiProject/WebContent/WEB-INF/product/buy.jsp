<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   String ctxPath = request.getContextPath();
%>    

<meta charset="utf-8">
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">
	
	div{
		    /* border:solid 1px red;     */

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
	// 옶션 가격 더해줄 값
	var plusopt1 = 0;
	var plusopt2 = 0;
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
	// 옵션 총합 지역변수 방지
	var finopt = 0;
	// 최대 갯수
	var cnt = 0;
	// 테이블 태그의 키값
	var key = 0;
	// 적립금 지역변수 방지
	var jukrib = 0;
	// 리뷰내용 작성했는지 확인
	var flagtext = false;
	// 주문번호 골랐는지 확인
	var flagjumun = false;
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
		if(opt3 == "안굽 1cm추가 (+5,000원)"){
			plusopt1 = 5000;
		}
		else{
			plusopt1 = 0;
		}
	}
	function flag4(){
		opt4 = $("select#optselect4").val();
		fg4 = true;
		if(opt4 == "워커창(러버솔) 변경(교환불가옵션 +10,000원)"){
			plusopt2 = 10000;
		}
		else if(opt4 == "가죽창(레더솔) 변경(교환불가옵션 +40,000원)"){
			plusopt2 = 40000;
		}
		else{
			plusopt2 = 0;
		}
	}
	// 수량 늘려주기
	function flag5(){
		num = $("input#num").val();
	}
	// 평점을 얼마나 적었는지
	function flagstar(){
		
		if($("select#insertstar").val() == "★★★★★ 매우만족해요"){
			$("input#whatstar").val("5");
		}
		else if($("select#insertstar").val() == "★★★★☆ 만족해요"){
			$("input#whatstar").val("4");		
		}
		else if($("select#insertstar").val() == "★★★☆☆ 보통이에요"){
			$("input#whatstar").val("3");
		}
		else if($("select#insertstar").val() == "★★☆☆☆ 불만족해요"){
			$("input#whatstar").val("2");
		}
		else{
			$("input#whatstar").val("1");
		}
	
	}
	// 주문 번호를 골랐는가
	function flagjumunbunho(){
		
		if($("select#selectjumun").val() == "주문번호 선택"){
			flagjumun = false;
		}
		if($("select#selectjumun").val() != "주문번호 선택"){
			flagjumun = true;
		}
	}
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
		
	/////////////////////////////////////////////////////////////////////////////////////
		
	$(document).ready(function(){
		
		// 새로고침 방지
		document.onkeydown = noRefresh ;
		
		// 초기 가격 설정해주기
		var orgpcd = $("span#product_ceil_price").html();
		var pcd = orgpcd.replace(",","");
		
		// 적립금 값 저장
		jukrib = pcd*0.1;
		
		// 초기 포인트 가격 넣어주기
		$("span#pct").text("(10%) "+jukrib+"포인트");
		
		// 수량추가 버튼 눌렀을 때
		$(document).on("click", "input#num", function(){
			
			num = $(this).val();
			
			if(num==10){
				alert("수량은 최대 10개 까지만 구매 가능합니다..")
			}
			// 수량 당 곱해주기
			var xpcd = num*pcd;
			var xopt = num*finopt;
			// 수량 당 신발 값
			$(this).parent().find(".cartprice").text(xpcd+"원");
			// 수량 당 옵션 값
			$(this).parent().find(".cartfinopt").text("+ "+xopt+"원");
			// 수량 당 포인트
			jukrib = pcd*num*0.1;
			$("span#pct").text("(10%) "+jukrib+"포인트");
			
			
		});//end of $(document).on("click", "input#num", function(){
			
		// 추가하기 버튼 눌렀을 때
		$(document).on("click", "span#plus", function(){
			// 옵션 값 더하기
			finopt = plusopt1 + plusopt2;
			// 각각의 고유한 키값
			key++;
			
			// 각각 옵션을 선택한 경우
			if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
				
				var html = "<div>" 
								+"<table id='"+key+"' style='height:72px; margin-bottom:12px;'>"
									+"<tr>"
										+"<td style='width:300px;'>"
											+"<div style='text-align:left; font-size:9pt; color:black;'>"
												+"<div style='font-weight:bold;'>"+ $("span#product_name").text() +"</div>"
												+"<div class='cartopt123'>"+opt1+"/"+opt2+"/"+opt3+"</div>"
												+"<div class='cartopt4'>/"+opt4+"</div>"
											+"</div>"
										+"</td>"
										+"<td style='width:140px; text-align:right; font-size:10pt;'>"
											+"<input id='num' class='cartnum' type='number' min='1' value='1' max='10' style='width:40px; height:20px; text-align:left;'/>"
											+"<img id='close' src='/SemiProject/images/close.png' style='width:20px; height:20px;'/>"
											+"<input class='tblkey' type='hidden' value='"+key+"'/>"
											+"<div id='upprice' class='cartprice'>"+pcd+"원</div>"
											+"<div class='cartfinopt'>+ "+finopt+"원</div>"
											+"<input type='hidden' class='num_cartprice' name='num_cartprice' value='"+pcd+"'/>"
											+"<input type='hidden'  class='num_cartfinopt' name='num_cartfinopt' value='"+finopt+"'/>"
										+"</td>"	
									+"</tr>"
									+"<tr>"
										+"<td colspan='2'>"
											+"<span id='buynow' style='display:inline-block; border:solid 1px black; margin-right:5px; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:206px; padding-top:5px'>BUY NOW</span>"
											+"<span id='cart' style='display:inline-block; border:solid 1px black; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:205px; padding-top:5px'>CART</span>"
											+"<input class='cartkey' type='hidden' value='"+key+"'/>"
										+"</td>"
									+"</tr>"
								+"</table>"
							+"</div>";
					
				// 지울때 갯수를 측정하기 위함
				// 아무 태그나 잡음
				cnt = $(".cartprice").size();			
									
				if(cnt<4){		
					// div에 append
					$("div#inthis").append(html);	
				}
				else{
					cnt = 4;
					alert("최대 4까지 담을 수 있습니다.");	
				}
				
			}
			else{
				alert("옵션을 모두 선택 후 추가 해주세요.");
			}//end of if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
			
			////////////////////////////////////////////
			// 나중에 추가되는 태그므로 도큐멘트.레디에서 못잡는다           //
			// 버튼 클릭시 나오는 태그이므로 버튼클릭 메소드 안에 잡아준다  //
			////////////////////////////////////////////
			// 옵션 지우기를 눌렀을 떄 //
			$("img#close").click(function(){
				
				// 키값을 가져오기 위함
				var tblkey = $(this).parent().find(".tblkey").val();
				$("table#"+tblkey).remove();
				// 지운만큼 추가하게 해준다
				cnt--;
				
			});//end of $("img#close").click(function(){--------------------------
			
		});//end of $(document).on("click", "span#plus", function(){------------
		
		// 장바구니로 연결하기
		$(document).on("click", "span#cart", function(){

			// 키값을 가져오기 위함
			var cartkey = $(this).parent().find(".cartkey").val();
			console.log(cartkey);
			// 장바구니를 선택한 태그 내의 내용을 옮겨주기 위하여 변수생성
			var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
			var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
			var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
			var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
			var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
			var num_cartprice = $("table#"+cartkey).parent().find("input.num_cartprice").val();
	        var num_cartfinopt = $("table#"+cartkey).parent().find("input.num_cartfinopt").val();
			
	        // 장바구니로 넘겨주기 위한 hidden 타입의 input 태그 생성
			// 넘기는 내용
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			var gocart = "<input type='hidden' name='product_front_p1' value='"+"${pvo.product_first_p}"+"'/>"
						+"<input type='hidden' name='cartname'   value='"+$("span#product_name").text()+"'/>"
					    +"<input type='hidden' name='cartopt123' value='"+cartopt123+"'/>"
					    +"<input type='hidden' name='cartopt4'   value='"+cartopt4+"'/>"	
					    +"<input type='hidden' name='cartnum'    value='"+cartnum+"'/>"	
					    +"<input type='hidden' name='cartprice'  value='"+cartprice+"'/>"
					    +"<input type='hidden' name='jukrib'  value='"+jukrib+"'/>"
					    +"<input type='hidden' name='cartfinopt' value='"+cartfinopt+"'/>"
					    +"<input type='hidden' name='frm_num_cartprice' value='"+num_cartprice+"'/>"
		                +"<input type='hidden' name='frm_num_cartfinopt' value='"+num_cartfinopt+"'/>";

			$("form#buyorcart").append(gocart);

			var frm = document.gogocart;
			frm.action = "<%= ctxPath%>/cart.sh";
			frm.method = "post";
			frm.submit();	  
			
			// 장바구니 전송 후 지우기
			$("table#"+cartkey).remove();
			// 장바구니 전송을 위해 만든 input 지우기
			$("form#buyorcart").empty(); 

		});//end of $(document).on("click", "button#cart", function(){-----------	
				
		// 리뷰 작성시 글자수 보여주기	
		$("textarea#text").keyup(function(){
			
			var wordcount = $(this).val();
			$("span#insertreviewword").text(wordcount.length); 
			
			// 100글자 넘어가면
			if(wordcount.length > 200){
				alert("최대 200글자 까지 작성 가능합니다");
			}
			
		});//end of $("input#text").keyup(function(){--------------------------------	
		
		// 구매창으로 연결하기
		$(document).on("click", "span#buynow", function(){
		
			// 키값을 가져오기 위함
			var cartkey = $(this).parent().find(".cartkey").val();
			
			// 장바구니를 선택한 태그 내의 내용을 옮겨주기 위하여 변수생성
			var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
			var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
			var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
			var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
			var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
			// 장바구니로 넘겨주기 위한 hidden 타입의 input 태그 생성
			// 넘기는 내용
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			var gocart = "<input type='hidden' name='product_front_p1' value='"+"${pvo.product_first_p}"+"'/>" 
						+"<input type='hidden' name='cartname'   value='"+$("span#product_name").text()+"'/>"
					    +"<input type='hidden' name='cartopt123' value='"+cartopt123+"'/>"
					    +"<input type='hidden' name='cartopt4'   value='"+cartopt4+"'/>"	
					    +"<input type='hidden' name='cartnum'    value='"+cartnum+"'/>"	
					    +"<input type='hidden' name='cartprice'  value='"+cartprice+"'/>"
					    +"<input type='hidden' name='jukrib'  value='"+jukrib+"'/>"
					    +"<input type='hidden' name='cartfinopt' value='"+cartfinopt+"'/>";
					  				    
			$("form#buyorcart").append(gocart);

			var frm = document.gogocart;
			frm.action = "<%= ctxPath%>/detailstore.sh";
			frm.method = "post";
			frm.submit();
			
			// 장바구니 전송 후 지우기
			$("table#"+cartkey).remove();
			// 장바구니 전송을 위해 만든 input 지우기
			$("form#buyorcart").empty(); 
			
		});//end of $(document).on("click", "button#buynow", function(){-----------	
				
		// 리뷰 작성시 글자수 보여주기	
		$("textarea#content").keyup(function(){
			
			var wordcount = $(this).val();
			$("span#insertreviewword").text(wordcount.length); 
			
			// 100글자 넘어가면
			if(wordcount.length > 200){
				alert("최대 200글자 까지 작성 가능합니다");
				return;
			}
			
		});//end of $("input#text").keyup(function(){--------------------------------		
	
		//////////////////////////////////////////////////////////////////////////////
		////////////////////////////// 여기서부터 리뷰 관련 기능 //////////////////////////////
		 
		// 리뷰내용 넣게하기
		$("textarea#content").blur(function(){
			
			var bool = $(this).val();
			
			if(bool == ""){
				flagtext = false;
			}
			else{	
				flagtext = true;
			}
			
		});//$("input#detailAddress").blur(function(){--------------------------------
		
		// 리뷰 보내기
		$("button#insertreview").click(function(){
			
			var checkidnull = "${requestScope.checkidnull}";
			
			if(checkidnull == "no"){
				alert("로그인 후 이용가능한 서비스 입니다");
				location.href = "<%= ctxPath%>/login/login.sh";
			}
			else{
				
				// 제품 구매내역이 있다면
				if("${requestScope.not_review}" != "not_review"){
				
					if(flagtext == true && flagjumun == true){
						// 보내기전 담아주기
						alert("고객님의 소중한 리뷰 감사합니다.");
						$("input#content").val($("textarea#content").val());
						$("input#jumun_bunho").val($("select#selectjumun").val());
						
						var frm = document.gogoreview;
						frm.action = "<%= ctxPath%>/buy.sh";
						frm.method = "post";
						frm.submit();
					}
					else if(flagtext == true && flagjumun == false){
						alert("주문번호를 확인 해주세요");
						$("select#selectjumun").focus();
					}
					else if(flagtext == false && flagjumun == true){
						alert("리뷰내용 작성 부탁드립니다.");
						$("textarea#content").focus();
					}
					else{
						alert("리뷰내용 작성 및 주분번호 선택 부탁드립니다.");
						$("textarea#content").focus();
					}//end of if(flagtext == true){-------- 
				
				}
				else{
				
					alert("리뷰를 작성 하셨거나 구매내역이 없습니다.");
					
				}//end of if("${requestScope.pbvo.checknull}" == "nonull"){
					
			}//end of if("{SessionScope.userid}" == ""){----------
			 
		});//end of $("button#isertreview").click(function(){----------------------- 	
		
		////////////////////////////////////////////////////////////////////////////
		
		var five  = "${starMap.five_stars}";
		var four  = "${starMap.four_stars}";
		var three = "${starMap.three_stars}";
		var two   = "${starMap.two_stars}";
		var won   = "${starMap.won_stars}";
		
		// 5stars 평점 막대그래프 넣기
		for(var i=0; i<=90; i+=10){
		
			if(i < five && five <= i+10){
				$("div#5stars").html("5 Stars<img style='height:20px; width:400px;' src='images/"+(i+10)+".jpg'/><span style='font-size:9pt;'>("+(i+10)+"%)</span>");	
			}
			if(five == 0){
				$("div#5stars").html("5 Stars<img style='height:20px; width:400px;' src='images/10.jpg'/><span style='font-size:9pt;'>(0%)</span>");
			}//end of if---------------------
			
		}//end of for------------------------
		
		// 4stars 평점 막대그래프 넣기
		for(var i=0; i<=90; i+=10){
		
			if(i < four && four <= i+10){				
				$("div#4stars").html("4 Stars<img style='height:20px; width:400px;' src='images/"+(i+10)+".jpg'/><span style='font-size:9pt;'>("+(i+10)+"%)</span>");				
			}
			if(four == 0){
				$("div#4stars").html("4 Stars<img style='height:20px; width:400px;' src='images/10.jpg'/><span style='font-size:9pt;'>(0%)</span>");
			}//end of if---------------------
			
		}//end of for------------------------
		
		// 3stars 평점 막대그래프 넣기
		for(var i=0; i<=90; i+=10){		
			if(i < three && three <= i+10){
				$("div#3stars").html("3 Stars<img style='height:20px; width:400px;' src='images/"+(i+10)+".jpg'/><span style='font-size:9pt;'>("+(i+10)+"%)</span>");				
			}
			if(three == 0){
				$("div#3stars").html("3 Stars<img style='height:20px; width:400px;' src='images/10.jpg'/><span style='font-size:9pt;'>(0%)</span>");
			}//end of if---------------------
			
		}//end of for------------------------
		
		// 2stars 평점 막대그래프 넣기
		for(var i=0; i<=90; i+=10){
		
			if(i < two && two <= i+10){				
				$("div#2stars").html("2 Stars<img style='height:20px; width:400px;' src='images/"+(i+10)+".jpg'/><span style='font-size:9pt;'>("+(i+10)+"%)</span>");				
			}
			if(two == 0){
				$("div#2stars").html("2 Stars<img style='height:20px; width:400px;' src='images/10.jpg'/><span style='font-size:9pt;'>(0%)</span>");
			}//end of if---------------------
			
		}//end of for------------------------
		
		// 1stars 평점 막대그래프 넣기
		for(var i=0; i<=90; i+=10){
		
			if(i < won && won <= i+10){				
				$("div#1stars").html("1 Stars<img style='height:20px; width:400px;' src='images/"+(i+10)+".jpg'/><span style='font-size:9pt;'>("+(i+10)+"%)</span>");				
			}
			if(won == 0){
				$("div#1stars").html("1 Stars<img style='height:20px; width:400px;' src='images/10.jpg'/><span style='font-size:9pt;'>(0%)</span>");
			}//end of if---------------------
			
		}//end of for------------------------
		
		/////////////////////////////////////////////////////////////////////////////
		
		// 잠시 숨기기
		$("div#view_close").hide();
		// 전체리뷰개수
		var rvcnt = "${requestScope.Review_cnt}"*1;
		// 클릭갯수
		var ckcnt = 1;
		
		// 페이지 로드시 일정 갯수 이상의 리뷰는 숨겨주기
		for(var i=0; i<rvcnt; i++){
			if(i>2){
				$("tr#"+i).hide();
			}	
		}//end of for----------------------------------
		
		// view more 클릭시
		$("div#view_more").click(function(){
			// 끝까지 view more를 했다면
			if((ckcnt+1)*3>rvcnt){
				$("div#view_more").hide();
				$("div#view_close").show();
			}
			// 3개씩 끊어서 보여주기
			for(var i=0; i<(ckcnt+1)*3; i++){
				$("tr#"+i).show();
			}
			// 클릭 갯수 올리기
			ckcnt++;			
		});//end of $("div#view_more").click(function(){
			
		// view close 클릭시
		$("div#view_close").click(function(){
			// 초기화 해주기
			ckcnt = 1;
			// 보여준거 숨기기
			for(var i=0; i<rvcnt; i++){
				if(i>2){
					$("tr#"+i).hide();
				}	
			}//end of for----------------------------------
			// 다시 원래대로 돌리기
			$("div#view_more").show();
			$("div#view_close").hide();		
		});//end of $("div#view_more").click(function(){	
		
		////////////////////////////////////////////////////////////////////////	
			
		// 댓글보기 모달 클릭시
		$("button#lookdatgle").click(function(){
		
			// 전에 댓글내용 우선 지워주기
			$("div#in_review_comment").html("");	
			
			// 모달창이 알아서 열리지만 굳이 이벤트를 만들어주는 이유는
			// 해당 댓글을 작성한 작성자의 리뷰내용과 옵션을 넣어주기 위함이다
			
			// 인풋 히든으로 몰래 숨겨두었다. 후후
			var modal_opt = $(this).next().val();
			var modal_ctt = $(this).next().next().val();
			var modal_img = $(this).next().next().next().next().val();
			
			// 해당 댓글의 리뷰 옵션내용
			$("div#modal_option").text(modal_opt);
			// 해당 댓글의 리뷰 내용
			$("div#modal_content").text(modal_ctt);
			// 해당 댓글의 사진
			var modal_img_html = "<img style='height:400px; width:400px;' src='<%= ctxPath%>/images/"+modal_img+"'/>";
			$("div#modal_img").html(modal_img_html);
			
			///////////////////////////////////////////////////////////////////
			
			// 아래부터는 댓글 가져오기
			
			// 혹시 모르니 비워주고
			$("input#what_reviewno").val("");
			// 어떤 리뷰를 눌럿는지
	 		var what_reviewno = $(this).next().next().next().val();
			// 값 담아주기
			// 아래 에이젝스 를 위해 만듬
			$("input#what_reviewno").val(what_reviewno);
			
	 		// 값 받아오기
	 		$.ajax({
	 			url:"<%= ctxPath%>/datgle.sh",
	 			data:{"what_reviewno":what_reviewno},
	 			dataType:"json",
	 			success: function(json){
	 		 		
	 		   		// 댓글 넣어주기
	 				$.each(json, function(index, item){
	 					
	 					if(item.review_text == null){
	 						
	 						var dhtml = "<div style='padding:100px 0px 0px 12px; font-size:10pt; height:30px; text-align:center;'>"+
	 										"댓글이 없습니다"+					
	 									"</div>";
	 						$("div#in_review_comment").append(dhtml);		
	 					}
	 					else{
	 				
	 						var dhtml =  "<div style='padding:10px 0px 0px 10px; font-size:10pt; height:30px;'>"+
	 								 		item.fk_userid +":"+ item.review_text +
	 								 	"</div>";
	 						$("div#in_review_comment").append(dhtml);		 
	 					}//end of if-------------------------------------
	 			 
	               }); //end of $.each(json)----------------------------------------------------------------
	            
	 			},
	 			error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}
	 			
	 		});//end of $.ajax({-----------------------------------------------------
			
		});//end of $("button#lookdatgle").click(function(){-------------------------
			
		/////////////////////////////////////////////////////////////////////////////
		
		// 댓글 전송 관련
		
		// 댓글 작성시 글자수 보여주기	
		$("input#datgle_text").keyup(function(){
			
			var datglecount = $(this).val();
			$("span#datgle_length").text(datglecount.length); 
			
			// 100글자 넘어가면
			if(datglecount.length > 30){
				alert("최대 30글자 까지 작성 가능합니다");
				return;
			}
			
		});//end of $("input#datgle_text").keyup(function(){----------------------
		
		// 댓글전송하기 클릭 시
		$("button#datgle_submit").click(function(){
		
			// 조건
			var jogun = 0;
			// 로그인 상태인가?
			if("${requestScope.userid}"!=""){
				jogun++;		
			}
			else{
				alert("로그인 후 이용 가능합니다");
				location.href = "<%= ctxPath%>/login/login.sh";
			}
			// 댓글내용을 작성하였는가?
			if($("input#datgle_text").val()!=""){
				jogun++;		
			}
			else{
				alert("댓글 내용을 작성 해주세요");
				$("input#datgle_text").focus();
			}
			// 댓글 길이의 수가 조건에 충족하는가		
			if($("input#datgle_text").val().length <= 30){
				jogun++;		
			}
			// 올바른 전송시
			if(jogun == 3){
				
				// 전에 댓글내용 우선 지워주기
				$("div#in_review_comment").html("");
				
				// 아까 넣어줬던 리뷰넘버 사용하기
				// 두 에이젝스 공용사용 변수
				var what_reviewno = $("input#what_reviewno").val();
			
				// 댓글전송을 위한 변수
				var userid = "${requestScope.userid}";
				var review_text = $("input#datgle_text").val();
				
				// 값 받아오기
		 		$.ajax({
		 			url:"<%= ctxPath%>/datgle.sh",
		 			data:{"what_reviewno":what_reviewno,"userid":userid,"review_text":review_text},
		 			dataType:"json",
		 			success: function(json){
		 		 		
		 			},
		 			error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
				}
		 			
		 		});//end of $.ajax({-----------------------------------------------------
				
		 		// 댓글 올리고 내용 지워주기
		 		$("input#datgle_text").val("");
		 			
				/////////////////////////////////////////////////////////////////////
				
				// 값 받아오기
		 		$.ajax({
		 			url:"<%= ctxPath%>/datgle.sh",
		 			data:{"what_reviewno":what_reviewno},
		 			dataType:"json",
		 			success: function(json){
		 		 	
		 			// 댓글 넣어주기
	 				$.each(json, function(index, item){
	 					
	 					if(item.review_text == null){
	 						
	 						var dhtml = "<div style='padding:100px 0px 0px 12px; font-size:10pt; height:30px; text-align:center;'>"+
	 										"댓글이 없습니다"+					
	 									"</div>";
	 						$("div#in_review_comment").append(dhtml);		
	 					}
	 					else{
	 				
	 						var dhtml =  "<div style='padding:10px 0px 0px 10px; font-size:10pt; height:30px;'>"+
	 								 		item.fk_userid +":"+ item.review_text +
	 								 	"</div>";
	 						$("div#in_review_comment").append(dhtml);		 
	 					}//end of $.each(json, function(index, item){---------------------------------------
		 				
	 				}); //end of $.each(json)----------------------------------------------------------------		
	 						
		 			},
		 			error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
				}
		 			
		 		});//end of $.ajax({-----------------------------------------------------
			
			}//end of if----------------------------
			
		});//end of $("button#datgle_submit").click(function(){----------------------
		
		// 댓글지우기 클릭 시
		$("button#datgle_close").click(function(){
			// 안의 내용 다 지워주기
			$("input#datgle_text").val("");
		});//end of $("button#datgle_submit").click(function(){----------------------	
			
	});//end of $(docunment).ready(function(){---------------------------------------
		

	
</script>
<!-- 리뷰 및 게시판 들어가는 곳 -->
<div id="container" style="width:1000px; margin:100px 300px; font-family:맑은 고딕;">
	<!-- 구매창 넣기 -->
	<table id="buy" style="margin:50px 0px;">
		<tr>
			<td id="insertimg"><img style="height:850px;" id="chun" src="${pvo.product_first_p}"/></td>
			<td id="buy" style="width:700px; height:800px;">
				<table id="inbuy" style="width:420px; height:850px; margin-left:40px;">
					<tr style="height:80px;">
						<td colspan="2" style="padding:0px 5px; width:450px; height:60px; text-align:left; font-size:14pt; font-weight:bold; color:black; border-bottom:solid 1px gray;">
							<span id="product_name">${pvo.product_name}</span><br>
							<span id="product_ceil_price" style="font-size:13pt; color:red;">${pvo.product_ceil_price}</span>&nbsp;
							<span style="font-size:10pt; color:gray;">/</span>
							<span id="product_price" style="padding:10px; font-size:10pt; color:gray;"><del>${pvo.product_price}</del></span>
						</td>
					</tr>
					<tr style="height:50px;">
						<td style="width:150px; text-align:left; font-size:10pt; color:black; padding-top:7px; padding-left:7px;">적립금</td>
						<td style="width:300px; font-size:10pt; padding-left:20px; padding-top:5px;"><span id="pct" style="color:red; display:inline-block; width:200px;"></span></td>
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
						<td colspan="2">
							<span id="plus" style="text-align:center; display:inline-block; background-color:black; color:white; height:50px; width:420px;padding-top:13px;">ADD</span>
						</td>
					</tr>
					<tr style="height:380px;">
						<td colspan="2">
							<div id="inthis" style="height:430px; width:420px;">
								<!-- 구매 목록이 들어가는 곳 -->
							</div>
						</td>
					</tr> 
				</table>
			</td>
		</tr>	
	</table>	
</div>
	
<hr style="border:solid 1px gray; width:1000px; margin:0px 300px;">	
	
	<!-- 제품 긴 사진 들어가는 곳 -->
<div id="picture" style="margin:50px 300px;">
	<img class="chun" src="${pvo.product_second_p}"/>
</div>
	
	
<div id="container2" style="width:1000px; margin:100px 300px; font-family:맑은 고딕;">	
	<hr style="border:solid 1px gray; margin:0px 0px 80px 0px;">
	
	<!-- 리뷰넣기 -->
	<div style="margin-bottom:5px;">
		<span style="text-aling:left; display:inline-block; width:880px; font-size:10pt; color:black; margin-bottom:5px;">REVIEW | 문의글 혹은 악의적인 비방글은 무통보 삭제됩니다</span>
		<button id="btnpoint" type="button" style="font-size:10pt; background-color:#efeff5; width:110px; height:30px; text-align:center; font-size:9pt;" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">구매내역 조회</button>
	</div>
	<!-- 리뷰 작성 할 때 잠시 값을 저장시켜 주는 곳 -->	
	<form name="gogoreview" enctype="multipart/form-data">
		<textarea id="content" style="width:1000px; height:150px; border:solid 1px gray; resize:none;"></textarea>
		<!-- 버튼 -->	
		<div style="margin:20px 0px 15px 0px;">
			<input type="file" id="insertpicture" name="insertpicture" style="display:inline-block; width:200px; height:29px; margin-right:5px; border:solid 1px gray; font-size:10pt;"/>
			<select id="insertstar" style="width:350px; height:30px; margin-right:5px; padding:0px 5px; font-size:10pt;" onclick="flagstar();">
				<option>★★★★★ 매우만족해요</option>
				<option>★★★★☆ 만족해요</option>
				<option>★★★☆☆ 보통이에요</option>
				<option>★★☆☆☆ 불만족해요</option>
				<option>★☆☆☆☆ 매우불만족해요</option>
			</select>
			<select id="selectjumun" style="width:200px; height:30px; margin-right:5px; padding:0px 5px; font-size:10pt;" onclick="flagjumunbunho();">
				<option>주문번호 선택</option>
				<c:if test="${empty requestScope.buyList || requestScope.checkidnull eq 'no'}">
					<option disabled="disabled">조회 내역이 없습니다.</option>
				</c:if>
				
				<c:if test="${not empty requestScope.buyList && requestScope.checkidnull ne 'no'}">
					<c:forEach var="buyList" items="${requestScope.buyList}">
						<option>${buyList.jumun_bunho}</option>
					</c:forEach>
				</c:if>
			</select>
			<span id="insertreviewword"></span>
			<input id="whatstar" name="whatstar" type="hidden" value="5"/>
			<input id="content" name="content" type="hidden" value=""/>
			<input id="retry_product_name" name="retry_product_name" type="hidden" value="${requestScope.product_name}"/>
			<input id="jumun_bunho" name="jumun_bunho" type="hidden" value=""/>
			<!-- 무작정 주소치고 들어오는거 방지 -->
			<input name="mujakjung" type="hidden" value="mujakjung"/>
		</div>
		</form>
			
		<button id="insertreview" style="width:150px; height:28px; margin-bottom:15px; border:solid 1px gray; text-align:center; font-size:11pt; color:white; background-color:black;">
			Confirm
		</button>	
		
	
	<!-- 리뷰관련 -->
	<table id="review" style="border:solid 1px gray; height:150px;">
		<tr>
			<td id="ofreview1" style="width:150px; text-align:center; font-size:10pt;">
				<div id="percent" style="background-color:black; color:white; font-size:35pt; width:100px; height:80px; margin:10px 30px 0px 30px; padding-top:5px; text-align:center;">
					<c:if test="${requestScope.Review_star eq 0}">
						0.0
					</c:if>
					<c:if test="${requestScope.Review_star ne 0}">
						<fmt:formatNumber value="${requestScope.Review_star / Review_cnt}" pattern=".0"/>
					</c:if>
				</div>
				<div id="jumsu" style="text-align:center; font-size:10pt; color:black; margin-top:5px;">${requestScope.Review_cnt}개의 리뷰평점</div>
			</td>
			<td id="ofreview2" style="width:500px; margin:0px 10px; color:black;">
				<div id="5stars"></div>
				<div id="4stars" style="margin-top:5px;"></div>
				<div id="3stars" style="margin-top:5px;"></div>
				<div id="2stars" style="margin-top:5px;"></div>
				<div id="1stars" style="margin-top:5px;"></div>
			</td>
			<td id="ofreview3" style="width:350px;">
				<div id="reviewandphoto" style="text-align:center; font-size:10pt;">이 상품의 포토/동영상 모아보기</div>
			</td>
		</tr>
	</table>
	
	<hr style="border:solid 1px gray; margin:80px 0px 80px 0px;">
	
	<table style="width:1000px;">
		<tr>
			<td colspan="2" style="height:40px; border-bottom:solid 1px gray;">
				<span id="newreview" style="font-size:10pt; margin-left:12px;">
					|&nbsp;&nbsp;&nbsp;&nbsp;최신순리뷰 &nbsp;&nbsp;&nbsp;|
				</span>
			</td>
		</tr>
		<c:if test="${empty requestScope.reviewList}">
			<tr>
				<td style="width:100px; height:200px; font-size:10pt; text-align:center; border-bottom:solid 1px gray;">
					등록된 리뷰가 없습니다.<br>
					첫 리뷰를 작성 해보세요!
				</td>
			</tr>
		</c:if>
		<c:if test="${not empty requestScope.reviewList}">
			<c:forEach var="reviewList" items="${requestScope.reviewList}" varStatus="index">
				<tr id="${index.index}" style="border-bottom:solid 1px gray;">
					<td>
						<img style="height:150px; width:150px;" src="<%= ctxPath%>/images/${reviewList.review_picture}"/>
					</td>
					<td style="height:150px; width:800px; font-size:10pt; color:black; padding-left:10px;">
						<div>
							${reviewList.review_content}
						</div>
						<div style="margin-top:10px;">
							<button id="lookdatgle" type="button" style="font-size:10pt; background-color:#efeff5; width:200px; height:30px; text-align:center; font-size:9pt;" class="btn btn-primary" data-toggle="modal" data-target="#fordatgleModal">댓글보기 및 작성</button>
							<input type="hidden" value="${reviewList.review_info}"/>
							<input type="hidden" value="${reviewList.review_content}"/>
							<input type="hidden" value="${reviewList.reviewno}"/>
							<input type="hidden" value="${reviewList.review_picture}"/>
						</div>
					</td>
					<td style="height:150px; width:200px; font-size:10pt; border-top:solid 1px gray;">
						<div id="writer" style="margin-top:10px;">작성자 : ${reviewList.fk_userid}</div>
						<div id="writeday" style="margin-top:10px;">작성일자 : ${reviewList.review_date}</div>
						<div id="writewhat" style="margin-top:10px;">옵션 : ${reviewList.review_info}</div>
					</td>
				</tr>
			</c:forEach>
		</c:if>	
	</table>
	<c:if test="${fn:length(reviewList) > 2}">
		<div id="view_more" style="text-align:center; font-size:13pt; font-weight:bold; margin-top:20px;">
			view more
		</div>
		<div id="view_close" style="text-align:center; font-size:13pt; font-weight:bold; margin-top:20px;">
			view close
		</div>
	</c:if>
</div>	

<!-- 장바구니 또는 구매 할 때 잠시 값을 저장시켜 주는 곳 -->
<form id="buyorcart" name="gogocart">

</form>	

<!-- 리뷰번호 숨겨주는곳 -->
<input name="what_reviewno" id="what_reviewno" type="hidden" value=""/>
	
<!-- 내 주문내역 모달 꾸미기 -->
<!-- //////////////////////////////////////////////////////////////////////// -->		
<div class="modal fade" id="exampleModal">
	<div class="modal-dialog">
		<div class="modal-content" style="width:1000px; margin-left:-250px">      
			<!-- Modal header -->
		    <div class="modal-header">
		    	<h5 class="modal-title">내 구매내역 조회</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		    </div>
		    <!-- Modal body -->
		    <div class="modal-body">
		    	<div id="container" style="text-align:center;">
			    	<!-- 여기서부터 디자인 시작 -->
			    	<table>
						<tr style="font-size:13pt; font-weight:bold; height:50px; text-align:left; padding-bottm:15px;">
							<td colspan="6" style="padding-left:15px;">
								상품정보
							</td>
						</tr>
						<tr style="background-color:#f5f5ef; border-bottom:solid 1px #d0d0e2; border-top:solid 1px #d0d0e2;">						
							<td style="width:120px; height:30px; font-size:10pt; color:black; text-align:center;">
								상품이미지
							</td>
							<td style="width:420px; font-size:10pt; color:black; text-align:center;">
								상품정보
							</td >
							<td style="width:120px; font-size:10pt; color:black; text-align:center;">
								수량
							</td>
							<td style="width:120px; font-size:10pt; color:black; text-align:center;">
								총 가격
							</td>
							<td style="width:120px; font-size:10pt; color:black; text-align:center;">
								주문번호
							</td>
							<td style="width:120px; font-size:10pt; color:black; text-align:center;">
								주문상태
							</td>
						</tr>
						<c:if test="${empty requestScope.buyList && requestScope.checkidnull ne 'no'}">
							<tr>
								<td colspan="6" style="height:200px; text-align:center; font-size:11pt;">
									고객님의 구매내역이 없습니다
								</td>
							</tr>	
						</c:if>
						<c:if test="${requestScope.checkidnull eq 'no'}">
							<tr>
								<td colspan="6" style="height:200px; text-align:center; font-size:11pt;">
									로그인 후 조회 가능합니다.
								</td>
							</tr>	
						</c:if>		
						<c:if test="${not empty requestScope.buyList && requestScope.checkidnull ne 'no'}">
							<c:forEach var="buyList" items="${requestScope.buyList}">
								<tr style="border-bottom:solid 1px gray;">							
									<td style="width:120px; height:150px; font-size:10pt; color:black; text-align:center;">
										<img style="width:120px; height:150;" id="chun" src="${buyList.fk_pimage3}"/>
									</td>
									<td style="width:420px; font-size:10pt; color:black; text-align:left; padding-left:30px;">
										${buyList.buy_opt_info}
									</td >
									<td style="width:100px; font-size:10pt; color:black; text-align:center;">
										${buyList.buy_qty}
									</td>
									<td style="width:120px; font-size:10pt; color:black; text-align:center;">
										<fmt:formatNumber value="${buyList.buy_opt_price + buyList.buy_pro_price}" pattern="###,###" />원
									</td>
									<td style="width:120px; font-size:10pt; color:black; text-align:center;">
										${buyList.jumun_bunho}
									</td>
									<td style="width:120px; font-size:10pt; color:black; text-align:center;">
										<c:choose>
											<c:when test="${buyList.baesong_sangtae eq 0}">배송준비</c:when>
											<c:when test="${buyList.baesong_sangtae eq 1}">배송중</c:when>
											<c:when test="${buyList.baesong_sangtae eq 2}">배송완료</c:when>
											<c:when test="${buyList.baesong_sangtae eq 3}">교환</c:when>
											<c:otherwise>환불</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
		    	</div>
	    	</div>
		    <!-- 여기서부터 디자인 끝 -->
		</div>
	</div>
</div>	
<!-- //////////////////////////////////////////////////////////////////////// -->	
	
<!-- 댓글보기 모달 꾸미기 -->
<!-- //////////////////////////////////////////////////////////////////////// -->		
<div class="modal fade" id="fordatgleModal">
	<div class="modal-dialog">
		<div class="modal-content" style="width:800px; margin-left:-150px">      
			<!-- Modal header -->
		    <div class="modal-header">
		    	<h5 class="modal-title">댓글보기 및 작성</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		    </div>
		    <!-- Modal body -->
		    <div class="modal-body">
		    	<div id="container" style="text-align:center;">
			    <!-- 여기서부터 디자인 시작 -->
			    	<table>
			    		<tr>
			    			<td>
			    				<div id="modal_img">
														    						
				    			</div>
			    			</td>
			    			<td>
			    				<table>
			    					<tr>
			    						<td>
				    						<div style="width:380px; padding-top:5px; height:30px; font-size:10pt; text-align:center; color:white; background-color:black">
												product option				    						
				    						</div>
				    						<div id="modal_option" style="width:380px; height:55px; font-size:10pt; text-align:center; padding:10px;">
														    						
				    						</div>
				    						<div style="width:380px; padding-top:5px; height:30px; font-size:10pt; text-align:center; color:white; background-color:black">
												review content				    						
				    						</div>
				    						<div id="modal_content" style="width:380px; height:55px; font-size:10pt; text-align:center; padding:10px;">
															    						
				    						</div>
			    						</td>
			    					</tr>
				    				<tr>
				    					<td>
						    				<div style="width:380px; padding-top:5px; height:30px; font-size:10pt; text-align:center; color:white; background-color:black">
												review comment				    						
				    						</div>
						    				<!-- foreach로 댓글내용 들어갈곳 -->
						    				<div style="overflow:auto; width:380px; height:200px;">
												<div id="in_review_comment">
													
												</div>	
						    				</div>
						    			</td>	
				    				<tr>
			    				</table>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="2">
			    				<input type="text" id="datgle_text" style="width:765px; height:60px; margin-top:20px; resize:none;"/>
			    				<span>
			    					<button id="datgle_submit" style="width:150px; height:28px; margin:20px 5px 0px 225px; border:solid 1px gray; text-align:center; font-size:10pt; color:white; background-color:black;">작성하기</button>
			    				</span>
			    				<span>
			    					<button id="datgle_close" style="width:150px; height:28px; margin:20px 5px 0px 0px; border:solid 1px gray; text-align:center; font-size:10pt; color:white; background-color:black;">지우기</button>
			    				</span>
			    				<span id="datgle_length" style="font-size:10pt;">
			    				
			    				</span>
			    			</td>
			    		</tr>
			    	</table>
		    	</div>
	    	</div>
		    <!-- 여기서부터 디자인 끝 -->
		</div>
	</div>
</div>	
<!-- //////////////////////////////////////////////////////////////////////// -->
	
<jsp:include page="/WEB-INF/footer.jsp" />
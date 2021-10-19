<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<meta charset="UTF-8">
<%
	String ctxPath = request.getContextPath();
    
%>  
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">

<style>
	table,tr,td{
		border:solid 1ox red;
	}

	img#imgmenu{
		border-radius: 50%;
		width:100px;
	}
	
	span.listname{
		color:black; 
		display:inline-block; 
		margin-top:10px;
		font-size: 11pt;
	}
	table{
		border-spacing : 100px;
		margin-right : auto;
		margin-left : auto;
		
		
	}

	
 	img.img{
 		width: 350px;
 		margin: 5 40px;
 		cursor:pointer;
 		
 	}
 	
 	
 	td#saleprice{
 		color:red;
 	}
 	
 	td{
 		font-size: 10pt;
 	}
 	
 	tr.productname > td{
 		padding-left:43px;
 	}
 	
 	ul{
 		 list-style:none;
 		 
 	}
 	
 	li#img{
 		display:inline-block;
 		padding: 0 15px;
 		
 	}
 	
 	a#pagenum{
 		letter-spacing:15px;
 	}

 	.container {
	    position: relative;
	    width: 50%;
	    /* max-width: 400px; */
	    margin:0 50px;
	}

	.container img {
	    width: 350px;
  	    height: auto;
	}

	.container .btn{
	  	position: absolute;
	  	top: 85%;
	  	left: 50%;
	  	transform: translate(-50%, -50%);
	  	-ms-transform: translate(-50%, -50%);
	  	background-color: #f1f1f1;
	  	color: black;
	  	font-size: 16px;
	  	padding: 16px 30px;
	  	border: none;
	  	cursor: pointer;
	  	border-radius: 5px;
	  	text-align: center;
	}

	.container .btntag0:hover {
	  	background-color: black;
	  	color: white;
	}

	.container .btntag1:hover {
	 	background-color: black;
	  	color: white;
	}

	.container .btntag2:hover {
	  	background-color: black;
	  	color: white;
	}
	
	.container .btntag3:hover {
	  	background-color: black;
	  	color: white;
	}
	
	.container .btntag4:hover {
	  	background-color: black;
	  	color: white;
	}
	
	.container .btntag5:hover {
	  	background-color: black;
	  	color: white;
	}


 	
</style>
<jsp:include page="../header.jsp"/>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	//수량
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
	// 초기가격 지역변수 방지
	var orgpcd = "";
	// 최대 갯수
	var cnt = 0;
	// 테이블 태그의 키값
	var key = 0;
	// 적립금 지역변수 방지
	var jukrib = 0;
	// 카트 구매창 사진 넘기기전 지역변수 방지
	var frontp = "";
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

	/////////////////////////////////////////////////////////////////////////////////
	
	$(document).ready(function(){

		/* 동그라미 사진 메뉴 이벤트 */
		$("ul#imglist > li").hover(function(){
		   	 $(this).css({'opacity':'0.5', 'cursor':'pointer', 'border-radius':'50%'});
			    }, 
						function(){
			    	         $(this).css({'opacity':'1.0', 'cursor':'default', 'border-radius':'0'});		 	 
										     });
	
	/////////////////////////////////////////////////////////////////////////////////
	
		// 동그라미 사진 메뉴 버튼 클릭하면 이동하는 것
		$("div#dubby").click(function(){
	
			var frm = document.dubbyfrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#mul").click(function(){
				
			var frm = document.mulfrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#boots").click(function(){
			
			var frm = document.bootsfrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#loper").click(function(){
			
			var frm = document.loperfrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#oxpode").click(function(){
			
			var frm = document.oxpodefrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#mongk").click(function(){
			
			var frm = document.mongkfrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
		
		$("div#sandle").click(function(){
			
			var frm = document.sandlefrm;
			frm.action="<%= ctxPath%>/productList.sh";
			frm.method="post";
			frm.submit();  
		});
	
	/////////////////////////////////////////////////////////////////////////////////
	
		//제품 사진 마우스 오버 이벤트
		$("button.btn").hide(); 
		
		$("div.imgtag0").mouseover(function() {
		     $(this).find("img#shose_0").attr("src",$("input#back_img0").val());
		     $("button.btntag0").show();
		}).mouseout(function() {
		     $(this).find("img#shose_0").attr("src",$("input#first_img0").val());
		     $("button.btntag0").hide();
		});
		 
		 
		$("div.imgtag1").mouseover(function() {
		     $(this).find("img#shose_1").attr("src",$("input#back_img1").val());
		     $("button.btntag1").show();
		}).mouseout(function() {
		     $(this).find("img#shose_1").attr("src", $("input#first_img1").val());
		     $("button.btntag1").hide();
		});
		
	 
		$("div.imgtag2").mouseover(function() {
		     $(this).find("img#shose_2").attr("src",$("input#back_img2").val());
		     $("button.btntag2").show();
		     
		}).mouseout(function() {
		     $(this).find("img#shose_2").attr("src", $("input#first_img2").val());
		     $("button.btntag2").hide();
		});
		
		$("div.imgtag3").mouseover(function() {
		     $(this).find("img#shose_3").attr("src",$("input#back_img3").val());
		     $("button.btntag3").show();
		}).mouseout(function() {
		     $(this).find("img#shose_3").attr("src", $("input#first_img3").val());
		     $("button.btntag3").hide();
		});
		
		$("div.imgtag4").mouseover(function() {
		     $(this).find("img#shose_4").attr("src",$("input#back_img4").val());
		     $("button.btntag4").show();
		}).mouseout(function() {
		     $(this).find("img#shose_4").attr("src", $("input#first_img4").val());
		     $("button.btntag4").hide();
		});
		
		$("div.imgtag5").mouseover(function() {
		     $(this).find("img#shose_5").attr("src",$("input#back_img5").val());
		     $("button.btntag5").show();
		}).mouseout(function() {
		     $(this).find("img#shose_5").attr("src", $("input#first_img5").val());
		     $("button.btntag5").hide();
		});
	
	/////////////////////////////////////////////////////////////////////////////////
		
		// 퀵뷰
	 	$("button.btn").click(function(){
	 		// 어떤 버튼을 눌럿는지
	 		var quickProductName = $(this).val();
	 		// 값 넘겨주기
	 		$.ajax({
	 			url:"<%= ctxPath%>/quickView.sh",
	 			data:{"quickProductName":quickProductName},
	 			dataType:"json",
	 			success: function(json){
	 		 	
	 		// 모달에 들어갈 내용	    
			var html = 	"<table id='buy' style='margin:50px 0px;'>"
							+"<tr>"
								+"<td id='insertimg'><img style='width:420px; height:600px;' id='chun' src='"+json.product_front_p1+"'/></td>"
								+"<td id='buy' style='width:700px; height:600px;'>"
									+"<table id='inbuy' style='width:420px; height:600px; margin-left:40px;'>"
										+"<tr style='height:80px;'>"
											+"<td colspan='2' style='padding:0px 5px; width:450px; height:60px; text-align:left; font-size:14pt; font-weight:bold; color:black; border-bottom:solid 1px gray;'>"
												+"<span id='product_name'>"+json.product_name+"</span><br>"
												+"<span id='product_ceil_price' style='font-size:13pt; color:red;'>"+json.product_ceil_price+"</span>&nbsp;"
												+"<span style='font-size:10pt; color:gray;'>/</span>"
												+"<span id='product_price' style='padding:10px; font-size:10pt; color:gray;'><del>"+json.product_price+"</del></span>"		
											+"</td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td style='width:150px; text-align:left; font-size:10pt; color:black; padding-top:7px; padding-left:7px;'>적립금</td>"
											+"<td style='width:300px; font-size:10pt; padding-left:20px; padding-top:5px;'><span id='pct' style='color:red; display:inline-block; width:200px;'></span></td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>사이즈</td>"
											+"<td style='width:300px; padding:0px 10px;'>"
												+"<select id='optselect1' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag1();'>"
													+"<option>- [필수]옵션을 선택 해주세요 -</option>"
													+"<option disabled='disabled'>---------------------</option>"
													+"<option>240</option>"
													+"<option>250</option>"
													+"<option>260</option>"
													+"<option>270</option>"
													+"<option>280</option>"
													+"<option>290</option>"
												+"</select>"
											+"</td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>볼너비</td>"
											+"<td style='width:300px; padding:0px 10px;'>"
												+"<select id='optselect2' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag2();'>"
													+"<option>- [필수]옵션을 선택 해주세요 -</option>"
													+"<option disabled='disabled'>---------------------</option>"
													+"<option>보통</option>"
													+"<option>넓음</option>"
												+"</select>"
											+"</td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>키높이</td>"
											+"<td style='width:300px; padding:0px 10px;'>"
												+"<select id='optselect3' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag3();'>"
													+"<option>- [필수]옵션을 선택 해주세요 -</option>"
													+"<option disabled='disabled'>---------------------</option>"
													+"<option>선택안함</option>"
													+"<option>안굽 1cm추가 (+5,000원)</option>"
												+"</select>"
											+"</td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td style='width:150px; text-align:left; font-size:8pt; color:black; padding-left:7px;'>아웃솔변경</td>"
											+"<td style='width:300px; padding:0px 10px;'>"
												+"<select id='optselect4' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin-left:5px;' onclick='flag4();'>"
													+"<option>- [필수]옵션을 선택 해주세요 -</option>"
													+"<option disabled='disabled'>---------------------</option>"
													+"<option>선택안함</option>"
													+"<option>워커창(러버솔) 변경(교환불가옵션 +10,000원)</option>"
													+"<option>가죽창(레더솔) 변경(교환불가옵션 +40,000원)</option>"
												+"</select>"
											+"</td>"
										+"</tr>"
										+"<tr style='height:50px;'>"
											+"<td colspan='2'>"
												+"<span id='plus' style='text-align:center; display:inline-block; background-color:black; color:white; height:50px; width:420px;padding-top:13px;'>ADD</span>"
											+"</td>"
										+"</tr>"
										+"<tr style='height:220px;'>"
											+"<td colspan='2'>"
												+"<div id='inthis' style='height:220px; width:420px;'>"
												+"</div>"
											+"</td>"
										+"</tr>"
									+"</table>"
								+"</td>"
							+"</tr>"
						+"</table>";
						
	 				$("div.modal-body").html(html);
	 				
	 				// 초기 가격
	 				orgpcd = json.product_price;
	 				// 넘기기 사진
	 				frontp = json.product_front_p1
	 			},
	 			error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}
	 			
	
	 		});//end of $.ajax({-------------------------------------------------------
	 		
	 		///////////////////////////////////////////////////////////////////////////
	 		
	 		// 추가하기 버튼 눌렀을 때
			$(document).on("click", "span#plus", function(){
				
				// 지우기 버튼 클릭 시
				$(document).on("click", "button#close", function(){
					// 키값을 가져오기 위함
					var tblkey = $(this).parent().find(".tblkey").val();
					$("table#"+tblkey).remove();
					// 지운만큼 추가하게 해준다
					cnt--;
				});
				
				// 초기 가격 설정해주기
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
				
				//////////////////////////////////////////////////////////////////////	
					
				// 옵션 값 더하기
				finopt = plusopt1 + plusopt2;
				// 각각의 고유한 키값
				key++;
				
				// 각각 옵션을 선택한 경우
				if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
					
					var html2 = "<div>" 
									+"<table id='"+key+"' style='height:72px; margin-bottom:12px;'>"
										+"<tr>"
											+"<td style='width:300px;'>"
												+"<div style='text-align:left; font-size:9pt; color:black;'>"
													+"<div style='font-weight:bold;'>"+ $("span#product_name").text() +"</div>"
													+"<div class='cartopt123'>"+opt1+"/"+opt2+"/"+opt3+"</div>"
													+"<div class='cartopt4'>/"+opt4+"</div>"
												+"</div>"
											+"</td>"
											+"<td style='width:120px; text-align:right; font-size:10pt;'>"
												+"<input id='num' class='cartnum' type='number' min='1' value='1' max='20' style='width:40px; height:20px; text-align:left;'/>"
												+"<img id='close' src='/SemiProject/images/close.png' style='width:20px; height:20px;'/>"
												+"<input class='tblkey' type='hidden' value='"+key+"'/>"
												+"<div id='upprice' class='cartprice'>"+pcd+"원</div>"
												+"<div class='cartfinopt'>+ "+finopt+"원</div>"
											+"</td>"	
										+"</tr>"
										+"<tr>"
											+"<td colspan='2'>"
												+"<span id='buynow' style='display:inline-block; border:solid 1px black; margin-right:5px; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:205px; padding-top:5px'>BUY NOW</span>"
												+"<span id='cart' style='display:inline-block; border:solid 1px black; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:206px; padding-top:5px'>CART</span>"
												+"<input class='cartkey' type='hidden' value='"+key+"'/>"
											+"</td>"
										+"</tr>"
									+"</table>"
								+"</div>";
					
					// 지울때 갯수를 측정하기 위함
					// 아무 태그나 잡음
					cnt = $(".cartprice").size();			
										
					if(cnt<2){		
						// div에 append
						$("div#inthis").append(html2);	
					}
					else{
						cnt = 2;
						alert("최대 2개만 담을 수 있습니다.");	
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
	 			
			/////////////////////////////////////////////////////////////////////////////
				
			// 장바구니로 연결하기
			$(document).on("click", "span#cart", function(){

				// 키값을 가져오기 위함
				var cartkey = $(this).parent().find(".cartkey").val();
				var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
				var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
				var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
				var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
				var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
				
				// 장바구니로 넘겨주기 위한 hidden 타입의 input 태그 생성
				// 넘기는 내용
				// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
				var gocart = "<input type='hidden' name='product_front_p1' value='"+frontp+"'/>"
							+"<input type='hidden' name='cartname'   value='"+$("span#product_name").text()+"'/>"
						    +"<input type='hidden' name='cartopt123' value='"+cartopt123+"'/>"
						    +"<input type='hidden' name='cartopt4'   value='"+cartopt4+"'/>"	
						    +"<input type='hidden' name='cartnum'    value='"+cartnum+"'/>"	
						    +"<input type='hidden' name='cartprice'  value='"+cartprice+"'/>"
						    +"<input type='hidden' name='jukrib'  value='"+jukrib+"'/>"
						    +"<input type='hidden' name='cartfinopt' value='"+cartfinopt+"'/>";

				$("form#buyorcart").append(gocart);

				var frm = document.gogocart;
				frm.action = "<%= ctxPath%>/mycart.sh";
				frm.method = "post";
				frm.submit();	  
				
				// 장바구니 전송 후 지우기
				$("table#"+cartkey).remove();
				// 장바구니 전송을 위해 만든 input 지우기
				$("form#buyorcart").empty(); 

			});//end of $(document).on("click", "button#cart", function(){-----------	
	 			
			/////////////////////////////////////////////////////////////////////////////////	
	 			
			// 구매창으로 연결하기
			$(document).on("click", "span#buynow", function(){
			
				// 키값을 가져오기 위함
				var cartkey = $(this).parent().find(".cartkey").val();
				console.log(cartkey);
				// 장바구니를 선택한 태그 내의 내용을 옮겨주기 위하여 변수생성
			 // var cartimg = $(this).parent().find(".upprice").val();
				var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
				var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
				var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
				var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
				var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
				console.log(cartopt123);
				// 장바구니로 넘겨주기 위한 hidden 타입의 input 태그 생성
				// 넘기는 내용
				// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
				var gocart = "<input type='hidden' name='product_front_p1' value='"+frontp+"'/>" 
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
	 			
			///////////////////////////////////////////////////////////////////////////	
				
	 	});//end of $("button.btn").click(function(){----------------------------------
 	
		/////////////////////////////////////////////////////////////////////////////////
 
		// 해당제품 상세페이지
		$("img.img").click(function(){
			var product_name = $(this).parent().find("input.product_name").val()
		    location.href="<%= ctxPath%>/buy.sh?product_name="+product_name;
		});
		
	});// end of $(document).ready(function()----------------------------------------
		
	/////////////////////////////////////////////////////////////////////////////////
		
</script>



<%-- 제품사진 메뉴 리스트 --%>


<ul id="imglist" style="margin-top: 80px; display:table; margin-left: auto; margin-right:auto; margin-bottom: 50px;">

	<li id="img" style="text-align:center;" >     <!-- BEST 버튼은 현재 allProductList로 가게되어있음 -->
		<form name="bestfrm" >
			<input type="hidden" id="bestid" name="productname" />
				<div id="best" >
					<a href="allProductList.sh"><div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/f73628a78fca4fa78f4ccc9cb7d78b6e.jpg" id="imgmenu" ></div><span  class="listname">BEST</span></a>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="dubbyfrm" >
			<input type="hidden" value="dubby" name="productname" />
				<div id="dubby">
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/56b8958fb641ce6f9f854ee98bf5df24.jpg" id="imgmenu" ></div><span  class="listname">더비</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="mulfrm" >
			<input type="hidden" value="mul" name="productname" />
				<div id="mul" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/869c4b254f3b5356f128f2b64a04e384.jpg" id="imgmenu" ></div><span  class="listname">뮬</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="bootsfrm" >
			<input type="hidden" value="boots" name="productname" />
				<div id="boots" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/1171a5fb41400cabe4cde966d418f3b3.jpg" id="imgmenu" ></div><span  class="listname">부츠</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="loperfrm" >
			<input type="hidden" value="loper" name="productname" />
				<div id="loper" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/d6639c71e8b26845d4a372c31a92bc1c.jpg" id="imgmenu" ></div><span  class="listname">로퍼</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="oxpodefrm" >
			<input type="hidden" value="oxpode" name="productname" />
				<div id="oxpode" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210825/d27954f804c1e3484a42cf3fb4476d6f.png" id="imgmenu" ></div><span  class="listname">옥스퍼드</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="mongkfrm" >
			<input type="hidden" value="mongk" name="productname" />
				<div id="mongk" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210825/0c5634ea9545afdc00e698a3c97f4efb.png" id="imgmenu" ></div><span  class="listname">몽크</span>
				</div>		
		</form>
	</li>
	<li id="img" style="text-align:center;" >
		<form name="sandlefrm" >
			<input type="hidden" value="sandle" name="productname" />
				<div id="sandle" >
					<div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/7d76dc6c16a54153e3a37f72529236da.jpg" id="imgmenu" ></div><span  class="listname">샌들</span>
				</div>		
		</form>
	</li>
</ul>

<table style = "margin-bottom:50px;">
	<tr>
		<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
			<c:if test="${status.index < 3}">
					<td>
						<div class="container imgtag${status.index}" style="padding:0px; margin:0px">
							<input type="hidden" id="first_img${status.index}" name="first_img${status.index}" value="${productvo.product_front_p1}"/>
							<input type="hidden" id="back_img${status.index}" name="back_img${status.index}" value="${productvo.product_back_p2}"/>
							<img src="${productvo.product_front_p1}" id="shose_${status.index}" class="img" >
							<input type="hidden" id="product_name" class="product_name" value="${productvo.product_name}"/>
							<button type="button" class="btn btntag${status.index}"  name="btn" data-toggle="modal" data-target="#quick_view_modal" value="${productvo.product_name}">Quick View</button>
						</div>
					</td>
					<img src="${productvo.product_back_p2}" class="img backimg" style="display:none;"/>		
			</c:if>
		</c:forEach>	
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index < 3}">
	 			<input type="hidden" id="productname${status.index}" value="${productvo.product_name}"/>
				<td>${productvo.product_name}</td>
			</c:if>
		</c:forEach>
	</tr>	
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index < 3}">
				<td><del>${productvo.product_price}</del></td>
			</c:if>
		</c:forEach>
	</tr>	
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index < 3}">
				<td id="saleprice">${productvo.product_ceil_price}</td>
			</c:if>
		</c:forEach>
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index < 3}">
				<td>상품후기:316개</td>
			</c:if>
		</c:forEach>
	</tr>
</table>	

<table style = "margin-bottom:100px;">
	<tr>
		<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
			<c:if test="${status.index > 2}">
				<td>
					<div class="container imgtag${status.index}" style="padding:0px">
						<input type="hidden" id="first_img${status.index}" name="first_img${status.index}" value="${productvo.product_front_p1}"/>
						<input type="hidden" id="back_img${status.index}" name="back_img${status.index}" value="${productvo.product_back_p2}"/>
						<img src="${productvo.product_front_p1}" id="shose_${status.index}" class="img" >
						<input type="hidden" id="product_name" class="product_name" name="product_name" value="${productvo.product_name}"/>
						<button type="button" class="btn btntag${status.index}"  name="btn" data-toggle="modal" data-target="#quick_view_modal" value="${productvo.product_name}">Quick View</button>
					</div>
				</td>
				<img src="${productvo.product_back_p2}" class="img backimg" style="display:none;"/>
			</c:if>
		</c:forEach>
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index > 2}">
				<td>${productvo.product_name}</td>
			</c:if>
		</c:forEach>
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index > 2}">
				<td><del>${productvo.product_price}</del></td>
			</c:if>
		</c:forEach>
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index > 2}">
				<td id="saleprice">${productvo.product_ceil_price}</td>
			</c:if>
		</c:forEach>
	</tr>
	<tr class = "productname">
	 	<c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
	 		<c:if test="${status.index > 2}">
				<td>상품후기:316개</td>
			</c:if>
		</c:forEach>
	</tr>		
</table>	
	
<div class="container quickviewmodal">   <!-- Modal 퀵 뷰 눌렀을때 나오는 모달 창 -->
	<div class="modal fade"  id="quick_view_modal">
	  <div class="modal-dialog modal-lg" style= "width:1000px; border-radius:0;">
	    <div class="modal-content" style= "width:1000px; border-radius:0;">
		      <!-- Modal body -->
		      <div class="modal-body"></div>       <!-- 퀵뷰 들어가는 곳 -->  
	    </div>
	  </div>
	</div>
</div>

<!-- 장바구니 또는 구매 할 때 잠시 값을 저장시켜 주는 곳 -->
<form id="buyorcart" name="gogocart">

</form>

<!-- 리뷰 작성 할 때 잠시 값을 저장시켜 주는 곳 -->
<form id="goreview" name="gogoreview">
	
</form>

<jsp:include page="../footer.jsp"/>
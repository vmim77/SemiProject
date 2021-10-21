<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%>    

<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>

<%
	Date now = new Date();
	
	SimpleDateFormat sdformat = new SimpleDateFormat("d");
	String today = sdformat.format(now);
	
%>

<meta charset="utf-8">
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">
	
	td{
		  border:solid 1px #cbcbb3;  
	}
	
	img#blackdojang{
		width:135px;
		height:110px;
		padding-top:6px;
		text-align:center;
	}
	
	img#reddojang{
		width:135px;
		height:110px;
		padding-top:6px;
		text-align:center;
	}
	
	div#design{
		width:140px;
		height:150px;
		text-align:center;"
	}
	
	#start1,#start2,#start3,#start4,#start5,#start6,#start7
   ,#start8,#start9,#start10,#start11,#start12,#start13,#start14
   ,#start15,#start16,#start17,#start18,#start19,#start20,#start21
   ,#start22,#start23,#start24,#start25,#start26,#start27,#start28
   ,#start29,#start30,#start31,#start32,#start33,#start34,#start35
   ,#start36,#start37,#start38,#start39,#start40,#start41,#start42
{
		padding-left:7px;
		width:140px;
		height:30px;
		text-align:left;
		font-size:14pt;
		border-bottom:solid 1px #cbcbb3;"
	}
	

</style>

<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
		
	$(document).ready(function(){
		
		//
		var cnt = 0;
		// 영어 달이름
		var monthname = "";
		// 년도
		var year = "${paraMap.year}";
		// 달
		var month = "${paraMap.month}";
		// 일
		var day = "${paraMap.day}";
		// 영어 달이름 정해주기
		if(month=="1"){
			monthname = "JAN";
		}
		else if(month=="2"){
			monthname = "FEB";
		}
		else if(month=="3"){
			monthname = "MAR";		
		}
		else if(month=="4"){
			monthname = "APR";
		}
		else if(month=="5"){
			monthname = "MAY";
		}
		else if(month=="6"){
			monthname = "JUN";
		}
		else if(month=="7"){
			monthname = "JUL";
		}
		else if(month=="8"){
			monthname = "AUG";
		}
		else if(month=="9"){
			monthname = "SEP";
		}
		else if(month=="10"){
			monthname = "OCT";
		}
		else if(month=="11"){
			monthname = "NOV";
		}
		else{
			monthname = "DEC";
		}
		
		// 달력에 날짜 총 결과
		var result = year + "." + monthname + "." + day; 
		// 년도 달 일 넣어주기
		$("span#indate").text(result);
		
		/////////////////////////////////////////////////////////////////////////////
		
		// 끝 날짜가 몇일인지 확인해주기
		// 깃발
		var flag31 = false;
		var flag28 = false;
		// 해달 달 끝 날짜가 30일인지 31일 확인하기 //
		if(month == "4" || month == "6" || month == "9" || month == "11"){
			flag31 = false;
		}
		else if(month == "1" || month == "3" || month == "5" || month == "7" || month == "8" || month == "10" || month == "12"){
			flag31 = true;
		}
		else{
			flag28 = true;
		}
		
		/////////////////////////////////////////////////////////////////////////////
		
		// 시작 아이디값 지역변수 방지
		var startnum = "${paraMap.startday}"*1;
		// 검정도장 이미지 태그 지역변수 방지
		var html = "<img id='blackdojang' src='/SemiProject/images/dojang.png'/>";
		// 빨간도장 이미지 태그 지역변수 방지
		var chghtml = "<img id='reddojang' src='/SemiProject/images/dojang2.PNG'/>";
		// for문에 i값 지역변수 방지
		var i = 0;
		// 6주 달력 잠시 숨기기
		$("tr#hide").hide();
		// 넘어온 데이터에 저장된 값 배열만들기
		var choolcheckday = "${requestScope.choolcheckday}".split(",");
		
		/////////////////////////////////////////////////////////////////////////////
		
		// 30일때
		if(flag31 == false){
			
			// 값 넣어주기
			for(i=0; i<30; i++){
				// 날짜 넣어주기
				$("div#start"+(startnum+i)).text(i+1);
				// 사진넣어주기
				$("span#img"+(startnum+i)).html(html);
				// 히든타입의 인풋
				var inputhtml = "<input type='hidden' value='"+(i+1)+"'/>";
				// 히든타입 인풋 넣어주기
				$("span#img"+(startnum+i)).append(inputhtml);
			}//end of for-----------------------------
			
			// id가 일정범위 지나가면 6주차 보여주기
			if( (startnum+i) >= 36){
				$("tr#hide").show();
			}
			cnt++;
		}//end of if----------------------------------
		
		/////////////////////////////////////////////////////////////
		
		// 31일때
		if(flag31 == true){
			 
			// 값 넣어주기
			for(i=0; i<31; i++){
				// 날짜 넣어주기
				$("div#start"+(startnum+i)).text(i+1);
				// 사진넣어주기
				$("span#img"+(startnum+i)).html(html);
				// 히든타입의 인풋
				var inputhtml = "<input type='hidden' value='"+(i+1)+"'/>";
				// 히든타입 인풋 넣어주기
				$("span#img"+(startnum+i)).append(inputhtml);
			}//end of for-----------------------------
			
			// id가 일정범위 지나가면 6주차 보여주기
			if( (startnum+i) >= 36){
				$("tr#hide").show();
			}
			cnt++;
		}//end of if----------------------------------
		
		/////////////////////////////////////////////////////////////
		
		// 28일 (2월)일때
		if(flag28 == true){
			
			// 값 넣어주기
			for(i=0; i<28; i++){
				// 날짜 넣어주기
				$("div#start"+(startnum+i)).text(i+1);
				// 사진넣어주기
				$("span#img"+(startnum+i)).html(html);
				// 히든타입의 인풋
				var inputhtml = "<input type='hidden' value='"+(i+1)+"'/>";
				// 히든타입 인풋 넣어주기
				$("span#img"+(startnum+i)).append(inputhtml);
			}//end of for-----------------------------
			cnt++;
		} //end of if----------------------------------
		
		/////////////////////////////////////////////////////////////
		
		// 시작시 그동안 해던체크 보여주기
		// j로 for문 작성한 이유는 위의 i가 지역변수가 아니기 때문
		for(var j=0; j<choolcheckday.length; j++){
			console.log((startnum+(choolcheckday[j]*1)));
			// 사진넣어주기
			$("span#img"+(startnum+(choolcheckday[j]*1)-1)).empty();
			$("span#img"+(startnum+(choolcheckday[j]*1)-1)).html(chghtml);
		}
		
		//////////////////////////////////////////////////////////////
		
		// 검정도장을 클릭했을 때
		$(document).on("click", "img#blackdojang" ,function(){
			
			// 누른 도장의 해당날짜와 오늘이 같다면
			if( $(this).next().val() ==  <%= today%>){
				// 경로 및 아이디 바꾸기
				$(this).attr("src", "/SemiProject/images/dojang2.PNG");
				$(this).attr("id", "reddojang");
				
				// 누른날짜 데이터 베이스에 전송시키기
		 		var savemycheck = $(this).next().val();
				
				// 값 넘겨주기
		 		$.ajax({
		 			url:"<%= ctxPath%>/memberCalendar.sh",
		 			data:{"savemycheck":savemycheck},
		 			success: function(json){
		 		 	
		 				// 값이 잘 저장 되었다면
		 				alert("출석체크 성공!");
		 				
		 				},
		 				error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
					}
		 			
		
		 		});//end of $.ajax({-------------------------------------
		 			
			}
			else{
				alert("오늘은 "+<%= today%>+"일 출석체크 입니다.");
			}
	 		 	
		});//end of $(document).on("click",function(){
		
		/////////////////////////////////////////////////////////////
		
		// 빨간도장을 클릭했을 때
		$(document).on("click", "img#reddojang" ,function(){
			
			alert("출석체크 하셨었습니다.");
			 	
		});//end of $(document).on("click",function(){
		
		/////////////////////////////////////////////////////////////
		
		
		
		
		
	});//end of $(docunment).ready(function(){
		
</script>

<div id="container" style="width:1200px; margin:20px 0px 50px 200px;">
	<table style="width:1200px; ">
		<tr>
			<td style="text-align:center; border:solid 1px white;">
				<img style="margin-bottom:10px;" src="/SemiProject/images/topdojang.PNG" style="width:500px; height:270px;"/>
			</td>
		</tr>
		<tr>
			<td style="height:550px; border:solid 1px white;">
				<!-- 안에 실질적인 달력 -->
				<table style="width:980px; margin-left:110px;">
					<tr>
						<td colspan="7" style="height:60px; text-align:center; border:solid 1px #cbcbb3;  font-size:25pt; font-weight:bold; font-family:궁서; font-style:italic; background-color:#e0e0d1;">
							<span id="indate"></span>
						</td>
					</tr>
					<tr style="height:50px; text-align:center; font-size:12pt; font-weight:bold;">
						<td style="width:140px; background-color:#ff4d4d; color:white;" >
							SUN
						</td>
						<td style="width:140px;">
							MON
						</td>
						<td style="width:140px;">
							TUE
						</td>
						<td style="width:140px;">
							WED
						</td>
						<td style="width:140px;">
							THU
						</td>
						<td style="width:140px;">
							FIR
						</td>
						<td style="width:140px; background-color:#668cff; color:white;">
							SAT
						</td>
					</tr>
					<tr>
						<td>
							<div id="design">
								<div id="start1"></div>
								<span id="img1"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start2"></div>
								<span id="img2"></span>
							</div>
						</td>
						<td>	
							<div id="design">
								<div id="start3"></div>
								<span id="img3"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start4"></div>
								<span id="img4"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start5"></div>
								<span id="img5"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start6"></div>
								<span id="img6"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start7"></div>
								<span id="img7"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="design">
								<div id="start8"></div>
								<span id="img8"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start9"></div>
								<span id="img9"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start10"></div>
								<span id="img10"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start11"></div>
								<span id="img11"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start12"></div>
								<span id="img12"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start13"></div>
								<span id="img13"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start14"></div>
								<span id="img14"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="design">
								<div id="start15"></div>
								<span id="img15"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start16"></div>
								<span id="img16"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start17"></div>
								<span id="img17"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start18"></div>
								<span id="img18"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start19"></div>
								<span id="img19"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start20"></div>
								<span id="img20"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start21"></div>
								<span id="img21"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="design">
								<div id="start22"></div>
								<span id="img22"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start23"></div>
								<span id="img23"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start24"></div>
								<span id="img24"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start25"></div>
								<span id="img25"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start26"></div>
								<span id="img26"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start27"></div>
								<span id="img27"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start28"></div>
								<span id="img28"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="design">
								<div id="start29"></div>
								<span id="img29"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start30"></div>
								<span id="img30"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start31"></div>
								<span id="img31"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start32"></div>
								<span id="img32"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start33"></div>
								<span id="img33"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start34"></div>
								<span id="img34"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start35"></div>
								<span id="img35"></span>
							</div>
						</td>
					</tr>
					<tr id="hide">
						<td>
							<div id="design">
								<div id="start36"></div>
								<span id="img36"></span>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start37"></div>
								<span id="img37"></span>
							</div>
						</td>
						<!-- 여기서부터는 디자인 처리를 위해 넣은것 -->
						<td>
							<div id="design">
								<div id="start38"></div>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start39"></div>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start40"></div>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start41"></div>
							</div>
						</td>
						<td>
							<div id="design">
								<div id="start42"></div>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<jsp:include page="/WEB-INF/footer.jsp" />
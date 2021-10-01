<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>  

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		var method = "${requestScope.method}";
		//	console.log("method => " + method);
		
	    if(method == "GET") {
	    	$("div#div_findResult").hide();
	    }
	    else if(method == "POST") {
	    	$("input#userid").val("${requestScope.userid}");
	    	$("input#email").val("${requestScope.email}");
	    	$("div#div_findResult").show();
	    	
	    	if(${requestScope.sendMailSuccess == true}) {
	    		$("div#div_btnFind").hide();
	    	}
	    	
	    }
		
		
		// 찾기
		$("button#btnFind").click(function(){
			
			var useridVal = $("input#userid").val().trim();
			var emailVal = $("input#email").val().trim();
			
			// 아이디 및 이메일에 대한 정규표현식을 사용한 유효성검사는 생략하겠습니다.
			if( useridVal != "" && emailVal != "" ) {
				var frm = document.pwdFindFrm;
				frm.action = "<%= ctxPath%>/login/pwdFind.sh";
				frm.method = "POST";
				frm.submit();
			}
			else {
				alert("아이디와 이메일을 입력하세요!!");
				return;
			}
			
		});// end of $("button#btnFind").click(function(){})----------------
		
		// 인증하기
		$("button#btnConfirmCode").click(function(){
			
			var frm = document.verifyCertificationFrm;
			
			frm.userid.value = $("input#userid").val();
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			
			frm.action = "<%= ctxPath%>/login/verifyCertification.sh";
			frm.method="POST";
			frm.submit();
			
			
		});// end of 인증하기
		
		
	});// end of $(document).ready(function(){})-----------------------------

</script>

<form name="pwdFindFrm">
   
   <ul style="list-style-type: none">
   		<li style="margin: 25px 0">
   			<label for="userid" style="display: inline-block; width: 90px">아이디</label>
   			<input type="text" name="userid" id="userid" size="25" placeholder="ID" autocomplete="off" required />
   		</li>
   		<li style="margin: 25px 0">
   			<label for="userid" style="display: inline-block; width: 90px">이메일</label>
   			<input type="text" name="email" id="email" size="25" placeholder="abc@def.com" autocomplete="off" required />
   		</li>
   </ul>
   
   <div class="my-3" id="div_btnFind">
   	  <p class="text-center">
   	  	<button type="button" class="btn btn-success" id="btnFind">찾기</button>
   	  </p>	
   </div>

   <div class="my-3" id="div_findResult">
   	  <p class="text-center">
		 <c:if test="${requestScope.isUserExist == false}">
		 	<span style="color: red;">사용자 정보가 없습니다.</span>
		 </c:if>
		 
		 <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
		 	<span style="color: red;">메일발송이 실패했습니다.</span>
		 </c:if>
		 
		 <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
		 	<span style="font-size: 10pt;">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br>
	   	    <span style="font-size: 10pt;">인증코드를 입력해주세요.</span><br>
	   	    <input type="text" name="input_confirmCode" id="input_confirmCode" required />
	   	    <br><br>
	   	    <button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>
		 </c:if>
		 
      </p>
   </div>   
      
</form>

<form name="verifyCertificationFrm">
	<input type="hidden" name="userid" />
	<input type="hidden" name="userCertificationCode" />
</form>




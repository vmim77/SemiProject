<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
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

<style>
 
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Noto Sans KR", sans-serif;
}

a {
  text-decoration: none;
  color: black;
}

li {
  list-style: none;
}

.wrap {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.1);
}

.login {
  margin-left: 650px;
  width: 30%;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

h2 {
  color: tomato;
  font-size: 2em;
}


.login_id {
  margin-top: 20px;
  width: 80%;
}

.login_id input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_pw {
  margin-top: 20px;
  width: 80%;
}

.login_pw input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_etc {
  padding: 10px;
  width: 80%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.submit {
  margin-top: 50px;
  width: 80%;
}
.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}


   table#loginTbl , table#snsloginTbl{
      width: 40%;
      border: solid 1px gray;
      border-collapse: collapse;
      margin-top: 20px;
      
   }
   
   table#loginTbl #th {
      background-color: silver;
      font-size: 14pt;
      text-align: center;
      height: 30px;
   }
   
   table#loginTbl td {
      border: solid 1px gray;
      line-height: 30px;
   }
</style>

<script>
	
	$(document).ready(function(){
		
		$("button#btnUpdate").click(function(){
			
			var pwd = $("input#pwd").val();
			var pwd2 = $("input#pwd2").val();
			
			// var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	       	// 또는
         	var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
         	// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
         	
         	var bool = regExp.test(pwd);
         	
         	if(!bool) {
         		alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
                $("input#pwd").val("");
                $("input#pwd2").val("");
                return; // 종료
         	}
         	
         	else if(bool && pwd != pwd2) {
         		alert("암호가 일치하지 않습니다.");
                $("input#pwd").val("");
                $("input#pwd2").val("");
                return; // 종료
         	}
         	
         	else {
         		var frm = document.pwdUpdateEndFrm;
         		frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.sh";
         		frm.method = "POST";
         		frm.submit();
         	}
		
		});
		
		
	});//end $(document).ready(function()

</script>

<form name="pwdUpdateEndFrm">
 <table id="loginTbl">
 <tbody>
 <div class="login">
            <h2 style="color: black;">비밀번호 변경</h2>
            
   <div id="login_id" align="center">
      <span style="color: blue; font-size: 12pt;">새암호</span><br/> 
      <input type="password" name="pwd" id="pwd" size="25" placeholder="PASSWORD" required />
   </div>
   
   <div id="login_pw" align="center">
      <span style="color: blue; font-size: 12pt;">새암호확인</span><br/>
      <input type="password" id="pwd2" size="25" placeholder="PASSWORD" required />
   </div>
  
   <br> 
   <input type="hidden" name="userid" value="${requestScope.userid}" />
   
   <c:if test="${requestScope.method == 'GET'}">
   	  <div id="div_btnUpdate" align="center">
          <button type="button" class="btn btn-dark" id="btnUpdate" style="margin-bottom: 60px;">암호변경하기</button>
      </div>			
   </c:if>
    <c:if test="${requestScope.method == 'POST' && requestScope.n == 1}">
		<div id="div_updateResult" align="center">
           	사용자 ID ${requestScope.userid}님의 암호가 변경되었습니다.<br>
      	</div> 
   </c:if>
</div>
   
   
   </tbody>
   </table>
</form>
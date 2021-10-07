<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String ctxPath = request.getContextPath();
 
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
.login_sns {
  padding: 20px;
  display: flex;
}

.login_sns li {
  padding: 0px 15px;
}

.login_sns a {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px;
  border-radius: 50px;
  background: white;
  font-size: 20px;
  box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px rgba(0, 0, 0, 0.1);
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

<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// === 로컬스토리지(localStorage)에 저장된 key 가 "saveid"인  userid 값을 불러와서 input 태그 userid에 넣어주기 === //
		var loginUserid = localStorage.getItem('saveid');
      
      	if(loginUserid != null) {
         $("input#loginUserid").val(loginUserid);
         $("input:checkbox[id=saveid]").prop("checked", true);
      	}
      	
      	
      	//////////////////////////////////////////////////////////////////////////////////////////////////////
	    // 자동로그인	  
	   	var autologinId = localStorage.getItem("autologinid");
	   	var autologinPwd = localStorage.getItem("autologinpwd");
      	
      	if(autologinId != null && autologinPwd != null) {
	            $("input#loginUserid").val(autologinId);
	            $("input#loginPwd").val(autologinPwd);
	            $("input:checkbox[id=autologin]").prop("checked", true);
	            
	            var bool = window.confirm("자동로그인하시려면 엔터를 누르세요!");
	           	
	            if(bool){
	            	goLogin();
	            }
	            else {
	            	alert("자동로그인을 사용하지 않으시려면 체크를 해제하세요!");
	            }
         	}
      	
      	
      	
      	
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
	 	$("button#btnSubmit").click(function(){
	 		goLogin();// 로그인 시도한다.
	 		
	 	});
	 	
	 	$("input#loginPwd").bind("keyup",function(event){
	 		if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우  
	 			goLogin(); // 로그인 시도한다.	
	 		}
	 	});
		
	 	$(".myclose").click(function(){
	 		javascript:history.go(0);
	 		
	 	
	 	});
	 	
	 	$("button#userIdfind").click(function(){
	 		goUserIdFind();
	 		
	 	});
	 	
	 	$("button#passwdfind").click(function(){
	 		goPasswdFind();
	 		
	 	});
	 	
	 	
		
	}); //end of $(document).ready(function()

			
//=====================================================================================================================================
	// Function Declaration
		// 로그인	
	   function goLogin() {
	      
	      var loginUserid = $("input#loginUserid").val().trim();
	      var loginPwd = $("input#loginPwd").val().trim();
	      
	      if(loginUserid == "") {
	         alert("아이디를 입력하세요!!");
	         $("input#loginUserid").val("");
	         $("input#loginUserid").focus();
	         return;  // 종료
	      }
	      
	      if(loginPwd == "") {
	         alert("비밀번호를 입력하세요!!");
	         $("input#loginPwd").val("");
	         $("input#loginPwd").focus();
	         return;   // 종료
	      }

	      
	      if( $("input:checkbox[id=saveid]").prop("checked") ) {
	    	 // alert("아이디저장 체크를 하셨네요");
	    	 
	    	  localStorage.setItem('saveid',$("input#loginUserid").val());
	    	 
	      }
	      else {
	    	 // alert("아이디저장 체크를 해제 하셨네요");
	    	 
	    	  localStorage.removeItem('saveid');
	      }
	      
	      // 자동로그인
	      if( $("input:checkbox[id=autologin]").prop("checked") ) {
		    	 
	    	  localStorage.setItem('autologinid',$("input#loginUserid").val());
	    	  localStorage.setItem('autologinpwd',$("input#loginPwd").val());
		    	 
	      }
	      else {
		    	 
	    	  localStorage.removeItem('autologinid');
	    	  localStorage.removeItem('autologinpwd');
	      }
	      
	      
	      var frm = document.loginFrm;
	      frm.action = "<%= request.getContextPath() %>/login/login.sh",
	      frm.method = "post";
	      frm.submit();
	      
	   }// end of function goLogin()--------------------------------------------
	   
	   
//============================================================================================================================================   
		// 로그아웃을 처리해주는 페이지로 이동
  	   function goLogOut(){
		location.href="<%= request.getContextPath()%>/login/logout.sh";
		   
	   }// end of function goLogOut()
//============================================================================================================================================
	   // 아이디 찾기
	   function goUserIdFind(){
         location.href="<%= request.getContextPath()%>/login/idFind.sh";
      }
//============================================================================================================================================
 	  // 비밀번호 찾기
		function goPasswdFind(){
         location.href="<%= request.getContextPath()%>/login/pwdFind.sh";
      }
//============================================================================================================================================
	   
		   
</script>
<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<c:if test="${empty sessionScope.loginuser}">
   
   <form name="loginFrm">
       <table id="loginTbl">
         <tbody>
           <div class="wrap">
        <div class="login">
            <h2 style="color: black;">LOGIN</h2>
            <div class="login_sns">
            <a href="<%= ctxPath%>/index.sh"><img src="../images/home1.PNG" style="width: 70px;"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            <a href="<%= ctxPath%>/member/memberRegister.sh"><img src="../images/regi.PNG" style="width: 75px;"/></a>
            </div>
            <div class="login_id">
                <h4>아이디</h4>
                <input type="email" name="userid" id="loginUserid" placeholder="아이디">
            </div>
            <div class="login_pw">
                <h4>비밀번호</h4>
                <input type="password" name="pwd" id="loginPwd" placeholder="비밀번호">
            </div>
            <div class="login_etc">
                <div class="checkbox">
                <input type="checkbox" name="saveid" id="saveid"> 아이디저장
                <input class="ml-1" type="checkbox" name="autologin" id="autologin"> 자동로그인
                </div>
                <div class="forgot_pw">
                   <button type="button" id="userIdfind" class="btn btn-light">아이디찾기</button>
           		   <button type="button" id="passwdfind" class="btn btn-light">비밀번호찾기</button>
            	</div>
            </div>
              <button type="button" id="btnSubmit" class="btn btn-dark">로그인</button>
        </div>
    </div>
         </tbody>
       </table>
   </form>
</c:if>

   





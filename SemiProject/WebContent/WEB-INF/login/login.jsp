<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String ctxPath = request.getContextPath();
 
%>


<style>


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
   
   <div class="alert alert-dark" role="alert">
   	 <a class="navbar-brand" href="<%= ctxPath%>/index.sh">HOME</a>
   	 <a class="navbar-brand" href="<%= ctxPath%>/member/memberRegister.sh">회원가입</a>
	</div>
   
   <form name="loginFrm">
       <table id="loginTbl">
         <thead>
         
            <tr>
            	<%-- 아래의 ${name_scope_request} 은 <c:set var="변수명" value="${값}" scope="" /> 를 테스트 하기 위해서 사용하는 것임. --%>  
               	<%-- 변수의 선언은 header.jsp 파일에서 선언 하였음 --%>
               		<th colspan="2" id="th">${name_scope_request}&nbsp;LOGIN</th>
            	<%-- 끝 --%>
            </tr>
         </thead>
         
         <tbody>
            <tr>
               <td style="width: 20%; border-bottom: hidden; border-right: hidden; padding: 10px;">ID</td>
               <td style="width: 80%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="20" class="box" autocomplete="off" /></td>
            </tr>   
            <tr>
               <td style="width: 20%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</td>
               <td style="width: 80%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="20" class="box" /></td>
            </tr>
            
             <tr>
               <td colspan="2" align="center">
                   <button type="button" id="userIdfind" >아이디찾기</button>
           		   <button type="button" id="passwdfind" >비밀번호찾기</button>
               </td>
            </tr>
            
            <tr>
               <td colspan="2" align="center" style="padding: 10px;">
                  <input type="checkbox" id="saveid" name="saveid" /><label for="saveid">아이디저장</label>
               <%--    
                  <button type="button" id="btnSubmit" style="width: 67px; height: 27px; background-image: url('<%= request.getContextPath()%>/images/login.png'); vertical-align: middle; border: none;"></button>
               --%>
                   <button type="button" id="btnSubmit" class="btn btn-primary btn-sm ml-5">로그인</button>
               </td>
            </tr>
         </tbody>
       </table>
   </form>
</c:if>





<p class="displaynone" id="noMemberWrap">
                <strong>비회원주문하기</strong>
				<span>비회원으로 구매가 가능합니다.<br>단, 비회원으로 구매시 여러가지 혜택에서 제외될 수 있습니다.</span>
                <a href="" onclick="" class="btn-nomem-buy btn-hover">비회원주문하기</a>
            </p>
      





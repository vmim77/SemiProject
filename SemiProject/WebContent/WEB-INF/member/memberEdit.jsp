<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>
<!DOCTYPE html>
<html>
<head>

<title>:::회원정보수정:::</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 


<style>
 	   div#head {
      width: 90%;
      height: 50px;
      border: 1px solid gray;
      margin-top: 10px;
      margin-bottom: 30px;
      padding-top: 10px;
      padding-bottom: 50px;
      background-color: #ffffe6;
      font-size: 18pt;
   }
   
   table#tblMemberUpdate {
          width: 90%;
       /* border: solid 1px red; */
   }  
      
   table#tblMemberUpdate td {
       /* border: solid 1px gray;  */
         line-height: 25px;
         padding-top: 8px;
         padding-bottom: 8px;
   }
   
   .star { color: red;
           font-weight: bold;
           font-size: 13pt;
   }
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

  
   
   $(document).ready(function(){
      
      $("span.error").hide();
      
      $("input#name").blur(function(){
         
         var name = $(this).val().trim();
         if(name == "") {
            // 입력하지 않거나 공백만 입력한 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            
         //   $(this).next().show();
         //  또는
            $(this).parent().find(".error").show();   
            $(this).focus();
         }
         else {
            // 공백이 아닌 글자를 입력했을 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);
         //   $(this).next().hide();
            //  또는
               $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      $("input#pwd").blur(function(){
         
      // var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
      // 또는
         var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
         // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
      
         var pwd = $(this).val();
         
         var bool = regExp.test(pwd);
         
         if(!bool) {
            // 암호가 정규표현식에 위배된 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            
            $(this).parent().find(".error").show();   
            $(this).focus();
         }
         else {
            // 암호가 정규표현식에 맞는 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);

            $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      
      $("input#pwdcheck").blur(function(){
         
         var pwd = $("input#pwd").val();
         var pwdcheck = $("input#pwdcheck").val();
         
         if(pwd != pwdcheck) {
            // 암호와 암호 확인 값이 틀린 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            $("input#pwd").prop("disabled",false);
            
            $(this).parent().find(".error").show();   
            $("input#pwd").focus();
         }
         else {
            // 암호와 암호 확인 값이 같은 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);

            $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      
      $("input#email").blur(function(){
         
         var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
         // 이메일 정규표현식 객체 생성
      
         var email = $(this).val();
         
         var bool = regExp.test(email);
         
         if(!bool) {
            // 이메일이 정규표현식에 위배된 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            
            $(this).parent().find(".error").show();   
            $(this).focus();
         }
         else {
            // 이메일이 정규표현식에 맞는 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);

            $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      
      $("input#hp2").blur(function(){
         
         var regExp = /^[1-9][0-9]{3}$/i;
         // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
      
         var hp2 = $(this).val();
         
         var bool = regExp.test(hp2);
         
         if(!bool) {
            // 국번이 정규표현식에 위배된 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            
            $(this).parent().find(".error").show();   
            $(this).focus();
         }
         else {
            // 국번이 정규표현식에 맞는 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);

            $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      
      $("input#hp3").blur(function(){
         
      //   var regExp = /^[0-9]{4}$/i;
      //  또는   
         var regExp = /^\d{4}$/i;
         // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
      
         var hp3 = $(this).val();
         
         var bool = regExp.test(hp3);
         
         if(!bool) {
            // 마지막 전화번호 4자리가 정규표현식에 위배된 경우
            $("table#tblMemberUpdate :input").prop("disabled",true);
            $(this).prop("disabled",false);
            
            $(this).parent().find(".error").show();   
            $(this).focus();
         }
         else {
            // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
            $("table#tblMemberUpdate :input").prop("disabled",false);

            $(this).parent().find(".error").hide();   
         
         }
         
      });// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
   
      $("img#zipcodeSearch").click(function(){
           new daum.Postcode({
               oncomplete: function(data) {
                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                   // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var addr = ''; // 주소 변수
                   var extraAddr = ''; // 참고항목 변수

                   //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                       addr = data.roadAddress;
                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
                       addr = data.jibunAddress;
                   }

                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                   if(data.userSelectedType === 'R'){
                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                           extraAddr += data.bname;
                       }
                       // 건물명이 있고, 공동주택일 경우 추가한다.
                       if(data.buildingName !== '' && data.apartment === 'Y'){
                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                       }
                       // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                       if(extraAddr !== ''){
                           extraAddr = ' (' + extraAddr + ')';
                       }
                       // 조합된 참고항목을 해당 필드에 넣는다.
                       document.getElementById("extraAddress").value = extraAddr;
                   
                   } else {
                       document.getElementById("extraAddress").value = '';
                   }

                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   document.getElementById('postcode').value = data.zonecode;
                   document.getElementById("address").value = addr;
                   // 커서를 상세주소 필드로 이동한다.
                   document.getElementById("detailAddress").focus();
               }
             }).open();               
         });
      	
      $("button#ok").click(function(){
			goEdit();
	  });  	
      $("button#close").click(function(){
			goClose();
	  });  	
      
   });// end of $(document).ready(function(){})-------------------------------

  
   
   // 수정하기
   function goEdit() {
   	
       // *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
      var boolFlag = false;
      
      $("input.requiredInfo").each(function(){
         var data = $(this).val().trim();
         if(data == "") {
            alert("* 표시된 필수입력사항은 모두 입력하셔야 합니다.");
            boolFlag = true;
            return false; // break; 라는 뜻이다.
         }
      });
      
      if(boolFlag) {
         return; // 종료
      }
   	

   
   
      var frm = document.editFrm;
      frm.action = "<%= ctxPath%>/member/memberEditEnd.sh";
      frm.method = "post";
      frm.submit(); 
      
      
   }// end of function goEdit()-----------------------------
   
   function goClose(){
	   self.close();
   }
   
</script>
</head>

<body>

<div align="center">

   <form name="editFrm">
   <div id="head" align="center">
         ::: 회원수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
   </div>
   <table id="tblMemberUpdate">

      <tr>
         <td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;">
             <input type="hidden" name="userid"  value="${sessionScope.loginuser.userid}" /> 
             <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required/> 
            <span class="error">성명은 필수입력 사항입니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" required/>
            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" required/> 
            <span class="error">암호가 일치하지 않습니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo"  required/> 
             <span class="error">이메일 형식에 맞지 않습니다.</span>
             
             <%-- ==== 퀴즈 시작 ==== --%>
             <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
             <span id="emailCheckResult"></span>
             <%-- ==== 퀴즈 끝 ==== --%>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">연락처</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7)  }"/>&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11)}"/>
             <span class="error">휴대폰 형식이 아닙니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">우편번호</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" value="${sessionScope.loginuser.postcode}"/>&nbsp;&nbsp;
            <%-- 우편번호 찾기 --%>
            <img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
            <span class="error">우편번호 형식이 아닙니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40"  /><br/>
            <input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40"  />&nbsp;<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40"  /> 
            <span class="error">주소를 입력하세요</span>
         </td>
      </tr>
      
      <tr>
         <td colspan="2" style="line-height: 90px;" class="text-center">
            <button type="button" id="ok" class="btn btn-dark btn-lg" >확인</button>
            <button type="button" id="close" class="btn btn-dark btn-lg">취소</button> 
            <button type="button" id="delete" class="btn btn-dark btn-lg">회원탈퇴</button> 
         </td>
      </tr>
      
   </table>
   </form>
   </div>


</body>
</html>
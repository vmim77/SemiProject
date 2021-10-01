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

<title>:::회원정보보기:::</title>

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


<script type="text/javascript">
   
   $(document).ready(function(){
      
      $("span.error").hide();
      
  	  $("button#ok").click(function(){
  			goMain();
  	  });  	  
	
  
      
   });// end of $(document).ready(function(){})-------------------------------
   
   function goMain(){
		location.href="<%= request.getContextPath()%>/index_1.sh";
   }

</script>
</head>

<body>

<div align="center">

   <form name="editFrm">
   <div id="head" align="center">
         ::: 회원보여주기 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
   </div>
   <table id="tblMember">

      <tr>
         <td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;">
             <input type="hidden" name="userid"  value="${sessionScope.loginuser.userid}" /> 
             <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required/> 
         </td>
      </tr>

      <tr>
         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo"  required/> 
            
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">연락처</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7)  }"/>&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11)}"/>
         </td>
      </tr>
   
      <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
         	<input type="text" id="postcode" name="postcode" size="6" maxlength="5" value="${sessionScope.loginuser.postcode}"/>&nbsp;&nbsp;<br/>
            <input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40"  /><br/>
            <input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40"  />&nbsp;<br/><input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40"  /> 
         </td>
      </tr>
      
      <tr>
         <td colspan="2" style="line-height: 90px;" class="text-center">
            <button type="button" id="ok" class="btn btn-dark btn-lg" >확인</button> 
         </td>
      </tr>
      
   </table>
   </form>
   </div>


</body>
</html>
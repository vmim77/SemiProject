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

<title>회원정보보기</title>

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
      /*border: 1px solid gray;*/
      margin-top: 10px;
      margin-bottom: 30px;
      padding-top: 10px;
      padding-bottom: 50px;
      font-weight: bold;
      font-size: 20pt;
      color: black;
   }
	input#username {
	
		border: none;
		font-size: 20pt;
		font-height:50%;
		font-weight: bold;
	}
	input#userinformation {
	
		border: none;		
		font-weight: italic;
	}
	input#hp1, #hp2, #hp3, #postcode, #address, #detailAddress, #extraAddress{
		border: none;		
		font-weight: italic;
		text-align: center;
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
	   
   div.container {
   		/*border : solid 5px blue; */
   }
   button#goUpdate{
   		border: none;
   		background-color: white;
   }
   td#horizon{
   	
  	border: none;
    border-top: 1px dotted gray;
    color: #fff;
    background-color: #fff;
    height: 1px;
    width: 80%;
   		
   
   }
   table#tblMember {
   }
   
   td#h1,h2,h3 {
   font-weight: bold;
   text-align: center;
   }
   
   * {
  margin-left:120px;
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


<script type="text/javascript">
   
   $(document).ready(function(){
      
      $("span.error").hide();
      
  	  $("button#ok").click(function(){
  			goMain();
  	  }); 
  	  
  	  $("button#update").click(function(){
  		 	goUpdate(); 
  	  });
	
  	  $("button#logout").click(function(){
  		  	Logout();
  	  });
  	  
      
   });// end of $(document).ready(function(){})-------------------------------
   
   function goMain(){
		location.href="<%= ctxPath%>/index.sh";
   }

   
   
   
</script>


</head>	
	
		
   <form name="editFrm" >
  
   <div id="head" align="center" style="width: 55%;">
         	내 정보 관리 
   </div>
   <table align="center" id="tblMember" style="width: 55%; " >

      <tr>        
         <td> 
             <i class="far fa-user-circle fa-5x"></i>&nbsp;&nbsp;<input type="hidden" name="userid"  value="${sessionScope.loginuser.userid}" /> 
             <input  type="text" name="username" id="username" value="${sessionScope.loginuser.name}" class="requiredInfo" required />
         </td>    
         
      </tr>
      <tr>
      	 <td  style="font-weight: bold;"><br/>고객명&nbsp;
      	 	<input type="hidden" name="userid"  value="${sessionScope.loginuser.userid}" /> 
         	<input  type="text" name="username" id="userinformation" value="${sessionScope.loginuser.name}" class="requiredInfo" required />
         </td>	
      </tr>
      
     <tr>	 
		<td  style="font-weight: bold;">이메일&nbsp;
        <input type="text" name="email" id="userinformation" value="${sessionScope.loginuser.email}" class="requiredInfo"  required/> </td>  
	</tr>
     
     <tr>
         <td  style="font-weight: bold;">연락처&nbsp;
         	 <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />-
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7)  }"/>-
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11)}"/>
        </td>
     </tr>
	  	
      <tr>
         <td style="font-weight: bold;	">주소    
         	[<input type="text" id="postcode" name="postcode" size="4" maxlength="5" value="${sessionScope.loginuser.postcode}"/>]
            <input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="27"  /><input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="12"  />
            <input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="12" />  
         </td>
      </tr>

      <tr>
         <td colspan="2" style="line-height: 90px;" class="text-center">
            <button type="button" id="edit" class="btn btn-dark btn-lg" onclick="loaction='<%=ctxPath%>/member/memberEdit.sh'">회원정보수정</button> 
            <button type="button" id="ok" class="btn btn-dark btn-lg" >확인</button> 
         </td>
      </tr>
   </table>
   </form>
 
</body>	
</html>



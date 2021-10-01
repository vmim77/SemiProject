<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	//		/MyMVC
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	window.onload = function(){
		
		alert("회원가입에 감사드립니다!!");
		
		var frm = document.loginFrm;
		frm.action ="<%= ctxPath%>/login/login.sh";
		frm.method ="post";
		frm.submit();
		
	}// end of window.onload = function()

</script>

</head>
<body>
	<form name="loginFrm">
		<input type="hidden" name="userid" 	value="${requestScope.userid}" />
		<input type="hidden" name="pwd" 	value="${requestScope.pwd}" />
	</form>
</body>
</html>
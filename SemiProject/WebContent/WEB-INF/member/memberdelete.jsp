<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
 
%>

<link href = "style.css" rel = "stylesheet" type = "text/css">
<script type="text/javascript">

      function begin()
      {
            document.myform.passwd.focus();
      }

 

      function checkIt()
      {
            if(!document.myform.passwd.value)
            {
                  alert("비밀번호를 입력하지 않으셨습니다.");
                  document.myform.passwd.focus();
                  return false;
            }
      }

</script>

 
<head><title>회원 탈퇴</title></head>
<body onload = "begin()" bgcolor = "<%= ctxPath %>">
<form name = "myform" action = "deletePro.jsp" method = "post" onSubmit = "return checkIt()">
<table cellspacing = "1" cellpadding = "1" width = "260" border = "1" align = "center">
<tr height = "30">
      <td colspan = "2" align = "middle" bgcolor = "<%= ctxPath %>">
            <font size = "+1"><b>회원 탈퇴</b></font>
      </td>
</tr>
<tr>
      <td width = "110" bgcolor = "<%= ctxPath %>" align = "center">비밀번호</td>
      <td width = "150" align = "center">
            <input type = "password" name = "passwd" size = "15" maxlength = "12">
      </td>
</tr>
<tr height = "30">
      <td colspan = "2" align = "middle" bgcolor = "<%= ctxPath %>">
            <input type = "submit" value = "회원탈퇴">
            <input type = "button" value = "취  소" onclick = "">
      </td>
</tr>
</table>
</form>
</body>
</html>

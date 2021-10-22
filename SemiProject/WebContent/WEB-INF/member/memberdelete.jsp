<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>       
    
<jsp:include page="../header.jsp" />    
<html>
<head>
    <title>탈퇴 화면</title>
    
    <style type="text/css">
        table{
            margin-left:auto; 
            margin-right:auto;
        }
        
      
        
    </style>
    
    <script type="text/javascript">
        function memberdel(){
        	
        	var frm = document.deleteform;
        	frm.method="post"; 
            frm.action="<%=ctxPath%>/member/memberOndelete.sh"; 
       		frm.submit();
       		
        }
    </script>
    
</head>
<body>
   <form name="deleteform">
   
   		<div style=" margin:90px 600px; font-weight: bold; text-align: center; " >
   			<span><span style="color: red">탈퇴 후 회원정보가 모두 삭제됩니다.</span><br>
  				     메일주소, 핸드폰 번호/기타 연락처 등 회원정보가 모두 삭제되며,<br> <span style="color: red;">삭제된 데이터는 복구되지 않습니다.</span></span>
			<hr>		
			<span> 탈퇴 후에도 작성된 게시글은 그대로 남아 있습니다.<br>
				     각 게시판에 등록한 게시물 및 댓글은 탈퇴 후에도 남아있습니다.<br>
				     삭제를 원하시는 게시물은 탈퇴 전 반드시 삭제하시기 바랍니다.<br>
				  (탈퇴 후에는 게시글 임의 삭제 요청을 받지 않습니다.)</span>
		</div>  					     
   		<div style=" margin:3px 600px; font-weight: bold; text-align: center; ">
   			<span style="color: red;">탈퇴 후에는 게시판의 게시글은 삭제할 수 없으며, 위의 안내 내용에 동의합니다.</span><br>
			<input type="checkbox" />&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-align: center;">안내사항을 모두 동의하며, 이의제기를 하지않습니다.</span>
   		</div>
        <table>
            <tr>
               	<td>비밀번호</td>
               	<td><input type="password" name="pwd" maxlength="50"></td>
            </tr>
        </table>
       			<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/> 
        <br> 
        <div style="text-align: center; height: 300px;">
	        <input type="button" value="탈퇴" onclick="memberdel();" />
    	    <input type="button" value="취소" onclick="javascript:window.location='<%=ctxPath%>/index.sh'">
        </div>
    </form>
   </body>
</html>

<jsp:include page="../footer.jsp" />

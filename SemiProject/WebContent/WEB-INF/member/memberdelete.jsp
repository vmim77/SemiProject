<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>       
    
<jsp:include page="../header.jsp" />    
<html>
<head>
    <title>Ż�� ȭ��</title>
    
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
   			<span><span style="color: red">Ż�� �� ȸ�������� ��� �����˴ϴ�.</span><br>
  				     �����ּ�, �ڵ��� ��ȣ/��Ÿ ����ó �� ȸ�������� ��� �����Ǹ�,<br> <span style="color: red;">������ �����ʹ� �������� �ʽ��ϴ�.</span></span>
			<hr>		
			<span> Ż�� �Ŀ��� �ۼ��� �Խñ��� �״�� ���� �ֽ��ϴ�.<br>
				     �� �Խ��ǿ� ����� �Խù� �� ����� Ż�� �Ŀ��� �����ֽ��ϴ�.<br>
				     ������ ���Ͻô� �Խù��� Ż�� �� �ݵ�� �����Ͻñ� �ٶ��ϴ�.<br>
				  (Ż�� �Ŀ��� �Խñ� ���� ���� ��û�� ���� �ʽ��ϴ�.)</span>
		</div>  					     
   		<div style=" margin:3px 600px; font-weight: bold; text-align: center; ">
   			<span style="color: red;">Ż�� �Ŀ��� �Խ����� �Խñ��� ������ �� ������, ���� �ȳ� ���뿡 �����մϴ�.</span><br>
			<input type="checkbox" />&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-align: center;">�ȳ������� ��� �����ϸ�, �������⸦ �����ʽ��ϴ�.</span>
   		</div>
        <table>
            <tr>
               	<td>��й�ȣ</td>
               	<td><input type="password" name="pwd" maxlength="50"></td>
            </tr>
        </table>
       			<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/> 
        <br> 
        <div style="text-align: center; height: 300px;">
	        <input type="button" value="Ż��" onclick="memberdel();" />
    	    <input type="button" value="���" onclick="javascript:window.location='<%=ctxPath%>/index.sh'">
        </div>
    </form>
   </body>
</html>

<jsp:include page="../footer.jsp" />

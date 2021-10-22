<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">

	alert("${requestScope.message}");
	
	opener.location.href = "${requestScope.loc}";
	
	// 팝업창 닫기
	self.close();

</script>
</html>
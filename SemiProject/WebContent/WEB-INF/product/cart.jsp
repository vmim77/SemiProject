<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String ctxPath = request.getContextPath();
%>    
    
<jsp:include page="/WEB-INF/header.jsp" />

<style type="text/css">

</style>

<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
				
	$(document).ready(function(){
		
		
	});//end of $(docunment).ready(function(){
		
</script>

<div>
<!-- {requestScope.img} -->
</div>
<h2>fsdlfdsafdsafds</h2>
<div>
${requestScope.cartname}

<h1>테스트테스트</h1>
</div>

<div>
${requestScope.cartopt123}
</div>

<div>
${requestScope.cartopt4}
</div>

<div>
${requestScope.cartnum}
</div>

<div>
${requestScope.cartprice}
</div>

<div>
${requestScope.cartfinopt}
</div>

<h2>fsdlfdsafdsafds</h2>

<jsp:include page="/WEB-INF/footer.jsp" />
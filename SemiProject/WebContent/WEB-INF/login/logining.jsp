<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String ctxPath = request.getContextPath();
 
%>

<script>

</script>

 *** 로그인 되어진 화면 *** 
<c:if test="${not empty sessionScope.loginuser}">
	<table style="width: 95%; height: 130px;">
          <tr style="background-color: #f2f2f2;">
             <td align="center" style="padding: 20px;">
                <span style="color: blue; font-weight: bold;">${(sessionScope.loginuser).name}</span>
                [<span style="color: red; font-weight: bold;">${(sessionScope.loginuser).userid}</span>]님
                <br/><br/>
                <div align="left" style="padding-left: 20px; line-height: 150%;">
                   <span style="font-weight: bold;">코인액&nbsp;:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).coin}" pattern="###,###" /> 원
                   <br/>
                   <span style="font-weight: bold;">포인트&nbsp;:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
                </div>
                <br/>로그인 중...<br/><br/>
                [<a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');">나의정보</a>]&nbsp;&nbsp;
                 [<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).userid}');">코인충전</a>] 
                 <br/><br/>
                <button type="button" class="btn btn-danger" onclick="goLogOut();">로그아웃</button>
             </td>
          </tr>
    </table> 
</c:if>
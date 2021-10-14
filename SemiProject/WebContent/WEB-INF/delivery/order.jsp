<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<jsp:include page="../header.jsp" />


<div>
    <div class="title">
        <h3>주문 상품 정보</h3>
    </div>
    <table border="1" summary="">
        <caption>주문 상품 정보</caption>
        <thead>
            <tr>
                <th scope="col" class="number">주문일자<br />[주문번호]</th>
                <th scope="col" class="product">상품정보</th>
                <th scope="col" class="price">상품구매금액</th>
                <th scope="col" class="state">주문처리상태</th>
            </tr>
        </thead>
        <tbody class="{$list_display|display}">
            <tr>
                <td class="number">
                    2021.10.14
                    <p><a href="detail_old.html{$param_detail}" class="line">민경만두</a></p>
                </td>
                <td class="product"><strong>승우조질 야구방망이</strong> <span>(총 1개 품목)</span></td>
                <td class="price"><strong>49,000</strong></td>
                <td class="state">배송진행중</td>
            </tr>
            <tr>
                <td class="number">
                    2021.10.13
                    <p><a href="detail_old.html{$param_detail}" class="line">금길영</a></p>
                </td>
                <td class="product"><strong>옥스포드 방망이</strong> <span>(총1개 품목)</span></td>
                <td class="price"><strong>169,000</strong></td>
                <td class="state">배송준비중</td>
            </tr>
        </tbody>
        <tbody class="{$empty_display|display}">
            <tr>
                <td colspan="4" class="empty">주문 내역이 없습니다</td>
            </tr>
        </tbody>
    </table>
</div>
 
<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="../header.jsp" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" >

<style type="text/css">

/*     table, tr, td{
        border:solid 1px red;   
   } */
   
	a#add {
	
	color: pick;
	
	}
 	
   
   a {
   
   color: black;
   font-size: 12pt;
   text-decoration: none;
   }

	
   div#contents {
   
   margin-left: 150px;
   }
   
   td {
   	border-top: solid 1px gray;
   	border-bottom: solid 1px gray;
   	border-left: none;
   	border-right: none;
   	border-top:none;
   }
   
    .titleArea h2 {
    padding-top: 80px;
    padding-right:150px;
    color: #000;
    font-size: 30px;
    font-family: "arimo",mg;
    font-weight: 700;
    letter-spacing: .05em; 
}
   	
   	
   	#menu {
	position: relative;
    display: block;
    height: 70px;
    /* border: 2px solid #ccc; */
    text-align: center;
    background: #fff;
    margin-bottom: 25px;
    border-color: pick;
    padding: 3px;

}


</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#trade").click(function(){
			
			 $("input#jumun_bunho").val($(this).next().val());
			
			
			  var frm = document.change;
		      frm.action = "<%= ctxPath%>/delivery/orderchange.sh";
		      frm.method = "post";
		      frm.submit(); 
			
			
		}); 
		
		
	}); // end of $(document).ready(function(){})-----------------------------
</script>

    
<div id="contents">
<div class="titleArea" style="text-align: center; ">
    <h2 style="font-wei">MY PAGE</h2>
</div>
<div id="menu" class="container" style="width:1000px; margin:100px 300px; height:100px; font-family:맑은 고딕;">
    <div style="text-align: center; margin-top: 30px">
      <span><a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');" style="text-decoration: none;">정보수정</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/memberCalendar.sh" style="text-decoration: none;">출석체크</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/cart.sh" style="text-decoration: none;">장바구니</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/member/memberdelete.sh" style="text-decoration: none;">회원탈퇴</a></span>
    </div>
</div>

<table id="" style="border: solid 2px gray; width: 1200px; ">
	<tr>
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:900px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_1.png"/>
				${(sessionScope.loginuser.name)}님 환영합니다<br>
			</span>
		</td>
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_2.png"/>
				<div style="font-size:9pt; margin-top:7px;">
					총 주문액
				</div>
				<div style="font-size:12pt; font-weight:bold;">
				<fmt:formatNumber value="${requestScope.buyMoney}" pattern="###,###" />원
				</div>
			</span>
		</td>
	
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_3.png"/>
				<div style="font-size:9pt; margin-top:7px; margin-left: 5px;">
				<div style="font-size:9pt; margin-top:7px;">
					포인트
				</div>
				<div style="font-size:12pt; font-weight:bold;">
				<fmt:formatNumber value="${sessionScope.loginuser.point}" pattern="###,###" />원
				</div>
				
			</div>
		</span>
		</td> 
		
		
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px; margin-left: 13px;" id="profile" src="../images/image_4.png"/>
				<div style="font-size:9pt; margin-top:7px; margin-left: 20px;">
					 <!-- 	<!-- modal 구동 버튼 (trigger) -->
		<button type="button" id="gobtn" class="btn btn-outline-secondary" data-toggle="modal" data-target="#myModal">
		  	쿠폰
		</button>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel" style="text-align: right;">쿠폰내역</h4>
      </div>
      
      <div class="modal-body">
        	<table border="1">
        	 <tr>
				<th scope="col" class="" style="height: 50px; width: 350px">쿠폰발급일자</th>
                <th scope="col" class="" style="height: 50px; width: 350px; text-align: center;">쿠폰명</th>
                <th scope="col" class="" style="height: 50px; width: 150px; text-align: center;">할인금액</th>
                <th scope="col" class="" style="height: 50px; width: 500px; text-align: center;" >유효기간</th>
            </tr>
            
        <c:forEach  var= "mvo" items="${requestScope.libo}" >
			<tr>
				<td class="" style="height: 50px; width: 300px;">${mvo.coupondate}</td>
                <td style="height: 50px; width: 400px; text-align: center;">${mvo.couponname}</td> 
                <td class="" style="height: 50px; width: 300px; text-align: center;"> <a href=""></a>${mvo.coupondiscount}원</td>
                <td class="" style="height: 50px; width: 400px; text-align: center;">${mvo.couponlastday}</td>
            </tr>
		</c:forEach>
       
            
        	</table>
      </div>
     		<div class="modal-footer">
       		 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	  </div>
	</div>
	</span>
		</td>
	</tr>
</table><br>

<!-- 여기서부터 디자인 시작 -->
                <table style="overflow: auto;">
                  <tr style="font-size:13pt; font-weight:bold; height:50px; text-align:left; padding-bottm:15px;">
                     <td colspan="8" style="padding-left:15px;">
                        주문내역
                     </td>
                  </tr>
                  <tr style="background-color:#f5f5ef; border-bottom:solid 1px #d0d0e2; border-top:solid 1px #d0d0e2;">                  
           			<td style="width:200px; height:30px; font-size:10pt; color:black; text-align:center;">
                        주문일자
                     </td>
                     <td style="width:200px; height:30px; font-size:10pt; color:black; text-align:center;">
                        상품이미지
                     </td>
                     <td style="width:600px; font-size:10pt; color:black; text-align:center;">
                        상품정보
                     </td >
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        수량
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        총 가격
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        주문번호
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        주문상태
                     </td>
                     <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                        환불/교환
                     </td>
                  </tr>
                  <c:if test="${empty requestScope.buyList && requestScope.checkidnull ne 'no'}">
                     <tr>
                        <td colspan="7" style="height:200px; text-align:center; font-size:11pt;">
                           고객님의 구매내역이 없습니다
                        </td>
                     </tr>   
                  </c:if>
                  <c:if test="${requestScope.checkidnull eq 'no'}">
                     <tr>
                        <td colspan="8" style="height:200px; text-align:center; font-size:11pt;">
                           로그인 후 조회 가능합니다.
                        </td>
                     </tr>   
                  </c:if>      
                  <c:if test="${not empty requestScope.buyList && requestScope.checkidnull ne 'no'}">
                     <c:forEach var="buyList" items="${requestScope.buyList}" varStatus="status">
                     	<c:if test="${status.index < 3 }">
                        <tr style="border-bottom:solid 1px gray;">            
                        	<td style="width:200px; font-size:10pt; color:black; text-align:left; padding-left:30px;">
                              ${buyList.buy_date}
                           </td >
                           <td style="width:200px; height:150px; font-size:10pt; color:black; text-align:center;">
                              <img style="width:200px; height:150;" id="chun" src="${buyList.fk_pimage3}"/>
                           </td>
                           <td style="width:600px; font-size:10pt; color:black; text-align:left; padding-left:30px;">
                              ${buyList.buy_opt_info}
                           </td >
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              ${buyList.buy_qty}
                           </td>
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              <fmt:formatNumber value="${buyList.buy_opt_price + buyList.buy_pro_price}" pattern="###,###" />원
                           </td>
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              ${buyList.jumun_bunho}
                           </td>
                           <td style="width:100px; font-size:10pt; color:black; text-align:center;">
                              <c:choose>
                                 <c:when test="${buyList.baesong_sangtae eq 0}">배송준비</c:when>
                                 <c:when test="${buyList.baesong_sangtae eq 1}">배송중</c:when>
                                 <c:when test="${buyList.baesong_sangtae eq 2}">배송완료</c:when>
                                 <c:when test="${buyList.baesong_sangtae eq 3}">환불</c:when>
                                 <c:when test="${buyList.baesong_sangtae eq 4}">교환</c:when>
                              </c:choose>
                           </td>
                           <td style="width:100px; font-size:9pt; color:black; text-align:center;">
                           		<button id="trade" class="btn btn-success">환불/교환</button>
                           		<input type="hidden" value="${buyList.jumun_bunho}">
                           </td>
                        </tr>
                        </c:if>
                     </c:forEach>
                  </c:if>
               </table>
               
               
  
               
               
<form name="change">
	<input type="hidden" id="jumun_bunho" name="jumun_bunho" value="" />
	<input style="display: none;">
</form>





<%-- 최근등록게시물 ####################################################################################### --%>
<br>

	<div id="mp-board" class="xans-element- xans-myshop xans-myshop-boardpackage "><div class="title">
        <h3 style="text-align:left;  font-weight:bold; font-size:16pt; color:black;">최근등록게시물</h3>
    </div>
		<table  style=" border: solid 2px gray; border-left: none; border-right: none;">
		
			<tr>
				<th scope="col" style="height: 50px; width: 300px;">번호</th>
                <th scope="col" style="height: 50px; width: 400px">제목</th>
                <th scope="col" style="height: 50px; width: 300px">작성자</th>
                <th scope="col" style="height: 50px; width: 400px">작성일</th>
                <th scope="col" style="height: 50px; width: 100px">조회</th>
            </tr>
		<c:if test="${empty requestScope.list ne 'no'}">
                     <tr>
                        <td colspan="5" style="height:200px; text-align:center; font-size:11pt;">
                           작성된 글이 없습니다.
                        </td>
                     </tr>   
                  </c:if>
	
		<c:forEach  var= "bvo" items="${requestScope.list}" varStatus="status">
			<c:if test="${status.index < 3}" >
			<tr>
				<td class="" style="height: 200px; width: 300px;">${bvo.boardno}</td>
                <td style="height: 200px; width: 400px">${bvo.title}</td> 
                <td class="" style="height: 200px; width: 300px">${bvo.fk_writer}</td>
                <td class="" style="height: 200px; width: 400px">${bvo.writetime}</td>
                <td class="" style="height: 200px; width: 100px">${bvo.viewcnt}</td>
            </tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>



	<br>
</div>
</div>

<br>
<jsp:include page="../footer.jsp" /> 
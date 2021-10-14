<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>


<jsp:include page="../header.jsp" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

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
   }
   
    .titleArea h2 {
    padding: 5% 45% 12px;
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
		

		
	}); // end of $(document).ready(function(){})-----------------------------
</script>

    
<div id="contents">
<div class="titleArea" style="text-align: center; ">
    <h2 style="font-wei">MY PAGE</h2>
</div>
<div id="menu" class="container" style="width:1000px; margin:100px 300px; height:100px; font-family:맑은 고딕;">
    <div style="text-align: center; margin-top: 30px">
      <span><a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');" style="text-decoration: none;">정보수정</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath%>/delivery/order.sh"  style="text-decoration: none;">주문내역</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/memberCalendar.sh" style="text-decoration: none;">출석체크</a></span> &nbsp;&nbsp;
      <span><a href="" style="text-decoration: none;">장바구니</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/member/memberdelete.sh" style="text-decoration: none;">회원탈퇴</a></span>
    </div>
</div>

<table id="" style="border: solid 2px gray; width: 1200px;">
	<tr>
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:900px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_1.png"/>
				${(sessionScope.loginuser.name)}님은 [화이트] 회원입니다.<br>
			</span>
		</td>
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_2.png"/>
				<div style="font-size:9pt; margin-top:7px;">
					총 주문액
				</div>
				<div style="font-size:12pt; font-weight:bold;">
					200,000원<!-- 값넣어야함  -->
				</div>
			</span>
		</td>
		
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_3.png"/>
				<div style="font-size:9pt; margin-top:7px; margin-left: 5px;">
				<button type="button" id="gobtn2" class="btn btn-success" data-toggle="modal" data-target="#myModal2">
		  			적립금
				</button>
				
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel" style="text-align: right;">포인트내역</h4>
      </div>
      
      <div class="modal-body">
        	<table border="1">
        	 <tr>
				<th scope="col" class="" style="height: 50px; width: 150px">적립일자</th>
                <th scope="col" class="" style="height: 50px; width: 150px; text-align: center;">적립	금액</th>
                <th scope="col" class="" style="height: 50px; width: 150px; text-align: center;">사용한포인트</th>
                <th scope="col" class="" style="height: 50px; width: 150px; text-align: center;">사용가능포인트</th>
            </tr>
            
        <c:forEach  var= "mvo" items="${requestScope.libo}" >
			<tr>
				<td class="" style="height: 50px; width: 150px;">${mvo.coupondate}</td>
                <td style="height: 50px; width: 150px; text-align: center;">${mvo.couponname}</td> 
                <td style="height: 50px; width: 150px; text-align: center;">${mvo.couponname}</td> 
                <td class="" style="height: 50px; width: 150px; text-align: center;"> <a href=""></a>${mvo.coupondiscount}원</td>
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
		
		
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px; margin-left: 13px;" id="profile" src="../images/image_4.png"/>
				<div style="font-size:9pt; margin-top:7px; margin-left: 20px;">
					 <!-- 	<!-- modal 구동 버튼 (trigger) -->
		<button type="button" id="gobtn" class="btn btn-success" data-toggle="modal" data-target="#myModal">
		  	쿠폰
		</button>

<!-- Modal -->
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

	<div style="font-weight:bold; font-size:16pt; color:black;">
		<h3>최근주문정보</h3>
		<span class="" ><a href="" id="add">더보기</a></span>
	</div>
<table style="border: solid 2px gray; border-left: none; border-right: none;">
        <thead><tr>
				<th scope="col" class="number" style="height: 50px; width: 150px">주문일자 [주문번호]</th>
                <th scope="col" class="" style="height: 50px; width: 350px; text-align: center;">이미지</th>
                <th scope="col" class="" style="height: 50px; width: 500px; text-align: center;">상품정보</th>
                <th scope="col" class="quantity" style="height: 50px; width: 150px; text-align: left;">수량</th>
                <th scope="col" class="price" style="height: 50px; width: 200px">상품구매금액</th>
                <th scope="col" class="service" style="height: 50px; width: 150px">취소/교환/반품</th>
            </tr></thead>
	<tbody class="displaynone">
		<tr class="">
				<td class="number displaynone">
                 <a href="" class="btn_addr displaynone"><span>2021-10-12</span></a>
         		  </td>
                <td class=""><a href=""><img src=""></a></td>
                <td class="">
                </td>
               		<td class=""></td>
                	<td class=""> 
					<strong></strong><div class="displaynone"></div>
				</td>
               <td class="number displaynone">
                 <a href="<%=ctxPath %>/delivery/orderchange.sh" class="btn_addr displaynone" style="text-align: center;"><span>교환/환불</span></a>
           		</td>
            </tr>
</tbody>
</table>

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
	
		<c:forEach  var= "bvo" items="${requestScope.list}" varStatus="status">
			<c:if test="${status.index < 3}" >
			<tr>
				<td class="" style="height: 200px; width: 300px;">${bvo.boardno}</td>
                <td style="height: 200px; width: 400px">${bvo.title }</td> 
                <td class="" style="height: 200px; width: 300px"> <a href=""></a>${bvo.fk_writer}</td>
                <td class="" style="height: 200px; width: 400px">${bvo.writetime}</td>
                <td class="" style="height: 200px; width: 100px">${bvo.viewcnt}</td>
            </tr>
			</c:if>
		</c:forEach>
		
</tbody>
</table>

		`<div>
			<p class="text-center">
			    <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
				<button type="button" class="btn btn-secondary btn-lg" id="btnMoreHIT" value="">더보기</button>
				<span id="totalHITCount">${requestScope.totalHITCount}</span>
			</p>
		</div>

	<br>

<table style="border: solid 2px gray; border-left: none; border-right: none;">
	<tr>
		<td colspan="2" style="text-align:left; height:80px; font-weight:bold; font-size:16pt; color:black;">관심상품목록
		<td style="text-align:right;"><button class="alert alert-light" style="border: solid 1px gray;">더보기 ></button>
		</td>
	</tr>
	
	<tr>
	  <td colspan="2" style="height: 200px; width: 1300px" ></td>
	  <td style="height: 200px; width: 200px" ></td>
	</tr>
</table>
</div>
</div>

<br>
<jsp:include page="../footer.jsp" /> 
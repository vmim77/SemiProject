<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
   String ctxPath = request.getContextPath();
 
%>   
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

    
<div id="contents">
<div class="titleArea" style="text-align: center; ">
    <h2 style="font-wei">MY PAGE</h2>
</div>
<div id="menu" class="container" style="width:1000px; margin:100px 300px; height:100px; font-family:맑은 고딕;">
    <div style="text-align: center; margin-top: 30px">
      <span><a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');" style="text-decoration: none;">정보수정</a></span> &nbsp;&nbsp;
      <span><a href="" style="text-decoration: none;">주문내역</a></span> &nbsp;&nbsp;
      <span><a href="<%= ctxPath %>/member/calendar.sh" style="text-decoration: none;">출석체크</a></span> &nbsp;&nbsp;
      <span><a href="" style="text-decoration: none;">장바구니</a></span> &nbsp;&nbsp;
      <span><a href="" style="text-decoration: none;">내가쓴게시물</a></span> &nbsp;&nbsp;
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
					내 적립금
				</div>
				<div style="font-size:12pt; font-weight:bold; margin-left: 5px;">
					4,500원<!-- 값넣어야함  -->
				</div>
			</span>
		</td>
		<td style="text-align:left; height:120px; background-color:#f5f5ef;">
			<span style="background-color:#f5f5ef; display:inline-block; height:100px; width:200px; padding-top:10px; padding-left:40px; font-size:10pt; border-right:solid 1px #d0d0e2;">
				<img style="height:80px; padding-right:10px;" id="profile" src="../images/image_4.png"/>
				<div style="font-size:9pt; margin-top:7px; margin-left: 20px;">
					 <%-- <a href="<%= ctxPath %>/member/memberCoupon.sh">쿠폰</a> --%>
					 <!-- 	<!-- modal 구동 버튼 (trigger) -->
		<button type="button" class="" data-toggle="modal" data-target="#myModal">
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
                <th scope="col" class="" style="height: 50px; width: 350px">쿠폰명</th>
                <th scope="col" class="" style="height: 50px; width: 150px">할인율</th>
                <th scope="col" class="" style="height: 50px; width: 500px; text-align: center;" >유효기간</th>
                <th scope="col" class="" style="height: 50px; width: 250px">상태</th>
            </tr>
            
            <tr>
            	<td>2021-10-10</td>
            	<td>신규가입쿠폰</td>
            	<td>10%</td>
            	<td style="text-align: center;">2021-10-16</td>
            	<td>사용가능</td>
            </tr>
            <tr>
            	<td>2021-10-10</td>
            	<td>신규가입쿠폰</td>
            	<td>10%</td>
            	<td style="text-align: center;">2021-10-16</td>
            	<td>사용가능</td>
            </tr>
            <tr>
            	<td>2021-10-10</td>
            	<td>신규가입쿠폰</td>
            	<td>10%</td>
            	<td style="text-align: center;">2021-10-16</td>
            	<td>사용가능</td>
            </tr>
            <tr>
            	<td>2021-10-10</td>
            	<td>신규가입쿠폰</td>
            	<td>10%</td>
            	<td style="text-align: center;">2021-10-16</td>
            	<td>사용가능</td>
            </tr>
            <tr>
            	<td>2021-10-10</td>
            	<td>신규가입쿠폰</td>
            	<td>10%</td>
            	<td style="text-align: center;">2021-10-16</td>
            	<td>사용가능</td>
            </tr>
            
        	</table>
      </div>
     		<div class="modal-footer">
       		 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	  </div>
	</div>
		<div style="font-size:12pt; font-weight:bold; margin-left: 20px;">
			 50장<!-- 값넣어야함  -->
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
                <th scope="col" class="" style="height: 50px; width: 150px">이미지</th>
                <th scope="col" class="" style="height: 50px; width: 650px">상품정보</th>
                <th scope="col" class="quantity" style="height: 50px; width: 100px">수량</th>
                <th scope="col" class="price" style="height: 50px; width: 150px">상품구매금액</th>
                <th scope="col" class="state" style="height: 50px; width: 150px">주문처리상태</th>
                <th scope="col" class="service" style="height: 50px; width: 150px">취소/교환/반품</th>
            </tr></thead>
	<tbody class="displaynone">
		<tr class="">
			<td class="number displaynone">
                 <a href="#none" class="btn_addr displaynone" onclick=""><span>주문취소</span></a>
                 <a href="cancel.html" class="btn_addr displaynone button"><span>취소신청</span></a>
                 <a href="exchange.html" class="btn_addr displaynone button"><span>교환신청</span></a>
                 <a href="return.html" class="btn_addr displaynone button"><span>반품신청</span></a>
           </td>
           
                <td class="thumb"><a href=""><img src="../images/image_6.PNG" alt=""></a></td>
                <td class="">
					 오징어게임에 참가해보시겠어연 ?
                </td>
               		<td class="quantity">1</td>
                	<td class="price"> 25,000원
					<strong></strong><div class="displaynone"></div>
				</td>
                <td class="state">
                    <p></p>
                    <p class="displaynone"><a href="" target=""></a></p>
                    <a href="/board/product/write.html" class="btn_addr displaynone"><span>구매후기</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>취소철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>교환철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>반품철회</span></a>
                </td>
                <td class="service">
                    <p class="displaynone"><a href="#none" class="line" onclick="">[상세정보]</a></p>
                </td>
            </tr>
</tbody>
</table>

<br>

	<div id="mp-board" class="xans-element- xans-myshop xans-myshop-boardpackage "><div class="title">
        <h3 style="text-align:left;  font-weight:bold; font-size:16pt; color:black;">최근등록게시물</h3>
		<span class="more_view"><a href="/myshop/board_list.html">더보기</a></span>
    </div>
		<table  style=" border: solid 2px gray; border-left: none; border-right: none;">
		
			<tr>
				<th scope="col">번호</th>
                <th scope="col">분류</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회</th>
            </tr>
	
			<tr>
				<td class="noData" style="height: 200px; width: 100px">게시물이 없습니다.</td>
                <td class="category" style="height: 200px; width: 200px"><a href=""></a>오징어!!</td>
                <td class="subject" style="height: 200px; width: 900px"> <a href=""></a>길영이는 12시에일어났어요</td>
                <td style="height: 200px; width: 100px">${sessionScope.loginuser.name }</td>
                <td class="txtLess" style="height: 200px; width: 100px">2021-10-07</td>
                <td class="txtLess" style="height: 200px; width: 100px">2</td>
            </tr>
</tbody>
</table>

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
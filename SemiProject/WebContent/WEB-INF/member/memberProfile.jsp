<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>

<jsp:include page="/WEB-INF/header.jsp" />


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 



<style type="text/css">

.titleArea h2 {
    padding: 5% 45% 12px;
    color: #000;
    font-size: 30px;
    font-family: "arimo",mg;
    font-weight: 700;
    letter-spacing: .05em;
}



a {
	color: black;
}

#mp_menu {
position: relative;
    display: block;
    height: 70px;
    border: 2px solid #ccc;
    text-align: center;
    background: #fff;
    margin-bottom: 25px;
    border-color: pick;
    padding: 3px;

}

#mp_menu li {
    display: table-cell;
    vertical-align: middle;
    padding: 20px 40px;
}

#m-1 {
	border: solid 2px red;
}

#mp_board {
    position: relative;
    display: block;
    background: #f5f5f5 url(/ruben/common/bg_mpchart.png) 50% 50% no-repeat;
    padding: 45px 20px 45px 40px;
    min-height: 100px;
    font-size: 0;
    margin: 20px auto;
}
html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td, img {
    margin: 0;
    padding: 0;
}
div {
    display: block;
}
body, code {
    font: 0.75em montserrat,nanum gothic,Verdana,Dotum,AppleGothic,sans-serif;
    color: #353535;
    background: #fff;
}

#mp_board .member_info .description h1 {
    color: #000;
    font-size: 13px;
    font-weight: normal;
    padding-bottom: 5px;
}
h1, h3 {
    margin: 0;
}
html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td, img {
    margin: 0;
    padding: 0;
}
h1 {
    display: block;
    font-size: 2em;
    margin-block-start: 0.67em;
    margin-block-end: 0.67em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
#mp_board .member_info .description {
    display: inline-block;
    vertical-align: middle;
    font-size: 11px;
    font-family: "lato",nanum gothic;
    color: #999;
    line-height: 18px;
}
#mp_board .member_info {
    display: inline-block;
    width: 35%;
    vertical-align: middle;
    font-size: 0;
}

body, code {
    font: 0.75em montserrat,nanum gothic,Verdana,Dotum,AppleGothic,sans-serif;
    color: #353535;
    background: #fff;
}

.quick_chart {
    display: inline-block;
    width: 65%;
    text-align: right;
    vertical-align: middle;
}

body, code {
    font: 0.75em montserrat,nanum gothic,Verdana,Dotum,AppleGothic,sans-serif;
    color: #353535;
    background: #fff;
}

.quick_chart li {
    display: table-cell;
    vertical-align: top;
    width: 150px;
    text-align: center;
    font-size: 11px;
    color: #999;
    letter-spacing: -0.075em;
}


li {
    list-style: none;
}
li {
    list-style: none;
}
li {
    text-align: -webkit-match-parent;
}
ul {
    list-style-type: disc;
}
.quick_chart {
    display: inline-block;
    width: 65%;
    text-align: right;
    vertical-align: middle;
}
#mp_board {
    position: relative;
    display: block;
    background: #f5f5f5 url(/ruben/common/bg_mpchart.png) 50% 50% no-repeat;
    padding: 45px 20px 45px 40px;
    min-height: 100px;
    font-size: 0;
    margin: 20px auto;
}
body, code {
    font: 0.75em montserrat,nanum gothic,Verdana,Dotum,AppleGothic,sans-serif;
    color: #353535;
    background: #fff;
}



</style>

<script type="text/javascript">
   
</script>

<div id="contents">
            
<div class="titleArea">
    <h2>MY PAGE</h2>
</div>

<div class="xans-element- xans-layout xans-layout-logincheck1 "><</div>


<div id="mp_menu" class="xans-element- xans-myshop xans-myshop-main "><ul>
<li><a href="/member/modify.html">정보수정</a></li>
<li><a href="/myshop/order/list.html">주문내역</a></li>
<li><a href="/myshop/mileage/historyList.html">적립금 내역</a></li>
<li class=""><a href="/myshop/deposits/historyList.html">예치금 내역</a></li>
<li><a href="/myshop/wish_list.html">관심상품</a></li>
<li><a href="/myshop/coupon/coupon.html">할인쿠폰</a></li>
<li><a href="/myshop/board_list.html">내가쓴게시물</a></li>
<li><a href="/myshop/addr/list.html">배송주소록</a></li>
</ul>
</div>


<div id="mp_board">
<div class="xans-element- xans-myshop xans-myshop-asyncbenefit"><!--- 간단회원정보 --->
<div class="member_info">
<p class="thumbnail"><img src="/ruben/common/ico_member_default.png" alt="" onerror="this.src='/ruben/common/ico_member_default.png';"></p>
<div class="description">
<h1><span><span class="xans-member-var-name">빵긋</span></span>님의 회원등급은 <span class="xans-member-var-group_name">화이트</span><span class="myshop_benefit_ship_free_message"></span>입니다.</h1>
<p class="myshop_benefit_display_no_benefit"><strong class="txtEm"><span class="myshop_benefit_dc_pay"></span> <span class="myshop_benefit_dc_min_price">0원 이상</span></strong> 구매시 <strong class="txtEm"><span class="myshop_benefit_dc_price">0원</span><span class="myshop_benefit_dc_type"></span></strong>을 <span class="myshop_benefit_use_dc">추가할인없음</span> 받으실 수 있습니다. <span class="myshop_benefit_dc_max_percent"></span></p>
<p class="displaynone myshop_benefit_display_with_all "><strong class="txtEm"><span class="myshop_benefit_dc_pay"></span> <span class="myshop_benefit_dc_min_price_mileage">0원 이상</span></strong> 구매시 <strong class="txtEm"><span class="myshop_benefit_dc_price_mileage">0원</span><span class="myshop_benefit_dc_type_mileage"></span></strong>을 <span class="myshop_benefit_use_dc_mileage"></span> 받으실 수 있습니다. <span class="myshop_benefit_dc_max_mileage_percent"></span></p>
<p><a href="<%=ctxPath%>/member/memberEdit.">회원정보수정</a></p>
</div>
</div>
<!---// 간단회원정보 --->
<!--- 퀵차트 --->
<div class="quick_chart">
<ul class="xans-element- xans-myshop xans-myshop-asyncbankbook "><li class="total_price" onclick="'">
<p>총주문금액</p>
<h1><span id="xans_myshop_bankbook_order_price">240,000원</span></h1>
</li>
<li class="mileage" onclick="'">
<p>적립금</p>
<h1><span id="xans_myshop_bankbook_avail_mileage">600,100원</span></h1>
</li>
<li class="coupon " onclick="'">
<p>쿠폰</p>
<h1><span id="xans_myshop_bankbook_coupon_cnt">20장</span></h1>
</li>
</ul>
</div>
<!---// 퀵차트 --->
</div>
</div>



<!------------------ 주문내역 ------------------>
<div id="mp-order" class="xans-element- xans-myshop xans-myshop-orderhistorylistitem"><!--
        $login_url = /member/login.html
    -->
<div class="title">
        <h3>최근주문정보</h3>
		<span class="more_view"><a href="/myshop/order/list.html">더보기</a></span>
    </div>
<table border="1" summary="" id="mp-table">
<caption>주문 상품 정보</caption>
        <thead><tr>
<th scope="col" class="number">주문일자 [주문번호]</th>
                <th scope="col" class="thumb">이미지</th>
                <th scope="col" class="product">상품정보</th>
                <th scope="col" class="quantity">수량</th>
                <th scope="col" class="price">상품구매금액</th>
                <th scope="col" class="state">주문처리상태</th>
                <th scope="col" class="service">취소/교환/반품</th>
            </tr></thead>
<tbody class="displaynone">
<tr class="">
<td class="number displaynone">
                                        <p><a href="detail.html" class="line">[]</a></p>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>주문취소</span></a>
                    <a href="cancel.html" class="btn_addr displaynone button"><span>취소신청</span></a>
                    <a href="exchange.html" class="btn_addr displaynone button"><span>교환신청</span></a>
                    <a href="return.html" class="btn_addr displaynone button"><span>반품신청</span></a>
                </td>
                <td class="thumb"><a href="/product/detail.html"><img src="http://img.echosting.cafe24.com/thumb/img_product_small.gif" onerror="this.src='http://img.echosting.cafe24.com/thumb/img_product_small.gif';" alt=""></a></td>
                <td class="product">
                    <a href="/product/detail.html"><strong></strong></a>
                    <div class="option displaynone"></div>
                    <ul class="xans-element- xans-myshop xans-myshop-optionset option"><li class="">
<strong></strong> (개)</li>
</ul>
<p class="free displaynone">무이자할부 상품</p>
                </td>
                <td class="quantity"></td>
                <td class="price">
<strong></strong><div class="displaynone"></div>
</td>
                <td class="state">
                    <p></p>
                    <p class="displaynone"><a href="" target=""></a></p>
                    <p class="displaynone"><a href="#none" class="line" onclick="">[]</a></p>
                    <a href="/board/product/write.html" class="btn_addr displaynone"><span>구매후기</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>취소철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>교환철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>반품철회</span></a>
                </td>
                <td class="service">
                    <p class="displaynone"><a href="#none" class="line" onclick="">[상세정보]</a></p>
                    <p class="displaynone">-</p>
                </td>
            </tr>
<tr class="">
<td class="number displaynone">
                                        <p><a href="detail.html" class="line">[]</a></p>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>주문취소</span></a>
                    <a href="cancel.html" class="btn_addr displaynone button"><span>취소신청</span></a>
                    <a href="exchange.html" class="btn_addr displaynone button"><span>교환신청</span></a>
                    <a href="return.html" class="btn_addr displaynone button"><span>반품신청</span></a>
                </td>
                <td class="thumb"><a href="/product/detail.html"><img src="http://img.echosting.cafe24.com/thumb/img_product_small.gif" onerror="this.src='http://img.echosting.cafe24.com/thumb/img_product_small.gif';" alt=""></a></td>
                <td class="product">
                    <a href="/product/detail.html"><strong></strong></a>
                    <div class="option displaynone"></div>
                    <ul class="xans-element- xans-myshop xans-myshop-optionset option"><li class="">
<strong></strong> (개)</li>
</ul>
<p class="free displaynone">무이자할부 상품</p>
                </td>
                <td class="quantity"></td>
                <td class="price">
<strong></strong><div class="displaynone"></div>
</td>
                <td class="state">
                    <p></p>
                    <p class="displaynone"><a href="" target=""></a></p>
                    <p class="displaynone"><a href="#none" class="line" onclick="">[]</a></p>
                    <a href="/board/product/write.html" class="btn_addr displaynone"><span>구매후기</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>취소철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>교환철회</span></a>
                    <a href="#none" class="btn_addr displaynone" onclick=""><span>반품철회</span></a>
                </td>
                <td class="service">
                    <p class="displaynone"><a href="#none" class="line" onclick="">[상세정보]</a></p>
                    <p class="displaynone">-</p>
                </td>
            </tr>
</tbody>
<tbody class=""><tr>
<td colspan="7" class="empty">주문 내역이 없습니다.</td>
            </tr></tbody>
</table>
</div>
<!------------------// 주문내역 ------------------>







<!------------------ 내가쓴게시물 ------------------>
<div id="mp-board" class="xans-element- xans-myshop xans-myshop-boardpackage "><div class="title">
        <h3>최근등록게시물</h3>
		<span class="more_view"><a href="/myshop/board_list.html">더보기</a></span>
    </div>
<div class="xans-element- xans-myshop xans-myshop-boardlist boardList"><!--
            $count = 10
            $relation_post = yes
        -->
<table border="1" summary="" id="mp-table">
<caption>게시물 관리 목록</caption>
        <colgroup class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 "><col style="width:70px;">
<col style="width:135px;">
<col style="width:auto;">
<col style="width:84px;">
<col style="width:80px;">
<col style="width:55px;">
</colgroup>
<thead><tr>
<th scope="col">번호</th>
                <th scope="col">분류</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회</th>
            </tr></thead>
<tbody class=""><tr>
<td class="noData">게시물이 없습니다.</td>
            </tr>

<tr class="">
<td></td>
                <td class="category"><a href=""></a></td>
                <td class="subject"> <a href=""></a> </td>
                <td></td>
                <td class="txtLess"></td>
                <td class="txtLess"></td>
            </tr>
<tr class="">
<td></td>
                <td class="category"><a href=""></a></td>
                <td class="subject"> <a href=""></a> </td>
                <td></td>
                <td class="txtLess"></td>
                <td class="txtLess"></td>
            </tr>
</tbody>
</table>
</div>
</div>
<!------------------// 내가쓴게시물 ------------------>








<!------------------ 위시리스트 ------------------>
<div id="mp-wishlist" class="xans-element- xans-myshop xans-myshop-wishlist xans-record-"><!--
        $login_page = /member/login.html
        $count = 10
    -->
<div class="title">
        <h3>관심상품목록</h3>
		<span class="more_view"><a href="/myshop/wish_list.html">더보기</a></span>
    </div>
<table border="1" summary="" class="displaynone" id="mp-table">
<caption>관심상품 목록</caption>
        <colgroup>
<col style="width:100px;">
<col style="width:230px;">
<col style="width:auto;">
<col style="width:auto;">
<col style="width:auto;">
<col style="width:auto;">
<col style="width:auto;">
<col style="width:110px;">
</colgroup>
<thead><tr>
<th scope="col">이미지</th>
                <th scope="col">상품정보</th>
                <th scope="col">판매가</th>
                <th scope="col">적립금</th>
                <th scope="col">배송구분</th>
                <th scope="col">배송비</th>
                <th scope="col">합계</th>
                <th scope="col">선택</th>
            </tr></thead></table>
<p class="empty ">관심상품 내역이 없습니다.</p>
</div>
<!------------------// 위시리스트 ------------------>
        </div>




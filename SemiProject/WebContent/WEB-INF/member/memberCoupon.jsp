<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">

</head>
<body>
<div module="myshop_CouponList">
    <!--@css(/css/module/myshop/couponList.css)-->
    <!--
        $product_list_url = coupon_product_list.html
    -->
    <div class="title">
        <h3>마이 쿠폰 목록</h3>
        <p>사용가능 쿠폰 : {$coupon_count}장</p>
    </div>
    <div class="couponList">
        <table border="1" summary="">
            <caption>마이 쿠폰 목록</caption>
            <thead>
                <tr>
                    <th scope="col" class="no">번호</th>
                    <th scope="col" class="coupon">쿠폰명</th>
                    <th scope="col" class="product">쿠폰적용 상품</th>
                    <th scope="col" class="price">구매금액</th>
                    <th scope="col" class="payment">결제수단</th>
                    <th scope="col" class="benefit">쿠폰 혜택</th>
                    <th scope="col" class="period">사용가능 기간</th>
                </tr>
            </thead>
            <tbody class="{$display_coupon_list|display}">
                <tr>
                    <td>{$coupon_no}</td>
                    <td class="coupon"><strong>{$coupon_name}</strong></td>
                    <td>{$coupon_use_product_icon}</td>
                    <td>{$coupon_use_price}</td>
                    <td class="payment">{$coupon_paymethod}</td>
                    <td>{$coupon_benefit_result}</td>
                    <td>{$coupon_start_end_date}</td>
                </tr>
                <tr>
                    <td>{$coupon_no}</td>
                    <td class="coupon"><strong>{$coupon_name}</strong></td>
                    <td>{$coupon_use_product_icon}</td>
                    <td>{$coupon_use_price}</td>
                    <td class="payment">{$coupon_paymethod}</td>
                    <td>{$coupon_benefit_result}</td>
                    <td>{$coupon_start_end_date}</td>
                </tr>
            </tbody>
            <tbody class="{$display_no_coupon_list|display}">
                <tr>
                    <td colspan="7" class="empty">보유하고 계신 쿠폰 내역이 없습니다</td>
                </tr>
            </tbody>
        </table>
    </div>
    <p class="button {$coupon_mileage_display|display}"><img src="http://img.echosting.cafe24.com/skin/base_ko_KR/myshop/btn_coupon_use.gif" alt="사용하기" onclick="COUPON.useCoupon()" /></p>
</div>
</body>
</html>
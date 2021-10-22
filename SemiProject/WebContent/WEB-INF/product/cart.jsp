<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath = request.getContextPath();
%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp"/>

<style type="text/css">

button{
   background-color:white;
   border:1px solid gray;
}

div#didi {
 text-align: right;
 margin-left: 300px;
 
}

ul{
   list-style:none;
   -webkit-padding-start:0px;
   
   }
div#numberstyle{
   display:inline-block; 
   background-color:#bfbfbf; 
   color:white; 
   width:18px; 
   text-align:center;
   border-radius: 1px;
   margin-top:3px;
}

</style>
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
   
   $(document).ready(function(){
      
   
      
      $("button#close").click(function(){
         
         
         
      });
      
      $(".cartcheck").click(function(){
         
         var flag = false;
         $(".cartcheck").each(function(){
            
            var ischeck = $(this).prop("checked");
            
            if(!ischeck){ //체크박스에 하나라도 체크가 해제가 되어있었다면! 전체체크 체크박스에서 해제한다.               
               $("#allcheck").prop("checked",false)
               flag = true;
               return false;
            }         
         })// end of $(".cartcheck").each(function()--------------------
            if(!flag){
               $("#allcheck").prop("checked",true);
            }
         
      });// end of $(".cartcheck").click(function()---------------------------
      
   });// end of $(document).ready(function()------------------------------------------
         
   function allCheckBox(){
      
      var isallcheck = $("#allcheck").is(":checked");
       /*
        $("#allcheck").is(":checked"); 은
          선택자 $("#allcheck") 이 체크되어지면 true를 나타내고,
          선택자 $("#allcheck") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
     */
     $(".cartcheck").prop("checked",isallcheck);
      
   }// end of function allCheckBox()----------------
   
   
   
   function goQtyEdit(qty){
      var index = $("button.updateQty").index(qty);
   //   console.log(index);
   
      var cartno = $("input.cartno").eq(index).val();
   //   console.log(cartno);
      
      var qty = $("input.cartqty").eq(index).val();
   //   console.log(qty);
   
   $.ajax({
      url:"<%=ctxPath%>/cartEdit.sh",
      type:"POST",
      data:{"cartno":cartno,
           "qty":qty},
      dataType:"JSON",
      success:function(json){
         if(json.n == 1){
            alert("주문수량이 변경되었습니다.");
            location.href="cartList.sh";
         }
         
         
      },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }
   })// end of $.ajax({-----------------------------
   
      
   }// end of function goQtyEdit(qty){----------------------------
      
      
      
   function goDel(target){ // this 라는 건 다수의 선택자들을 잡을건데 그 중 너가 클릭한 태그자체를 말한다. 즉 this를 onclick함수 괄호안에 써줌으로써 바로 해당태그를 잡아온 것이다.
      
      var index = $("button.del").index(target)  // 그래서 이 뜻은 반복문 실행했으니까 많은 button.del의 태그들이 있고 거기에서 너가 클릭한 button.del 태그의 인덱스 값이 무었인지 알아온 것이다. index(태그)   제이쿼리 보면 index($target) 이렇게 있다.
      //console.log(index)
      
      var cartno = $("input.cartno").eq(index).val();
      
      $.ajax({
         url:"<%=ctxPath%>/cartDel.sh",
         type:"post",
         data:{"cartno":cartno},
         dataType:"JSON",
         success:function(json){
            if(json.n==1){
               location.href="cartList.sh";
            }
         },
          error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
      
         });
      
   //   console.log(cartno);
   }// end of function goDel(target){-----------------------
      
   function goAllDel(){
      
      $.ajax({
         url:"<%=ctxPath%>/cartAllDel.sh",
         type:"post",
         dataType:"JSON",
         success:function(json){
            if(json.n>=1){
               location.href="cartList.sh";
            }
            else if(json.n==0){
               location.href="cartList.sh";
            }
         },
          error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
      
         });
   }// end of function goAllDel()----------------------------------------------------------------
   
   
   
   function goOrder(){
      
   ///// == 체크박스의 체크된 갯수(checked 속성이용) == /////   
   var checkCnt = $("input:checkbox[name=cartcheck]:checked").length;
   
//   alert(checkCnt);

   if(checkCnt < 1) {
          alert("주문하실 제품을 선택하세요!!");
          return; // 종료 
       }
   
   else{
      
      
   //// == 체크박스에서 체크된 value값(checked 속성이용) == ////
        ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. ///
      var allCnt = $("input:checkbox[name=cartcheck]").length;
     //   alert(allCnt);
        var pimage1Arr = new Array();
        var pnameArr = new Array();
      var pnumArr = new Array();  // 몇개의 상품을 주문하느냐에 따라 insert를 맞춰서 해준다.
        var qtyArr = new Array();  // 그 상품의 주문수량
        var optionArr = new Array(); // 옵션정보
        var option_priceArr = new Array(); // 옵션 가격
        var cartnoArr = new Array();
        var salePriceArr = new Array();
        var totalPointArr = new Array();
        var totalPriceArr = new Array();
        
        
        var formtagin ="";
        for(var i=0; i<allCnt; i++) {
            if( $("input:checkbox[name=cartcheck]").eq(i).is(":checked") ) {  // 체크를 한 장바구니 목록들만 그 내용들을 각 배열속에 넣ㅇ어라~~
              pimage1Arr.push( $("input.pimage1").eq(i).val() );
              pnameArr.push( $("input.pname").eq(i).val() );
              pnumArr.push( $("input.pnum").eq(i).val() );
              qtyArr.push( $("input.qty").eq(i).val() );
              optionArr.push( $("input.option").eq(i).val() );
              option_priceArr.push( $("input.option_price").eq(i).val() );
              cartnoArr.push( $("input.cartno").eq(i).val() );             
              salePriceArr.push( $("input.salePrice").eq(i).val() );
              totalPointArr.push( $("input.totalPoint").eq(i).val() );
              totalPriceArr.push( $("input.totalPrice").eq(i).val() );
              
              formtagin += "<input type='text' class='pimage1' name='pimage1' value='"+$("input.pimage1").eq(i).val()+"'/>"+
                          "<input type='text' class='pname' name='pname' value='"+$("input.pname").eq(i).val()+"'/>"+
                          "<input type='text' class='pnum'  name='pnum' value='"+$("input.pnum").eq(i).val()+"'/>"+
                          "<input type='text' class='qty'  name='qty' value='"+$("input.qty").eq(i).val()+"'/>"+
                          "<input type='text' class='cartno' name='cartno' value='"+$("input.cartno").eq(i).val()+"'/>"+
                          "<input type='text' class='option' name='option' value='"+$("input.option").eq(i).val()+"'/>"+
                          "<input type='text' class='option_price' name='option_price' value='"+$("input.option_price").eq(i).val()+"'/>"+
                          "<input type='text' class='salePrice' name='salePrice' value='"+$("input.salePrice").eq(i).val()+"'/>"+
                          "<input type='text' class='totalPoint' name='totalPoint' value='"+$("input.totalPoint").eq(i).val()+"'/>"+
                          "<input type='text' class='totalPoint' name='test' value='test'>"+
                          "<input type='text' class='totalPrice' name='totalPrice' value='"+$("input.totalPrice").eq(i).val()+"'/>";
                          
                          
                          
           }
        }// end of for---------------------------
       
        $("form#cartlist").html(formtagin);
        
       // console.log(formtagin);
        
        
        for(var i=0; i<checkCnt; i++) {
            console.log("확인용 이미지 주소 : "+pnameArr[i]+" 확인용 제품번호: " + totalPriceArr[i] + ", 주문량: " + qtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + optionArr[i] + ", 포인트: " + option_priceArr[i] + salePriceArr[i]);
         /*
                 확인용 제품번호: 3, 주문량: 3, 장바구니번호 : 14, 주문금액: 30000, 포인트: 15
                 확인용 제품번호: 56, 주문량: 2, 장바구니번호: 13, 주문금액: 2000000, 포인트 : 120 
                 확인용 제품번호: 59, 주문량: 3, 장바구니번호: 11, 주문금액: 30000, 포인트 : 300    
         */
         }// end of for---------------------------
         
        var pimage1join = pimage1Arr.join();
        var pnamejoin = pnameArr.join();
        var pnumjoin = pnumArr.join();
        var qtyjoin = qtyArr.join();
        var optionjoin = optionArr.join();
        var option_pricejoin = option_priceArr.join();
        var cartnojoin = cartnoArr.join();
        var salePricejoin = salePriceArr.join();
        var totalPointjoin = totalPointArr.join();
        var totalPricejoin = totalPriceArr.join();
        
        var sumtotalPoint = 0;
        var sumtotalPrice = 0;
        
        for(var i=0; i<totalPointArr.length; i++) {
           sumtotalPoint += parseInt(totalPointArr[i]);
        }
        
        for(var i=0; i<totalPriceArr.length; i++) {
           sumtotalPrice += parseInt(totalPriceArr[i]);
        }
        
        var html = "";
        html += "<input type='hidden' name='sumtotalPrice' value='"+sumtotalPrice+"'";
        
        
        
        $("div#input").html
        
        console.log("확인용 pimage1join : " + pimage1join);
        console.log("확인용 pnamejoin : " + pnamejoin);
        console.log("확인용 totalPointjoin : " + totalPointjoin);
        
        console.log("확인용sumtotalPoint : " + sumtotalPoint);
        
        var str_sumtotalPrice = sumtotalPrice.toLocaleString('en');
        
        var bool = confirm("총주문액 : "+str_sumtotalPrice+"원 결제하시겠습니까?");
        
        if(bool) {
            
            
            var frm = document.cartlist;
         frm.action = "<%= ctxPath%>/cartDetailStore.sh";
         frm.method = "post";
         frm.submit();
         }
        
        
         
        
   }
      
      
   }// end of function goOrder()---------------------------------------------
   
   function goSelectDel(){
      
   ///// == 체크박스의 체크된 갯수(checked 속성이용) == /////   
      var checkCnt = $("input:checkbox[name=cartcheck]:checked").length;
      
//      alert(checkCnt);

      if(checkCnt < 1) {
             alert("삭제하실 제품을 선택하세요!!");
             return; // 종료 
          }
      
      else{
         
         
      //// == 체크박스에서 체크된 value값(checked 속성이용) == ////
           ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. ///
         var allCnt = $("input:checkbox[name=cartcheck]").length;
        //   alert(allCnt);

           var cartnoArr = new Array();

           
           
           var formtagin ="";
           for(var i=0; i<allCnt; i++) {
               if( $("input:checkbox[name=cartcheck]").eq(i).is(":checked") ) {  // 체크를 한 장바구니 목록들만 그 내용들을 각 배열속에 넣ㅇ어라~~
   
                 cartnoArr.push( $("input.cartno").eq(i).val() );             

              }
           }// end of for---------------------------
          

           var cartnojoin = cartnoArr.join();
                     
           var bool = confirm("선택하신 제품을 삭제하시겠습니까?");
           
           if(bool) {
               
                $.ajax({
                        url:"<%= request.getContextPath()%>/cartSelectDel.sh",
                        type:"POST",
                        data:{"cartnojoin":cartnojoin},
                        dataType:"JSON",     
                        success:function(json){
                           if(json.n>=1){
                          location.href="cartList.sh";
                       }
                       else if(json.n==0){
                          location.href="cartList.sh";
                       }
                        },
                        error: function(request, status, error){
                           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                     });
            }
           
           
            
           
      }
      
   }// end of function goSelectDel()-----------------------------------------------------------
   
   <%-- 
   function goSelectOrder(target){
      
      var index = $("button.selectorder").index(target);
      
   //   console.log(index);
   
      var pimage1 = $("input.pimage1").eq(index).val();
      var pname = $("input.pname").eq(index).val();
      var pnum = $("input.pnum").eq(index).val();
      var cartno = $("input.cartno").eq(index).val();
      var qty = $("input.qty").eq(index).val();
      var option = $("input.option").eq(index).val();
      var option_price = $("input.option_price").eq(index).val();
      var salePrice = $("input.salePrice").eq(index).val();
      var totalPoint = $("input.totalPoint").eq(index).val();
      var totalPrice = $("input.totalPrice").eq(index).val();
      
      
       $.ajax({
             url:"<%= request.getContextPath()%>/cartSelectOrder.sh",
             type:"POST",
             data:{"pimage1":pimage1,
                  "pname":pname,
                  "pnum":pnum
                  "cartno":cartno
                  "qty":qty,
                  "option":option,
                  "option_price":option_price,
                  "salePrice":salePrice,
                  "totalPoint":totalPoint,
                  "totalPrice":totalPrice},
                  
             dataType:"JSON",     
             success:function(json){
                if(json.n>=1){
               location.href="cartList.sh";
            }
            else if(json.n==0){
               location.href="cartList.sh";
            }
             },
             error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
          });
   
      
      
   }// end of function goSelectOrder(target){---------------------------------- --%>
   
      
      
    function likeproduct(){
      
      alert("관심상품에 등록되었습니다.");
   } 
   
         
         

</script>

<div id="content" style="width:80%; margin:auto; font-size:9pt;">
   <div style="text-align:center; margin-botton:50px; margin-top:70px; font-weight:bold; font-size:12pt;">CART</div>
      
   <table style="width:100%; height: 150px; background-color:#f2f2f2; margin-top:50px;">
      <tr style="width:50%;">
                                                         <!-- http://romanticmove.com/ruben/common/ico_member_default.png -->
         <td rowspan="2" style="text-align:center; width:50%;"><img  src="/SemiProject/images/표범.jpg" style="width:70px; border-radius:50%;"><strong>&nbsp;&nbsp;&nbsp;${requestScope.username}</strong> 님, 환영합니다.</td>
         <td style="width:28%; line-hight:50px;"><div style="border-left:1px solid #cccccc; padding-left:180px; align:center;">&nbsp;<span style="line-height:40px; "><img src="/SemiProject/images/적립금사진.jpg" style="width:50px;"><br>가용적립급<br><span style="font-weight:bold;">&nbsp;&nbsp;<fmt:formatNumber value="${requestScope.point}" pattern="###,###" /></span>원</span></div></td>
         <td style="padding-left:50px;"><span style="line-height:40px;"><img style="height:40px; padding-right:10px;  width:60px;" id="profile" src="/SemiProject/images/쿠폰사진.jpg"/><br>&nbsp;&nbsp;쿠폰<br><span style="font-weight:bold;">&nbsp;&nbsp;&nbsp;0</span>개</td></span>
         
      
      </tr>


   </table>
   <c:if test="${empty requestScope.cartList }">
      <table style="width:100%; margin-top:40px;  margin-bottom: 15px;">
      <tr >
         <td><span style="display:inline-block; height:30px;"> 배송상품</span></td>
      </tr>
      <tr style=" border-bottom:0.5px solid #d9d9d9; border-top:0.8px solid #d9d9d9;">
         <td style="text-align:center; height:300px;">
            <span>장바구니가 비어 있습니다.</span>
         </td>
      </tr>
      </table>
   </c:if>
   
   <c:if test="${not empty requestScope.cartList }">
   <table style="width:100%; margin-top:40px;  margin-bottom: 15px;">
      <tr>
         <td><span style="display:inline-block; height:30px;"> 배송상품</span></td>
      </tr>
      <tr>
      
      
         <td style=" text-align:top; border-top:1px solid gray">
            
            
            
            <table style="width:100%; text-align:center;">
               <tr style="border-bottom:0.5px solid #d9d9d9; height:60px;">
                  <td style="width:40px; align:center;"><input type="checkbox" id="allcheck" onclick="allCheckBox();"/></td>
                  <td>상품</td>
                  <td>상품정보</td>
                  <td>판매가</td>
                  <td>수량</td>
                  <td>적립금</td>
                  <td>합계</td>
                  <td>선택</td>
                  <td>삭제</td>
               </tr>
               
         <form id="list" name="list">
            <c:forEach var="cartvo" items="${requestScope.cartList}" varStatus="status"> 
               <tr class="cartlist" style="padding-bottom:50px; height:140px; border-bottom: 0.5px solid #d9d9d9;">
                  <td style="width:auto;">
                     <input type="checkbox" class="cartcheck" name="cartcheck" style="text-align:center;"/>
                  </td>
                  <td>
                     <img src="${cartvo.prvo.pimage1}" style="width:80px;"/>
                           
                     <input type="hidden" class="pimage1" name="pimage1" value="${cartvo.prvo.pimage1}"/>
                     <input type="hidden" class="pname" name="pname" value="${cartvo.prvo.pname}"/>                  
                     <input type="hidden" class="pnum"  name="pnum" value="${cartvo.prvo.pnum}"/>
                     <input type="hidden" class="cartno" name="cartno" value="${cartvo.cartno}"/>
                     <input type="hidden" class="qty"  name="qty" value="${cartvo.cart_qty}"/>
                     <input type="hidden" class="option" name="option" value="${cartvo.cart_opt_info}"/>
                     <input type="hidden" class="option_price" name="option_price" value="${cartvo.cart_opt_price}"/>                  
                     <input type="hidden" class="salePrice" name="salePrice" value="${cartvo.prvo.saleprice}"/>
                     <input type="hidden" class="totalPoint" name="totalPoint" value="${cartvo.prvo.totalJukrib}"/>
                     <input type="hidden" class="totalPrice" name="totalPrice" value="${cartvo.prvo.totalPrice}"/>
                     
                     
                     
                     
                  </td>
                  <td style=" word-break:break-all; width:300px; text-align:left;"><span style="font-weight:bold;">${cartvo.prvo.pname}</span><br>[옵션: ${cartvo.cart_opt_info} (+${cartvo.cart_opt_price})]</td>               
                  <td style="font-weight:bold;"><fmt:formatNumber value="${cartvo.saleprice_optprice}" pattern="###,###" />원</td>
                  <td><input type="number" class="cartqty" value="${cartvo.cart_qty}" style="width:40px; margin-right:3px; " min="1" max="100"/><button type="button" class="updateQty" style="border-radius: 1px;" onclick="goQtyEdit(this);">변경</button></td>
                  <td><img src="http://img.echosting.cafe24.com/design/common/icon_cash.gif" style="width:11px;">&nbsp;<fmt:formatNumber value="${cartvo.prvo.totalJukrib}" pattern="###,###" />원</td>
                  <td class="num_total_price" style="font-weight:bold;"><fmt:formatNumber value="${cartvo.prvo.totalPrice}" pattern="###,###" />원</td>
                  <td><button type="button" class="selectorder" style="width:100px; height:30px; margin-bottom:15px;" onclick="goOrder();">주문하기</button><br><button style="width:100px; height:30px; background-color:#f2f2f2;" onclick="likeproduct()">관심상품</button></td>
                  <td><button type="button" class="del" style="border:none; font-size:13pt; color:#cccccc;" onclick="goDel(this);">X</button></td>
                  
               </tr>   
               
             </c:forEach>
           </form>
             <div id="input"></div>
         
         
            </table>
            </td>
         </tr>      
      <tr style="background-color:#f2f2f2; height:80px; vertical-align:center; ">            
         <td colspan="9" style="font-size:9pt; ">
         <div style="float:left; padding-left: 20px; font-weight:bold; margin-top:17px;">선택상품을&nbsp;&nbsp;<button type="button" style="width:100px; height:40px; margin-right:12px;" onclick="goSelectDel();">삭제하기</button>
         <button type="button" style="width:100px; height:40px;" onclick="goOrder();">주문하기</button></div><div style="float:right; display:inline-block; text-align:right; padding:20px;">할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.<br>결제예정금액은 배송비가 포함된 금액이므로 주문서작성에서 확인 가능합니다.</div>
         </td>
      </tr>
                  
         
      
   </table>
   
   <form id="cartlist" name="cartlist" style="display:none;"></form>
   
   
   <span><button type="button" style="width:160px; height:55px; margin-right:12px; font-size:10pt;" onclick="goAllDel();">장바구니 비우기</button><button type="button" style="width:160px; height:55px; font-size:10pt;" onclick="javascript:location.href='<%=ctxPath%>/allProductList.sh'">쇼핑계속하기</button></span>   
   <span  style=" display:inline-block; margin-left:950px;">
      <table style="width:250px; align:right;">
         <tr style=" border-bottom:0.5px solid gray; height:65px; ">
            <td style="text-align:left; font-size:11pt; ">Total Point</td>
            <td id="total_total_price" style="text-align:right; font-size:14pt; font-weight:bold;" ><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPOINT}" pattern="###,###" />원</td>
            
         </tr>
         <tr style=" border-bottom:1px solid gray; height:65px;">
            <td style="text-align:left; font-size:11pt;">Total Amount</td>
            <td id="total_total_price" style=" text-align:right; font-size:16pt; font-weight:bold;"><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPRICE}" pattern="###,###" />원</td>
         </tr>
         <tr>
            <td colspan="2"><button type="button" style="background-color:black; color:white; width:100%; height:50px; margin-top:30px;" onclick="goOrder();">주문하기</button></td>
         </tr>
      </table>
   </span>

</c:if>
   
   <div style="border:1px solid #cccccc; margin-top: 60px; margin-bottom:50px; padding:20px;">
      <div style="font-size:10pt; border-bottom:1px solid #e6e6e6; font-weight:bold;  margin-bottom:8px; padding-bottom:8px;">이용안내</div>
   <div style="color:#737373;">
             <div style="font-size:10pt; margin-top:8px; margin-bottom:8px;">장바구니 이용안내</div>
           <ul>
            <li style="font-size:9pt;"><div id="numberstyle" >1</div>&nbsp;&nbsp;해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >2</div>&nbsp;&nbsp;해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >3</div>&nbsp;&nbsp;선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >4</div>&nbsp;&nbsp;[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >5</div>&nbsp;&nbsp;장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >6</div>&nbsp;&nbsp;파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
           </ul>
         <div style="font-size:10pt; margin-top:8px; margin-bottom:8px;">무이자 할부 이용안내</div>
           <ul>
            <li style="font-size:9pt;"><div id="numberstyle" >1</div>&nbsp;&nbsp;상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >2</div>&nbsp;&nbsp;[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
               <li style="font-size:9pt;"><div id="numberstyle" >3</div>&nbsp;&nbsp;단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
           </ul>
   </div>
   
   </div>
   


</div>



<jsp:include page="../footer.jsp"/>
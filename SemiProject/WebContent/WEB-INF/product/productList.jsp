<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<meta charset="UTF-8">
<%
   String ctxPath = request.getContextPath();
    
%>  
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">

<style>
   table,tr,td{
      border:solid 1ox red;
   }

   img#imgmenu{
      border-radius: 50%;
      width:100px;
   }
   
   span.listname{
      color:black; 
      display:inline-block; 
      margin-top:10px;
      font-size: 11pt;
   }
   table{
      border-spacing : 100px;
      margin-right : auto;
      margin-left : auto;
      
      
   }

   
    img.img{
       width: 350px;
       margin: 5 40px;
       cursor:pointer;
       
    }
    
    
    td#saleprice{
       color:red;
    }
    
    td{
       font-size: 10pt;
    }
    
    tr.productname > td{
       padding-left:43px;
    }
    
    ul{
        list-style:none;
        
    }
    
    li#img{
       display:inline-block;
       padding: 0 15px;
       
    }
    
    a#pagenum{
       letter-spacing:15px;
    }

    .container {
       position: relative;
       width: 50%;
       /* max-width: 400px; */
       margin:0 50px;
   }

   .container img {
       width: 350px;
         height: auto;
   }

   .container .btn{
        position: absolute;
        top: 85%;
        left: 50%;
        transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        background-color: #f1f1f1;
        color: black;
        font-size: 16px;
        padding: 16px 30px;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        text-align: center;
   }

   .container .btntag0:hover {
        background-color: black;
        color: white;
   }

   .container .btntag1:hover {
       background-color: black;
        color: white;
   }

   .container .btntag2:hover {
        background-color: black;
        color: white;
   }
   
   .container .btntag3:hover {
        background-color: black;
        color: white;
   }
   
   .container .btntag4:hover {
        background-color: black;
        color: white;
   }
   
   .container .btntag5:hover {
        background-color: black;
        color: white;
   }


    
</style>
<jsp:include page="../header.jsp"/>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

   //??????
   var num = 1;
   // ?????? ?????????
   var org = "- [??????]????????? ?????? ???????????? -";
   // ?????? ?????? ????????? ???
   var plusopt1 = 0;
   var plusopt2 = 0;
   // ?????? ????????? ?????????
   var opt1 = "";
   var opt2 = "";
   var opt3 = "";
   var opt4 = "";
   // ????????? ?????? ????????? ???????????? ??????
   var fg1 = false;
   var fg2 = false;
   var fg3 = false;
   var fg4 = false;
   // ?????? ?????? ???????????? ??????
   var finopt = 0;
   // ???????????? ???????????? ??????
   var orgpcd = "";
   // ?????? ??????
   var cnt = 0;
   // ????????? ????????? ??????
   var key = 0;
   // ????????? ???????????? ??????
   var jukrib = 0;
   // ?????? ????????? ?????? ???????????? ???????????? ??????
   var frontp = "";
   // ?????? ????????? ??????????????? ?????????
   function flag1(){
      opt1 = $("select#optselect1").val();
      fg1 = true;
   }
   function flag2(){
      opt2 = $("select#optselect2").val();
      fg2 = true;
   }
   function flag3(){
      opt3 = $("select#optselect3").val();
      fg3 = true;
      if(opt3 == "?????? 1cm?????? (+5,000???)"){
         plusopt1 = 5000;
      }
      else{
         plusopt1 = 0;
      }
   }
   function flag4(){
      opt4 = $("select#optselect4").val();
      fg4 = true;
      if(opt4 == "?????????(?????????) ??????(?????????????????? +10,000???)"){
         plusopt2 = 10000;
      }
      else if(opt4 == "?????????(?????????) ??????(?????????????????? +40,000???)"){
         plusopt2 = 40000;
      }
      else{
         plusopt2 = 0;
      }
   }
   // ?????? ????????????
   function flag5(){
      num = $("input#num").val();
   }

   /////////////////////////////////////////////////////////////////////////////////
   
   $(document).ready(function(){

      /* ???????????? ?????? ?????? ????????? */
      $("ul#imglist > li").hover(function(){
             $(this).css({'opacity':'0.5', 'cursor':'pointer', 'border-radius':'50%'});
             }, 
                  function(){
                         $(this).css({'opacity':'1.0', 'cursor':'default', 'border-radius':'0'});           
                                   });
   
   /////////////////////////////////////////////////////////////////////////////////
   
      // ???????????? ?????? ?????? ?????? ???????????? ???????????? ???
      $("div#dubby").click(function(){
   
         var frm = document.dubbyfrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#mul").click(function(){
            
         var frm = document.mulfrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#boots").click(function(){
         
         var frm = document.bootsfrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#loper").click(function(){
         
         var frm = document.loperfrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#oxpode").click(function(){
         
         var frm = document.oxpodefrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#mongk").click(function(){
         
         var frm = document.mongkfrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
      
      $("div#sandle").click(function(){
         
         var frm = document.sandlefrm;
         frm.action="<%= ctxPath%>/productList.sh";
         frm.method="post";
         frm.submit();  
      });
   
   /////////////////////////////////////////////////////////////////////////////////
   
      //?????? ?????? ????????? ?????? ?????????
      $("button.btn").hide(); 
      
      $("div.imgtag0").mouseover(function() {
           $(this).find("img#shose_0").attr("src",$("input#back_img0").val());
           $("button.btntag0").show();
      }).mouseout(function() {
           $(this).find("img#shose_0").attr("src",$("input#first_img0").val());
           $("button.btntag0").hide();
      });
       
       
      $("div.imgtag1").mouseover(function() {
           $(this).find("img#shose_1").attr("src",$("input#back_img1").val());
           $("button.btntag1").show();
      }).mouseout(function() {
           $(this).find("img#shose_1").attr("src", $("input#first_img1").val());
           $("button.btntag1").hide();
      });
      
    
      $("div.imgtag2").mouseover(function() {
           $(this).find("img#shose_2").attr("src",$("input#back_img2").val());
           $("button.btntag2").show();
           
      }).mouseout(function() {
           $(this).find("img#shose_2").attr("src", $("input#first_img2").val());
           $("button.btntag2").hide();
      });
      
      $("div.imgtag3").mouseover(function() {
           $(this).find("img#shose_3").attr("src",$("input#back_img3").val());
           $("button.btntag3").show();
      }).mouseout(function() {
           $(this).find("img#shose_3").attr("src", $("input#first_img3").val());
           $("button.btntag3").hide();
      });
      
      $("div.imgtag4").mouseover(function() {
           $(this).find("img#shose_4").attr("src",$("input#back_img4").val());
           $("button.btntag4").show();
      }).mouseout(function() {
           $(this).find("img#shose_4").attr("src", $("input#first_img4").val());
           $("button.btntag4").hide();
      });
      
      $("div.imgtag5").mouseover(function() {
           $(this).find("img#shose_5").attr("src",$("input#back_img5").val());
           $("button.btntag5").show();
      }).mouseout(function() {
           $(this).find("img#shose_5").attr("src", $("input#first_img5").val());
           $("button.btntag5").hide();
      });
   
   /////////////////////////////////////////////////////////////////////////////////
      
      // ??????
       $("button.btn").click(function(){
          // ?????? ????????? ????????????
          var quickProductName = $(this).val();
          // ??? ????????????
          $.ajax({
             url:"<%= ctxPath%>/quickView.sh",
             data:{"quickProductName":quickProductName},
             dataType:"json",
             success: function(json){
              
          // ????????? ????????? ??????       
         var html =    "<table id='buy' style='margin:50px 0px;'>"
                     +"<tr>"
                        +"<td id='insertimg'><img style='width:420px; height:600px;' id='chun' src='"+json.product_front_p1+"'/></td>"
                        +"<td id='buy' style='width:700px; height:600px;'>"
                           +"<table id='inbuy' style='width:420px; height:600px; margin-left:40px;'>"
                              +"<tr style='height:80px;'>"
                                 +"<td colspan='2' style='padding:0px 5px; width:450px; height:60px; text-align:left; font-size:14pt; font-weight:bold; color:black; border-bottom:solid 1px gray;'>"
                                    +"<span id='product_name'>"+json.product_name+"</span><br>"
                                    +"<span id='product_ceil_price' style='font-size:13pt; color:red;'>"+json.product_ceil_price+"</span>&nbsp;"
                                    +"<span style='font-size:10pt; color:gray;'>/</span>"
                                    +"<span id='product_price' style='padding:10px; font-size:10pt; color:gray;'><del>"+json.product_price+"</del></span>"      
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td style='width:150px; text-align:left; font-size:10pt; color:black; padding-top:7px; padding-left:7px;'>?????????</td>"
                                 +"<td style='width:300px; font-size:10pt; padding-left:20px; padding-top:5px;'><span id='pct' style='color:red; display:inline-block; width:200px;'></span></td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>?????????</td>"
                                 +"<td style='width:300px; padding:0px 10px;'>"
                                    +"<select id='optselect1' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag1();'>"
                                       +"<option>- [??????]????????? ?????? ???????????? -</option>"
                                       +"<option disabled='disabled'>---------------------</option>"
                                       +"<option>240</option>"
                                       +"<option>250</option>"
                                       +"<option>260</option>"
                                       +"<option>270</option>"
                                       +"<option>280</option>"
                                       +"<option>290</option>"
                                    +"</select>"
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>?????????</td>"
                                 +"<td style='width:300px; padding:0px 10px;'>"
                                    +"<select id='optselect2' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag2();'>"
                                       +"<option>- [??????]????????? ?????? ???????????? -</option>"
                                       +"<option disabled='disabled'>---------------------</option>"
                                       +"<option>??????</option>"
                                       +"<option>??????</option>"
                                    +"</select>"
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td style='width:150px; text-align:left; font-size:9pt; color:black; padding:0px 0px 0px 7px;'>?????????</td>"
                                 +"<td style='width:300px; padding:0px 10px;'>"
                                    +"<select id='optselect3' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin:0px 0px 8px 5px;' onclick='flag3();'>"
                                       +"<option>- [??????]????????? ?????? ???????????? -</option>"
                                       +"<option disabled='disabled'>---------------------</option>"
                                       +"<option>????????????</option>"
                                       +"<option>?????? 1cm?????? (+5,000???)</option>"
                                    +"</select>"
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td style='width:150px; text-align:left; font-size:8pt; color:black; padding-left:7px;'>???????????????</td>"
                                 +"<td style='width:300px; padding:0px 10px;'>"
                                    +"<select id='optselect4' style='border-bottom:solid 1px black; border-left:solid 1px white; border-right:solid 1px white; border-top:solid 1px white; width:330px; font-size:10pt; text-align:left; color:gray; margin-left:5px;' onclick='flag4();'>"
                                       +"<option>- [??????]????????? ?????? ???????????? -</option>"
                                       +"<option disabled='disabled'>---------------------</option>"
                                       +"<option>????????????</option>"
                                       +"<option>?????????(?????????) ??????(?????????????????? +10,000???)</option>"
                                       +"<option>?????????(?????????) ??????(?????????????????? +40,000???)</option>"
                                    +"</select>"
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:50px;'>"
                                 +"<td colspan='2'>"
                                    +"<span id='plus' style='text-align:center; display:inline-block; background-color:black; color:white; height:50px; width:420px;padding-top:13px;'>ADD</span>"
                                 +"</td>"
                              +"</tr>"
                              +"<tr style='height:220px;'>"
                                 +"<td colspan='2'>"
                                    +"<div id='inthis' style='height:220px; width:420px;'>"
                                    +"</div>"
                                 +"</td>"
                              +"</tr>"
                           +"</table>"
                        +"</td>"
                     +"</tr>"
                  +"</table>";
                  
                $("div.modal-body").html(html);
                
                // ?????? ??????
                orgpcd = json.product_price;
                // ????????? ??????
                frontp = json.product_front_p1
             },
             error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
         }
             
   
          });//end of $.ajax({-------------------------------------------------------
          
          ///////////////////////////////////////////////////////////////////////////
          
          // ???????????? ?????? ????????? ???
         $(document).on("click", "span#plus", function(){
            
            // ????????? ?????? ?????? ???
            $(document).on("click", "button#close", function(){
               // ????????? ???????????? ??????
               var tblkey = $(this).parent().find(".tblkey").val();
               $("table#"+tblkey).remove();
               // ???????????? ???????????? ?????????
               cnt--;
            });
            
            // ?????? ?????? ???????????????
            var pcd = orgpcd.replace(",","");
            
            // ????????? ??? ??????
            jukrib = pcd*0.1;
            
            // ?????? ????????? ?????? ????????????
            $("span#pct").text("(10%) "+jukrib+"?????????");
            
            // ???????????? ?????? ????????? ???
            $(document).on("click", "input#num", function(){
               
               num = $(this).val();
               
               if(num==10){
                  alert("????????? ?????? 10??? ????????? ?????? ???????????????..")
               }
               // ?????? ??? ????????????
               var xpcd = num*pcd;
               var xopt = num*finopt;
               // ?????? ??? ?????? ???
               $(this).parent().find(".cartprice").text(xpcd+"???");
               // ?????? ??? ?????? ???
               $(this).parent().find(".cartfinopt").text("+ "+xopt+"???");
               // ?????? ??? ?????????
               jukrib = pcd*num*0.1;
               $("span#pct").text("(10%) "+jukrib+"?????????");
               
               
            });//end of $(document).on("click", "input#num", function(){
            
            //////////////////////////////////////////////////////////////////////   
               
            // ?????? ??? ?????????
            finopt = plusopt1 + plusopt2;
            // ????????? ????????? ??????
            key++;
            
            // ?????? ????????? ????????? ??????
            if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
               
               var html2 = "<div>" 
                           +"<table id='"+key+"' style='height:72px; margin-bottom:12px;'>"
                              +"<tr>"
                                 +"<td style='width:300px;'>"
                                    +"<div style='text-align:left; font-size:9pt; color:black;'>"
                                       +"<div style='font-weight:bold;'>"+ $("span#product_name").text() +"</div>"
                                       +"<div class='cartopt123'>"+opt1+"/"+opt2+"/"+opt3+"</div>"
                                       +"<div class='cartopt4'>/"+opt4+"</div>"
                                    +"</div>"
                                 +"</td>"
                                 +"<td style='width:120px; text-align:right; font-size:10pt;'>"
                                    +"<input id='num' class='cartnum' type='number' min='1' value='1' max='20' style='width:40px; height:20px; text-align:left;'/>"
                                    +"<img id='close' src='/SemiProject/images/close.png' style='width:20px; height:20px;'/>"
                                    +"<input class='tblkey' type='hidden' value='"+key+"'/>"
                                    +"<div id='upprice' class='cartprice'>"+pcd+"???</div>"
                                    +"<input type='hidden' class='num_cartprice' name='num_cartprice' value='"+pcd+"'/>"
                                    +"<div class='cartfinopt'>+ "+finopt+"???</div>"
                                    +"<input type='hidden'  class='num_cartfinopt' name='num_cartfinopt' value='"+finopt+"'/>"
                                 +"</td>"   
                              +"</tr>"
                              +"<tr>"
                                 +"<td colspan='2'>"
                                    +"<span id='buynow' style='display:inline-block; border:solid 1px black; margin-right:5px; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:205px; padding-top:5px'>BUY NOW</span>"
                                    +"<span id='cart' style='display:inline-block; border:solid 1px black; text-align:center;  font-size:10pt; background-color:black; color:white; height:30px; width:206px; padding-top:5px'>CART</span>"
                                    +"<input class='cartkey' type='hidden' value='"+key+"'/>"
                                 +"</td>"
                              +"</tr>"
                           +"</table>"
                        +"</div>";
               
               // ????????? ????????? ???????????? ??????
               // ?????? ????????? ??????
               cnt = $(".cartprice").size();         
                              
               if(cnt<2){      
                  // div??? append
                  $("div#inthis").append(html2);   
               }
               else{
                  cnt = 2;
                  alert("?????? 2?????? ?????? ??? ????????????.");   
               }
               
            }
            else{
               alert("????????? ?????? ?????? ??? ?????? ????????????.");
            }//end of if(opt1 != org && opt2 != org && opt3 != org && opt4 != org && fg1 == true && fg2 == true && fg3 == true && fg4 == true){
            
            ////////////////////////////////////////////
            // ????????? ???????????? ???????????? ????????????.???????????? ????????????           //
            // ?????? ????????? ????????? ??????????????? ???????????? ????????? ?????? ????????????  //
            ////////////////////////////////////////////
            // ?????? ???????????? ????????? ??? //
            $("img#close").click(function(){
               
               // ????????? ???????????? ??????
               var tblkey = $(this).parent().find(".tblkey").val();
               $("table#"+tblkey).remove();
               // ???????????? ???????????? ?????????
               cnt--;
               
            });//end of $("img#close").click(function(){--------------------------
            
         });//end of $(document).on("click", "span#plus", function(){------------
             
         /////////////////////////////////////////////////////////////////////////////
            
         // ??????????????? ????????????
         $(document).on("click", "span#cart", function(){

            // ????????? ???????????? ??????
            var cartkey = $(this).parent().find(".cartkey").val();
            var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
            var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
            var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
            var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
            var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
            var num_cartprice = $("table#"+cartkey).parent().find("input.num_cartprice").val();
            var num_cartfinopt = $("table#"+cartkey).parent().find("input.num_cartfinopt").val();
            
            // ??????????????? ???????????? ?????? hidden ????????? input ?????? ??????
            // ????????? ??????
            // ????????????, ??????1~4, ??????, ??????, ????????????
            //
            var gocart ="<input type='hidden' name='cartname'   value='"+$("span#product_name").text()+"'/>"
                      +"<input type='hidden' name='cartopt123' value='"+cartopt123+"'/>"
                      +"<input type='hidden' name='cartopt4'   value='"+cartopt4+"'/>"   
                      +"<input type='hidden' name='cartnum'    value='"+cartnum+"'/>"   
                      +"<input type='hidden' name='cartprice'  value='"+cartprice+"'/>"
                      +"<input type='hidden' name='jukrib'  value='"+jukrib+"'/>"
                      +"<input type='hidden' name='cartfinopt' value='"+cartfinopt+"'/>"
                      +"<input type='hidden' name='frm_num_cartprice' value='"+num_cartprice+"'/>"
                      +"<input type='hidden' name='frm_num_cartfinopt' value='"+num_cartfinopt+"'/>"
                      +"<input type='hidden' name='product_front_p1' value='"+frontp+"'/>";

            $("form#buyorcart").append(gocart);

            var frm = document.gogocart;
            frm.action = "<%= ctxPath%>/cart.sh";
            frm.method = "post";
            frm.submit();     
            
            // ???????????? ?????? ??? ?????????
            $("table#"+cartkey).remove();
            // ???????????? ????????? ?????? ?????? input ?????????
            $("form#buyorcart").empty(); 

         });//end of $(document).on("click", "button#cart", function(){-----------   
             
         /////////////////////////////////////////////////////////////////////////////////   
             
         // ??????????????? ????????????
         $(document).on("click", "span#buynow", function(){
         
            // ????????? ???????????? ??????
            var cartkey = $(this).parent().find(".cartkey").val();
            console.log(cartkey);
            // ??????????????? ????????? ?????? ?????? ????????? ???????????? ????????? ????????????
          // var cartimg = $(this).parent().find(".upprice").val();
            var cartopt123 = $("table#"+cartkey).parent().find(".cartopt123").text();
            var cartopt4   = $("table#"+cartkey).parent().find(".cartopt4").text();
            var cartnum    = $("table#"+cartkey).parent().find(".cartnum").val();
            var cartprice  = $("table#"+cartkey).parent().find(".cartprice").text();
            var cartfinopt = $("table#"+cartkey).parent().find(".cartfinopt").text();
            console.log(cartopt123);
            // ??????????????? ???????????? ?????? hidden ????????? input ?????? ??????
            // ????????? ??????
            // ????????????, ??????1~4, ??????, ??????, ????????????
            var gocart = "<input type='hidden' name='product_front_p1' value='"+frontp+"'/>" 
                     +"<input type='hidden' name='cartname'   value='"+$("span#product_name").text()+"'/>"
                      +"<input type='hidden' name='cartopt123' value='"+cartopt123+"'/>"
                      +"<input type='hidden' name='cartopt4'   value='"+cartopt4+"'/>"   
                      +"<input type='hidden' name='cartnum'    value='"+cartnum+"'/>"   
                      +"<input type='hidden' name='cartprice'  value='"+cartprice+"'/>"
                      +"<input type='hidden' name='jukrib'  value='"+jukrib+"'/>"
                      +"<input type='hidden' name='cartfinopt' value='"+cartfinopt+"'/>";
                      
            $("form#buyorcart").append(gocart);
   
            var frm = document.gogocart;
            frm.action = "<%= ctxPath%>/detailstore.sh";
            frm.method = "post";
            frm.submit();
            
            // ???????????? ?????? ??? ?????????
            $("table#"+cartkey).remove();
            // ???????????? ????????? ?????? ?????? input ?????????
            $("form#buyorcart").empty(); 
            
         });//end of $(document).on("click", "button#buynow", function(){-----------
             
         ///////////////////////////////////////////////////////////////////////////   
            
       });//end of $("button.btn").click(function(){----------------------------------
    
      /////////////////////////////////////////////////////////////////////////////////
 
      // ???????????? ???????????????
      $("img.img").click(function(){
         var product_name = $(this).parent().find("input.product_name").val()
          location.href="<%= ctxPath%>/buy.sh?product_name="+product_name;
      });
      
   });// end of $(document).ready(function()----------------------------------------
      
   /////////////////////////////////////////////////////////////////////////////////
      
</script>



<%-- ???????????? ?????? ????????? --%>


<ul id="imglist" style="margin-top: 80px; display:table; margin-left: auto; margin-right:auto; margin-bottom: 50px;">

   <li id="img" style="text-align:center;" >     <!-- BEST ????????? ?????? allProductList??? ?????????????????? -->
      <form name="bestfrm" >
         <input type="hidden" id="bestid" name="productname" />
            <div id="best" >
               <a href="allProductList.sh"><div><img src="/SemiProject/images/allall.png" id="imgmenu" ></div><span  class="listname">ALL</span></a>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="dubbyfrm" >
         <input type="hidden" value="dubby" name="productname" />
            <div id="dubby">
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/56b8958fb641ce6f9f854ee98bf5df24.jpg" id="imgmenu" ></div><span  class="listname">??????</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="mulfrm" >
         <input type="hidden" value="mul" name="productname" />
            <div id="mul" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/869c4b254f3b5356f128f2b64a04e384.jpg" id="imgmenu" ></div><span  class="listname">???</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="bootsfrm" >
         <input type="hidden" value="boots" name="productname" />
            <div id="boots" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/1171a5fb41400cabe4cde966d418f3b3.jpg" id="imgmenu" ></div><span  class="listname">??????</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="loperfrm" >
         <input type="hidden" value="loper" name="productname" />
            <div id="loper" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/d6639c71e8b26845d4a372c31a92bc1c.jpg" id="imgmenu" ></div><span  class="listname">??????</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="oxpodefrm" >
         <input type="hidden" value="oxpode" name="productname" />
            <div id="oxpode" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210825/d27954f804c1e3484a42cf3fb4476d6f.png" id="imgmenu" ></div><span  class="listname">????????????</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="mongkfrm" >
         <input type="hidden" value="mongk" name="productname" />
            <div id="mongk" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210825/0c5634ea9545afdc00e698a3c97f4efb.png" id="imgmenu" ></div><span  class="listname">??????</span>
            </div>      
      </form>
   </li>
   <li id="img" style="text-align:center;" >
      <form name="sandlefrm" >
         <input type="hidden" value="sandle" name="productname" />
            <div id="sandle" >
               <div><img src="http://www.romanticmove.com/web/upload/NNEditor/20210804/7d76dc6c16a54153e3a37f72529236da.jpg" id="imgmenu" ></div><span  class="listname">??????</span>
            </div>      
      </form>
   </li>
</ul>

<table style = "margin-bottom:50px;">
   <tr>
      <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
         <c:if test="${status.index < 3}">
               <td>
                  <div class="container imgtag${status.index}" style="padding:0px; margin:0px">
                     <input type="hidden" id="first_img${status.index}" name="first_img${status.index}" value="${productvo.product_front_p1}"/>
                     <input type="hidden" id="back_img${status.index}" name="back_img${status.index}" value="${productvo.product_back_p2}"/>
                     <img src="${productvo.product_front_p1}" id="shose_${status.index}" class="img" >
                     <input type="hidden" id="product_name" class="product_name" value="${productvo.product_name}"/>
                     <button type="button" class="btn btntag${status.index}"  name="btn" data-toggle="modal" data-target="#quick_view_modal" value="${productvo.product_name}">Quick View</button>
                  </div>
               </td>
               <img src="${productvo.product_back_p2}" class="img backimg" style="display:none;"/>      
         </c:if>
      </c:forEach>   
   </tr>
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index < 3}">
             <input type="hidden" id="productname${status.index}" value="${productvo.product_name}"/>
            <td>${productvo.product_name}</td>
         </c:if>
      </c:forEach>
   </tr>   
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index < 3}">
            <td><del>${productvo.product_price}</del></td>
         </c:if>
      </c:forEach>
   </tr>   
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index < 3}">
            <td id="saleprice">${productvo.product_ceil_price}</td>
         </c:if>
      </c:forEach>
   </tr>
</table>   

<table style = "margin-bottom:100px;">
   <tr>
      <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
         <c:if test="${status.index > 2 && status.index < 6}">
            <td>
               <div class="container imgtag${status.index}" style="padding:0px">
                  <input type="hidden" id="first_img${status.index}" name="first_img${status.index}" value="${productvo.product_front_p1}"/>
                  <input type="hidden" id="back_img${status.index}" name="back_img${status.index}" value="${productvo.product_back_p2}"/>
                  <img src="${productvo.product_front_p1}" id="shose_${status.index}" class="img" >
                  <input type="hidden" id="product_name" class="product_name" name="product_name" value="${productvo.product_name}"/>
                  <button type="button" class="btn btntag${status.index}"  name="btn" data-toggle="modal" data-target="#quick_view_modal" value="${productvo.product_name}">Quick View</button>
               </div>
            </td>
            <img src="${productvo.product_back_p2}" class="img backimg" style="display:none;"/>
         </c:if>
      </c:forEach>
   </tr>
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index > 2 && status.index < 6}">
            <td>${productvo.product_name}</td>
         </c:if>
      </c:forEach>
   </tr>
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index > 2 && status.index < 6}">
            <td><del>${productvo.product_price}</del></td>
         </c:if>
      </c:forEach>
   </tr>
   <tr class = "productname">
       <c:forEach var="productvo" items="${requestScope.productimgList}" varStatus="status">
          <c:if test="${status.index > 2 && status.index < 6}">
            <td id="saleprice">${productvo.product_ceil_price}</td>
         </c:if>
      </c:forEach>
   </tr>    
</table>   
   
   
   
   
<div class="container quickviewmodal">   <!-- Modal ??? ??? ???????????? ????????? ?????? ??? -->
   <div class="modal fade"  id="quick_view_modal">
     <div class="modal-dialog modal-lg" style= "width:1000px; border-radius:0;">
       <div class="modal-content" style= "width:1000px; border-radius:0;">
            <!-- Modal body -->
            <div class="modal-body"></div>       <!-- ?????? ???????????? ??? -->  
       </div>
     </div>
   </div>
</div>





<!-- ???????????? ?????? ?????? ??? ??? ?????? ?????? ???????????? ?????? ??? -->
<form id="buyorcart" name="gogocart">

</form>

<!-- ?????? ?????? ??? ??? ?????? ?????? ???????????? ?????? ??? -->
<form id="goreview" name="gogoreview">
   
</form>

<jsp:include page="../footer.jsp"/>
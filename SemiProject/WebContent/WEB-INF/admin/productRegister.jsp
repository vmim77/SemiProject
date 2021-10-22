<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();   
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="../header.jsp"/>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" /> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<style type="text/css">

	table{
		font-size:10pt;
		color:#4d4d4d;
	}
	 table#tblProdInput  tr{
		height:65px;
		
	}
	table#tblProdInput td{
		padding-left:30px;
	}
	input.file{
		background-color:white;
		
	}
	.error {color: red; font-weight: bold; font-size: 9pt;};


</style>



<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		//스피너 달아주기
	/* 	$("input#spinnerPqty").spinner({
			
			spin:function(event,ui){
	            if(ui.value > 100) {
	               $(this).spinner("value", 100);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
			}
		}); // end of $("input#spinnerPqty").spinner-----------------  */
		
		$("input#btnRegister").click(function(){
			
			var flag = false;
			
			$(".infoData").each(function(){
				var val = $(this).val().trim();
				if(val == ""){
					$(this).next().show();
					flag = true;
					return false;  // each 에서 break 는 return false이다.!!!!
				}
			});
			
			if(!flag){ // 전부 다 채웠다면~~~
				var frm = document.prodInputFrm;
				frm.submit();
				
			}
			
		});
		
		
		$("input[type=reset]").click(function(){
			$("div#divfileattach").empty();
			$("span.error").hide();
		});
		
		
	});// end of $(document).ready(function()--------------------------------------------------
	
</script>


<div align="center" style="margin-bottom: 20px;">

<div style=" width: 1000px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px;/*  border-bottom:0.5px solid #cccccc; margin-bottom:70px; */ ">       
   <span style="font-size: 13pt; font-weight: bold;">Product Register</span>   
</div>
<br/>

<form name="prodInputFrm"
      action="<%= ctxPath%>/admin/productRegister.sh"
      method="POST"                         
      enctype="multipart/form-data">
      
<table id="tblProdInput" style="width: 60%; margin-left:50px; border:0.5px solid #cccccc;">
<tbody>
   <tr >
      <td width="10%" class="prodInputName" style="padding-top: 10px; ">카테고리</td>
      <td width="75%" align="left" style="padding-top: 10px;" >
         <select name="fk_cnum" class="infoData">
            <option value="">:::선택하세요:::</option>

            <c:forEach var="map" items="${requestScope.categoryList}">
               <option value="${map.cnum}">${map.cname}</option>
            </c:forEach>
         </select>
         <span class="error">필수입력</span>
      </td>   
   </tr>
   <tr >
      <td width="25%" class="prodInputName">제품명</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
         <input type="text" style="width: 300px; height:30px;" name="pname" class="box infoData" />
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품이미지</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <input type="file" name="pimage1" class="infoData " style="margin-bottom:15px;"/><span class="error">필수입력</span>
         <input type="file" name="pimage2" class="infoData " /><span class="error">필수입력</span>
         <input type="file" name="pimage3" class="infoData " /><span class="error">필수입력</span>
         <input type="file" name="pimage4" class="infoData " /><span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품수량</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
              <input type="number" id="spinnerPqty" name="pqty" value="1" min="1" max="100" style="width: 50px; height: 30px;"> 개
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품정가</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <input type="text" style="width: 100px; height:30px;" name="price" class="box infoData" /> 원
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품판매가</td>
      <td width="75%" align="left" style="border-top: hidden; ">
         <input type="text" style="width: 100px; height:30px;" name="saleprice" class="box infoData" /> 원
         <span class="error">필수입력</span>
      </td>
   </tr>
  
</tbody>
</table>
<div style=" width: 800px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; ">       
       <input type="button" value="제품등록" id="btnRegister" style="width: 150px; height: 50px; background-color:white; border:1px solid black; text-weight:bold;" /> 
          &nbsp;
          <input type="reset" value="취소"  style="width: 150px; height: 50px; background-color:white; border:1px solid black;" /> 
</div>
  
       
</form>
</div>

<jsp:include page="../footer.jsp"/>
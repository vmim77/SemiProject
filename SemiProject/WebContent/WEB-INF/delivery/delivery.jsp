<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
 
%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>


<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Noto Sans KR", sans-serif;
}

a {
  text-decoration: none;
  color: black;
}

li {
  list-style: none;
}

.wrap {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.1);
}

.login {
  width: 30%;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

h2 {
  color: tomato;
  font-size: 2em;
}
.login_sns {
  padding: 20px;
  display: flex;
}

.login_sns li {
  padding: 0px 15px;
}

.login_sns a {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px;
  border-radius: 50px;
  background: white;
  font-size: 20px;
  box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px rgba(0, 0, 0, 0.1);
}

.login_id {
  margin-top: 20px;
  width: 80%;
}

.login_id input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_pw {
  margin-top: 20px;
  width: 80%;
}

.login_pw input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_etc {
  padding: 10px;
  width: 80%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.submit {
  margin-top: 50px;
  width: 80%;
}
.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}


   table#loginTbl , table#snsloginTbl{
      width: 40%;
      border: solid 1px gray;
      border-collapse: collapse;
      margin-top: 20px;
      
   }
   
   table#loginTbl #th {
      background-color: silver;
      font-size: 14pt;
      text-align: center;
      height: 30px;
   }
   
   table#loginTbl td {
      border: solid 1px gray;
      line-height: 30px;
   }
</style>

<script type="text/javascript">




$(document).ready(function(){
	
	//$("button#btnSubmit").hide()
	
	$("button#btnSubmit").click(function(){
		var jumun_bunho = $("select#selectjumun").val();
		
		$.ajax({
			url:"<%=ctxPath%>/delivery/deliveryEnd.sh",
				data:{"jumun_bunho":jumun_bunho}, 
				dataType:"json",
				success:function(json) {
					
					
					// 댓글 넣어주기
	                $.each(json, function(index, item){
	                   
	                	var ahtml = item.buy_date;
	                	var bhtml = item.fk_userid;
	                	if(item.baesong_sangtae == 0){
	                		$("div#c").text("배송준비");
	                	}
	                	if(item.baesong_sangtae == 1){
	                		$("div#c").text("배송중");
	                	}
	                	if(item.baesong_sangtae == 2){
	                		$("div#c").text("배송완료");
	                	}
	                	if(item.baesong_sangtae == 3){
	                		$("div#c").text("환불");
	                	}
	                	if(item.baesong_sangtae == 4){
	                		$("div#c").text("교환");
	                	}
	                	
	                	$("div#a").html(ahtml);
	                	$("div#b").html(bhtml);
		           		
	              
	                  }); //end of $.each(json)--------------------------------------
					
				},
				error: function(request, status, error) {
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
	});
	
	
});



</script>

<form name="loginFrm">
       <table id="loginTbl">
           <div class="wrap">
        <div class="login">
            <h2 style="color: black;">운송장 번호로 조회</h2>
            <div class="login_id">
               <select id="selectjumun" style="width:200px; height:30px; margin-right:5px; padding:0px 5px; font-size:10pt; margin-left: 110px; ">
         <option>주문번호 선택</option>
         <c:choose>
		   <c:when test="${empty requestScope.order}"> 조회내역이 없습니다.
            	<option disabled="disabled">조회 내역이 없습니다.</option>
           </c:when>
		    <c:when test="${not empty requestScope.order}">
			     <c:forEach var="order" items="${requestScope.order}">
			     <option value="${order.jumun_bunho}">${order.jumun_bunho}</option>			
            	 </c:forEach>
		    </c:when>     
		</c:choose>
      </select>
   <button type='button' id='btnSubmit' class='btn btn-dark' data-toggle='modal' data-target='#myModal'>조회</button>
      </div>
   	  </div>
 	</div>
    </table>
</form>
   
   
   
   		

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel" style="text-align: right;">배송조회</h4>
        
      </div>
      
      <div class="modal-body">
        	<table border="1">
        	 <tr id="test">
				<th scope="col" class="" style="height: 50px; width: 350px">주문일자</th>
                <th scope="col" class="" style="height: 50px; width: 350px">주문자</th>
                <th scope="col" class="" style="height: 50px; width: 350px">배송상황</th>
            </tr>
			<tr>
				<td>
					<div id="a" style="text-align: left;"></div>
				</td>
				<td>
					<div id="b" style="text-align: left;"></div>
				</td>
				<td>
					<div id="c" style="text-align: left;"></div>
				</td>
			</tr>
        	</table>
      </div>
     		<div class="modal-footer">
       		 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	 </div>
	 
<form name="change">
	<input id="jumun_bunho" name="jumun_bunho" value="" />
	<input style="display: none;">
</form>	 
	   
   
<jsp:include page="../footer.jsp" />

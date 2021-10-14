<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
 
%>   
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

 function godelivery() {
	 
	 
	 
 }


</script>


<form name="loginFrm">
       <table id="loginTbl">
           <div class="wrap">
        <div class="login">
            <h2 style="color: black;">운송장 번호로 조회</h2>
            <div class="login_id">
                <input type="text" name="" id="" placeholder="예 01234567890, ‘-’를 제외한 숫자 11자리" maxlength="11" >
            </div>
            <div class="login_pw">
            </div>
            <button type="button" id="btnSubmit" class="btn btn-dark" data-toggle="modal" data-target="#myModal">
		  	조회
		</button>
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
        	 <tr>
				<th scope="col" class="" style="height: 50px; width: 350px">주문일자</th>
                <th scope="col" class="" style="height: 50px; width: 350px">주문자</th>
                <th scope="col" class="" style="height: 50px; width: 350px">진행사항</th>
            </tr>
            
			
			<tr>
				<td>2021-10-13</td>
				<td>금길영</td>
				<td>배송준비중</td>
			</tr>            
        	</table>
      </div>
     		<div class="modal-footer">
       		 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	 </div>
	   
   
<jsp:include page="../footer.jsp" />

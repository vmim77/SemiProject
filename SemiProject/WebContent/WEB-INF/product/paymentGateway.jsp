<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		var IMP = window.IMP;  
		IMP.init('imp20734563');  
		
		IMP.request_pay({
	       
			pg : 'html5_inicis',
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '결제테스트(코인충전|주문명)',
			
			/////////////////////////////////////////////////////////////////
			amount : 100, // '${coinmoney}'  결제 금액 number 타입. 필수항목.	   
			buyer_email    : '${requestScope.email}',      // 구매자 email
			buyer_name     : '${requestScope.name}',	   // 구매자 이름 
			buyer_tel      : '${requestScope.mobile}',     // 구매자 전화번호 (필수항목)
			buyer_addr     : '',  
			buyer_postcode : '',
			/////////////////////////////////////////////////////////////////
			
			m_redirect_url : ''  // 휴대폰 사용시 결제 완료 후  action : 컨트롤러로 보내서 자체 db에 입력시킬것!
		
		}, function(rsp) {
			if ( rsp.success ) { 
				self.close();
	        } 
			else {
	            location.href="/SemiProject/index.sh";
	            alert("결제에 실패하였습니다.");
	       }//end of if ( rsp.success ) {-------------------------
	
	   }); // end of IMP.request_pay()----------------------------
	
	}); // end of $(document).ready()-----------------------------

</script>
</head>	

<body>
</body>
</html>

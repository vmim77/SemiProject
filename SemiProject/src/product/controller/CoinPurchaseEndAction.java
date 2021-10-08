package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CoinPurchaseEndAction extends AbstractController {
//============================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		// 나중에 로그인하고 묶어주고
		// 포스트로 바꿔주기
		if("GET".equalsIgnoreCase(method)) {
				
			super.setViewPage("/WEB-INF/product/paymentGateway.jsp");
				
		}
		else {
			
			String message = "비 정상적인 경로 입니다";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
			
		}

	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//============================================================================================
}

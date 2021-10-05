package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class StoreAction extends AbstractController {
//=========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		String cartopt123 = request.getParameter("cartopt123");
		
		if("POST".equalsIgnoreCase(method) ) {
			
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			// String img = request.getParameter("img");
			String cartname   = request.getParameter("cartname");    
			String cartopt4   = request.getParameter("cartopt4");   
			String cartnum    = request.getParameter("cartnum");   
			String cartprice  = request.getParameter("cartprice");   
			String cartfinopt = request.getParameter("cartfinopt");   
			cartopt123 = request.getParameter("cartopt123");
			request.setAttribute("cartname", cartname);
			request.setAttribute("cartopt123", cartopt123);
			request.setAttribute("cartopt4", cartopt4);
			request.setAttribute("cartnum", cartnum);
			request.setAttribute("cartprice", cartprice);
			request.setAttribute("cartfinopt", cartfinopt);
			
			super.setViewPage("/WEB-INF/product/store.jsp");
			
		}
		else {
			
			if(cartopt123 == null) {
			 
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			}
			
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//=========================================================================================
}

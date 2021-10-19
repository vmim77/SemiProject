package product.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.*;

public class MycartAction extends AbstractController {
//===========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {
			
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			String product_front_p1 = request.getParameter("product_front_p1");
			String cartname   = request.getParameter("cartname");
			String cartopt123 = request.getParameter("cartopt123");    
			String cartopt4   = request.getParameter("cartopt4");   
			String cartnum    = request.getParameter("cartnum");   
			String cartprice  = request.getParameter("cartprice");   
			String cartfinopt = request.getParameter("cartfinopt");   
			
			request.setAttribute("product_front_p1", product_front_p1);
			request.setAttribute("cartname", cartname);
			request.setAttribute("cartopt123", cartopt123);
			request.setAttribute("cartopt4", cartopt4);
			request.setAttribute("cartnum", cartnum);
			request.setAttribute("cartprice", cartprice);
			request.setAttribute("cartfinopt", cartfinopt);
			
			super.setViewPage("/WEB-INF/product/cart.jsp");
			
		}
		else {
			
			String message = "로그인 후 이용가능한 서비스 입니다";
			String loc = "/SemiProject/login/login.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//===========================================================================================
}

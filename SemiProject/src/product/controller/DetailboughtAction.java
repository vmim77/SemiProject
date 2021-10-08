package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class DetailboughtAction extends AbstractController {
//==========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			String product_front_p1 = request.getParameter("product_front_p1");
			String cartname   = request.getParameter("cartname");
			String cartopt123 = request.getParameter("cartopt123");    
			String cartopt4   = request.getParameter("cartopt4");   
			String cartnum    = request.getParameter("cartnum");   
			String cartprice  = request.getParameter("cartprice");   
			String cartfinopt = request.getParameter("cartfinopt");  
			String jukrib = request.getParameter("jukrib");
			
			request.setAttribute("product_front_p1", product_front_p1);
			request.setAttribute("cartname", cartname);
			request.setAttribute("cartopt123", cartopt123);
			request.setAttribute("cartopt4", cartopt4);
			request.setAttribute("cartnum", cartnum);
			request.setAttribute("cartprice", cartprice);
			request.setAttribute("cartfinopt", cartfinopt);
			request.setAttribute("jukrib", jukrib);
			
			// 배송을 위한 정보를 담은 내역
			String name = request.getParameter("name");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String firstemail = request.getParameter("firstemail");
			String secondemail = request.getParameter("secondemail");
			String text = request.getParameter("text");
			
			// 받아온거로 새로운 값 처리
			String email = firstemail + secondemail;
			if(text == "") {
				text = "조심히 와주세요";
			}
			
			request.setAttribute("name", name);
			request.setAttribute("postcode", postcode);
			request.setAttribute("address", address);
			request.setAttribute("detailAddress", detailAddress);
			request.setAttribute("hp1", hp1);
			request.setAttribute("hp2", hp2);
			request.setAttribute("hp3", hp3);
			request.setAttribute("email", email);
			request.setAttribute("text", text);
			
			super.setViewPage("/WEB-INF/product/detailbought.jsp");
		}
		else {
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==========================================================================================
}

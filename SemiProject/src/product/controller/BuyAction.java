package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.controller.AbstractController;
import product.model.*;

public class BuyAction extends AbstractController {
//==========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String product_name = request.getParameter("product_name");
		
		if(product_name != null) {

			// DAO객체 생성
			InterProductDAO pdao = new ProductDAO();
			// 받은 제품이름으로 셀렉트 검색해주기
			ProductVO pvo = pdao.getOneProduct(product_name);
			// 값 넘겨주기
			request.setAttribute("pvo", pvo);
			
			super.setViewPage("/WEB-INF/product/buy.jsp");
			
		}
		else {
			
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}//end of if("POST".equalsIgnoreCase(method)) {-------------------------------------
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==========================================================================================
}

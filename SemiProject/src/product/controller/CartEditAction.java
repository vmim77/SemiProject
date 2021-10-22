package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductRealDAO;

public class CartEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// get 방식이라면
			String message = "비정상적인 경로로 들어왔습니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
		}
		
		else if("post".equalsIgnoreCase(method) && super.checkLogin(request)){
			
			String cartno = request.getParameter("cartno");
			String qty = request.getParameter("qty");
			
			System.out.println(cartno);
			System.out.println(qty);
			
			InterProductRealDAO prdao = new ProductRealDAO();
			
			// 장바구니 테이블에서 특정제품의 주문량 변경시키기 
			int n = prdao.updateQty(cartno,qty);
			
			 JSONObject jsobj = new JSONObject();
	         jsobj.put("n", n);
	         
	         String json = jsobj.toString();
	         
	         request.setAttribute("json", json);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
		
		
	}

}

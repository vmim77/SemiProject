package product.controller;

import java.util.List;
import javax.servlet.http.*;
import common.controller.AbstractController;
import product.model.*;

public class ProductListAction extends AbstractController {
//============================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  
		String product_name = request.getParameter("productname");
		
		if(product_name != null) {

			InterProductDAO pdao = new ProductDAO();		
			List<ProductVO> productimgList = pdao.productimgList(product_name);
			  
			request.setAttribute("productimgList", productimgList);
			
			super.setViewPage("/WEB-INF/product/productList.jsp");
			
		}
		else {
			
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//============================================================================================
}
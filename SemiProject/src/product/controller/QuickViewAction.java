package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class QuickViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String quickProductName = request.getParameter("quickProductName");
		
		System.out.println(quickProductName);
		
		 InterProductDAO pdao = new ProductDAO();
		 
		 ProductVO quickViewProduct = pdao.quickViewProduct(quickProductName);
		 System.out.println(quickViewProduct.getProduct_name());
		 
		 JSONObject jsonObj = new JSONObject();
		 
		 jsonObj.put("product_name", quickViewProduct.getProduct_name());
		 jsonObj.put("product_front_p1", quickViewProduct.getProduct_front_p1());
		 jsonObj.put("product_back_p2", quickViewProduct.getProduct_back_p2());
		 jsonObj.put("product_price", quickViewProduct.getProduct_price());
		 jsonObj.put("product_ceil_price", quickViewProduct.getProduct_ceil_price());
		 jsonObj.put("product_first_p", quickViewProduct.getProduct_first_p());
		 jsonObj.put("product_second_p", quickViewProduct.getProduct_second_p());

		 
		 String json = jsonObj.toString();
		 
		 request.setAttribute("json", json);
		 
		 //super.setRedirect(false);
		 super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}

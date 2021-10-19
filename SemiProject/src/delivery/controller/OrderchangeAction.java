package delivery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductBuyVO;
import product.realmodel.ProductRealDAO;

public class OrderchangeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterProductRealDAO prdao = new ProductRealDAO();
        
        String jumun_bunho = request.getParameter("jumun_bunho");
        
        List<ProductBuyVO> orderList = prdao.SelectMyBought(jumun_bunho);
        
        request.setAttribute("jumun_bunho", jumun_bunho);
        
        request.setAttribute("orderList", orderList);
        
        int th = 0;
        String can = request.getParameter("can");
        
        System.out.println("can => " + can);
        System.out.println("th => " + th);
        
        if( can != null ) {
        	
        	jumun_bunho = request.getParameter("retry_jumun_bunho");
	        
	        if("환불·취소".equals(can)) {
	        	th = 3;
	        	System.out.println("th => " + th);
	        	System.out.println("jumun_bunho => " + jumun_bunho);
	        	int ChangeList = prdao.Change(jumun_bunho,th);
	        	request.setAttribute("ChangeList", ChangeList);
	        }
	        else {
	        	th = 4;
	        	int ChangeList = prdao.Change(jumun_bunho,th);
	        	request.setAttribute("ChangeList", ChangeList);
	        }
        }
        	
        
		super.setViewPage("/WEB-INF/delivery/orderchange.jsp");
		
	}

}

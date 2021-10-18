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
        String baesong_sangtae = request.getParameter("baesong_sangtae");
        
        List<ProductBuyVO> orderList = prdao.SelectMyBought(jumun_bunho);
        
        request.setAttribute("orderList", orderList);
        
        
        if( baesong_sangtae == "배송준비" ) {
        	int ChangeList = prdao.Change(jumun_bunho);
        	
        	request.setAttribute("ChangeList", ChangeList);
        }
        else {
        	
        	
        }
        
		
		
		super.setViewPage("/WEB-INF/delivery/orderchange.jsp");
		
	}

}

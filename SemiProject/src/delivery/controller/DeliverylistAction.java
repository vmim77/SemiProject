package delivery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductBuyVO;
import product.realmodel.ProductRealDAO;

public class DeliverylistAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
	    MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
	    String userid = loginuser.getUserid();
		
		InterProductRealDAO prdao = new ProductRealDAO();
		
		List<ProductBuyVO> order = prdao.myorder(userid); 
		request.setAttribute("order", order);
		
		
		
		
		super.setViewPage("/WEB-INF/delivery/delivery.jsp");
		
	}

}

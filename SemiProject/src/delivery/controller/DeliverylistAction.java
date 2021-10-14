package delivery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class DeliverylistAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
		InterProductDAO pdao = new ProductDAO();
		
		String userid = loginuser.getUserid();
		
		List<ProductDAO> libo = pdao.myorder(userid); 
		
		
		
		super.setViewPage("/WEB-INF/delivery/delivery.jsp");
		
	}

}

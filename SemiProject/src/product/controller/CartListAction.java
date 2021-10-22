package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductCartVO;
import product.realmodel.ProductRealDAO;

public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		boolean isLogin = super.checkLogin(request);
		
		if(!isLogin) {// 로그인을 하지 않고 장바구니를 가려고 한다면
			request.setAttribute("message", "장바구니를 보려면 로그인부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {// 로그인을 했다면~
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			request.setAttribute("username", loginuser.getName());
			request.setAttribute("point", loginuser.getPoint());
			
		//	System.out.println(loginuser.getUserid());
			InterProductRealDAO prdao = new ProductRealDAO();
			
			
			
			List<ProductCartVO> cartList = prdao.getCartList(loginuser.getUserid());
			HashMap<String,String> sumMap = prdao.getTotal_totalprice(loginuser.getUserid());
			
			request.setAttribute("sumMap", sumMap);
			request.setAttribute("cartList", cartList);
			
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/cart.jsp");
			
		}
		
		
		
		
		
		
		
	}

}

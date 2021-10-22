package product.controller;

import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.*;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductRealDAO;

public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === 로그인 유무 검사하기 === //
	      boolean isLogin = super.checkLogin(request);
	      
	   if(!isLogin) { // 로그인을 하지 않은 상태이라면 
	          /*
	             사용자가 로그인을 하지 않은 상태에서 특정제품을 장바구니에 담고자 하는 경우 
	             사용자가 로그인을 하면 장바구니에 담고자 했던 그 특정제품 페이지로 이동하도록 해야 한다.
	             이와 같이 하려고 ProdViewAction 클래스에서 super.goBackURL(request); 을 해두었음.   
	          */
	             
	          request.setAttribute("message", "장바구니에 담으려면 먼저 로그인 부터 하세요!!");
	          request.setAttribute("loc", "javascript:history.back()");
	             
	       //   super.setRedirect(false);
          super.setViewPage("/WEB-INF/msg.jsp");
	             
	          return;
	       }
	      else {// 로그인을 한 상태이라면 	    	
	          // 장바구니 테이블(tbl_cart)에 해당 제품을 담아야 한다.
	          // 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert 를 해야하고, 
	          // 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 tbl_cart 테이블에 update 를 해야한다.
	    	  
	    	  String method = request.getMethod();
	    	  
	    	  if("POST".equalsIgnoreCase(method)) {
	    		  
	    		  InterProductRealDAO prdao = new ProductRealDAO();
	    		  
	    		  	// 장바구니 번호 채번해오기
	    		//    int cartno = prdao.getCartno();
	    		    
	    		    //제품 번호 알아오기 VO를 잘못짜서 제품이름으로 알아와야 함.
	    		    String cartname = request.getParameter("cartname");
	    		    
	    		    int pnum = prdao.getPnum(cartname);
	    		    
	    			
	    			String cartopt123 = request.getParameter("cartopt123");
	    			String cartopt4 = request.getParameter("cartopt4");
	    			String cart_opt_info = cartopt123+cartopt4;
	    			
	    			String cart_qty = request.getParameter("cartnum");
	    			String cartprice = request.getParameter("cartprice");
	    			String cartfinopt = request.getParameter("cartfinopt");
	    			String frm_num_cartprice = request.getParameter("frm_num_cartprice");
	    			String cart_opt_price = request.getParameter("frm_num_cartfinopt");
	    			String product_front_p1 = request.getParameter("product_front_p1");
	    			
	    			HttpSession session = request.getSession();
		    		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		    		
		    		
		    		
		    	//	유저아이디,제품번호,수량,옵션,옵션가격
		    		
		    		//장바구니 담기 삽입 또는 업데이트
		    		int n = prdao.addCart(loginuser.getUserid(),pnum,cart_opt_info,cart_qty,cart_opt_price);
		    		
		    		if(n==1) {
		    			  request.setAttribute("message", "장바구니 담기 성공!!");
		                  request.setAttribute("loc", "cartList.sh");
		                   // 장바구니 목록보여주기 페이지 이동 
		    		  }
		    		  else {
		                  request.setAttribute("message", "장바구니 담기 실패!!");
		                  request.setAttribute("loc", "javascript:history.back()"); 
		               }
		    		  //  super.setRedirect(false);   
		              super.setViewPage("/WEB-INF/msg.jsp");
	    					    
	    		  
	    	  }
	    	  else {
	    		  
	    		// GET 방식이라면 
	              String message = "비정상적인 경로로 들어왔습니다";
	              String loc = "javascript:history.back()";
	               
	              request.setAttribute("message", message);
	              request.setAttribute("loc", loc);
	              
	           //  super.setRedirect(false);   
	              super.setViewPage("/WEB-INF/msg.jsp");
	    	  }
	    	  
	    	  
	      }
		
		

		
		
	}

}

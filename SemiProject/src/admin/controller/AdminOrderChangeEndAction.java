package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.realmodel.*;

public class AdminOrderChangeEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			if("admin".equals(loginuser.getUserid())) {
				
				String odrcode = request.getParameter("odrcode");
				String pnum = request.getParameter("pnum");
				String changeStatus = request.getParameter("changeStatus");
				
				
				InterProductRealDAO prdao = new ProductRealDAO();
				
				int n = prdao.changeBaesongStatus(odrcode, pnum, changeStatus);
				
				String message = "";
				String loc = "";
				if(n==1) {
					message = "배송상태 변경성공";
					loc = request.getContextPath()+"/admin/orderList.sh";
				}
				
				else {
					message = "배송상태 변경실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
				
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
				
				
				
				
			}
			else {
	            String message = "권한이 없는 사용자입니다.";
	            String loc = "javascript:history.back();";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else {
            String message = "잘못된 접근입니다.";
            String loc = "javascript:history.back();";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
		
	}

}

package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.realmodel.*;

public class AdminOrderChangeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			if(loginuser != null && "admin".equals(loginuser.getUserid())) {
				
				String odrcode = request.getParameter("odrcode");
				String userid = request.getParameter("userid");
				String pnum = request.getParameter("pnum");
				String status = request.getParameter("status");
				
				Map<String, String> map = new HashMap<>();
				
				map.put("odrcode", odrcode);
				map.put("userid", userid);
				map.put("pnum", pnum);
				map.put("status",status);
				
				
				request.setAttribute("map", map);
				super.setViewPage("/WEB-INF/admin/orderStatusChange.jsp");
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
		
		else { // "GET" 접근
            String message = "잘못된 접근입니다.";
            String loc = "javascript:history.back();";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
		
	}

}

package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class AdminMemberEditEndAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 추후에 로그인한 유저정보가 '운영자'인지 아닌지 확인하는 if절을 걸어서 걸러낼겁니다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST로 들어오는 경우
				
				// 수정하기 전
				String userid = request.getParameter("userid");
			
				
				int point = Integer.parseInt(request.getParameter("point"));
				int status = Integer.parseInt(request.getParameter("status"));
				int idle = Integer.parseInt(request.getParameter("idle"));
				String couponname =  request.getParameter("couponname");
				
				
				String onlyinfo = request.getParameter("onlyinfo");
				String onlycoupon = request.getParameter("onlycoupon");
	
				MemberVO member = new MemberVO();
				
				member.setUserid(userid);
				member.setPoint(point);
				member.setStatus(status);
				member.setIdle(idle);
				member.setCouponname(couponname);
			
				
				if( "test".equals(onlyinfo) && "onlycoupon".equals(onlycoupon)) {
					
					mdao.couponudate(member);
					
					message = " 쿠폰 추가 성공![운영자메뉴]";
					loc = "javascript:history.back()";
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/msg.jsp");
						
				}
				else if( "onlyinfo".equals(onlyinfo) && "test".equals(onlycoupon)) {
					
					
					
					int n = mdao.adminUpdateUser(member);
					
					
					if(n==1) { // UPDATE 성공한 경우
						message = "회원정보 변경성공[운영자메뉴]";
						loc = request.getContextPath()+"/index.sh";
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
				
					else { // UPDATE 실패한 경우
						message = "회원정보 변경실패[운영자메뉴]";
						loc = request.getContextPath()+"/index.sh";
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						super.setViewPage("/WEB-INF/msg.jsp");
						
					}
					
				}//end of if( onlyinfo == "test" && onlycoupon == "onlycoupon") {
				
			}
			else { // "GET" 으로 들어오는 경우
				
				message = "일반회원이 사용할 수 없는 기능입니다!!";
				loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}//end of if("POST".equalsIgnoreCase(method)) { // POST로 들어오는 경우
			
		}
		else {
			
			message = "잘못된 접근입니다.";
			loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}//end of if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
}


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
		
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 먼저 운영자인지 아닌지를 검사한다.
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			// "GET" or "POST"
			
			String message = "";
			String loc = "";
			
			// 수정하기는 POST를 통해서만 폼이 전송되어진다.
			if("POST".equalsIgnoreCase(method)) {
				
				String userid = request.getParameter("userid"); 				// 조건절에 사용할 유저아이디
				int point = Integer.parseInt(request.getParameter("point")); 	// 변경된 포인트
				int status = Integer.parseInt(request.getParameter("status")); 	// 변경된 회원상태
				int idle = Integer.parseInt(request.getParameter("idle")); 		// 변경된 휴면여부
				String couponname =  request.getParameter("couponname"); 		// 쿠폰이름
				
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
						message = "[운영자메뉴]회원정보 변경성공";
						loc = request.getContextPath()+"/admin/memberList.sh";
					}
					
					else { // UPDATE 실패한 경우
						message = "[운영자메뉴]회원정보 변경실패";
						loc = request.getContextPath()+"/index.sh";
					}
					
				}//end of if( onlyinfo == "test" && onlycoupon == "onlycoupon") {
				
				
			}
			
			else { // "GET" 으로 들어오는 경우이다.
				message = "잘못된 접근입니다!!";
				loc = request.getContextPath()+"/index.sh";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		else {
			String message = "운영자 메뉴입니다. 잘못된 접근입니다!!";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		

		
	}

}

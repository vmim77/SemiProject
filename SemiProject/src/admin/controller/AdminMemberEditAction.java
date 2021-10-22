package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class AdminMemberEditAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 먼저 운영자인지 아닌지를 판별한다.
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			// 함수에서 GET으로 넘긴 유저의 아이디이다.
			String userid = request.getParameter("userid");
			
			// DAO에 파라미터로 전송하여 select where로 기존 회원의 정보를 조회해온다.
			MemberVO member = mdao.adminEditUserInfo(userid);
			
			// 만약 조회된 회원이 없다면 member는 null이다.
			if(member != null) { 
				
				// 기존의 회원정보를 request 영역에 담아서 넘긴다.
				request.setAttribute("member", member);
				
				// 또한 정보를 변경하고 넘길때 update에서 where절에 사용할 userid도 같이 넘긴다.
				request.setAttribute("userid", userid);
				
				super.setViewPage("/WEB-INF/admin/memberEdit.jsp");
				
			}
			
			else { // 조회된 회원이 없는 경우이다.
				String message = "조회된 회원이 없습니다. 다시 확인바랍니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else { // 운영자가 아닌 사용자가 URL로 들어오거나 했다면 막아준다.
			String message = "관리자전용 메뉴입니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		

		
	}

}

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
		
		// 추후에 로그인한 유저정보가 '운영자'인지 아닌지 확인하는 if절을 걸어서 걸러낼겁니다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String userid = request.getParameter("userid"); // 모달창에서 팝업으로 GET으로 전송시킨 USERID입니다.
			
			MemberVO member = mdao.adminEditUserInfo(userid); // DAO에 넘겨서 기존 회원의 정보를 가져옵니다.
			
			
			if(member != null) {
				request.setAttribute("member", member);
				// memberEdit.jsp에 가져가서 찍어줄 회원정보입니다.
				
				request.setAttribute("userid", userid);
				// 새로운 정보를 입력받고 update로 넘길때 where절에 사용할 userid 입니다.
				
				super.setViewPage("/WEB-INF/admin/memberEdit.jsp");
				
			}
			
			else {
				String message = "SQL 오류로 인해 회원정보를 가져오지 못했습니다.";
				String loc = "javascript:history.back()";
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}
		
		else {
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		

		
	}

}

package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class MemberEditEndAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		int point = Integer.parseInt(request.getParameter("point"));
		int status = Integer.parseInt(request.getParameter("status"));
		int idle = Integer.parseInt(request.getParameter("idle"));

		MemberVO member = new MemberVO();
		
		member.setUserid(userid);
		member.setPoint(point);
		member.setStatus(status);
		member.setIdle(idle);
		
		int n = mdao.adminUpdateUser(member);
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			message = "회원정보 변경성공[운영자메뉴]";
		}
	
		else {
			message = "회원정보 변경성공[운영자메뉴]";
		}
		
		loc = "javascript:history.back();";
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}

}

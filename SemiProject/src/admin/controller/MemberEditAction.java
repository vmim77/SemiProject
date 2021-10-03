package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class MemberEditAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String userid = request.getParameter("userid"); // 모달창에서 팝업으로 GET으로 전송시킨 USERID입니다.
		
		MemberVO member = mdao.adminEditUserInfo(userid); // DAO에 넘겨서 기존 회원의 정보를 가져옵니다.
		
		request.setAttribute("member", member);
		// memberEdit.jsp에 가져가서 찍어줄 회원정보입니다.
		
		request.setAttribute("userid", userid);
		// 새로운 정보를 입력받고 update로 넘길때 where절에 사용할 userid 입니다.
		
		super.setViewPage("/WEB-INF/admin/memberEdit.jsp");
		
	}

}

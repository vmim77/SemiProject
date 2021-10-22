package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {
//====================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String userCertificationCode = request.getParameter("userCertificationCode");
		
		HttpSession session = request.getSession();// 세션불러오기
		String certificationCode = (String)session.getAttribute("certificationCode");
		// object 타입을 형변환해서 사용하자
		
		String message = "";
		String loc = "";
		
		if(certificationCode.equals(userCertificationCode)) {
			message = "인증성공 되었습니다.";
			loc = request.getContextPath()+"/login/pwdUpdateEnd.sh?userid="+userid;
		}
		else {
			message = "발급된 인증코드가 아닙니다. 인증코드를 다시 받으세요!!";
			loc = request.getContextPath()+"/login/pwdFind.sh";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		super.setViewPage("/WEB-INF/msg.jsp");
		
		// 중요중요아주중요!!!
		// 세션에 저장된 인증코드가 맞는지 아닌지 알아봤으니 다썼으면 세션에 저장되있는 코드를 삭제해야한다.
		// 세션 지우는 2가지 방법 LogoutAction 확인하기
		session.removeAttribute("certificationCode");
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//====================================================================================
}

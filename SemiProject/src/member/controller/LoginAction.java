package member.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.AbstractController;
import member.model.*;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온 것이 아니라면 
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
			
			return; //  execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료하기
		}
		
		// POST 방식으로 넘어온 것이라면
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		// ===> 클라이언트의 IP 주소를 알아오는 것  <=== //
		String clientip = request.getRemoteAddr();
		// C:\NCS\workspace(jsp)\MyMVC\WebContent\JSP 파일을 실행시켰을 때 IP 주소가 제대로 출력되기위한 방법.txt 참조할 것
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		paraMap.put("clientip", clientip);
		
		InterMemberDAO mdao = new MemberDAO();
		
		MemberVO loginuser = mdao.selectOneMember(paraMap);
		
		if(loginuser != null ) {
			
			if(loginuser.getIdle() == 1 ) {
				 String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다. 관리자가에게 문의 바랍니다.";
		         String loc = request.getContextPath()+"/login/login.sh";
		         // 원래는 위와 같이 index.up 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
		         
		         return; // 메소드 종료
				
			}
			
			
			HttpSession session = request.getSession();
			// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
			
			session.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
			
			if( loginuser.isRequirePwdChange() == true) {
				 String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!";
		         String loc = request.getContextPath()+"/login/login.sh";
		         // 원래는 위와 같이 index.up 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다.
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
		         
		         return;
			}
			
			else {
				// 비밀번호를 변경한지 3개월이내인 경우
				// 페이지 이동을 시킨다.
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index_1.sh");
				
			
				
			}
			
		}
		
		
		else {
			// System.out.println(">>> 확인용 로그인 실패!!! <<<");
	         String message = "로그인 실패";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}

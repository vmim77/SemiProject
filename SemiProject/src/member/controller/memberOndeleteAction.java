package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class memberOndeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온 것이 아니라면 
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		else {
		
			String message ="";
			String loc ="";
			
		// POST 방식으로 넘어온 것이라면
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.deleteMember(userid,pwd);
			 
			 if(n==1) {
		    	 message = "회원탈퇴 성공";
		    	 super.setViewPage("/WEB-INF/index.jsp"); // 시작페이지로 이동한다.
		     }
			 
			 else {
		    	 message = "SQL구문 에러발생";
		    	 loc="javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
		     }
	
		     request.setAttribute("message", message);
		     request.setAttribute("loc", loc);
		     
		//   super.setRedirect(false);
		     super.setViewPage("/WEB-INF/msg.jsp");
		}		
		
	}

}

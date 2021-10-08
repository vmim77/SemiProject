package member.controller;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberOndeleteAction extends AbstractController {

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
		
			
		// POST 방식으로 넘어온 것이라면
			HttpSession session = request.getSession();
		     MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		      
		    String userid = loginuser.getUserid();
			String pwd = request.getParameter("pwd");
			
			//System.out.println("확인용"+userid+pwd);
			
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.deleteMember(userid,pwd);
			 
			 if(n==1) {
		    	 String message = "회원탈퇴 성공";
		    	 String loc ="/SemiProject/index.sh";

		    	 request.setAttribute("message", message);
		    	 request.setAttribute("loc", loc);// 시작페이지로 이동한다.
		    	 
			     session.invalidate(); // 새션값 비우기
			     
			//   super.setRedirect(false);
				 super.setViewPage("/WEB-INF/msg.jsp");
		     }
			 else if(n==3) {
				 String message ="비밀번호 오류";
				 String  loc="javascript:history.back()";
				 request.setAttribute("message", message);
				 request.setAttribute("loc", loc);
				 
			//   super.setRedirect(false);
				 super.setViewPage("/WEB-INF/msg.jsp");
			 }
			 else {
		    	String message = "SQL구문 에러발생";
		    	String  loc="javascript:history.back()";
		    	request.setAttribute("message", message);
			    request.setAttribute("loc", loc);// 자바스크립트를 이용한 이전페이지로 이동하는것.
			    
			//  super.setRedirect(false);
			    super.setViewPage("/WEB-INF/msg.jsp");
			 
			 }
	
		     
		     
		//   super.setRedirect(false);
		     super.setViewPage("/WEB-INF/msg.jsp");
		}		
		
	}

}

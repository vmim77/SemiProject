package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
			
		}
		
		else {
			 String name = request.getParameter("name"); 
		     String userid = request.getParameter("userid"); 
		     String pwd = request.getParameter("pwd"); 
		     String email = request.getParameter("email"); 
		     String hp1 = request.getParameter("hp1"); 
		     String hp2 = request.getParameter("hp2"); 
		     String hp3 = request.getParameter("hp3"); 
		     String postcode = request.getParameter("postcode");
		     String address = request.getParameter("address"); 
		     String detailAddress = request.getParameter("detailAddress"); 
		     String extraAddress = request.getParameter("extraAddress"); 
		     String gender = request.getParameter("gender"); 
		     String birthyyyy = request.getParameter("birthyyyy"); 
		     String birthmm = request.getParameter("birthmm"); 
		     String birthdd = request.getParameter("birthdd");
		     String referral = request.getParameter("referral");
		    
		     
		     String mobile = hp1+hp2+hp3;
		     String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
		     
		     MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday, referral);
		     
		     String message = "";
		     String loc = "";
		     
		     try {
		     
			     InterMemberDAO mdao = new MemberDAO();
			     int n = mdao.registerMember(member);
			     
			     if(n==1) {
			    	 message = "회원가입 성공";
			    	 			
			    	 loc = request.getContextPath()+"/index.sh"; // 시작페이지로 이동한다.
			     }
		     } catch (SQLException e) {
		    	 message = "SQL구문 에러발생";
		    	 loc="javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
		     }
		     
		     request.setAttribute("message", message);
		     request.setAttribute("loc", loc);
		     
		//   super.setRedirect(false);
		     super.setViewPage("/WEB-INF/msg.jsp");
		  
		     // #### 회원가입이 성공되면 자동으로 로그인 되도록 하겠다. ####
		/*     
		     try {
			     
			     InterMemberDAO mdao = new MemberDAO();
			     int n = mdao.registerMember(member);
			     
			     if(n==1) {
			    	 request.setAttribute("userid", userid);
			    	 request.setAttribute("pwd", pwd);
			    	 
			    //	 super.setRedirect(false);
			    	 super.setViewPage("/WEB-INF/login/registerAfterAutoLogin.jsp");
			     }
		     } catch (SQLException e) {
		    	  message = "SQL구문 에러발생";
		    	  loc="javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
		     
		    	 request.setAttribute("message", message);
			     request.setAttribute("loc", loc);
			     
			//   super.setRedirect(false);
			     super.setViewPage("/WEB-INF/msg.jsp");
			  
		     }
		     */
		     
		}
		

		
	}

}

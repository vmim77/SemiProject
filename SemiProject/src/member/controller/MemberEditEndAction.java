package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;


public class MemberEditEndAction extends AbstractController {

	//==============================================================================================
	   @Override
	   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
	      String method = request.getMethod();
	      
	      if("post".equalsIgnoreCase(method)) {
	         
	         String userid = request.getParameter("userid");
	         String pwd = request.getParameter("pwd");
	         String name = request.getParameter("name");
	         String email = request.getParameter("email");
	         String hp1 = request.getParameter("hp1");
	         String hp2 = request.getParameter("hp2");
	         String hp3 = request.getParameter("hp3");
	         String postcode = request.getParameter("postcode");
	         String address = request.getParameter("address");
	         String detailAddress = request.getParameter("detailAddress");
	         String extraAddress = request.getParameter("extraAddress");
	         String referral = request.getParameter("referral");
	         
	         String mobile = hp1+hp2+hp3;
	         
	         MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress,referral);
	         
	         InterMemberDAO mado = new MemberDAO();
	         int n = mado.updateMember(member);
	         
	         String message = "";
	         String loc = "javascript:history.back()";
	         
	         if(n==1) {
	            
	            // session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다.
	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	            
	            loginuser.setName(name);
	            loginuser.setPwd(pwd);
	            loginuser.setEmail(email);
	            loginuser.setMobile(mobile);
	            loginuser.setPostcode(postcode);
	            loginuser.setAddress(address);
	            loginuser.setDetailaddress(detailAddress);
	            loginuser.setExtraaddress(extraAddress);
	            
	            message = "회원정보 수정 성공!";
	         }
	         else {
	            message = "회원정보 수정 실패!";
	         }
	         
	         request.setAttribute("loc", loc);
	         request.setAttribute("message", message);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	      }
	      else {
	         
	         String message = "비정상적인 경로를 통해 들어왔습니다.!!"; 
	         String loc = "javascript:history.back()";
	            
	         request.setAttribute("message", message); 
	         request.setAttribute("loc", loc);
	            
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	      }//end of if("post".equalsIgnoreCase(method)) {------------------
	      
	   }//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
}
	//==============================================================================================
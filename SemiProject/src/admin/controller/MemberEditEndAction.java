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
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String hp1 = request.getParameter("hp1");
		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String detailaddress = request.getParameter("detailaddress");
		String extraaddress = request.getParameter("extraaddress");
		
		String mobile = hp1+hp2+hp3;
		
		MemberVO member = new MemberVO();
		
		member.setUserid(userid);
		member.setName(name);
		member.setEmail(email);
		member.setMobile(mobile);
		member.setPostcode(postcode);
		member.setAddress(address);
		member.setDetailaddress(detailaddress);
		member.setExtraaddress(extraaddress);
		
		int n = mdao.adminUpdateUser(member);
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			message = "변경성공";
			loc = "javascript:history.back();";
		}
		
		else {
			message = "변경실패";
			loc = "javascript:history.back();";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}

}

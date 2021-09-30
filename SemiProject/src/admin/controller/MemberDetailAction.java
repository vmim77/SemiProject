package admin.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.controller.AbstractController;
import member.model.*;

public class MemberDetailAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		
		// Ajax 특정 회원조회로 들어온 경우입니다. 
			
			String userid = request.getParameter("userid");
			
			// System.out.println(userid);
			
			MemberVO member = mdao.selectOneUser(userid);
			
				
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			out.print(new Gson().toJson(member));
			
		
	}

}

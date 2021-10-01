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
		
		// 테이블에서 한 행을 클릭하면 그 행의 userid를 따옵니다. 그 유저아이디를 가지고 select where절을 돌려서 한 회원의 상세정보들을 가져옵니다.
		String userid = request.getParameter("userid");
		
		// 특정한 한 명의 회원의 상세정보를 가져옵니다.
		MemberVO member = mdao.selectOneUser(userid);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		// 성공적으로 가져왔다면 GSON을 이용해서 MemberVO member를 JSON 형태로 바꿔줍니다.
		out.print(new Gson().toJson(member));
		
	}

}
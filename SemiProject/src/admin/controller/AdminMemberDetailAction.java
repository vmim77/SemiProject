package admin.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.controller.AbstractController;
import member.model.*;

public class AdminMemberDetailAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 추후에 로그인한 유저정보가 '운영자'인지 아닌지 확인하는 if절을 걸어서 걸러낼겁니다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			// "GET" or "POST"
			
			if("POST".equalsIgnoreCase(method)) { // "POST" 로 전송된 정보라면
				
				// 테이블에서 한 행을 클릭하면 그 행의 userid를 따옵니다. 그 유저아이디를 가지고 select where절을 돌려서 한 회원의 상세정보들을 가져옵니다.
				String userid = request.getParameter("userid");
				
				// 특정한 한 명의 회원의 상세정보를 가져옵니다.
				MemberVO member = mdao.selectOneUser(userid);
				
				response.setContentType("text/html; charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				
				// 성공적으로 가져왔다면 GSON을 이용해서 MemberVO member를 JSON 형태로 바꿔줍니다.
				out.print(new Gson().toJson(member));
				
			}
			
			else { // "GET"으로 들어오는 경우
				String message = "일반회원이 사용할 수 없는 기능입니다!!";
				String loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}
		
		else {
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		

	}

}
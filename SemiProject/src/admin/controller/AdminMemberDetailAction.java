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
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())) { // 회원 상세조회 기능은 운영자만 할 수 있는 기능이다.
			
			String method = request.getMethod();
			// "GET" or "POST"
			
			if("POST".equalsIgnoreCase(method)) { // AJAX를 통해 POST로 전송됐다면 기능이 작동한다.
				
				// AJAX에서 전송해준 userid를 받아온다.
				String userid = request.getParameter("userid");
				
				// DAO를 통해서 select where로 해당 회원의 상세정보를 조회한다.
				MemberVO member = mdao.adminSelectOneUser(userid);
				
				if(member != null) { // 회원조회 SQL이 성공적으로 작동했다면 GSON을 통해서 JSON 형태로 바꾼다.
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.print(new Gson().toJson(member));
				}
				
				else {
					String message = "조회할 수 없는 회원입니다.";
					String loc = request.getContextPath()+"/admin/memberList.sh";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
			}
			
			else { // "GET"으로 들어오는 경우이다. 
				String message = "잘못된 접근입니다.";
				String loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		
		else { // 운영자가 아닌 사용자가 접근했다면 막아준다.
			
			String message = "운영자 메뉴입니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		

	}

}
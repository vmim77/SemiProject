package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod(); // "GET" or "POST"
			
			// 나중에는 ${sessionScope.loginuser.userid} 로 아이디가 'admin'이면 아래 기능들이 작동하게 할 예정!!
			
			if("post".equalsIgnoreCase(method)) { // "POST"로 들어왔다면 글을 쓰기위해서 정보를 입력하고 들어온 경우이다.
				
				String fk_writer = request.getParameter("fk_writer");
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				Map<String, BoardVO> paraMap = new HashMap<>();
				
				BoardVO bvo = new BoardVO();
				
				bvo.setFk_writer(fk_writer);
				bvo.setTitle(title);
				bvo.setContent(content);
				
				paraMap.put("bvo", bvo);
				
				InterBoardDAO mdao = new BoardDAO();
				
				int n = mdao.writeNotice(paraMap);
				
				String message = "";
				String loc= "";
				
				if(n==1) {// update 성공
					message = "글쓰기 성공";
					loc = request.getContextPath()+"/board/notice.sh";
					
				}
				else {// update 실패
					message = "글쓰기 실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
			else { // GET으로 들어왔다면 URL을 쳐서 들어왔거나, 처음으로 글 쓰기위해서 들어온 경우이다.
		
				super.setViewPage("/WEB-INF/board/noticeWrite.jsp");
				
				// 일반유저이거나 URL로 무단으로 들어온 사람이면 msg.jsp로 보내준다.
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

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class NoticeDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// if( "admin".equalsIgnorecase(${sessionScope.loginuser.userid}) ) {}
		
		String method = request.getMethod(); // "GET" OR "POST"
		
		if("POST".equalsIgnoreCase(method)) { // POST로 들어왔다는 것은 팝업창에서 삭제하겠다고 동의한 것이다.
			
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			
			InterBoardDAO bdao = new BoardDAO();
			
			int n = bdao.deleteNotice(boardno); // 공지사항 게시글 삭제하기
			
			String message = "";
			String loc = "";
			
			if(n==1) { // 삭제 성공
				message = "삭제 성공";
				loc = request.getContextPath()+"/board/notice.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/deleteMsg.jsp");
			}
			
			else { // 삭제 실패
				message = "삭제 실패!!!!!";
				loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else { // GET으로 왔다는 것은 운영자이면서!!, 게시판 상세보기에서 삭제하기를 누른 것이다. 또는 URL로 들어왔거나
			
			String boardno = request.getParameter("boardno");
			
			request.setAttribute("boardno", boardno);
			
			super.setViewPage("/WEB-INF/board/noticeDelete.jsp");
			
		}
		
		////////////////////////////////////////////////////////////////////////////
		
		
		
		
		
	}

}

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			// 기존의 글정보를 먼저 찍어주기위해서 다음과 같이 VO에 넣어준다.
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			String fk_writer = request.getParameter("fk_writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			content = content.replace("<br>", "\r\n"); // DB에 보낼때 <br>로 치환시켜둔 엔터를 다시 개행문자로 바꾼다.
			
			BoardVO bvo = new BoardVO();
			
			bvo.setBoardno(boardno);
			bvo.setFk_writer(fk_writer);
			bvo.setTitle(title);
			bvo.setContent(content);
			
			request.setAttribute("bvo", bvo); 
			
			// 글 수정을 위하여 새로운정보를 입력하도록 View 페이지로 이동한다.
			super.setViewPage("/WEB-INF/board/noticeEdit.jsp");
			
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

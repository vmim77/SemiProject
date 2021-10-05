package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardVO;
import common.controller.AbstractController;

public class NoticeEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// if("admin".equalsIgnorecase(${sessionScope.loginuser.userid}) ) {} 
		// 운영자로 들어와야 해당 기능이 작동하게 해준다.
		
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

}

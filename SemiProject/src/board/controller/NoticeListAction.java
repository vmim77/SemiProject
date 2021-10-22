package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import comment.model.*;
import common.controller.AbstractController;

public class NoticeListAction extends AbstractController {
	
	InterBoardDAO bdao = new BoardDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// header에서 [Notice] 메뉴를 클릭하면 모든 공지사항 글을 조회해온다.
		List<BoardVO> list = bdao.selectAllNotice(); 
		
		request.setAttribute("list", list);
		
		super.setViewPage("/WEB-INF/board/notice.jsp");
		
	}

}

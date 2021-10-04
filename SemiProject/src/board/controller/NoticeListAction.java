package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class NoticeListAction extends AbstractController {
	
	InterBoardDAO bdao = new BoardDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<BoardVO> list = bdao.selectAllNotice(); // DAO로 이동해서 tbl_notice_board의 대한 글목록을 받아옵니다.
		
		request.setAttribute("list", list);
		
		super.setViewPage("/WEB-INF/board/notice.jsp");
		
	}

}

package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class QnAListAction extends AbstractController {
	
	InterBoardDAO bdao = new BoardDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<BoardVO> list = bdao.selectAllQnA(); // 문의사항 메뉴에 들어왔다면 먼저 문의사항 테이블에 기록된 모든 글들을 조회해옵니다.
		
		request.setAttribute("list", list); // 뷰단으로 넘겨서 출력하게 합니다.
		
		super.setViewPage("/WEB-INF/board/qna.jsp");
		
	}

}

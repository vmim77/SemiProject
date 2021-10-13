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
		
		List<BoardVO> list = bdao.selectAllQnA();
		
		request.setAttribute("list", list);
		
		super.setViewPage("/WEB-INF/board/qna.jsp");
		
	}

}

package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class NoticeSearchAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		InterBoardDAO bdao = new BoardDAO();
		
		List<BoardVO> list = bdao.searchNotice(paraMap);
		
		request.setAttribute("list", list);
		
		super.setViewPage("/WEB-INF/board/notice.jsp");
		
		
		
		
		
		
	}

}

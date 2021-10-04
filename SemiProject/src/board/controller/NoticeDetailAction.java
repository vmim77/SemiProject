package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import comment.model.*;
import common.controller.AbstractController;

public class NoticeDetailAction extends AbstractController {
	
	InterBoardDAO bdao = new BoardDAO(); // 게시판 DAO
	InterCommentDAO cdao = new CommentDAO(); // 댓글 DAO
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int boardno = Integer.parseInt(request.getParameter("boardno")); // GET으로 전송되어온 글번호
		
		// System.out.println(boardno);
		
		BoardVO bvo = bdao.selectOneNotice(boardno); // 특정 글을 조회해옵니다. 조회된 글이 없다면 NULL
		
		// System.out.println("게시판 조회하기 성공");
		
		request.setAttribute("boardno", boardno); // 글번호
		request.setAttribute("bvo", bvo); // 글 내용
		
		if( bvo != null) { // 조회된 글이 있으니 댓글도 조회해옵니다.
			
			List<CommentVO> commentList = cdao.selectComment(boardno); // 특정 글번호에 대한 댓글들을 모두 가져옵니다.
			
			// System.out.println("댓글 조회하기 성공");
			
			request.setAttribute("commentList", commentList); // 댓글 
		}
		
		
		super.setViewPage("/WEB-INF/board/noticeDetail.jsp");
	}

}

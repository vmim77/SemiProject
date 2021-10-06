package comment.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.model.*;
import common.controller.AbstractController;

public class NoticeCommentEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String boardno = request.getParameter("boardno");
		int commentno = Integer.parseInt(request.getParameter("commentno"));
		String fk_commenter = request.getParameter("fk_commenter");
		String comment_content = request.getParameter("comment_content");
		
		
		CommentVO cvo = new CommentVO();
		
		cvo.setCommentno(commentno);
		cvo.setFk_commenter(fk_commenter);
		cvo.setComment_content(comment_content);
		
		request.setAttribute("cvo", cvo);
		request.setAttribute("boardno", boardno);
		
		super.setViewPage("/WEB-INF/comment/commentEdit.jsp");

		
		
	}

}

package comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.model.*;
import common.controller.AbstractController;

public class NoticeCommentDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"post".equalsIgnoreCase(method)) {
			String commentno = request.getParameter("commentno");
			
			request.setAttribute("commentno", commentno);
			
			super.setViewPage("/WEB-INF/comment/commentDelete.jsp");
		}
		else {
			
			int commentno = Integer.parseInt(request.getParameter("commentno"));
			
			InterCommentDAO cdao = new CommentDAO();
			
			int n = cdao.deleteNoticeComment(commentno);
			
			
			String message = "";
			String loc = "";
			
			if(n==1) { // 삭제 성공
				message = "댓글삭제 성공";
				loc = request.getContextPath()+"/board/notice.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/deleteMsg.jsp");
			}
			
			else { // 삭제 실패
				message = "댓글삭제 실패!!!!!";
				loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		

		
	}

}

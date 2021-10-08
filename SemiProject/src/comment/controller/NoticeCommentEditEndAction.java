package comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.model.*;
import common.controller.AbstractController;

public class NoticeCommentEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		String message = "";
		String loc = "";
		
		if("post".equalsIgnoreCase(method)) {
			
			String comment_content = request.getParameter("comment_content");
			int commentno = Integer.parseInt(request.getParameter("commentno"));
			String boardno = request.getParameter("boardno"); // 다시 댓글 썻던 곳으로 돌려보내기 위해서 가져온 보드넘버
			
			CommentVO cvo = new CommentVO();
			cvo.setComment_content(comment_content);
			cvo.setCommentno(commentno);
			
			InterCommentDAO cdao = new CommentDAO();
			
			int n = cdao.editNoticeComment(cvo);
			
			
			if(n==1) { // 갱신 성공
				
				message = "댓글 수정하기 성공";
				loc = request.getContextPath()+"/board/noticeDetail.sh?boardno="+boardno;
				
			}
			else { // 갱신 실패
				message = "댓글 수정하기 실패";
				loc = request.getContextPath()+"/board/notice.sh";
				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			
			message ="잘못된 경로접근입니다.";
			loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}

}

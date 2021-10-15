package comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comment.model.*;
import common.controller.AbstractController;
import member.model.*;

public class QnACommentEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod(); // "GET" or "POST"
			
			if("post".equalsIgnoreCase(method)) { // 댓글수정하기는 POST로만 들어온다.
				
				String boardno = request.getParameter("boardno");
				String commentno = request.getParameter("commentno");
				String fk_commenter = request.getParameter("fk_commenter");
				String comment_content = request.getParameter("comment_content");
				
				CommentVO cvo = new CommentVO();
				
				cvo.setFk_boardno(Integer.parseInt(boardno));
				cvo.setCommentno(Integer.parseInt(commentno));
				cvo.setFk_commenter(fk_commenter);
				cvo.setComment_content(comment_content);
				
				InterCommentDAO cdao = new CommentDAO();
				
				int n = cdao.editQnAComment(cvo);
				
				if(n==1) {
					String message = "답변수정 성공!!";
					String loc = request.getContextPath()+"/board/QnADetail.sh?boardno="+boardno+"&fk_writer="+loginuser.getUserid();
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				else {
					String message = "답변수정 실패...";
					String loc = request.getContextPath()+"/index.sh";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}
			else {
				String message = "잘못된 접근입니다.";
				String loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}
		else {
			String message = "운영자만 문의사항에 대한 답변을 수정할 수 있습니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
	}

}

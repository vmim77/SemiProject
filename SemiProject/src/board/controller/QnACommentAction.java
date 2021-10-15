package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comment.model.*;
import common.controller.AbstractController;
import member.model.*;

public class QnACommentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) { // 운영자만 문의사항에 대한 답변을 달 수 있습니다.
			
			String method = request.getMethod(); // "GET" or "POST"
			
			if("post".equalsIgnoreCase(method)) { // 댓글을 작성하고 들어왔다면 POST이다.
				
				String fk_boardno = request.getParameter("fk_boardno");
				String fk_commenter = request.getParameter("fk_commenter");
				String comment_content = request.getParameter("comment_content");
				
				InterCommentDAO cdao = new CommentDAO();
				
				CommentVO cvo = new CommentVO();
				
				cvo.setFk_boardno(Integer.parseInt(fk_boardno));
				cvo.setFk_commenter(fk_commenter);
				cvo.setComment_content(comment_content);
				
				int n = cdao.insertQnAComment(cvo); 
				// 답변을 DB에 insert 합니다.
				// 또한 insert가 성공됐다면 해당 글의 feedbackYN도 바꿔줍니다! 
				
				// insert와 update를 성공했다면 n은 2가 됩니다.
				
				String message = "";
				String loc = "";
				
				if(n==2) {
					message = "답변등록 및 피드백여부 변경 성공!!";
					loc = request.getContextPath()+"/board/QnA.sh";
				}
				else if(n==1) { // SQL에서 insert만 성공한 경우
					message = "피드백여부 변경 실패";
					loc = request.getContextPath()+"/index.sh";
				}
				else { // 모든 SQL문 실패함
					message = "모든 SQL문 실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				
			}
			else { // GET 방식이면 유저가 장난친 것이다.
				
				String message = "잘못된 접근입니다.";
				String loc = request.getContextPath()+"/index.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}//////////////////////////// 운영자 확인절
		
		else { // 운영자가 아닌 유저인 경우이다.
			
			String message = "운영자만 문의사항에 대한 답변을 달 수 있습니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}

}

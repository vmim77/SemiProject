package comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comment.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnACommentDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			
			if("post".equalsIgnoreCase(method)) {
				
				String str_commentno = request.getParameter("commentno");
				String str_boardno = request.getParameter("boardno");
				
				int commentno = Integer.parseInt(str_commentno);
				int fk_boardno = Integer.parseInt(str_boardno);
				
				CommentVO cvo = new CommentVO();
				
				cvo.setCommentno(commentno);
				cvo.setFk_boardno(fk_boardno);
				
				InterCommentDAO cdao = new CommentDAO();
				
				int n = cdao.deleteQnAComment(cvo);
				String message = "";
				String loc = "";
				
				if(n==1) {
					message = "문의사항 답변 삭제 성공 & 피드백여부 변경완료!";
					loc = request.getContextPath()+"/board/QnA.sh";
				}
				else {
					message = "문의사항 답변 삭제 실패!";
					loc = request.getContextPath()+"/index.sh";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
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
			String message = "운영자만 문의사항에 대한 답변을 삭제할 수 있습니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

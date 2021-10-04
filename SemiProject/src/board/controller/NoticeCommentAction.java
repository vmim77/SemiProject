package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.model.*;
import common.controller.AbstractController;
import member.model.*;

public class NoticeCommentAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int fk_boardno = Integer.parseInt(request.getParameter("fk_boardno"));
		String fk_commenter = request.getParameter("fk_commenter");
		String comment_content = request.getParameter("comment_content");
		
		boolean bool = mdao.idDuplicateCheck(fk_commenter); // 실제로 있는 회원이여야 댓글을 작성할 수 있다.
															// True면 있는 회원
		
		String message = "";
		String loc = "";
		
		if(bool) { // 실제로 회원테이블에 있는 회원이다.
			
			CommentVO cvo = new CommentVO();
			
			cvo.setFk_boardno(fk_boardno);
			cvo.setFk_commenter(fk_commenter);
			cvo.setComment_content(comment_content);
			
			Map<String, CommentVO> paraMap = new HashMap<>(); // 글번호, 댓글 쓴 사람, 댓글내용이 들어갈 HashMap
			
			paraMap.put("cvo", cvo);
			
			InterCommentDAO cdao = new CommentDAO();
			
			int n = cdao.insertComment(paraMap); // 댓글쓰기

			if(n==1) { // 댓글쓰기 insert 성공
				message = "댓글쓰기 성공!";
				loc= request.getContextPath()+"/board/noticeDetail.sh?boardno="+fk_boardno;
			}
			else { // SQL구문 오류
				message = "SQL구문 오류!";
				loc = request.getContextPath()+"/index.sh";
			}
			
		}
		
		else { // 존재하지않는 회원
			
			message = "가입하지 않은 회원은 댓글작성이 불가능합니다!";
			loc = request.getContextPath()+"/index.sh";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}

}

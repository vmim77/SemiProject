package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import comment.model.*;
import common.controller.AbstractController;
import member.model.*;

public class QnADetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String boardno = request.getParameter("boardno");
		String fk_writer = request.getParameter("fk_writer");
		
		String message = "";
		String loc = "";
		
		if(loginuser != null) {
			
			if(fk_writer.equals(loginuser.getUserid()) || "admin".equals(loginuser.getUserid())) {
				
				InterBoardDAO bdao = new BoardDAO();
				
				BoardVO bvo = bdao.selectOneQnA(boardno); // 문의게시판에 대한 자세한 글정보를 받아옵니다.
				request.setAttribute("bvo", bvo);
				
				if( bvo != null) { // 해당 글의 답변 조회해오기
					
					InterCommentDAO cdao = new CommentDAO();
					
					List<CommentVO> commentList = cdao.selectQnaComment(boardno); // 문의사항에 답변을 모두 가져옵니다.
					
					// System.out.println("댓글 조회하기 성공");
					
					request.setAttribute("commentList", commentList); // 댓글 
					
				}
				
				super.setViewPage("/WEB-INF/board/qnaDetail.jsp");
			}
		
			else {
				message = "문의사항 글 열람은 작성자 본인만 할 수 있습니다!";
				loc = request.getContextPath()+"/index.sh";
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}//////////////////////////////////////////// 로그인여부 확인
		
		else {
			message = "로그인을 먼저 하셔야 합니다.";
			loc = request.getContextPath()+"/index.sh";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		


		
	}

}

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
		
		// 먼저 로그인을 한 유저가 누구인지를 알아옵니다.
		// 문의사항 글을 보려면 글 작성자이거나 운영자이여만 합니다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 게시글 번호는 게시글 select where 과 댓글 select where을 위해서 사용됩니다.
		String boardno = request.getParameter("boardno");
		// 글작성자 or 운영자인지 확인하기 위한 비교기준
		String fk_writer = request.getParameter("fk_writer");
		
		String message = "";
		String loc = "";
		
		if(loginuser != null && fk_writer != null) { // 일단 로그인을 해야합니다.
			
			
			if(fk_writer.equals(loginuser.getUserid()) || "admin".equals(loginuser.getUserid())) { // 글작성자 or 운영자가 아니면 열람할 수 없습니다.
				
				InterBoardDAO bdao = new BoardDAO();
				
				BoardVO bvo = bdao.selectOneQnA(boardno); // 문의게시판에 대한 자세한 글정보를 받아옵니다.
				
				
				request.setAttribute("bvo", bvo);
				
				if( bvo != null) { // 해당 글의 답변 조회해오기 (== 댓글)
					
					InterCommentDAO cdao = new CommentDAO();
					
					List<CommentVO> commentList = cdao.selectQnaComment(boardno); // 문의사항에 답변을 모두 가져옵니다.
					
					request.setAttribute("commentList", commentList); // 문의사항 답변들이 있습니다.
					
				}
				
				super.setViewPage("/WEB-INF/board/qnaDetail.jsp"); // 성공적으로 된 경우 문의사항 글 View 페이지로 보내줍니다.
			}
		
			else { // 글작성자 or 운영자가 아닌 경우입니다.
				
				message = "문의사항 글 열람은 작성자 본인만 할 수 있습니다!";
				loc = request.getContextPath()+"/board/QnA.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}//////////////////////////////////////////// 로그인여부 확인
		
		else { // 로그인을 안 한 경우입니다.
			message = "로그인을 먼저 하셔야 합니다.";
			loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		


		
	}

}

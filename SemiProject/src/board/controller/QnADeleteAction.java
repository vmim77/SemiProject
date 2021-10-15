package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnADeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String fk_writer = request.getParameter("fk_writer"); // 작성자 확인용 
		
			if( loginuser != null && fk_writer.equals(loginuser.getUserid())) { // 작성자만 삭제할 수 있다.
				
				// 1. 글 상세보기에서 삭제를 누를때 1번 검사
				// 2. 글 삭제하기 '예' 버튼을 누르면 또 1번 검사
				
				
				String method = request.getMethod(); // "GET" OR "POST"
				
				if("get".equalsIgnoreCase(method)) { // "GET"이면 삭제하기버튼을 누르고 처음 들어온 경우이다.
					
					String boardno = request.getParameter("boardno");
					
					request.setAttribute("boardno", boardno);
					
					super.setViewPage("/WEB-INF/board/qnaDelete.jsp");
				}
				
				else {
					
						int boardno = Integer.parseInt(request.getParameter("boardno"));
						
						InterBoardDAO bdao = new BoardDAO();
						
						int n = bdao.deleteQnA(boardno); // 게시글 삭제하기
						
						String message = "";
						String loc = "";
						
						if(n==1) { // 삭제 성공
							message = "삭제 성공";
							loc = request.getContextPath()+"/board/QnA.sh";
							
							request.setAttribute("message", message);
							request.setAttribute("loc", loc);
							super.setViewPage("/WEB-INF/deleteMsg.jsp");
						}
						
						else { // 삭제 실패
							message = "삭제 실패!!!!!";
							loc = request.getContextPath()+"/index.sh";
							
							request.setAttribute("message", message);
							request.setAttribute("loc", loc);
							super.setViewPage("/WEB-INF/msg.jsp");
						}
					
				}
				
			}/////////////////////// 작성자 if 절
			
			else {
				
				String message = "삭제권한이 없습니다!";
				String loc = request.getContextPath()+"/board/QnA.sh";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
	}
		
}



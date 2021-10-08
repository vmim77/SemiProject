package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod();
			
			String message = "";
			String loc= "";
			
			if("post".equalsIgnoreCase(method)) { // 수정할 글내용과 제목등을 적고 수정하기버튼을 눌러야 POST로 들어올 수 있다.
				
				String fk_writer = request.getParameter("fk_writer");
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				int boardno = Integer.parseInt(request.getParameter("boardno"));
				
				Map<String, BoardVO> paraMap = new HashMap<>();
				
				BoardVO bvo = new BoardVO();
				
				bvo.setFk_writer(fk_writer);
				bvo.setTitle(title);
				bvo.setContent(content);
				bvo.setBoardno(boardno);
				
				InterBoardDAO mdao = new BoardDAO();
				
				int n = mdao.editNotice(bvo);
				

				if(n==1) {// update 성공
					message = "글 수정하기 성공";
					loc = request.getContextPath()+"/board/noticeDetail.sh?boardno="+boardno;
				}
				else {// update 실패
					message = "글 수정하기 실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
			}
			
			else { // GET방식이나, URL 접근이다.
				message = "잘못된 접근입니다.";
				loc= request.getContextPath()+"/index.sh";
				
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

}

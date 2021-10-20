package board.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import comment.model.*;
import common.controller.AbstractController;
import member.model.*;

public class NoticeDetailAction extends AbstractController {
	
	InterBoardDAO bdao = new BoardDAO(); // 게시판 DAO
	InterCommentDAO cdao = new CommentDAO(); // 댓글 DAO
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String boardno = request.getParameter("boardno"); // GET으로 전송되어온 글번호
		
		if(loginuser != null && !( "admin".equalsIgnoreCase(loginuser.getUserid()) ) ) { // 운영자가 아니면 조회수 검사, 조회수 업데이트, 조회수기록 넣기를 실시한다.
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("boardno", boardno);
			paraMap.put("userid", loginuser.getUserid());
			
			Date now = new Date();
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
			
			
			String strnow = simpleDateFormat.format(now);
			
			paraMap.put("now",strnow);
			
			int n = bdao.noticeViewCheck(paraMap); // 해당 글번호의 글을 이 유저가 조회한 적이 있나 없나 확인한다.
			
			
			if(n != 1) { // 오늘 하룻동안 이 글을 본 적이 없는 것이다. 해당 게시글의 조회수를 올려주고, 조회기록에 넣어야 한다.
				n = 0;
				n = bdao.updateNoticeViewcnt(paraMap);
				
				if(n==1) {
					
					n = 0;
					n = bdao.insertNoticeViewHistory(paraMap);
					
					if(n==1) {
					}
					else {
						return;
					}
				}
				else {
					return;
				}
			}// end of 조회수 처리하기

			
		}
		
		
		// System.out.println(boardno);
		
		BoardVO bvo = bdao.selectOneNotice(boardno); // 특정 글을 조회해옵니다. 조회된 글이 없다면 NULL
		
		// System.out.println("게시판 조회하기 성공");
		
		request.setAttribute("boardno", boardno); // 글번호
		request.setAttribute("bvo", bvo); // 글 내용
		
		if( bvo != null) { // 조회된 글이 있으니 댓글도 조회해옵니다.
			
			List<CommentVO> commentList = cdao.selectComment(boardno); // 특정 글번호에 대한 댓글들을 모두 가져옵니다.
			
			// System.out.println("댓글 조회하기 성공");
			
			request.setAttribute("commentList", commentList); // 댓글 
		}
		
		
		super.setViewPage("/WEB-INF/board/noticeDetail.jsp");
	}

}

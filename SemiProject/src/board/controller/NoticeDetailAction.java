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
			
			paraMap.put("boardno", boardno); // 공지사항 게시글번호
			paraMap.put("userid", loginuser.getUserid()); // 로그인한 유저의 아이디
			
			Date now = new Date(); // 현재 시각을 추출
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
			
			String strnow = simpleDateFormat.format(now);
			
			paraMap.put("now",strnow);
			
			
			// 조회수 처리하기
			//////////////////////////////////////////////////////////////////////////////////
			int n = bdao.noticeViewCheck(paraMap); // 해당 글번호의 글을 이 유저가 오늘 조회한 적이 있나 없나 확인한다.
			
			// System.out.println("내가 오늘 이 글을 봤나요? => "+ n);
			// 내가 오늘 이 글을 봤다면 1
			// 내가 오늘 처음 이 글을 본다면 0
			
			if(n != 1) { // 오늘 하룻동안 이 글을 본 적이 없는 것이다. 해당 게시글의 조회수를 올려주고, 조회기록에 넣어야 한다.
				
				n = 0; // 트랜잭션을 위해서 0으로 초기화
				n = bdao.updateNoticeViewcnt(paraMap); // 업데이트에 성공했다면 n은 다시 1이 된다.
				
				if(n==1) { // UPDATE를 성공했다면 조회수를 기록해주는 테이블에도 기록을 한다.
					
					n = 0; // 트랜잭션을 위해서 0으로 초기화
					// System.out.println("게시글 조회수를 1 올렸어요");
					n = bdao.insertNoticeViewHistory(paraMap);
					
					if(n==1) { // 조회수 기록 테이블에 성공적으로 들어갔다면 n은 다시 1이다.
						// System.out.println("조회수 기록테이블에 기록을 넣었습니다.");
					}
					else {
						// System.out.println("조회수 기록 테이블 insert 오류");
						return;
					}
				}
				else {
					// System.out.println("게시글 조회수 update 오류");
					return;
				}
			}// end of 조회수 처리하기
			//////////////////////////////////////////////////////////////////////////////////
		}
		
		// System.out.println(boardno);
		
		BoardVO bvo = bdao.selectOneNotice(boardno); // 특정 글을 조회해옵니다. 조회된 글이 없다면 NULL
		
		// System.out.println("게시판 조회하기 성공");
		
		request.setAttribute("boardno", boardno); // 글번호
		request.setAttribute("bvo", bvo); // 해당 공지사항 게시글의 정보가 들어가있다.
		
		if( bvo != null) { // 조회된 글이 있으니 댓글도 조회해옵니다.
			
			List<CommentVO> commentList = cdao.selectComment(boardno); // 특정 글번호에 대한 댓글들을 모두 가져옵니다.
			
			// System.out.println("댓글 조회하기 성공");
			
			request.setAttribute("commentList", commentList); // 댓글 
		}
		
		
		super.setViewPage("/WEB-INF/board/noticeDetail.jsp");
	}

}

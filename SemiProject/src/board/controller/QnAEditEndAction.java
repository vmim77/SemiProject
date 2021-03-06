package board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnAEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String method = request.getMethod(); // 
			
			if("POST".equalsIgnoreCase(method)) { // GET방식이면 안 된다.
				
				//////////////////////////////////////////////////////////////////////////
				MultipartRequest mtrequest = null;
				
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images");
				
				
				try {
					mtrequest = new MultipartRequest(request, 	// 리퀘스트 객체
							uploadFileDir, // 파일이 업로드될 경로명
							10*1024*1024, 	// 10MB로 제한한다. (단위는 bite로 써야함)
							"UTF-8", 		// 인코딩 타입
							new DefaultFileRenamePolicy());
				} catch(IOException e) {
					request.setAttribute("message", "파일 용량 초과로 인해서 업로드 실패함!");
					request.setAttribute("loc", request.getContextPath()+"/board/notice.sh"); 
					e.printStackTrace();
					super.setViewPage("/WEB-INF/msg.jsp");
					return; 
				}
				//////////////////////////////////////////////////////////////////////////
				
			
				String fk_writer = mtrequest.getParameter("fk_writer"); // 작성자 확인용 
				int boardno = Integer.parseInt(mtrequest.getParameter("boardno"));
				String title = mtrequest.getParameter("title");
				String content = mtrequest.getParameter("content");
				
				String imgfilename = mtrequest.getFilesystemName("imgfilename"); // 기존 글에 이미지가 없었다면 null 이다.
				String fk_pnum = mtrequest.getParameter("fk_pnum");
				
				content = content.replaceAll("<", "&lt;");
				content = content.replaceAll(">", "&gt;");
				content = content.replaceAll("\r\n", "<br>");
				
				BoardVO bvo = new BoardVO();
				
				bvo.setFk_writer(fk_writer);
				bvo.setTitle(title);
				bvo.setContent(content);
				bvo.setBoardno(boardno);
				bvo.setImgfilename(imgfilename);
				bvo.setFk_pnum(Integer.parseInt(fk_pnum));
				
				
				InterBoardDAO mdao = new BoardDAO();
				
				int n = mdao.editQnA(bvo);
				
				String message = "";
				String loc= "";
				
				if(n==1) {// update 성공
					message = "글 수정하기 성공";
					loc = request.getContextPath()+"/board/QnADetail.sh?boardno="+boardno+"&fk_writer="+fk_writer;
				}
				else {// update 실패
					message = "글 수정하기 실패";
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

}

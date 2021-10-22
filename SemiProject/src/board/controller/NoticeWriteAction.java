package board.controller;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String method = request.getMethod(); // "GET" or "POST"
			
			// 나중에는 ${sessionScope.loginuser.userid} 로 아이디가 'admin'이면 아래 기능들이 작동하게 할 예정!!
			
			if("post".equalsIgnoreCase(method)) { // "POST"로 들어왔다면 글을 쓰기위해서 뷰페이지에서 정보를 입력하고 들어온 경우이다.
				
				
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
	                
	                super.setViewPage("/WEB-INF/msg.jsp");
	                return; 
				}
				//////////////////////////////////////////////////////////////////////////
				
				String fk_writer = mtrequest.getParameter("fk_writer"); // 글쓴이
				String title = mtrequest.getParameter("title"); // 제목
				String content = mtrequest.getParameter("content"); // 내용 
				
				content = content.replaceAll("<", "&lt;");
				content = content.replaceAll(">", "&gt;");
				content = content.replaceAll("\r\n", "<br>");
				
				String imgfilename = mtrequest.getFilesystemName("imgfilename");
				
				
				Map<String, BoardVO> paraMap = new HashMap<>();
				
				BoardVO bvo = new BoardVO();
				
				bvo.setFk_writer(fk_writer);
				bvo.setTitle(title);
				bvo.setContent(content);
				bvo.setImgfilename(imgfilename);
				
				
				paraMap.put("bvo", bvo);
				
				InterBoardDAO mdao = new BoardDAO();
				
				int n = mdao.writeNotice(paraMap);
				
				String message = "";
				String loc= "";
				
				if(n==1) {// 게시글을 성공적으로 insert 한 경우이다.
					message = "글쓰기 성공";
					loc = request.getContextPath()+"/board/notice.sh";
				}
				
				else {// 게시글 insert 실패한 경우이다.
					message = "글쓰기 실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
			else { // GET으로 들어왔다면 URL을 쳐서 들어왔거나, 처음으로 글 쓰기위해서 들어온 경우이다.
		
				super.setViewPage("/WEB-INF/board/noticeWrite.jsp");
				
				// 일반유저이거나 URL로 무단으로 들어온 사람이면 msg.jsp로 보내준다.
			}
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

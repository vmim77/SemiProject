package board.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.BoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class NoticeEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
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
			
			
			
			
			// 기존의 글정보들을 hidden 폼에서 보내준다.
			// 기존의 글정보를 먼저 찍어주기위해서 다음과 같이 VO에 넣어준다.
			int boardno = Integer.parseInt(mtrequest.getParameter("boardno"));
			String fk_writer = mtrequest.getParameter("fk_writer");
			String title = mtrequest.getParameter("title");
			String content = mtrequest.getParameter("content");
			
			content = content.replaceAll("<", "&lt;");
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("\r\n", "<br>");
			
			
			String imgfilename = mtrequest.getParameter("imgfilename"); // 기존 글에 이미지가 없었다면 null 이다.
			
			content = content.replace("<br>", "\r\n"); // DB에 보낼때 <br>로 치환시켜둔 엔터를 다시 개행문자로 바꾼다.
			
			BoardVO bvo = new BoardVO();
			
			bvo.setBoardno(boardno);
			bvo.setFk_writer(fk_writer);
			bvo.setTitle(title);
			bvo.setContent(content);
			bvo.setImgfilename(imgfilename);
			
			request.setAttribute("bvo", bvo); 
			
			// 글 수정을 위하여 새로운정보를 입력하도록 View 페이지로 이동한다.
			super.setViewPage("/WEB-INF/board/noticeEdit.jsp");
			
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

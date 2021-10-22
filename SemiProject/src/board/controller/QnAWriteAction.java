package board.controller;

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
import member.model.*;
import product.model.*;
import product.realmodel.*;

public class QnAWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && ! "admin".equalsIgnoreCase(loginuser.getUserid()) ) { // 로그인을 했으면서, 운영자가 아니면 문의사항 글을 쓸 수 있다.
			
			String method = request.getMethod(); // "GET" or "POST"
			
			
			if(!"post".equalsIgnoreCase(method)) { // GET이면 문의사항 작성페이지로 
				
				// 제품번호와 제품명을 가져온다.
				InterProductRealDAO pdao = new ProductRealDAO();
				List<ProductRealVO> pvoList = pdao.getProdInfo();
				
				request.setAttribute("pvoList", pvoList);
				
				super.setViewPage("/WEB-INF/board/qnaWrite.jsp");
			}
			
			else { // POST이면 문의사항 게시글 테이블에 insert를 해준 후에 결과를 출력
				
				
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
				
				
				
				
				String fk_writer = mtrequest.getParameter("fk_writer");
				String title = mtrequest.getParameter("title");
				String fk_pnum = mtrequest.getParameter("fk_pnum");
				
				String content = mtrequest.getParameter("content");
				
				content = content.replaceAll("<", "&lt;");
				content = content.replaceAll(">", "&gt;");
				content = content.replaceAll("\r\n", "<br>");
				
				String imgfilename = mtrequest.getFilesystemName("imgfilename");
				
				BoardVO bvo = new BoardVO();
				
				bvo.setFk_writer(fk_writer);
				bvo.setTitle(title);
				bvo.setFk_pnum(Integer.parseInt(fk_pnum));
				bvo.setContent(content);
				bvo.setImgfilename(imgfilename);
				
				InterBoardDAO bdao = new BoardDAO();
				
				int n = bdao.writeQnA(bvo);
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					message="문의사항 작성 성공!!";
					loc = request.getContextPath()+"/board/QnA.sh";
				}
				else {
					message="문의사항 작성 실패!!";
					loc = request.getContextPath()+"/board/QnA.sh";
				}
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

			
		}
		
		else { // 운영자이거나 로그인을 안했거나
			
			String message = "해당 서비스를 이용하기 위해서는 로그인을 하셔야 합니다!";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

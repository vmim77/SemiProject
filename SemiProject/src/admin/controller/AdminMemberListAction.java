package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class AdminMemberListAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// header에서 [운영자메뉴] - [회원목록]을 클릭하면 실행되는 Action 입니다.
		// 먼저 모든 회원들의 간단한 정보를 조회해서 출력을 해준다.
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid())) { // 운영자만 해당 기능에 접근할 수 있다.
			
			Map<String, String> paraMap = new HashMap<>();
			
			String searchType = request.getParameter("searchType"); // 검색어 타입 - "아이디", "성명"
			String searchWord = request.getParameter("searchWord"); // 검색어
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재 보고있는 페이지
			String sizePerPage = request.getParameter("sizePerPage"); 			  // 회원을 몇명씩 조회해서 볼 것인가
			
			if( currentShowPageNo == null ) { // 현재보고있는 페이지가 null이면 1을 기본값으로 준다, null인 경우는 처음으로 회원목록 페이지에 들어온 경우이다.
				currentShowPageNo = "1";
			}
			
			if ( sizePerPage == null || !( "3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) ) { // 몇명씩 볼 것인지가 null 혹은 3, 5, 10이 아니라면 기본값 10을 준다.
				sizePerPage = "10";
			}
			
			try { // 무언가를 검색하고 들어왔다면  현재보고있는 페이지는 정상적인 int 범위의 숫자이다. 허나 사용자가 GET방식을 이용하여 악의적으로 들어올 가능성을 막는다.
				Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);

			
			
			List<MemberVO> mbrList =  mdao.adminSelectAllUser(paraMap); 
			// DAO에서 tbl_member의 모든 회원정보를 조회한 다음에 ArrayList에 담는다.
			// 검색을 해서 들어온 경우에는 검색타입과 검색어를 가지고가서 찾아준다.
			
			request.setAttribute("mbrList", mbrList);
			request.setAttribute("sizePerPage", sizePerPage); 
			
			String pageBar = "";
			
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			
			int totalPage = mdao.getTotalPage(paraMap);
			
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			if(pageNo != 1) {
				pageBar += "<li class='page-item' style='background-color:black;'><a class='page-link' href='memberList.sh?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.sh?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
			}
			
			
			
			while( !(loop > blockSize || pageNo > totalPage ) ) { 
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active' style='background-color:black;'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='memberList.sh?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
				}
				
				loop++; 
				
				pageNo++; 	
				
				
			}// end of while------------------------------------
			
			
			if(pageNo <= totalPage) {
				
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.sh?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.sh?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
			}
			
			
			request.setAttribute("pageBar", pageBar);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");
			
			
		}
		
		else { // 운영자가 아닌 회원이 접근했다면
			
			String message = "잘못된 접근입니다.";
			String loc = request.getContextPath()+"/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
		

		
	}

}

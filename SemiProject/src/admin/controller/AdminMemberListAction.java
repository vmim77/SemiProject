package admin.controller;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;

import common.controller.AbstractController;
import member.model.*;

public class AdminMemberListAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if( loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			Map<String, String> paraMap = new HashMap<>(); // DAO에 보낼 파라미터들을 담아줄 해쉬맵입니다.
			
			String searchType = request.getParameter("searchType"); // 아이디, 성명 
			String searchWord = request.getParameter("searchWord"); // 검색어
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			
			String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재 보고있는 페이지
			String sizePerPage = request.getParameter("sizePerPage"); // 몇명씩 볼지
			
			
			if( currentShowPageNo == null ) {
				currentShowPageNo = "1";
			}
			
			if ( sizePerPage == null || !( "3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) ) {
				sizePerPage = "10";
			}
			
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			
			List<MemberVO> mbrList =  mdao.selectAllUser(paraMap); 
			// DAO에서 tbl_member의 모든 회원정보를 조회해주는 SQL문을 돌립니다. 리턴값은 회원들의 정보를 여러개 담아와야하니깐 List로 리턴을 합니다.
			
			// 검색을 해서 들어온 경우에는 검색타입과 검색어를 가지고가서 찾아줍니다.
			// "검색"버튼을 한 번 더 누른다면 paraMap에 있는 애들은 NULL이여서 전체조회를 해줍니다.
			
			request.setAttribute("mbrList", mbrList); // View 페이지로 List를 전송시켜서 찍어주도록 합니다.
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");
			
			
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

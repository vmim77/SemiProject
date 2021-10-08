package admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberDAO;
import myshop.model.InterMemberDAO;

public class MemberSearchAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		Map<String, String> paraMap = new HashMap<>(); // DAO에 보낼 파라미터들 입니다.
		
		String searchType = request.getParameter("searchType"); // 아이디, 성명
		String searchWord = request.getParameter("searchWord"); // 검색어
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		
	}

}

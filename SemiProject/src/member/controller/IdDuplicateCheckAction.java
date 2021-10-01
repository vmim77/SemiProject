package member.controller;

import javax.servlet.http.*;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class IdDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)){
		
			String userid = request.getParameter("userid");
			
		//	System.out.println("~~~ 확인용 userid => " + userid);
			
			InterMemberDAO mdao = new MemberDAO();
			boolean isExists = mdao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();  // {}
			jsonObj.put("isExists", isExists);		// {"isExists":true} 또는 {"isExists":false}
			
			String json =  jsonObj.toString();// 문자열 형태인 "{"isExists":true}" 또는 "{"isExists":false}"
		//	System.out.println(">>> 확인용 json => " + json);
		//	>>> 확인용 json => {"isExists":true}
		//	>>> 확인용 json => {"isExists":false}
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
	
		}
	}
	
}

package member.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.*;
import member.model.*;

public class PwdUpdateEndAction extends AbstractController {
//====================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.pwdUpdate(paraMap);
			
			request.setAttribute("n", n);
		}
		
		request.setAttribute("userid", userid);		
		request.setAttribute("method", method);

		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//====================================================================================
}

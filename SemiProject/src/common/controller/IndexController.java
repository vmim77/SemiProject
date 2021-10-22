package common.controller;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
class IndexController extends AbstractController {
//=============================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");	
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
//=============================================================================================
}

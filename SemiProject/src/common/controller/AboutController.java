package common.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

class AboutController extends AbstractController {
//===================================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/about.jsp");		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//===================================================================================================
}

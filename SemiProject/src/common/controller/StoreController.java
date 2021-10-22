package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StoreController extends AbstractController {
//===========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/store.jsp");	
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//===========================================================================================
}

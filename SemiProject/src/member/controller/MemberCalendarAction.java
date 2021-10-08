package member.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MemberCalendarAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/calendar.jsp");
	}

}

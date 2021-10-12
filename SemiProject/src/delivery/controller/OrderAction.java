package delivery.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	
		//	setRedirect(false);
			setViewPage("/WEB-INF/delivery/order.jsp");
		
	}

}

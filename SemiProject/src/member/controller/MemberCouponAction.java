package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MemberCouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/memberCoupon.jsp");
			}
		else {
			String couponnum = request.getParameter("couponnum");
			String coupondate = request.getParameter("coupondate");
			String couponname = request.getParameter("couponname");
			String coupondiscount = request.getParameter("coupondiscount");
			String couponlastday = request.getParameter("couponlastday");
			String status = request.getParameter("status");
			
			

		}
		
		
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/memberCoupon.jsp");
	}

}

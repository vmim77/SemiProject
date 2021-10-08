package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberVO;
import myshop.model.InterMemberDAO;

public class MemberCouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			
			// 파라미터로 유저아이디 받기
			String userid = request.getParameter("userid");
			System.out.println("유저아이디:"+userid);
			InterMemberDAO mado = new MemberDAO();
			MemberVO mvo = mado.membercoupon(userid);
	
			request.setAttribute("mvo", mvo);
			// 디에이오에서 저장한 객체 넘기기
			// 위 내용 셋어트리
			 System.out.println("확인용"+mvo.getCouponname());
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/memberCoupon.jsp");
			}
		else {
			
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
	
			// 멧지

		}
		
	}

}

package product.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class StoreAction extends AbstractController {
//=========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 확인
		if(super.checkLogin(request)) {
			
			////////////////////////////////////////////////////////////////////
			
			// 내가 담은 내역
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			String product_front_p1 = request.getParameter("product_front_p1");
			String cartname   = request.getParameter("cartname");
			String cartopt123 = request.getParameter("cartopt123");    
			String cartopt4   = request.getParameter("cartopt4");   
			String cartnum    = request.getParameter("cartnum");   
			String cartprice  = request.getParameter("cartprice");
			String jukrib  = request.getParameter("jukrib");
			String cartfinopt = request.getParameter("cartfinopt");   
			// , 넣어주기
			cartprice = cartprice.replace("원","");
			
			// 우선 자르고 , 넣어주기
			cartfinopt = cartfinopt.substring(2);
			cartfinopt = cartfinopt.replace("원","");
			
			request.setAttribute("product_front_p1", product_front_p1);
			request.setAttribute("cartname", cartname);
			request.setAttribute("cartopt123", cartopt123);
			request.setAttribute("cartopt4", cartopt4);
			request.setAttribute("cartnum", cartnum);
			request.setAttribute("cartprice", cartprice);
			request.setAttribute("jukrib", jukrib);
			request.setAttribute("cartfinopt", cartfinopt);
			
			///////////////////////////////////////////////////////////////////
			
			// 내정보 불러오기를 위한 처리작업
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
			
			InterMemberDAO mado = new MemberDAO();
			Map<String, String> paraMap = mado.SelectMyInfo(userid);
			
			request.setAttribute("paraMap", paraMap);
					
			////////////////////////////////////////////////////////////////////
			
			// 내 포인트 넘겨주기
			InterMemberDAO mdao = new MemberDAO();
			int mypoint = mdao.selectMyPoint(userid);
			request.setAttribute("mypoint", mypoint);
			
			/////////////////////////////////////////////////////////////////////
			
			super.setViewPage("/WEB-INF/product/detailstore.jsp");
			
		}
		else {
			 
			String message = "로그인 후 이용가능한 서비스 입니다";
			String loc = "/SemiProject/login/login.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//=========================================================================================
}

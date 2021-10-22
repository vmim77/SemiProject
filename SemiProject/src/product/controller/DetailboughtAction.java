package product.controller;

import java.util.*;
import javax.servlet.http.*;
import common.controller.*;
import member.model.*;
import product.realmodel.*;

public class DetailboughtAction extends AbstractController {
//==========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 아이디 지역변수 방지
		String userid = "";
		
		// 혹시나 새로고침 방지
		try {
	
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			userid = loginuser.getUserid();
			
			////////////////////////////////////////////////////////////////////
			
			super.setViewPage("/WEB-INF/product/detailbought.jsp");
			
		}catch(NullPointerException e) {
			
			String message = "재 로그인 부탁드립니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}//end of try-catch
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method) && userid != null) {
			
			////////////////////////////////////////////////////////////////////
			// 내가 담은 내역
			// 이미지명, 옵션1~4, 수량, 가격, 옵션가격
			String product_front_p1 = request.getParameter("product_front_p1");
			String cartname   = request.getParameter("cartname");
			String cartopt123 = request.getParameter("cartopt123");    
			String cartopt4   = request.getParameter("cartopt4");   
			String cartnum    = request.getParameter("cartnum");     
			String cartfinopt = request.getParameter("cartfinopt");  
			String jukrib = request.getParameter("jukrib");
			String cartprice  = request.getParameter("cartprice");
			String jibulpoint  = request.getParameter("jibulpoint");
			String coupon = request.getParameter("coupon");
			
			request.setAttribute("product_front_p1", product_front_p1);
			request.setAttribute("cartname", cartname);
			request.setAttribute("cartopt123", cartopt123);
			request.setAttribute("cartopt4", cartopt4);
			request.setAttribute("cartnum", cartnum);
			request.setAttribute("cartfinopt", cartfinopt);
			request.setAttribute("jukrib", jukrib);
			request.setAttribute("cartprice", cartprice);
			request.setAttribute("jibulpoint", jibulpoint);
			request.setAttribute("coupon", coupon);
			
			// 주문번호 랜덤으로 만들기
			Random rnd = new Random();
			
			int jumun = rnd.nextInt(99999-10000+1)+10000;
			int bunho = rnd.nextInt(99-10+1)+10;
			
			String jumun_bunho = jumun + "-" + bunho;
			
			// 전송을 위해 담아주기
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);         				// 유저아이디
			paraMap.put("cartname", cartname);	   				// 제품명
			String buy_opt_price = cartopt123 + cartopt4;       // 나눠진 옵션정보 합치기
			paraMap.put("buy_opt_price", buy_opt_price);		// 옵션정보
			paraMap.put("cartnum", cartnum);                    // 수량
			paraMap.put("cartfinopt", cartfinopt);				// 옵션가격
			paraMap.put("cartprice", cartprice);				// 제품가격
			paraMap.put("jukrib", jukrib);						// 적립금
			paraMap.put("jumun_bunho", jumun_bunho);            // 주문번호
			paraMap.put("product_front_p1", product_front_p1);  // fk_pimgae3
			
			// 구매내역에 저장하기
			InterProductRealDAO prdao = new ProductRealDAO();
			prdao.UpdateMyBought(paraMap);
			
			////////////////////////////////////////////////////////////////////
			// 배송을 위한 정보를 담은 내역
			String name = request.getParameter("name");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String firstemail = request.getParameter("firstemail");
			String secondemail = request.getParameter("secondemail");
			String text = request.getParameter("text");
			
			// 받아온거로 새로운 값 처리
			String email = firstemail + secondemail;
			if(text == "") {
				text = "조심히 와주세요";
			}
			
			request.setAttribute("name", name);
			request.setAttribute("postcode", postcode);
			request.setAttribute("address", address);
			request.setAttribute("detailAddress", detailAddress);
			request.setAttribute("hp1", hp1);
			request.setAttribute("hp2", hp2);
			request.setAttribute("hp3", hp3);
			request.setAttribute("email", email);
			request.setAttribute("text", text);
			
			////////////////////////////////////////////////////////////////////
			// 내 포인트 잔액을 디비에 업데이트 한다
			InterMemberDAO mdao = new MemberDAO();
			
			// 남은금액
			String dbpoint = request.getParameter("dbpoint");
			// 그러나 남은 잔액과 현재 받은 적립금을 더해주어야 한다
			int intdbpoint = Integer.parseInt(dbpoint)+Integer.parseInt(jukrib);
			// 형변환 해주기
			dbpoint = intdbpoint + "";
			
			mdao.UpdateMypoint(userid, dbpoint); 
			
			////////////////////////////////////////////////////////////////////
			
			// 사용한 쿠폰 디비에 없애기
			mdao.ByeCoupon(userid, coupon);
			
		}
		else {
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==========================================================================================
}

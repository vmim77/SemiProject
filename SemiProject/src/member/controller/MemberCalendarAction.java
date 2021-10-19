package member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class MemberCalendarAction extends AbstractController {
//========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 하도 널포인트 떨어져서 빡쳐서 그냥 이렇게 했습니다
		try {
			
			// 로그인 한 사람만 들어올 수 있게 해주기
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
			String userid = loginuser.getUserid();
			
			if(userid != null) {
				
				InterProductDAO pdao = new ProductDAO();
				
				Map<String, String> paraMap = pdao.choolcheckevent(userid);
				
				// 정제되지 않은 값 정제 작업
				String choolcheckday = paraMap.get("choolcheckday");
				
				// 콤마로 끝나기 때문에 그 부분은 자른다
				choolcheckday = choolcheckday.substring(0, choolcheckday.length()-1);
				
				// 값 넘겨주기
				request.setAttribute("choolcheckday", choolcheckday);
				request.setAttribute("paraMap", paraMap);
				
				// 내가 체크한 도장 값 넘겨주기
				String savemycheck = request.getParameter("savemycheck");
				
				if(savemycheck != null) {
					pdao.Savemycheck(savemycheck, userid);
				}
				
				super.setViewPage("/WEB-INF/member/memberCalendar.jsp");
				
			}
			
		}catch(NullPointerException e) {
			
			String message = "로그인 후 이용가능한 서비스 입니다";
			String loc = "/SemiProject/login/login.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//========================================================================================
}

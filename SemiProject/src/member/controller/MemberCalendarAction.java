package member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class MemberCalendarAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 해당 유저 아이디가 아니면 못들어오는 코딩 걸어주기
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = pdao.choolcheckevent();
		
		// 정제되지 않은 값 정제 작업
		String choolcheckday = paraMap.get("choolcheckday");
		// 콤마로 끝나기 때문에 그 부분은 자른다
		choolcheckday = choolcheckday.substring(0, choolcheckday.length()-1);
		
		// 값 넘겨주기
		request.setAttribute("choolcheckday", choolcheckday);
		request.setAttribute("paraMap", paraMap);
		
		// 내가 체크한 도장 값 넘겨주기
		String savemycheck = request.getParameter("savemycheck");
		pdao.Savemycheck(savemycheck);
		
		super.setViewPage("/WEB-INF/member/memberCalendar.jsp");

	}

}

package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import member.model.*;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import product.realmodel.*;

public class AdminOrderChangeEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			if("admin".equals(loginuser.getUserid())) {
				
				String odrcode = request.getParameter("odrcode");
				String pnum = request.getParameter("pnum");
				String changeStatus = request.getParameter("changeStatus");
				String userid = request.getParameter("userid");
				
				
				System.out.println("changeStatus => " + changeStatus);
				System.out.println("userid => " + userid);
				
				InterProductRealDAO prdao = new ProductRealDAO();
				
				int n = prdao.changeBaesongStatus(odrcode, pnum, changeStatus);
				
				System.out.println("n" + n);
				
				InterMemberDAO mdao = new MemberDAO();
				
				MemberVO mvo = mdao.getUserInfo(userid);
				
				if("1".equals(changeStatus) && n==1 && mvo != null) {

	                  String api_key = "NCSCKIEW9NQW3PSC"; 
	                  String api_secret = "9JW87QWSUNLWR4GHPOWOYRMP1ZPNSFVH";
	                  Message coolsms = new Message(api_key, api_secret);

	                  HashMap<String, String> paraMap = new HashMap<String, String>();
	                  paraMap.put("to", mvo.getMobile()); // 수신번호
	                  paraMap.put("from", "01027973149"); // 발신번호
	                  paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
	                  paraMap.put("text", "[THIS MAN 택배안내] "+mvo.getName()+"님 께서 주문하신 전표["+odrcode+"]를 택배사로 전달했습니다."); // 문자내용    
	                  paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version
	                        
	                  try {
	                     JSONObject jsobj = (JSONObject) coolsms.send(paraMap);
	                 System.out.println("확인용 jsobj.toString() => " + jsobj.toString());

	                  } catch (CoolsmsException e) {
	                     e.printStackTrace();
	                  }
					
				}
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					message = "배송상태 변경성공";
					loc = request.getContextPath()+"/admin/orderList.sh";
				}
				
				else {
					message = "배송상태 변경실패";
					loc = request.getContextPath()+"/index.sh";
				}
				
				
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
				
				
				
				
			}
			else {
	            String message = "권한이 없는 사용자입니다.";
	            String loc = "javascript:history.back();";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else {
            String message = "잘못된 접근입니다.";
            String loc = "javascript:history.back();";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
		
	}

}

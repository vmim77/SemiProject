package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class EmailDuplicateCheckAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String method = request.getMethod(); // "GET" 또는 "POST"
        
      if("POST".equalsIgnoreCase(method)) {
         String email = request.getParameter("email");
         
         InterMemberDAO mdao = new MemberDAO();
         boolean isExists = mdao.emailDuplicateCheck(email);
      
         JSONObject jsonObj = new JSONObject(); // {}
         jsonObj.put("isExists", isExists);      // {"isExists":true} 또는 {"isExists":false}
         
         String json = jsonObj.toString(); // 문자열 형태인 "{"isExists":true} 또는 {"isExists":false}" 으로 된다.
      //   System.out.println(">>> 확인용 json => " + json);
      //  {"isExists":true} 또는 {"isExists":false}
         
         request.setAttribute("json", json);
         
      //   super.setRedirect(false);
         super.setViewPage("/WEB-INF/jsonview.jsp");
      
      }
         
   }

}
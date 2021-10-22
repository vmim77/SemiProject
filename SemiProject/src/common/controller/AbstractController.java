package common.controller;

import java.sql.SQLException;
import java.util.*;
import javax.servlet.http.*;
import member.model.MemberVO;
import product.model.*;

// import member.model.MemberVO;

public abstract class AbstractController implements InterCommand{
//==================================================================================	
	private String viewPage;
	private boolean Redirect = false;
//==================================================================================
	public String getViewPage() {
		return viewPage;
	}
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	public boolean isRedirect() {
		return Redirect;
	}
	public void setRedirect(boolean redirect) {
		Redirect = redirect;
	}
//==================================================================================	
	// 로그인 유무를 검사해서 로그인 했으면 true를 리턴해주고 아니면 false를 리턴 //
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			return true;
		}
		else {
			return false;
		}//end of if(loginuser != null) {
		
	}//end of public boolean checkLogin() {	
//==================================================================================
   // ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //
   public void getCategoryList(HttpServletRequest request) throws SQLException{
      
      InterProductDAO pdao = new ProductDAO();
      List<Map<String,String>> categoryList = pdao.getCategoryList();
      
      request.setAttribute("categoryList", categoryList);
   }
//====================================================================================	
}//end of public abstract class AbstractController implements InterCommand{----------

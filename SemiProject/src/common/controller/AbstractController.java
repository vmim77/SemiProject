package common.controller;

import javax.servlet.http.*;

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
	/*
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
	*/
//==================================================================================
}//end of public abstract class AbstractController implements InterCommand{----------

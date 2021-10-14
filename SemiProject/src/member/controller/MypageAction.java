package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MypageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterMemberDAO mdao = new MemberDAO();
		InterBoardDAO bdao = new BoardDAO();
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        String userid = loginuser.getUserid();

        List<MemberVO> libo = mdao.mycoupon(userid); 
        
        request.setAttribute("libo", libo);
        
		List<BoardVO> list = bdao.selectmyboard(userid); // DAO로 이동해서 tbl_notice_board의 대한 글목록을 받아옵니다.

		request.setAttribute("list", list);
		
		
		
    	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/mypage.jsp");
        
		
		

	}

}

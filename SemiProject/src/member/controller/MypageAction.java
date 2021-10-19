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
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductBuyVO;
import product.realmodel.ProductRealDAO;

public class MypageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductRealDAO prdao = new ProductRealDAO();
		InterMemberDAO mdao = new MemberDAO();
		InterBoardDAO bdao = new BoardDAO();
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        String userid = loginuser.getUserid();
//======================================================================================================
        // 쿠폰 넘겨받기
        List<MemberVO> libo = mdao.mycoupon(userid); 
        
        request.setAttribute("libo", libo);
//=======================================================================================================
        // 마에페이지 구매내역 가져오기
		List<BoardVO> list = bdao.selectmyboard(userid); // DAO로 이동해서 tbl_notice_board의 대한 글목록을 받아옵니다.

		request.setAttribute("list", list);
		
		// 환불/취소시 변경되게하는 메소드
        List<ProductBuyVO> buyList = prdao.SelectMyPageBought(userid);
        
        request.setAttribute("buyList", buyList);
        
        // 포인트 증가 되게 하는 메소드
        List<MemberVO> mbvo = mdao.mypoint(userid);
        
        request.setAttribute("mbvo", mbvo);
        
        // 마이페이지 총구매금액 메소드
        List<ProductBuyVO> buyMoney = prdao.SelectMyBuyMoney(userid);
        
        request.setAttribute("buyMoney", buyMoney);
        
		
	//	  List<ProductBuyVO> buyList = prdao.SelectMyallBought(userid);
		
		
		
    	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/mypage.jsp");
        
		
		

	}

}

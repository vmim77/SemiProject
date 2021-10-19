package product.controller;

import java.util.*;
import javax.servlet.http.*;
import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;
import product.realmodel.*;

public class BuyAction extends AbstractController {
//==========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		InterProductDAO pdao = new ProductDAO();
		InterBoardDAO idao = new BoardDAO();
		InterProductRealDAO prdao = new ProductRealDAO();
		
		// buy.jsp로 들어오는 경로는 총 3가지가 있다
		// 주소치고 들어오기, 프로덕트 리스트에서 들어오기, 리뷰작성후 다시 재로딩
		// 무작정 주소치고 들어오는 것을 방지하기위해 아래 변수를 만들었다
		String mujakjung = request.getParameter("mujakjung");
		
		String method = request.getMethod();
		
		// 지역변수 방지
		// 리뷰는 로그인 시에만 가능하게 한다 따라서 로그인 확인을 위해 만들어준 변수
		String checkidnull = "";
		String userid = "";
		
		// 경로를 막 타고 들어왔는지 확인
		// 이 경로는 productlist에서 타고 들어오는 경로이다
		String product_name = request.getParameter("product_name");
		
		// 어떤 제품을 누르고 들어왔는지 확인을 위해 product_name을 넘긴다
		// 해당제품의 사진 및 가격을 가져온다
		ProductVO pvo = pdao.getOneProduct(product_name);
		
		// 처음 시작할 때 가져올 값
		// 리뷰 평점, 리뷰 갯수, 리뷰조회수, 올린 사진, 댓글, 작성자, 시간, 제품내용 가져오기
		ReviewVO rvo = idao.SelectAllReview(product_name);
		
		// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
		int review_check = prdao.SearchMyBuy(userid, product_name);
		
		// 로그인 안하고 들어오는 것을 방지하기 위한 트라이 처리
		try {
			// 리뷰작성은 로그인이 된 상태에서 가능하기 때문에 아이디를 불러와준다
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			userid = loginuser.getUserid();
		}catch(NullPointerException e) {
			checkidnull = "no";
			request.setAttribute("checkidnull", checkidnull);
		}
		/////////////////////////////////////////////////////////////////////
		
		if(product_name != null && mujakjung == null) {

			// 해당 제품의 사진 및 가격 넘기기
			request.setAttribute("pvo", pvo);
			
			///////////////////////////////////////////////////////
			
			// 모든 리뷰 가져오기
			request.setAttribute("rvo", rvo);
			
			// 만약 해당제품의 리뷰를 작성 안했다면
			// 내 구매내역을 가져오고 리뷰작성을 가능케 하겠다.
			if(review_check == 0) {
				// 리뷰를 작성안한 내 구매내역을 가져오기
				List<ProductBuyVO> buyList = prdao.SelectMyBought(userid, product_name);
				// 넘겨주기
				request.setAttribute("buyList", buyList);
			}
			
			super.setViewPage("/WEB-INF/product/buy.jsp");
			
		/////////////////////////////////////////////////////////////////
			
		}
		else if(product_name == null && "GET".equalsIgnoreCase(method) && mujakjung != null) {

			// 이 경로는 buy에서 다시 자기 자신에게 타고 들어오는 경로이다
			// 따라서 다시 들어올때 위의 product_name의 값은 null 이 들어가므로
			// 다시 값을 넣어 줘서 보여지게 한다

			// 해당 제품의 사진 및 가격 넘기기
			request.setAttribute("pvo", pvo);
						
			///////////////////////////////////////////////////////
						
			// 모든 리뷰 가져오기
			request.setAttribute("rvo", rvo);
			
			///////////////////////////////////////////////////////
			
			// 만약 해당제품의 리뷰를 작성 안했다면
			// 내 구매내역을 가져오고 리뷰작성을 가능케 하겠다.
			if(review_check == 0) {
				// 리뷰를 작성안한 내 구매내역을 가져오기
				List<ProductBuyVO> buyList = prdao.SelectMyBought(userid, product_name);
				// 넘겨주기
				request.setAttribute("buyList", buyList);
			}
			
			// 내가 작성한 후 올리기 위해 리뷰내용, 평점, 이미지 넘겨받은값임
			// 그 외 제품번호, 올린날짜, 구매정보는 구매내역 테이블을 통해 가져오도록 한다.
			String content = request.getParameter("content");
			String whatstar = request.getParameter("whatstar");
			String insertpicture = request.getParameter("insertpicture");
			
			// 내 리뷰 업데이트하기
			idao.UpdateMyReview(userid, content, whatstar, insertpicture, product_name);
			
			super.setViewPage("/WEB-INF/product/buy.jsp");
			
			///////////////////////////////////////////////////////////
			
		}
		else {
			
			String message = "잘못된 경로 입니다.";
			String loc = "/SemiProject/index.sh";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}//end of if("POST".equalsIgnoreCase(method)) {-------------------------------------
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==========================================================================================
}

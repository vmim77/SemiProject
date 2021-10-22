package product.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.*;
import comment.model.*;
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
		InterCommentDAO icdao = new CommentDAO();
		HttpSession session = request.getSession();
		
		// buy.jsp로 들어오는 경로는 총 3가지가 있다
		// 주소치고 들어오기, 프로덕트 리스트에서 들어오기, 리뷰작성후 다시 재로딩
		// 무작정 주소치고 들어오는 것을 방지하기위해 아래 변수를 만들었다
		String mujakjung = request.getParameter("mujakjung");
		
		String method = request.getMethod();
		
		// 지역변수 방지
		// 리뷰는 로그인 시에만 가능하게 한다 따라서 로그인 확인을 위해 만들어준 변수
		String checkidnull = "";
		String userid = "";
		
		// 매우 중요
		// 리뷰를 작성 안한 내 구매내역이 있는지 확인하기 위한 변수
		String not_review = "not_review";
		
		// 경로를 막 타고 들어왔는지 확인
		// 이 경로는 productlist에서 타고 들어오는 경로이다
		String product_name = request.getParameter("product_name");
		request.setAttribute("product_name", product_name);
		// 로그인 안하고 들어오는 것을 방지하기 위한 트라이 처리
		try {
			// 리뷰작성은 로그인이 된 상태에서 가능하기 때문에 아이디를 불러와준다
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			userid = loginuser.getUserid();
		}catch(NullPointerException e) {
			checkidnull = "no";
			request.setAttribute("checkidnull", checkidnull);
		}
		
		// 댓글 작성에 필요한 아이디 넘겨주기
		request.setAttribute("userid", userid);
		
		/////////////////////////////////////////////////////////////////////
		
		if("get".equalsIgnoreCase(method) && product_name != null && mujakjung == null) {

			// 어떤 제품을 누르고 들어왔는지 확인을 위해 product_name을 넘긴다
			// 해당제품의 사진 및 가격을 가져온다
			ProductVO pvo = pdao.getOneProduct(product_name);
			// 해당 제품의 사진 및 가격 넘기기
			request.setAttribute("pvo", pvo);
			
			///////////////////////////////////////////////////////
			
			// 처음 시작할 때 가져올 값
			// 리뷰 평점, 리뷰 갯수, 리뷰조회수, 올린 사진, 댓글, 작성자, 시간, 제품내용 가져오기
			List<ReviewVO> reviewList = idao.SelectAllReview(product_name); 
			
			// 리뷰 평점
			int Review_star = 0;
			// 리뷰 갯수
			int Review_cnt = 0;
			
			// 다 더해주기
			for(int i=0; i<reviewList.size(); i++) {
				Review_star += Integer.parseInt(reviewList.get(i).getReview_star());
				Review_cnt++;
			}
			// 전체 리뷰 평점 가져오기
			Map<String, String> starMap = idao.selectStar(product_name);
			// 전체 리뷰 평점 넘겨주기
			request.setAttribute("starMap", starMap);
			// 값 넘겨주기
			request.setAttribute("Review_star", Review_star);
			// 리뷰갯수 넘겨주기
			request.setAttribute("Review_cnt", Review_cnt);
			// 모든 리뷰 가져오기
			request.setAttribute("reviewList", reviewList);
			
			// 리뷰를 작성안한 내 구매내역을 가져오기
			List<ProductBuyVO> buyList = prdao.SelectMyBought(userid, product_name);
			
			if(buyList != null) {
				not_review = "yes_review";
			}
			
			// 넘겨주기
			request.setAttribute("buyList", buyList);
			request.setAttribute("not_review", not_review);
			
			super.setViewPage("/WEB-INF/product/buy.jsp");
			
			/////////////////////////////////////////////////////////////////
			
		}
		//product_name == null && "GET".equalsIgnoreCase(method) && mujakjung != null
		else if("post".equalsIgnoreCase(method)) {

			///////////////////////////////////////////////////////
			
			MultipartRequest mtrequest = null;
			
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images");
			
			try {
			mtrequest = new MultipartRequest(request,    // 리퀘스트 객체
			uploadFileDir, // 파일이 업로드될 경로명
			100*1024*1024,    // 10MB로 제한한다. (단위는 bite로 써야함)
			"UTF-8",       // 인코딩 타입
			new DefaultFileRenamePolicy());
			} catch(IOException e) {
			
			request.setAttribute("message", "파일 용량 초과로 인해서 업로드 실패함!");
			request.setAttribute("loc", request.getContextPath()+"/index.sh"); 
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return; 
			}
			
			//////////////////////////////////////////////////////
			
			// 이 경로는 buy에서 다시 자기 자신에게 타고 들어오는 경로이다
			// 따라서 다시 들어올때 위의 product_name의 값은 null 이 들어가므로
			// 다시 값을 넣어 줘서 보여지게 한다
			product_name = mtrequest.getParameter("retry_product_name"); 

			// 어떤 제품을 누르고 들어왔는지 확인을 위해 product_name을 넘긴다
			// 해당제품의 사진 및 가격을 가져온다
			ProductVO pvo = pdao.getOneProduct(product_name);
			
			// 해당 제품의 사진 및 가격 넘기기
			request.setAttribute("pvo", pvo);
						
			///////////////////////////////////////////////////////
			
			// 내가 작성한 후 올리기 위해 리뷰내용, 평점, 이미지 넘겨받은값임
			// 그 외 제품번호, 올린날짜, 구매정보는 구매내역 테이블을 통해 가져오도록 한다.
			String content = mtrequest.getParameter("content");
			String whatstar = mtrequest.getParameter("whatstar");
			String insertpicture = mtrequest.getFilesystemName("insertpicture");
			String jumun_bunho = mtrequest.getParameter("jumun_bunho");
			
			if(insertpicture == null) {
				insertpicture = "noimage.gif"; 
			}
			
			if(content != null && whatstar != null && jumun_bunho != null) {
				// 내 리뷰 업데이트하기
				idao.UpdateMyReview(userid, content, whatstar, insertpicture, product_name, jumun_bunho);
				// 그 후 해당제품의 리뷰를 달았다는 업데이트를 해준다
				prdao.updateMyReviewCheckUp(jumun_bunho);
				// 리뷰를 작성안한 내 구매내역을 가져오기
				List<ProductBuyVO> buyList = prdao.SelectMyBought(userid, product_name);
				if(buyList != null) {
					not_review = "yes_review";
				}
				// 넘겨주기
				request.setAttribute("buyList", buyList);
				request.setAttribute("not_review", not_review);
			}
			
			// 처음 시작할 때 가져올 값
			// 리뷰 평점, 리뷰 갯수, 리뷰조회수, 올린 사진, 댓글, 작성자, 시간, 제품내용 가져오기
			List<ReviewVO> reviewList = idao.SelectAllReview(product_name); 
			
			// 리뷰 평점
			int Review_star = 0;
			// 리뷰 갯수
			int Review_cnt = 0;
			
			// 다 더해주기
			for(int i=0; i<reviewList.size(); i++) {
				Review_star += Integer.parseInt(reviewList.get(i).getReview_star());
				Review_cnt++;
			}
			
			// 전체 리뷰 평점 가져오기
			Map<String, String> starMap = idao.selectStar(product_name);
			// 전체 리뷰 평점 넘겨주기
			request.setAttribute("starMap", starMap);
			// 값 넘겨주기
			request.setAttribute("Review_star", Review_star);
			// 리뷰갯수 넘겨주기
			request.setAttribute("Review_cnt", Review_cnt);
			// 모든 리뷰 가져오기
			request.setAttribute("reviewList", reviewList);
			
			///////////////////////////////////////////////////////
			
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

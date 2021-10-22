package product.controller;

import java.util.*;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;
import comment.model.*;
import common.controller.*;

public class DatgleAction extends AbstractController {
//=========================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 댓글 객체
		InterCommentDAO icdao = new CommentDAO();
		
		// 어떤 리뷰를 눌렀는지 번호를 받아옴
		String what_reviewno = request.getParameter("what_reviewno");
		// 댓글내용
		String review_text = request.getParameter("review_text");
		// 작성자 아이디
		String userid = request.getParameter("userid");
		
		// 작성한 내용 업데이트 해주기
		// 단 널값이 들어오면 안된다
		if(review_text != null && userid != null) {
			icdao.UpdateDatgle(review_text, userid, what_reviewno);
		}
		
		// 리뷰 번호에 맞게 댓글들 가져오기
		List<ReviewCommentVO> commentList = icdao.SelectAllComment(what_reviewno); 

		///////////////////////////////////////////////////////////////////////////
		   
		JSONArray jsonArr = new JSONArray();
		
		for(ReviewCommentVO rcvo : commentList) {
	            
			JSONObject jsobj = new JSONObject();          
	            
			jsobj.put("fk_reviewno", rcvo.getFk_reviewno());          
			jsobj.put("review_text", rcvo.getReview_text());
			jsobj.put("fk_userid", rcvo.getFk_userid());
			   
			jsonArr.put(jsobj);
	         
		}// end of for----------------------------
			
		String json = jsonArr.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");

	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//=========================================================================================
}

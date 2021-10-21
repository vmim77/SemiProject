package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.realmodel.*;

public class AdminOrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			// 모든 회원의 주문내역 조회는 운영자만 가능하다.
			
			InterProductRealDAO prdao = new ProductRealDAO();
			
			
			
			////////////////////////// 페이징 처리 ///////////////////////////////////
			int sizePerPage = 10;
			
			int totalPage = 0;
			
			int totalCountOrder = prdao.getTotalCountOrder(); // 총 주문내역 건수 알아오기
			
			
			totalPage = (int) Math.ceil((double)(totalCountOrder/sizePerPage));
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			int currentShowPageNo = 0;
	          
	          try {
	        	  if(str_currentShowPageNo == null) {
	        		  currentShowPageNo = 1;
	        	  }
	        	  else {
	        		  currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	        		  
	        		  if( currentShowPageNo < 1 || currentShowPageNo > totalPage ) {
	        			  currentShowPageNo = 1;
	        		  }
	        	  }
	          } catch (NumberFormatException e) {
	        	  currentShowPageNo = 1;
	          }
			
			
	        List<Map<String, String>> orderList =  prdao.selectAllOrderList(currentShowPageNo, sizePerPage); // 모든 주문내역을 가져온다.
	        
	        String url = "orderList.sh";
	        
	        int blockSize = 10;
	        
	        int loop = 1;
	        
	        int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
	        
	        String pageBar = "";
	        
            if(pageNo != 1) {
	             pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
	             pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	        }
            
	        while( !(loop > blockSize || pageNo > totalPage) ) {
		           
		           if(pageNo == currentShowPageNo) {
		              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";  
		           }
		           else {
		              pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
		           }
		           
		           loop++;
		           pageNo++;
		        }// end of while----------------------
		        
		        // *** [다음][마지막] 만들기 *** // 
		        if( pageNo <= totalPage ) {
		           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
		           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		    }
		        
		        
		        
		        
		    request.setAttribute("pageBar", pageBar);
			request.setAttribute("orderList", orderList);
			
			super.setViewPage("/WEB-INF/admin/orderList.jsp");
			
		}
		else {
			// 로그인을 안했거나, 운영자가 아닌 경우이다.
            String message = "권한이 없는 사용자입니다.";
            String loc = "javascript:history.back();";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
		}
	
		
		
		
	}

}

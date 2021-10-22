package product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductRealDAO;

public class CartDetailStoreAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// get 방식이라면
			 String message = "비정상적인 경로로 들어왔습니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
		}
		else if("post".equalsIgnoreCase(method) && super.checkLogin(request)) {

		/*
			String pimage1join =  request.getParameter("pimage1join");
            String pnamejoin =  request.getParameter("pnamejoin");
            String pnumjoin =  request.getParameter("pnumjoin");
            String qtyjoin =  request.getParameter("qtyjoin");
            String optionjoin =  request.getParameter("optionjoin");
            String option_pricejoin =  request.getParameter("option_pricejoin");
            String cartnojoin =  request.getParameter("cartnojoin");
            String salePricejoin =  request.getParameter("salePricejoin");
            String totalPointjoin = request.getParameter("totalPointjoin");
            String totalPricejoin =  request.getParameter("totalPricejoin");
        */   
            
			String pimage1 = request.getParameter("pimage1");
		//	System.out.println("test ="+pimage1);
			
			
            String[] pimage1Arr = request.getParameterValues("pimage1");
            String[] pnameArr = request.getParameterValues("pname");
            String[] pnumArr = request.getParameterValues("pnum");
            String[] qtyArr = request.getParameterValues("qty");
            String[] optionArr= request.getParameterValues("option");
            String[] option_priceArr= request.getParameterValues("option_price");
            String[] cartnoArr= request.getParameterValues("cartno");
            String[] salePriceArr= request.getParameterValues("salePrice");
            String[] totalPointArr= request.getParameterValues("totalPoint");
            String[] totalPriceArr= request.getParameterValues("totalPrice");
            
            String sumtotalPrice =  request.getParameter("sumtotalPrice");
            String sumtotalPoint =  request.getParameter("sumtotalPoint");
        //    System.out.println(sumtotalPrice);
            
            // 배열로 넘겨받은걸로 목록 한세트 만들어서 리스트에 각각 저장하기
            List<Map<String,String>> orderlist = new ArrayList<>();
            
            
            // 밑에 표에 넣기 위한  원래 판매가들의 합과 각 적립금들의 합 그릐고 총 판매가와 총 적립금 까지도!
            int sumsalePrice = 0;
            int sumoption_price = 0;
            int sum_totalprice = 0;
            int sum_totalpoint = 0;
            
            
            for (int i = 0; i < pnameArr.length; i++) {
            //	System.out.println(pimage1Arr[i]);
            //	System.out.println(pnameArr[i]);
            //	System.out.println(pnumArr[i]);
            //	System.out.println(qtyArr[i]);
            	System.out.println(optionArr[i]);
            	System.out.println(option_priceArr[i]);   // 옵션 가격만 배열 저장
            	System.out.println(cartnoArr[i]);
            	System.out.println(salePriceArr[i]);       // 세일판매가만 저장
            	System.out.println(totalPointArr[i]);      // 수량까지 곱한 각 적립금들 저장
            	System.out.println(totalPriceArr[i]);      // 옵션+세일판매가에 수량까지 곱한 것들 저장 각 상품의 최종 판매가
            	
            	sumsalePrice += Integer.parseInt(salePriceArr[i])*Integer.parseInt(qtyArr[i]);        // 세일판매가에 수량을 곱한 것들을 합한 것!!! 배열은 아님
            	sumoption_price += Integer.parseInt(option_priceArr[i])*Integer.parseInt(qtyArr[i]);  // 옵션에 수량을 곱한 것들을 합한 것!! 배열은 아님
            	sum_totalprice += Integer.parseInt(totalPriceArr[i]);				// 총 모든 최종 판매가들을 다 더한 것
            	sum_totalpoint += (int)Double.parseDouble((String)totalPointArr[i]);     // 총 모든 적립금 다 더한것
            	System.out.println("확인용 sum_totalpoint : "+ sum_totalpoint);
            	
            	
            	
            	Map<String, String> map = new HashMap<>();
            	map.put("pimage1", pimage1Arr[i]);
            	map.put("pname", pnameArr[i]);
            	map.put("pnum", pnumArr[i]);
            	map.put("qty", qtyArr[i]);
            	map.put("option", optionArr[i]);
            	map.put("option_price", option_priceArr[i]);
            	map.put("cartno", cartnoArr[i]);
            	map.put("salePrice", salePriceArr[i]);
            	map.put("totalPoint", totalPointArr[i]);
            	map.put("totalPrice", totalPriceArr[i]);
            	
            	orderlist.add(map);
            	
            	}
           // sumPoint= (int)sumPoint;
         /*   
            String[] pimage1Arr  = pimage1join.split(","); 
            String[] pnameArr  = pnamejoin.split(",");
            String[] pnumArr = pnumjoin.split(",");
            String[] qtyArr  = qtyjoin.split(",");
            String[] optionArr  = optionjoin.split(",");
            String[] option_priceArr  = option_pricejoin.split(",");
            String[] cartnoArr  = cartnojoin.split(",");
            String[] salePriceArr  = salePricejoin.split(",");
            String[] totalPointArr  = totalPointjoin.split(",");
            String[] totalPriceArr  = totalPricejoin.split(",");
            
            request.setAttribute("product_front_p1", pimage1Arr);
            request.setAttribute("pnameArr", pnameArr);
            request.setAttribute("pnumArr", pnumArr);
            request.setAttribute("qtyArr", qtyArr);
            request.setAttribute("optionArr", optionArr);
            request.setAttribute("option_priceArr", option_priceArr);
            request.setAttribute("cartnoArr", cartnoArr);
            request.setAttribute("salePriceArr", salePriceArr);
            request.setAttribute("totalPointArr", totalPointArr);
            request.setAttribute("totalPriceArr", totalPriceArr);
            request.setAttribute("sumtotalPrice", sumtotalPrice);
            request.setAttribute("sumtotalPoint", sumtotalPoint);
         */   
            
            request.setAttribute("orderlist", orderlist);
            
            request.setAttribute("sumsalePrice", sumsalePrice);
            request.setAttribute("sumoption_price", sumoption_price);
            
            request.setAttribute("sum_totalprice", sum_totalprice);
            request.setAttribute("sum_totalpoint", sum_totalpoint);

            
         // 내정보 불러오기를 위한 처리작업
            HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
    		
    		InterMemberDAO mdao = new MemberDAO();
    		
    		// 쿠폰 넘겨받기
	        List<MemberVO> libo = mdao.mycoupon(userid); 
	        request.setAttribute("libo", libo);
			
			InterMemberDAO mado = new MemberDAO();
			Map<String, String> paraMap = mado.SelectMyInfo(userid);
			
			request.setAttribute("paraMap", paraMap);
			
			// 내 포인트 넘겨주기
			int mypoint = mdao.selectMyPoint(userid);
			request.setAttribute("mypoint", mypoint);
			
			/////////////////////////////////////////////////////////////////////
						
			super.setViewPage("/WEB-INF/product/cartdetailstore.jsp");
            
            
            

		
			
		}
		
	}

}

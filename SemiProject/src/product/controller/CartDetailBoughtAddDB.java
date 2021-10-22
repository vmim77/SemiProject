package product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.controller.GoogleMail;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductRealDAO;
import product.realmodel.ProductRealVO;

public class CartDetailBoughtAddDB extends AbstractController {

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
	            
	            /////////////////////////////////////////////////
	            
	            String coupon = request.getParameter("coupon");
	            request.setAttribute("coupon", coupon);
	            
	            /////////////////////////////////////////////////
	            
	            String cartnojoin = String.join(",", cartnoArr);
	            System.out.println(cartnojoin);
	            
	            // 주문번호 랜덤으로 만들기
				Random rnd = new Random();
				
				int jumun = rnd.nextInt(99999-10000+1)+10000;
				int bunho = rnd.nextInt(99-10+1)+10;
				
				String jumun_bunho = jumun + "-" + bunho;
				
				HashMap<String, Object> paraMap = new HashMap<>();
				//구매내역에 insert위한 용도
				paraMap.put("pimage1Arr", pimage1Arr);
				paraMap.put("pnameArr", pnameArr);
				paraMap.put("pnumArr", pnumArr);
				paraMap.put("qtyArr", qtyArr);
				paraMap.put("optionArr", optionArr);
				paraMap.put("option_priceArr", option_priceArr);
				paraMap.put("cartnoArr", cartnoArr);
				paraMap.put("salePriceArr", salePriceArr);
				paraMap.put("totalPointArr", totalPointArr);
				paraMap.put("totalPriceArr", totalPriceArr);		
				
				// 장바구니 테이블에 deleete
		        paraMap.put("cartnojoin", cartnojoin);
				
		        //구매내역 테이블에 insert위한 용도
	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	           String userid = loginuser.getUserid();
	            paraMap.put("userid", loginuser.getUserid());
	            
	            // 주문번호도 구매내역에 insert위한 용도
	            paraMap.put("jumun_bunho", jumun_bunho);
				
	            int sumsalePrice = 0;
	            int sumoption_price = 0;
	            int sum_totalprice = 0;
	            int sum_totalpoint = 0;
	            
	            InterMemberDAO mdao = new MemberDAO();
	            
	         // 사용한 쿠폰 디비에 없애기
				mdao.ByeCoupon(userid, coupon);
	            
	         // 배열로 넘겨 받은거 목록 한 세트로 만들고 List에 저장하기
	            List<Map<String,String>> finalorderlist = new ArrayList<>();
	            
	            for (int i = 0; i < pnameArr.length; i++) {
                //	System.out.println(pimage1Arr[i]);
                //	System.out.println(pnameArr[i]);
                //	System.out.println(pnumArr[i]);
                //	System.out.println(qtyArr[i]);
                //	System.out.println(optionArr[i]);
                //	System.out.println(option_priceArr[i]);       // 옵션 가격만 배열 저장
                //	System.out.println(cartnoArr[i]);
                //	System.out.println(salePriceArr[i]);          // 세일판매가만 저장
                //	System.out.println(totalPointArr[i]);		  // 수량까지 곱한 각 적립금들 저장
                //	System.out.println(totalPriceArr[i]);         // 옵션+세일판매가에 수량까지 곱한 것들 저장 각 상품의 최종 판매가
                	
	            	sumsalePrice += Integer.parseInt((String)salePriceArr[i])*Integer.parseInt((String)qtyArr[i]);                // 세일판매가에 수량을 곱한 것들을 합한 것!!! 배열은 아님
	        //    	String[] buy_pro_price = String.valueOf(Integer.parseInt(salePriceArr[i])*Integer.parseInt(qtyArr[i]));    
	            	
	            	sumoption_price += Integer.parseInt((String)option_priceArr[i])*Integer.parseInt((String)qtyArr[i]);           // 옵션에 수량을 곱한 것들을 합한 것!! 배열은 아님
	            	sum_totalprice += Integer.parseInt((String)totalPriceArr[i]);                     // 총 모든 최종 판매가들을 다 더한 것
	            	sum_totalpoint += (int)Double.parseDouble((String)totalPointArr[i]);              // 총 모든 적립금 다 더한것
	            	
	            	
	            	Map<String, String> listmap = new HashMap<>();
	            	listmap.put("pimage1", pimage1Arr[i]);
	            	listmap.put("pname", pnameArr[i]);
	            	listmap.put("pnum", pnumArr[i]);
	            	listmap.put("qty", qtyArr[i]);
	            	listmap.put("option", optionArr[i]);
	            	listmap.put("option_price", option_priceArr[i]);
	            	listmap.put("cartno", cartnoArr[i]);
	            	listmap.put("salePrice", salePriceArr[i]);
	            	listmap.put("totalPoint", totalPointArr[i]);
	            	listmap.put("totalPrice", totalPriceArr[i]);
	            	
	            	finalorderlist.add(listmap);
                	
            }
	            
	            paraMap.put("sumsalePrice", sumsalePrice);
	            paraMap.put("sumoption_price", sumoption_price);
	            paraMap.put("sum_totalprice", sum_totalprice);
	            paraMap.put("sum_totalpoint", sum_totalpoint);
	            
	            
            
	            
				InterProductRealDAO prdao = new ProductRealDAO();
				
				//구매내역에 넣어주기
				int isSuccess = prdao.orderAdd(paraMap);
				
				
				
				// **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
		         //      이어서 주문이 완료되었다라는 email 보내주기  **** //        
		        if(isSuccess ==1) {
		        	// 세션에 저장되어져 있는 loginuser 정보를 갱신		        	
		        	loginuser.setPoint(loginuser.getPoint() + sum_totalpoint);
		        	
		 ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
		        	 GoogleMail mail = new GoogleMail();
		        	 
		        	 StringBuilder sb = new StringBuilder();
		        	 
		        	 for(int i=0; i<pnumArr.length; i++) {
		        		 sb.append("\'"+pnumArr[i]+"\',");
		        	   /*
		                 tbl_product 테이블에서 select 시
		                 where 절에 in() 속에 제품번호가 들어간다.
		                                      만약에 제품번호가 문자열로 되어있어서 반드시 홑따옴표(')가 필요한 경우에는 위와같이 해주면 된다.
		              */
		        	 }// end of for----------------------------
		        	 
		        	 String pnumes = sb.toString().trim();
		        	 // '3', '56', '59',
		        	 
		        	 pnumes = pnumes.substring(0, pnumes.length()-1);
		        	 // 맨 뒤에 콤마(,)를 제거하기 위함.
		        	 //'3', '56', '59'
		        	 
		        	 System.out.println("~~~~확인용 주문한 제품번호 : " + pnumes);
		             // ~~~~확인용 주문한 제품번호 : '3','56','59'
		        	 
		        //	 List<ProductRealVO> jumunProductList = prdao.getJumunProductList(pnumes);
		        	// 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것.
		        	 
		        	 sb.setLength(0);
		        	 //StringBuilder sb의 초기화하기
		        	 sb.append("<div style='align:center; color:black;'>");
		        	 sb.append("주문코드번호 : <span style='color: blue; font-weight: bold;'>"+jumun_bunho+"</span><br/><br/>");
		        	 sb.append("<주문상품><br/>");
		        	 
		        	 for(int i=0; i< pnumArr.length; i++) {		        		 
		        		 sb.append("<br/>");
		        		 sb.append(pnameArr[i]+"&nbsp;"+qtyArr[i]+"개&nbsp;&nbsp;");
		        		 sb.append("<br/>");			        		 
		        		 sb.append("<img src='"+pimage1Arr[i]+"' style='width:250px'/>");
		        		 sb.append("<br/>");
		        		
		        		 
		        	 }// end of for--------------------------------------------
		        	 
		        	 sb.append("<br/>이용해주셔서 감사합니다.");
		        	 sb.append("</div>");
		        	 String emailContents = sb.toString();
		        	 
		        	 mail.sendmail_OrderFinish(loginuser.getEmail(), loginuser.getName(), emailContents);
		        
		        	////////// === 주문이 완료되었다는 email 보내기 종료 === /////////// 
		        	 
					////////////////////////////////////////////////////////////////////
					// 배송을 위한 정보를 담은 내역
					String name = request.getParameter("name");
					String postcode = request.getParameter("postcode");
					String address = request.getParameter("address");
					String detailAddress = request.getParameter("detailAddress");
					String hp1 = request.getParameter("hp1");
					String hp2 = request.getParameter("hp2");
					String hp3 = request.getParameter("hp3");
					String firstemail = request.getParameter("firstemail");
					String secondemail = request.getParameter("secondemail");
					String text = request.getParameter("text");
					
					// 받아온거로 새로운 값 처리
					String email = firstemail + secondemail;
					if(text == "") {
					text = "기사님 조심히 오세요";
					}
					
					request.setAttribute("name", name);
					request.setAttribute("postcode", postcode);
					request.setAttribute("address", address);
					request.setAttribute("detailAddress", detailAddress);
					request.setAttribute("hp1", hp1);
					request.setAttribute("hp2", hp2);
					request.setAttribute("hp3", hp3);
					request.setAttribute("email", email);
					request.setAttribute("text", text);
					
					////////////////////////////////////////////////////////////////////
					
					
					// 남은금액
					String dbpoint = request.getParameter("dbpoint");
					// 그러나 남은 잔액과 현재 받은 적립금을 더해주어야 한다
					int intdbpoint = Integer.parseInt(dbpoint)+sum_totalpoint;
					// 형변환 해주기
					dbpoint = intdbpoint + "";
					
					mdao.UpdateMypoint(loginuser.getUserid(), dbpoint); 
					
					
					
		        	 
		        }
		        
		        else {
		        	String message = "구매에 실패하셨습니다..";
			         String loc = "javascript:history.back()";
			         
			         request.setAttribute("message", message);
			         request.setAttribute("loc", loc);
			         
			         super.setViewPage("/WEB-INF/msg.jsp");
			         return;
			      }
		        
		        
		        request.setAttribute("finalorderlist", finalorderlist);		       
	            request.setAttribute("sum_totalprice", sum_totalprice);
		        
		        //super.setRedirect(false);
			      super.setViewPage("/WEB-INF/product/cartDetailBought.jsp");
	            
			
		}
		
	}

}

package product.realmodel;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import util.security.*;

public class ProductRealDAO implements InterProductRealDAO {
//=====================================================================================
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	private AES256 aes;
//=====================================================================================
	// 기본생성자
	public ProductRealDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
			aes = new AES256(SecretMyKey.KEY);
			   
			} catch(NamingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				
				e.printStackTrace();
			}
		}
//=====================================================================================	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
				if(rs != null)    {rs.close();    rs=null;}
				if(pstmt != null) {pstmt.close(); pstmt=null;}
				if(conn != null)  {conn.close();  conn=null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
//=====================================================================================		
	// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
	@Override
	public int SearchMyBuy(String userid, String product_name) throws SQLException {
		
			// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
			int review_check = 0;
			
			try {
				
				conn = ds.getConnection();
				
				// 리뷰 작성했는지 찾아보기
				String sql = " select review_check "+
						     " from tbl_buy "+
						     " where fk_userid = ? and fk_pnum = (select pnum "+
						     "                                    from tbl_product "+
						     "                                    where pname = ?) "+
						     " and review_check = 1 ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, product_name);
				
				rs = pstmt.executeQuery();
				
				// 만약 작성한지 일주일된 리뷰가 있다면
				while(rs.next()) {
					review_check++;
				}
				
			} finally {
				close();
			}
			
			return review_check;
			
		}//end of public int SearchMyBuy(String userid, String product_name) throws SQLException {
//=====================================================================================
	// 내 구매내역 업데이트 하기
	@Override
	public void UpdateMyBought(Map<String, String> paraMap) throws SQLException {
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_buy "+
					     " (fk_pnum "+
					     " ,fk_userid "+
					     " ,buy_opt_info "+
					     " ,buy_qty "+
					     " ,buy_opt_price "+
					     " ,buy_pro_price "+
					     " ,buy_jeokrib_money"+
					     " ,fk_pimage3"+
					     " ,jumun_bunho) "+
					     " values( "+
					     " (select pnum "+
					     "  from tbl_product "+
					     "  where pname = ?) "+
					     " ,? "+
					     " ,? "+
					     " ,? "+
					     " ,? "+
					     " ,? "+
					     " ,? "+
					     " ,? "+
					     " ,?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("cartname"));
			pstmt.setString(2, paraMap.get("userid"));
			pstmt.setString(3, paraMap.get("buy_opt_price"));
			pstmt.setString(4, paraMap.get("cartnum"));
			pstmt.setString(5, paraMap.get("cartfinopt"));
			pstmt.setString(6, paraMap.get("cartprice"));
			pstmt.setString(7, paraMap.get("jukrib"));
			pstmt.setString(8, paraMap.get("product_front_p1"));
			pstmt.setString(9, paraMap.get("jumun_bunho"));
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
	}//end of public void UpdateMyBought(Map<String, String> paraMap) throws SQLException {
//========================================================================================	
	// 리뷰를 작성안한 내 구매내역을 가져오기
	@Override
	public List<ProductBuyVO> SelectMyBought(String userid, String product_name)  throws SQLException{
		
		List<ProductBuyVO> buyList = new ArrayList<>();
		
		try {			
			conn = ds.getConnection();
			
			// 구매날짜 14일 안으로만 리뷰작성이 가능케 하도록 함
			String sql = " select buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, jumun_bunho, baesong_sangtae, fk_pimage3 "+
					     " from tbl_buy "+
					     " where fk_userid = ? and fk_pnum = (select pnum "+
					     "                                    from tbl_product "+
					     "                                    where pname = ?) "+
					     " and review_check = 0 and sysdate - buy_date between 0 and 14 ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, product_name);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductBuyVO pbvo = new ProductBuyVO();
				
				pbvo.setBuy_opt_info(rs.getString(1));
				pbvo.setBuy_qty(rs.getInt(2));
				pbvo.setBuy_opt_price(rs.getString(3));
				pbvo.setBuy_pro_price(rs.getString(4));
				pbvo.setJumun_bunho(rs.getString(5));
				pbvo.setBaesong_sangtae(rs.getInt(6));
				pbvo.setFk_pimage3(rs.getString(7));
				
				buyList.add(pbvo);
				
			}//end of while(rs.next()) {-------------------------

		} finally {
			close();
		}
		
		return buyList;
		
	}//end of public ProductRealVO SelectMyBought(String userid, String product_name)  throws SQLException{
//=====================================================================================	
	// 해당제품의 리뷰를 달았다는 것을 업데이트	
	@Override
	public void updateMyReviewCheckUp(String jumun_bunho) throws SQLException{
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_buy set review_check = 1 "+
					     " where jumun_bunho = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jumun_bunho);
			
			pstmt.executeUpdate();

		} finally {
			close();
		}
		
	}//end of public void updateMyReviewCheckUp(String jumun_bunho) {	
//=====================================================================================		
	// 마이페이지에 내 구매내역을 가져오기	
	@Override
	public List<ProductBuyVO> SelectMyPageBought(String userid)  throws SQLException{
      
		List<ProductBuyVO> buyList = new ArrayList<>();
      
		try {      
			conn = ds.getConnection();
         
			String sql = " select buy_date,buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, jumun_bunho, baesong_sangtae, fk_pimage3 "+
                    " from tbl_buy "+
                    " where fk_userid = ? "+
         			" order by buy_date desc ";
         
			pstmt = conn.prepareStatement(sql);
         
			pstmt.setString(1, userid);
         
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            
            ProductBuyVO pbvo = new ProductBuyVO();
            
            pbvo.setBuy_date(rs.getString(1));
            pbvo.setBuy_opt_info(rs.getString(2));
            pbvo.setBuy_qty(rs.getInt(3));
            pbvo.setBuy_opt_price(rs.getString(4));
            pbvo.setBuy_pro_price(rs.getString(5));
            pbvo.setJumun_bunho(rs.getString(6));
            pbvo.setBaesong_sangtae(rs.getInt(7));
            pbvo.setFk_pimage3(rs.getString(8));
            
            buyList.add(pbvo);
            
         }//end of while(rs.next()) {-------------------------

      } finally {
         close();
      }
      
      return buyList;
      
   }//end of public ProductRealVO SelectMyBought(String userid, String product_name)  throws SQLException{
	
	
		// 환불/교환 클릭시 값 받아오기
	   @Override
	   public List<ProductBuyVO> Mychange(String jumun_bunho)  throws SQLException{
	      
	      List<ProductBuyVO> orderList = new ArrayList<>();
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, jumun_bunho, baesong_sangtae, fk_pimage3 "+
	                    " from tbl_buy "+
	                    " where jumun_bunho = ? ";

	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, jumun_bunho);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            
	            ProductBuyVO pbvo = new ProductBuyVO();
	            
	            pbvo.setBuy_opt_info(rs.getString(1));
	            pbvo.setBuy_qty(rs.getInt(2));
	            pbvo.setBuy_opt_price(rs.getString(3));
	            pbvo.setBuy_pro_price(rs.getString(4));
	            pbvo.setJumun_bunho(rs.getString(5));
	            pbvo.setBaesong_sangtae(rs.getInt(6));
	            pbvo.setFk_pimage3(rs.getString(7));
	            
	            orderList.add(pbvo);
	            
	         }//end of while(rs.next()) {-------------------------

	      } finally {
	         close();
	      }
	      
	      return orderList;
	      
	   }//end of public ProductRealVO SelectMyBought(String userid, String product_name)  throws SQLException{
	
//============================================================================================================	   
	 // 환불/취소 선택시 환불처리로 변경되는 메소드 
	@Override
	public int Change(String jumun_bunho , int th, String changeOpt) throws SQLException {
		
		int n = 0;
		
		System.out.println("##### " + changeOpt);
		System.out.println("##### " + jumun_bunho);
		System.out.println("##### " + th);
		
		try {
			
			conn=ds.getConnection();
			
			String sql = " update tbl_buy set baesong_sangtae = ? ";
			
			if(changeOpt.length() > 0) {
				sql += " , buy_opt_info = ? ";
			}
			
			sql += " where jumun_bunho = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(changeOpt.length() > 0) {
				pstmt.setInt(1, th);
				pstmt.setString(2, changeOpt);
				pstmt.setString(3, jumun_bunho);
				
			}
			else {
				pstmt.setInt(1, th);
				pstmt.setString(2, jumun_bunho);
			}
			
			n = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			close();
		}
		
		return n;
	}
	
//=========================================================================================================
	
	@Override
	public List<ProductBuyVO> myorder(String userid) throws SQLException {
		
		List<ProductBuyVO> order = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			

			String sql = " select buy_date,fk_userid,baesong_sangtae,jumun_bunho "
					   + " from tbl_buy "
					   + " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductBuyVO pdvo = new ProductBuyVO();
				pdvo.setBuy_date(rs.getString(1));
				pdvo.setFk_userid(rs.getString(2));
				pdvo.setBaesong_sangtae(rs.getInt(3));
				pdvo.setJumun_bunho(rs.getString(4));
				
				order.add(pdvo);
				
			}
			
			
		}finally {
			close();
		}
		
		
		
		return order;
	}
	
	
	// 마이페이지 총구매금액
	@Override
	public int SelectMyBuyMoney(String userid) throws SQLException {
		// 총구매금액
		int buyMoney = 0;
		// 에러방지
		int cnt = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select buy_opt_price , buy_pro_price  "+
						 " from tbl_buy "+
						 " where fk_userid =? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt++;
			}
			
			if(cnt>0) {
				while(rs.next()) {
					buyMoney += Integer.parseInt(rs.getString(1))+ Integer.parseInt(rs.getString(2));
				}//end of while
			}
			
		} finally {
			close();
		}
		
		return buyMoney;
	}
	
	// 배송조회시 주문번호 조회검색
	@Override
	public List<ProductBuyVO> SelectJumun(String jumun_bunho) throws SQLException {
		
		List<ProductBuyVO> jumunList = new ArrayList<>();
		
		
		
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select to_char(buy_date,'yyyy-mm-dd'),fk_userid,baesong_sangtae "+
	                      " from tbl_buy "+
	                      " where jumun_bunho = ? ";

	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, jumun_bunho);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            
	            ProductBuyVO pvo = new ProductBuyVO();
	            
	            pvo.setBuy_date(rs.getString(1));
	            pvo.setFk_userid(rs.getString(2));
	            pvo.setBaesong_sangtae(rs.getInt(3));
	            
	            
	            
	            jumunList.add(pvo);
	            
	         }//end of while(rs.next()) {-------------------------

	      } finally {
	         close();
	      }
	      
	      return jumunList;
	      
	}
	
//=====================================================================================	
	   
	   
	   // 장바구니 번호 채번해오기
	      @Override
	      public int getCartno() throws SQLException {
	         
	         int cartno = 0;
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select seq_tbl_cart_cartno.nextval AS CARTNO " +
	                           " from dual ";
	                    
	               pstmt = conn.prepareStatement(sql);
	               rs = pstmt.executeQuery();
	                         
	               rs.next();
	               cartno = rs.getInt(1);
	            
	         }finally {
	            close();
	         }
	         
	         return cartno;
	      }// end of public int getCartno() throws SQLException-------------------------------
	      

	      
	      //=====================================================================================      
	   
	      
	   //제품 번호 알아오기 VO를 잘못짜서 제품이름으로 알아와야 함.
	   @Override
	   public int getPnum(String cartname) throws SQLException {
	      
	      int pnum = 0;
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select pnum "+
	               " from tbl_product "+
	               " where pname = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cartname);
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         pnum = rs.getInt(1);
	         
	         
	      } finally {
	         close();
	      }
	      
	      return pnum;
	      
	   }
	   
	   
	   
	   
	   
	   
	   
	   // 장바구니 테이블에 삽입하기( 똑같은게 있으면 업데이트이고 없으면 삽입힌다.
	   @Override
	   public int addCart(String userid, int pnum, String cart_opt_info, String cart_qty, String cart_opt_price) throws SQLException{
	      int n = 0;
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select cartno " 
	                  + " from tbl_cart "
	                  + " where fk_userid = ? and fk_pnum = ? and cart_opt_info = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	           pstmt.setString(1, userid);
	           pstmt.setInt(2, pnum);
	           pstmt.setString(3, cart_opt_info);
	           
	           rs = pstmt.executeQuery();
	             
	             if(rs.next()) {
	              // 어떤 제품을 추가로 장바구니에 넣고자 하는 경우
	                int cartno = rs.getInt("cartno");
	                
	                sql = " update tbl_cart set cart_qty = cart_qty + ? "
	                     + " where cartno = ? ";
	                
	                pstmt = conn.prepareStatement(sql);
	                 pstmt.setInt(1, Integer.parseInt(cart_qty));
	                 pstmt.setInt(2, cartno);
	                 
	                 n = pstmt.executeUpdate();
	                
	             }
	             else {
	              // 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
	                
	                 sql = " insert into tbl_cart(cartno, fk_pnum, fk_userid, cart_opt_info, cart_qty, cart_opt_price, cart_date ) "
	                      + " values(seq_tbl_cart_cartno.nextval, ?, ?, ?, ?, ?, default) ";
	                  
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setInt(1, pnum);
	                  pstmt.setString(2, userid);
	                  pstmt.setString(3, cart_opt_info);
	                  pstmt.setString(4, cart_qty);
	                  pstmt.setString(5, cart_opt_price);
	                  
	                  n = pstmt.executeUpdate();
	                
	             }
	         
	         
	      } finally {
	         
	      }
	      return n;
	   }// end of public int addCart(String userid, int pnum, String cart_opt_info, String cart_qty, String cart_opt_price) throws SQLException-------
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   // 로그인 아이디로 장바구니 목록 얻어오기
	   @Override
	   public List<ProductCartVO> getCartList(String userid) throws SQLException {
	      
	      List<ProductCartVO> listcvo= null;
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = "  select P.pname, P.pimage1,  replace(p.saleprice,',','') AS saleprice, C.cartno, C.cart_opt_info , C.cart_opt_price, replace(p.saleprice,',','') + C.cart_opt_price AS saleprice_optprice, C.fk_userid, C.cart_qty, P.pnum  "+
	                   " from tbl_product P join tbl_cart C "+
	                   " on P.pnum = C.fk_pnum "+
	                   " where fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         int cnt = 0;
	         while(rs.next()) {
	            
	            cnt++;
	            
	            if(cnt==1) {
	               listcvo = new ArrayList<>();
	            }
	            
	            ProductRealVO prvo = new ProductRealVO();
	            prvo.setPname(rs.getString(1));
	            prvo.setPimage1(rs.getString(2));
	            prvo.setSaleprice(rs.getString(3));
	            prvo.setPnum(rs.getInt(10));
	            
	            int saleprice_optprice = rs.getInt(7);
	            int cart_qty = rs.getInt(9);
	            
	            prvo.setTotalPrice_TotalJukrib(cart_qty,saleprice_optprice);  // 수량을 넣어주면 productrealvo에서 판매가와 적립금을 구해준다.
	            
	            ProductCartVO cvo = new ProductCartVO();
	            cvo.setCartno(rs.getInt(4));
	            cvo.setCart_opt_info(rs.getString(5));
	            cvo.setCart_opt_price(rs.getString(6));
	            cvo.setSaleprice_optprice(rs.getInt(7));
	            cvo.setFk_userid(rs.getString(8));
	            cvo.setCart_qty(rs.getInt(9));            
	            cvo.setPrvo(prvo);
	            
	            listcvo.add(cvo);
	            
	            
	            
	         }
	         
	      } finally {
	         close();
	      }
	      
	      return listcvo;
	      
	   }// end of public List<ProductCartVO> getCartList(String userid) throws SQLException---------------------------
	   
	   
	   
	   
	   
	   
	   // 모든 제품 총합 총적립금 구해오기
	   @Override
	   public HashMap<String, String> getTotal_totalprice(String userid) throws SQLException{

	      HashMap<String, String> total_totalprice = new HashMap<>();
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select sum((replace(p.saleprice,',','') + C.cart_opt_price)*cart_qty ),( sum((replace(p.saleprice,',','') + C.cart_opt_price)*cart_qty ))*0.1 "+
	                    " from tbl_product P join tbl_cart C  on P.pnum = C.fk_pnum   "+
	                   " where fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            total_totalprice.put("SUMTOTALPRICE", rs.getString(1));
	            total_totalprice.put("SUMTOTALPOINT", rs.getString(2));
	         }
	         
	         
	         
	      } finally {
	         close();
	      }
	      return total_totalprice;

	   }
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   // 장바구니 테이블에서 특정제품의 주문량 변경시키기
	   @Override
	   public int updateQty(String cartno, String qty) throws SQLException {
	      
	      int n = 0;
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_cart set cart_qty = ? "+
	                   " where cartno= ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, qty);
	         pstmt.setString(2, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;

	      
	   }
	   
	   
	   
	   
	   
	   
	   
	   
	   // 삭제 버튼 클릭시 장바구니 목록에서 삭제
	   @Override
	   public int delCart(String cartno) throws SQLException {
	      
	      int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "+
	                   " where cartno= ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      return n;
	   }
	   
	   
	   
	   
	   
	   
	   // 장바구니 내 모든 상품 삭제
	   @Override
	   public int allDelCart(String userid) throws SQLException {
	      
	      int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "+
	                   " where fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      return n;
	   }
	   
	   
	   
	   
	   
	   //구매내역에 넣어주기
	   @Override
	   public int orderAdd(HashMap<String, Object> paraMap) throws SQLException {

	      int isSuccess = 0; 
	      int n1=0;
	      int n2=0;
	      int n3=0;
	      int n4=0;
	      
	      try {
	         
	         conn=ds.getConnection();
	         
	         conn.setAutoCommit(false); // 수동 커밋
	         
	         
	         
	         String[] pimage1Arr = (String[])paraMap.get("pimage1Arr");
	         String[] pnameArr = (String[])paraMap.get("pnameArr");
	         String[] pnumArr = (String[])paraMap.get("pnumArr");
	         String[] optionArr = (String[])paraMap.get("optionArr");
	         String[] option_priceArr = (String[])paraMap.get("option_priceArr");
	         String[] qtyArr = (String[])paraMap.get("qtyArr");
	         String[] salePriceArr = (String[])paraMap.get("salePriceArr");
	         String[] totalPointArr = (String[])paraMap.get("totalPointArr");
	         String[] totalPriceArr = (String[])paraMap.get("totalPriceArr");
	         
	         String jumun_bunho = (String)paraMap.get("jumun_bunho");
	         String userid = (String)paraMap.get("userid");
	         
	         String cartnojoin = (String)paraMap.get("cartnojoin");
	         
	         int sum_totalpoint = (int)paraMap.get("sum_totalpoint");
	         
	         //1. 구매내역에 인서트
	         int cnt = 0;
	         
	         String sql = "";
	           for(int i=0; i<pnumArr.length; i++) { 
	              
	               sql = "  insert into tbl_buy(fk_pnum  ,fk_userid  ,buy_opt_info  ,buy_qty  ,buy_opt_price  ,buy_pro_price  ,buy_jeokrib_money ,fk_pimage3 ,jumun_bunho)  "+
	                   " values( ?, ?  ,?  ,?  ,?  ,?  ,?  ,? , ?) ";
	               
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setInt(1, Integer.parseInt(pnumArr[i]));
	               pstmt.setString(2, userid);
	               pstmt.setString(3, optionArr[i]);
	               pstmt.setInt(4, Integer.parseInt(qtyArr[i]));
	               pstmt.setInt(5, Integer.parseInt((String)option_priceArr[i])*Integer.parseInt((String)qtyArr[i]));
	               pstmt.setInt(6, Integer.parseInt((String)salePriceArr[i])*Integer.parseInt((String)qtyArr[i]));
	               pstmt.setString(7, totalPointArr[i]);
	               pstmt.setString(8, pimage1Arr[i]);
	               pstmt.setString(9, jumun_bunho);
	               
	               pstmt.executeUpdate();
	                 
	                 cnt++;
	           }// end of for-------------------------
	           
	              if(cnt == pnumArr.length) {
	                 n1=1;
	              }
	              System.out.println("~~~~~확인용 n1 : " + n1);
	              
	              
	           //2. 제품테이블에 구매한 수량만큼 재고 감소
	           if(n1==1) {
	              
	              cnt = 0;
	              for(int i=0; i<pnumArr.length; i++) {
	                 sql = " update tbl_product set pqty = pqty - ? "
	                       + " where pnum = ? ";
	                 
	                 pstmt = conn.prepareStatement(sql);
	                 pstmt.setInt(1, Integer.parseInt(qtyArr[i]));
	                 pstmt.setString(2, pnumArr[i]);
	                 
	                 pstmt.executeUpdate();
	                 
	                 cnt++;
	                 
	              }// end of for--------------------------------
	              
	              if(cnt == pnumArr.length) {
	                 n2=1;
	              }
	              System.out.println("~~~~~확인용 n2 : " + n2);
	              
	           }// end of if(n1==1)-----------------------------------
	           
	           
	           // 3. 장바구니 목록에서 삭제
	           if(paraMap.get("cartnojoin") != null && n2==1) {
	              
	              sql = " delete from tbl_cart "
	                    + " where cartno in("+ cartnojoin +") ";
	              
	              pstmt = conn.prepareStatement(sql);
	              
	              n3 = pstmt.executeUpdate();
	              
	              System.out.println("~~~~~확인용 n3 : " + n3);
	              
	           }// end of if--------------------------
	           
	           
	           //4. point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	           if(n3 > 0) {
	              
	              sql = " update tbl_member set point = point + ? " 
	                      + " where userid = ? ";
	              
	              pstmt = conn.prepareStatement(sql);
	              pstmt.setInt(1, sum_totalpoint);
	              pstmt.setString(2, userid);
	              
	              n4 = pstmt.executeUpdate();
	               
	               System.out.println("~~~~~확인용 n4 : " + n4);
	              
	           }// end of if---------------------------
	           
	        // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	           if(n1*n2*n3*n4 > 0) {
	              
	              conn.commit();
	              
	              conn.setAutoCommit(true);
	              //자동커밋 전환
	              
	              System.out.println("~~~~~확인용 n1*n2*n3*n4*n5 : "+ n1*n2*n3*n4);
	              
	              isSuccess = 1;
	           }
	           
	           
	               
	           
	         
	         
	         
	         
	      } catch(SQLException e) {
	         
	          //  **** SQL 장애 발생시 rollback 하기(rollback) ****
	         conn.rollback();
	         
	         conn.setAutoCommit(true);
	         // 자동커밋 전환
	         
	         isSuccess = 0;
	         System.out.println("SQL문제야!!!!!!!!!!!");
	         
	         
	      } finally {
	         close();
	      }
	      
	      return isSuccess;
	      
	   }// end of public int orderAdd(HashMap<String, Object> paraMap) throws SQLException-------------------------------------
	   
	   
	   
	   
	   
	   
	   
	   //선택한 상품 삭제하기
	   @Override
	   public int selectDelCart(String cartnojoin) throws SQLException {

	      int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_cart "+
	                   " where cartno in("+ cartnojoin +")  ";
	         
	         pstmt = conn.prepareStatement(sql);         
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      return n;
	      
	   }
	// 박성현 - 문의사항 작성용 메소드
			// 제품번호와 제품명을 가져온다.
			@Override
			public List<ProductRealVO> getProdInfo() throws SQLException {
				
				List<ProductRealVO> pvoList = new ArrayList<>();
				
				try {
					
					conn = ds.getConnection();
					
					String sql = " select pnum, pname " + 
							     " from tbl_product "
							   + " order by fk_cnum ";
					
					pstmt = conn.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						
						ProductRealVO pvo = new ProductRealVO();
						
						pvo.setPnum(rs.getInt(1));
						pvo.setPname(rs.getString(2));
						
						pvoList.add(pvo);
						
					}
					
				} finally {
					close();
				}
				
				
				return pvoList;
			}// end of public List<ProductRealVO> getProdInfo()------------------------------------------------
			
			
			// 박성현 - 주문내역 조회용 메소드
			// 모든 회원들의 주문내역을 조회해온다.
			@Override
			public List<Map<String, String>> selectAllOrderList(int currentShowPageNo, int sizePerPage) throws SQLException {
				
				List<Map<String, String>> orderList = null;
				
				try {
					
					conn = ds.getConnection();
					
					String sql = " select jumun_bunho, pname, pnum, fk_userid, buy_pro_price, buy_opt_price, buy_pro_price + buy_opt_price AS saleprice, trunc(buy_jeokrib_money) AS buy_jeokrib_money , to_char(buy_date, 'yyyy-mm-dd hh24:mi') AS buy_date, baesong_sangtae, fk_pimage3 "+
		                      " from "+
		                      " (     "+
		                      "     select jumun_bunho, pname, pnum, fk_userid, buy_pro_price, buy_opt_price, buy_pro_price + buy_opt_price AS saleprice, buy_jeokrib_money, buy_date, baesong_sangtae, fk_pimage3, "+
		                      "     row_number() over (order by buy_date desc) AS RNO  "+
		                      "     from  "+
		                      "     (  "+
		                      "         select fk_pnum, fk_userid, buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, buy_jeokrib_money, buy_date, baesong_sangtae, jumun_bunho, fk_pimage3 "+
		                      "         from tbl_buy "+
		                      "     ) A  "+
		                      "     LEFT JOIN  "+
		                      "     (   "+
		                      "         select pnum, pname  "+
		                      "         from tbl_product  "+
		                      "     ) B  "+
		                      "     on A.fk_pnum = B.pnum "+
		                      " ) T "+
		                      " where rno between ? and ? "
		                      + " order by buy_date desc ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, (currentShowPageNo*sizePerPage)-(sizePerPage-1));
					pstmt.setInt(2, (currentShowPageNo*sizePerPage));
					
					rs = pstmt.executeQuery();
					
					int cnt = 0;
					
					while(rs.next()) {
						cnt++;
						
						if(cnt==1) {
							orderList = new ArrayList<>();
						}
						Map<String, String> map = new HashMap<>();
						
						map.put("jumun_bunho", rs.getString(1));
						map.put("pname", rs.getString(2));
						map.put("pnum", rs.getString(3));
						map.put("fk_userid", rs.getString(4));
						map.put("buy_pro_price", rs.getString(5));
						map.put("buy_opt_price", rs.getString(6));
						map.put("saleprice", rs.getString(7));
						map.put("buy_jeokrib_money", rs.getString(8));
						map.put("buy_date", rs.getString(9));
						map.put("baesong_sangtae", rs.getString(10));
						map.put("fk_pimage3", rs.getString(11));
						
						orderList.add(map);
						
					}// end of while--------------------------------
					
				} finally {
					close();
				}
				
				return orderList;
			}// end of public List<ProductRealVO> selectAllOrderList()---------------------------
			
			
			// 총 주문내역 건수 알아오기
			@Override
			public int getTotalCountOrder() throws SQLException {
				
				int totalCountOrder = 0;
				
				try {
					
					conn = ds.getConnection();
					
					String sql = " select count(*) from tbl_buy ";
					
					pstmt = conn.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					
					rs.next();
					
					totalCountOrder = rs.getInt(1);
					
				} finally {
					close();
				}
				
				
				return totalCountOrder;
			}// end of public int getTotalCountOrder()-----------------------------------
			
			
			// 배송상태 변경시키기
			@Override
			public int changeBaesongStatus(String odrcode, String pnum, String changeStatus) throws SQLException {
				
				int n = 0;
				
				try {
					
					conn = ds.getConnection();
					
					String sql = " update tbl_buy set baesong_sangtae = ?  ";
					
					if("2".equals(changeStatus)) {
						sql += " , buy_finish_date = sysdate ";
					}
					
						sql+=    " where jumun_bunho = ? and fk_pnum = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(changeStatus));
					pstmt.setString(2, odrcode);
					pstmt.setInt(3, Integer.parseInt(pnum));
					
					n = pstmt.executeUpdate();
					
				} finally {
					close();
				}
				
				return n;
			}// end of public int changeBaesongStatus(String odrcode, String pnum, String changeStatus) -------------------
}

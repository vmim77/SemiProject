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
	//	// 리뷰를 작성안한 내 구매내역을 가져오기
	//	@Override
	//	public List<ProductBuyVO> SelectMyBought(String userid, String product_name)  throws SQLException{
	//		
	//		List<ProductBuyVO> buyList = new ArrayList<>();
	//		
	//		try {
	//			
	//			conn = ds.getConnection();
	//			
	//			// 구매날짜 14일 안으로만 리뷰작성이 가능케 하도록 함
	//			String sql = " select buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, jumun_bunho, baesong_sangtae, fk_pimage3 "+
	//					     " from tbl_buy "+
	//					     " where fk_userid = ? and fk_pnum = (select pnum "+
	//					     "                                    from tbl_product "+
	//					     "                                    where pname = ?) "+
	//					     " and review_check = 0 and sysdate - buy_date between 0 and 14 ";
	//			
	//			pstmt = conn.prepareStatement(sql);
	//			pstmt.setString(1, userid);
	//			pstmt.setString(2, product_name);
	//			
	//			rs = pstmt.executeQuery();
	//			
	//			while(rs.next()) {
	//				
	//				ProductBuyVO pbvo = new ProductBuyVO();
	//				
	//				pbvo.setBuy_opt_info(rs.getString(1));
	//				pbvo.setBuy_qty(rs.getInt(2));
	//				pbvo.setBuy_opt_price(rs.getString(3));
	//				pbvo.setBuy_pro_price(rs.getString(4));
	//				pbvo.setJumun_bunho(rs.getString(5));
	//				pbvo.setBaesong_sangtae(rs.getInt(6));
	//				pbvo.setFk_pimage3(rs.getString(7));
	//				
	//				buyList.add(pbvo);
	//				
	//			}//end of while(rs.next()) {-------------------------
	//
	//		} finally {
	//			close();
	//		}
	//		
	//		return buyList;
	//		
	//	}//end of public ProductRealVO SelectMyBought(String userid, String product_name)  throws SQLException{
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
	   public List<ProductBuyVO> SelectMyBought(String jumun_bunho)  throws SQLException{
	      
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
	
	
	
		// 나의 주문목록을 받아온다.
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
		}// end of public List<ProductBuyVO> myorder(String userid)------------------------------
	
	
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
		}// end of public int SelectMyBuyMoney(String userid)---------------------------------------
	
	
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
		      
		}// end of public List<ProductBuyVO> SelectJumun(String jumun_bunho)----------------------------
	
	
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
				
				
				String sql = " select jumun_bunho, pname, pnum, fk_userid, buy_pro_price, buy_opt_price, buy_pro_price + buy_opt_price AS saleprice, buy_jeokrib_money, buy_date, baesong_sangtae, fk_pimage3 "+
							 " from "+
							 " (     "+
							 "     select jumun_bunho, pname, pnum, fk_userid, buy_pro_price, buy_opt_price, buy_pro_price + buy_opt_price AS saleprice, buy_jeokrib_money, buy_date, baesong_sangtae, fk_pimage3, "+
							 "     rownum AS RNO  "+
							 "     from  "+
							 "     (  "+
							 "         select fk_pnum, fk_userid, buy_opt_info, buy_qty, buy_opt_price, buy_pro_price, buy_jeokrib_money, buy_date, baesong_sangtae, jumun_bunho, fk_pimage3 "+
							 "         from tbl_buy "+
							 "     ) A  "+
							 "     JOIN  "+
							 "     (   "+
							 "         select pnum, pname  "+
							 "         from tbl_product  "+
							 "     ) B  "+
							 "     on A.fk_pnum = B.pnum "+
							 " ) T "+
							 " where rno between ? and ?"
						+    " order by buy_date desc ";
				
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
		
		
	
	
	
//=====================================================================================	
}

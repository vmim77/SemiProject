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
		
	}//end of public ProductRealVO SelectMyBought(String userid, String product_name)  throws SQLException
	
	
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
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//=====================================================================================	
}

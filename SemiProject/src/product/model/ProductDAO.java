package product.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.*;

public class ProductDAO implements InterProductDAO {
//=====================================================================================
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	private AES256 aes;
//=====================================================================================
	// 기본생성자
	public ProductDAO() {
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
	//동그라미 사진 클릭하면 해당 상품 리스트 가져오기
	@Override
	public List<ProductVO> productimgList(String product_name) throws SQLException {
		
		List<ProductVO> productimgList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select * "+
					      " from tbl_product_"+product_name;
			
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 
				 ProductVO provo = new ProductVO();
				 
				 provo.setProduct_name(rs.getString(1));
				 provo.setProduct_front_p1(rs.getString(2));
				 provo.setProduct_back_p2(rs.getString(3));
				 provo.setProduct_price(rs.getString(4));
				 provo.setProduct_ceil_price(rs.getString(5));
				 provo.setProduct_first_p(rs.getString(6));
				 provo.setProduct_second_p(rs.getString(7));
				 productimgList.add(provo);
				 
			 }// end of while--------------------------
			
		} finally {
			close();
		}
		
		return productimgList;
		
	}// end of public List<ProductVO> productimgList(String dubby) throws SQLException--------------------
//=====================================================================================
	// 모든 제품 사진 가져오기
	@Override
	public List<ProductVO> allProductimgList() throws SQLException {
		
		List<ProductVO> allProductimgList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			 
			String sql = " select* "+
						" from tbl_product_dubby "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_mul "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_boots "+
						" UNION ALL"+
						" select*"+
						" from tbl_product_loper "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_oxpode "+
						" UNION ALL "+
						" select * "+
						" from tbl_product_mongk "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_sandle ";
			
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 
				 ProductVO provo = new ProductVO();
				 
				 provo.setProduct_name(rs.getString(1));
				 provo.setProduct_front_p1(rs.getString(2));
				 provo.setProduct_back_p2(rs.getString(3));
				 provo.setProduct_price(rs.getString(4));
				 provo.setProduct_ceil_price(rs.getString(5));
				 provo.setProduct_first_p(rs.getString(6));
				 provo.setProduct_second_p(rs.getString(7));
				 
				 allProductimgList.add(provo);
				 
			 }// end of while--------------------------
			
		} finally {
			close();
		} 
		
		
		return allProductimgList;
	}// end of public List<ProductVO> allProductimgList() throws SQLException -----------------------------------------
//=====================================================================================
	//퀵뷰에 나타내기 위한 상품 한개 가져오기
	@Override
	public ProductVO quickViewProduct(String quickProductName) throws SQLException {
		
		ProductVO quickViewProduct = new ProductVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select * "+
						" from "+
						" ( "+
						" select* "+
						" from tbl_product_dubby "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_mul "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_boots "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_loper "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_oxpode "+
						" UNION ALL "+
						" select * "+
						" from tbl_product_mongk "+
						" UNION ALL "+
						" select* "+
						" from tbl_product_sandle "+
						" ) V "+
						" where product_name = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, quickProductName);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				quickViewProduct.setProduct_name(rs.getString(1));
				quickViewProduct.setProduct_front_p1(rs.getString(2));
				quickViewProduct.setProduct_back_p2(rs.getString(3));
				quickViewProduct.setProduct_price(rs.getString(4));
				quickViewProduct.setProduct_ceil_price(rs.getString(5));
				quickViewProduct.setProduct_first_p(rs.getString(6));
				quickViewProduct.setProduct_second_p(rs.getString(7));
				
			}
			
		} finally {
			close();
		}
		
		return quickViewProduct;
	}
//=====================================================================================
	@Override
	public ProductVO getOneProduct(String product_name) throws SQLException {
   
		ProductVO getOneProduct = new ProductVO();
	
		try {
		  	         
			conn = ds.getConnection();
		         		        	         
			String sql = " select * "+
		                   " from "+
		                   " ( "+
		                   " select* "+
		                   " from tbl_product_dubby "+
		                   " UNION ALL "+
		                   " select* "+
		                   " from tbl_product_mul "+
		                   " UNION ALL "+
		                   " select* "+
		                   " from tbl_product_boots "+
		                   " UNION ALL "+
		                   " select* "+
		                   " from tbl_product_loper "+
		                   " UNION ALL "+
		                   " select* "+
		                   " from tbl_product_oxpode "+
		                   " UNION ALL "+
		                   " select * "+
		                   " from tbl_product_mongk "+
		                   " UNION ALL "+
		                   " select* "+
		                   " from tbl_product_sandle "+
		                   " ) V "+
		                   " where product_name = ? ";
		         	          
			pstmt = conn.prepareStatement(sql);          
			pstmt.setString(1, product_name);	          	          
			rs = pstmt.executeQuery();
			
		          	          
			if(rs.next()) {
		               		             
				getOneProduct.setProduct_name(rs.getString(1));	             
				getOneProduct.setProduct_front_p1(rs.getString(2));		             		             
				getOneProduct.setProduct_back_p2(rs.getString(3));		             
				getOneProduct.setProduct_price(rs.getString(4));		            
				getOneProduct.setProduct_ceil_price(rs.getString(5));		             
				getOneProduct.setProduct_first_p(rs.getString(6));		             
				getOneProduct.setProduct_second_p(rs.getString(7));
		            
			}
		      
		} finally {
			close();
		}
		        
		return getOneProduct;
		
	}//end of public Map<String, String> getOneProduct(String product_name) throws SQLException {
//=====================================================================================
	// 출석체크이벤트
	@Override
	public Map<String, String> choolcheckevent() throws SQLException {
		
		// 값 담아줄 용도
		Map<String, String> paraMap = new HashMap<>();
		
		// 지역변수 방지
		String choolcheckday = "";
		String startday = "";
		String year = "";
		String month = "";
		String day = "";
		
		try {
 	         
			conn = ds.getConnection();
			////////////////////////////////////////////////////////////////////////
			// 출첵했는지 확인용도
			String sql = " select daynum "+
					     " from choolcheck_test ";   	          
			pstmt = conn.prepareStatement(sql);          
			rs = pstmt.executeQuery();  	          
			while(rs.next()) {
				choolcheckday += rs.getString(1) + ",";	 
			}
		    ////////////////////////////////////////////////////////////////////////
			// 이번달 시작 날짜
			sql = " select to_char(last_day(add_months(sysdate,-1))+1,'d') "+
			      " from dual ";   	          
			pstmt = conn.prepareStatement(sql);          
			rs = pstmt.executeQuery();  	          
			if(rs.next()) {
				startday = rs.getString(1);	                     
			}
			////////////////////////////////////////////////////////////////////////
			// 이번 년도
			sql = " select to_char(sysdate,'yyyy-mm-dd') "+
				  " from dual ";	          
			pstmt = conn.prepareStatement(sql);          
			rs = pstmt.executeQuery();  	          
			if(rs.next()) {
				year = rs.getString(1).substring(2, 4);
				month = rs.getString(1).substring(5, 7);
				day = rs.getString(1).substring(8, 10);
			}
			////////////////////////////////////////////////////////////////////////
			paraMap.put("startday", startday);
			paraMap.put("year", year);
			paraMap.put("month", month);
			paraMap.put("day", day);
			paraMap.put("choolcheckday", choolcheckday);
		} finally {
			close();
		}
		
		return paraMap;
		
	}
//=====================================================================================
	// 출석도장 저장
	@Override
	public void Savemycheck(String savemycheck) throws SQLException {
		
		try {
	         
			conn = ds.getConnection();
	
			String sql = " insert into choolcheck_test(daynum) values('"+savemycheck+"') ";          
			pstmt = conn.prepareStatement(sql);          
			pstmt.executeUpdate();  	          
		    
		} finally {
			close();
		}
		
	}//end of public void Savemycheck() throws SQLException {
//=====================================================================================	
	// 배송조회하기
	@Override
	public List<ProductDAO> myorder(String userid) throws SQLException {
		
		List<ProductDAO> pdao = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			 
			 String sql = "";
			 
			
			
		} finally {
			close();
		}
		
		
		return pdao;
	}
}

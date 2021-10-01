package product.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	
	
	
	// 기본생성자
		public ProductDAO() {
			try {
				Context initContext = new InitialContext();
			    Context envContext  = (Context)initContext.lookup("java:/comp/env");
			    ds = (DataSource)envContext.lookup("jdbc/semioracle");
			    
			
					aes = new AES256(SecretMyKey.KEY);
					 // SecretMyKey 우리가 만든 비밀 키이다.
				
			   
			    
			} catch(NamingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				
				e.printStackTrace();
			}
		}
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
			
			

	//동그라미 사진 클릭하면 해당 상품 리스트 가져오기
	@Override
	public List<ProductVO> productimgList(String dubby) throws SQLException {
		
		List<ProductVO> productimgList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select * "+
					 " from tbl_product_"+dubby;
			
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

}

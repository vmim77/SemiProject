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

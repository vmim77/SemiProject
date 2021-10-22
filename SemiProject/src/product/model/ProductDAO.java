package product.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import product.realmodel.ProductRealVO;
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
                          " from tbl_product_"+product_name+" order by product_ceil_price desc ";
			
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
			 
			String sql = " select * "+
	                  " from "+
	                  " ( "+
	                  "    select*  "+
	                  "     from tbl_product_dubby  "+
	                  "     UNION  "+
	                  "     select*  "+
	                  "     from tbl_product_mul  "+
	                  "     UNION   "+
	                  "     select*  "+
	                  "     from tbl_product_boots  "+
	                  "     UNION  "+
	                  "     select* "+
	                  "     from tbl_product_loper  "+
	                  "     UNION   "+
	                  "     select* "+
	                  "     from tbl_product_oxpode  "+
	                  "     UNION   "+
	                  "     select *  "+
	                  "     from tbl_product_mongk  "+
	                  "     UNION   "+
	                  "     select*  "+
	                  "     from tbl_product_sandle )V "+
	                  "     order by product_ceil_price desc ";
			
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
	public Map<String, String> choolcheckevent(String userid) throws SQLException {
		
		// 값 담아줄 용도
		Map<String, String> paraMap = new HashMap<>();
		
		// 지역변수 방지
		String choolcheckday = "";
		String startday = "";
		String year = "";
		String month = "";
		String day = "";
		int cnt = 0;
		
		try {
 	         
			conn = ds.getConnection();
			////////////////////////////////////////////////////////////////////////
			// 출첵했는지 확인용도
			String sql = " select daynum "
					    +" from tbl_chk_"+userid;
			pstmt = conn.prepareStatement(sql);          
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt++;
			}
			// 만약 처음 가입해서 처음 들어가는거라면 당연히 테이블에 값이 없다
			// 따라서 오늘 날짜를 넣어주겠다
			if(cnt==0) {
				//////////////////////////////////////////////////
				sql = " insert into tbl_chk_"+userid+"(daynum) "+
					  " values( to_char(sysdate,'dd')*1) ";
				// 매우중요
				// 위처럼 'dd' 형식으로 넣으면 01 02 와 같이 숫자앞에 0 이 붙기 때문에
				// *1 을 해서 한자리수로 만들어준다
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				//////////////////////////////////////////////////
				// 그 후 select 로 값 뽑아주기
				sql = " select daynum "
					 +" from tbl_chk_"+userid;
				pstmt = conn.prepareStatement(sql);          
				rs = pstmt.executeQuery();
				while(rs.next()) {
					choolcheckday += rs.getString(1) + ",";
				}
				///////////////////////////////////////////////////
			}
			else {
				
				// 출첵했는지 확인용도
				sql = " select daynum "
				     +" from tbl_chk_"+userid
				     +" order by to_number(daynum) ";
				pstmt = conn.prepareStatement(sql);          
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					choolcheckday += rs.getString(1) + ",";
				}
				
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
	public int Savemycheck(String savemycheck, String userid) throws SQLException {
		
		//넘겨줄 결과값
		int result = 0;
		// 중복된 값이 있는지 확인하기
		int cnt = 0;
		// point 넣어주기 위한 내용
		int pointcnt = 0;
		
		try {
	        
			conn = ds.getConnection();
			// 값 업데이트 하기
			String sql = " insert into tbl_chk_"+userid+"(daynum) values('"+savemycheck+"') ";          
			pstmt = conn.prepareStatement(sql);          
			pstmt.executeUpdate();
			
			//////////////////////////////////////////////////////////////////////////
			
			// 혹시나 같은 값이 들어갔는지 확인해야한다
			// 그 말은 다음달이 되었냐 라는 말과 같다
			sql = " select daynum "+
				  " from tbl_chk_"+userid+
				  " where daynum = ? ";
		
			pstmt = conn.prepareStatement(sql);          
			pstmt.setString(1, savemycheck);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cnt++;
			}
			
			// 같은 값이 있냐 없냐
			if(cnt>=2) {
				
				// 만약에 똑같은 값이 있다면
				// 전체테이블을 지워준다
				sql = " delete tbl_chk_"+userid+
				      " where length(daynum)>0 ";
				pstmt = conn.prepareStatement(sql);          	          	          
				pstmt.executeUpdate();
				
				// 그 후 다시 넣어준다
				sql = " insert into tbl_chk_"+userid+"(daynum) values('"+savemycheck+"') ";          
				pstmt = conn.prepareStatement(sql);          
				pstmt.executeUpdate();
				
			}
			// 없으면 그냥 인서트 하고 끝이다.
			
			///////////////////////////////////////////////////////////////////////////
			
			// 단계 날짜 별 포인트 지급을 위해 검색
			sql = " select daynum "+
				  " from tbl_chk_"+userid;
				
			pstmt = conn.prepareStatement(sql);          
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// 몇일이나 출석했는지 확인하는 카운트
				pointcnt++;
			}
			
			// 해당유저의 포인트를 먼저 찾는다
			sql = " select point "+
			      " from tbl_member "+
			      " where userid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			int userpoint = 0;
			if(rs.next()) {
				userpoint = rs.getInt(1);
			}
			
			// 5,10..25 일차 마다 포인트를 지급해준다
			for(int i=5; i<=25; i+=5) {
				
				// 5,10..25 일차이라면
				if(i==pointcnt) {
					// 포인트 지급
					result = i*200; 
					// 포인트 업데이트 하기
					sql = " update tbl_member set point = ? "+
						  " where userid = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, userpoint + result);
					pstmt.setString(2, userid);
					pstmt.executeUpdate();
					
				}//end of if(i==pointcnt) {
				
			}//end of for(int i=5; i<=25; i+=5) {
			
			/////////////////////////////////////////////////////////////////
			
		} finally {
			close();
		}
		
		return result;
		
	}//end of public void Savemycheck() throws SQLException {
//=====================================================================================	
   // ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //
   @Override
   public List<Map<String, String>> getCategoryList() throws SQLException {
      List<Map<String, String>> categoryList = new ArrayList<>();
      
      try {
         
         conn = ds.getConnection();
         
         String sql = " select cnum, code, cname " + 
                    " from tbl_category " + 
                   " order by cnum asc ";
         
         pstmt = conn.prepareStatement(sql);
         
         rs = pstmt.executeQuery();
         
         while(rs.next()) {

            Map<String, String> map = new HashMap<>();
            
            map.put("cnum", rs.getString(1));
            map.put("code", rs.getString(2));
            map.put("cname", rs.getString(3));
            
            categoryList.add(map);
            
         }// end of while(rs.next()) -----------------------------
         
      } finally {
         close();
      }
      
      return categoryList;
      
   }
   
   
   //=====================================================================================   
   
   
   // 제품번호 채번 해오기
   @Override
   public int getPnumOfProduct() throws SQLException {
      
      int pnum = 0;
         
         try {
             conn = ds.getConnection();
             
             String sql = " select seq_tbl_product_pnum.nextval AS PNUM " +
                        " from dual ";
                     
             pstmt = conn.prepareStatement(sql);
             rs = pstmt.executeQuery();
                       
             rs.next();
             pnum = rs.getInt(1);
         
         } finally {
            close();
         }
         
         return pnum;
   }
   
   
   //=====================================================================================      
   
   
   
   
   //tbl_product 테이블에 제품정보 insert 하기   
   @Override
   public int productInsert(ProductRealVO prvo) throws SQLException {
      
      int result = 0;
         
         try {
            conn = ds.getConnection();
            
            String sql = " insert into tbl_product(pnum, pname, fk_cnum,  pimage1, pimage2, pimage3, pimage4, pqty, price, saleprice ) " +  
                       " values(?,?,?,?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, prvo.getPnum());
            pstmt.setString(2, prvo.getPname());
            pstmt.setInt(3, prvo.getFk_cnum());
            pstmt.setString(4, prvo.getPimage1());    
            pstmt.setString(5, prvo.getPimage2());
            pstmt.setString(6, prvo.getPimage3());    
            pstmt.setString(7, prvo.getPimage4());
            pstmt.setInt(8, prvo.getPqty()); 
            pstmt.setString(9, prvo.getPrice());
            pstmt.setString(10, prvo.getSaleprice());

               
            result = pstmt.executeUpdate();
            
         } finally {
            close();
         }
         
         return result;
      
   }// end of public int productInsert(ProductRealVO prvo) throws SQLException------------------------
//=====================================================================================   
   // 카테고리 이름 알아오기
   @Override
   public String getCname(String fk_cnum) throws SQLException {
      
      String getcname = "";
      
      try {
         
         conn = ds.getConnection();
         
         String sql = " select cname "+
               " from tbl_category "+
               " where cnum = ? ";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, fk_cnum);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            getcname = rs.getString(1);
         }
         
      } finally {
         close();
      }
      
      return getcname;
   }// end of public String getCname(String fk_cnum) throws SQLException -----------------------------------
//========================================================================================
 //나눠진 제품 테이블에서 insert 하기
   @Override
   public int selectproductInsert(ProductRealVO prvo, String cname) throws SQLException{
      
      
        int result = 0;
         
         try {
            conn = ds.getConnection();
            
            String sql = " insert into tbl_product_"+cname+"(PRODUCT_NAME , PRODUCT_FRONT_P1 , PRODUCT_BACK_P2 ,  PRODUCT_PRICE , PRODUCT_CEIL_PRICE , PRODUCT_FIRST_P , PRODUCT_SECOND_P) " +  
                       " values(?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, prvo.getPname());
            pstmt.setString(2, prvo.getPimage1());   
            pstmt.setString(3, prvo.getPimage2());
            pstmt.setString(4, prvo.getPrice());
            pstmt.setString(5, prvo.getSaleprice());
            pstmt.setString(6, prvo.getPimage3());    
            pstmt.setString(7, prvo.getPimage4());

               
            result = pstmt.executeUpdate();
            
         } finally {
            close();
         }
         
         return result;
   }
//=========================================================================================   
}

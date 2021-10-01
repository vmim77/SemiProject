package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {

		private DataSource ds;// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		private AES256 aes;
		
		// 기본생성자
		public MemberDAO() {
			try {
				Context initContext = new InitialContext();
			    Context envContext  = (Context)initContext.lookup("java:/comp/env");
			    ds = (DataSource)envContext.lookup("jdbc/semioracle"); //web.xml => ref에 값과 동일해야한다.
			    
			    aes = new AES256(SecretMyKey.KEY);
			    // SecretMyKey.KEY 는 우리가 만든 비밀키이다.
			} catch (NamingException e) { //NamingException
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
		
		// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)  
		@Override
		public boolean idDuplicateCheck(String userid) throws SQLException {
			
			boolean isExists = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select userid "
						   + " from tbl_member "
						   + " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				
				rs = pstmt.executeQuery();
				
				isExists = rs.next(); // 행이 있으면 (중복된 userid) true,
									  // 행이 없으면 (사용가능한 userid) false
				
				
			} finally {
				close();
			}
			
		
			return isExists;
		}// end of public boolean idDuplicateCheck(String userid) throws SQLException

		
		// email 중복검사 (tbl_member 테이블에서 email 가 존재하면 true를 리턴해주고, email 가 존재하지 않으면 false를 리턴한다)
		@Override
		public boolean emailDuplicateCheck(String email) throws SQLException {
		
			boolean isExists = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select email "
						   + " from tbl_member "
						   + " where email = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, aes.encrypt(email)); // "seokj@gmail.com" ==> aes.encrypt("seokj@gmail.com") ==> 암호화되서 나온다.
				// 여기서 나오는 이메일은 @포함한 이메일이지만 sql에서는 그렇게 나오지않는다 그러므로
				// 암호화시켜서 넘겨야 한다.
				rs = pstmt.executeQuery();
				
				isExists = rs.next(); // 행이 있으면 (중복된 email) true,
									  // 행이 없으면 (사용가능한 email) false
				
			} catch (GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
		
			return isExists;
			
		}// end of public boolean emailDuplicateCheck(String email) throws SQLException

		
		
		
		// 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
		@Override
		public int registerMember(MemberVO member) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, referral) "     
		                  	+" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "; 
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member.getUserid());
				pstmt.setString(2, Sha256.encrypt( member.getPwd()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
				pstmt.setString(3, member.getName());
				pstmt.setString(4, aes.encrypt(member.getEmail())); // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
				pstmt.setString(5, aes.encrypt(member.getMobile()));// 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
				pstmt.setString(6, member.getPostcode());
		        pstmt.setString(7, member.getAddress());
		        pstmt.setString(8, member.getDetailaddress());
		        pstmt.setString(9, member.getExtraaddress());
		        pstmt.setString(10, member.getGender());
		        pstmt.setString(11, member.getBirthday());
		        pstmt.setString(12, member.getReferral());
		        
		        n = pstmt.executeUpdate();
				
			} catch (GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return n;
		}// end of public int registerMember(MemberVO member) throws SQLException ===================================================

		// 입력받은 paraMap 을 가지고 한 명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
		   @Override
		   public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		      
		      MemberVO member = null;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = "SELECT userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
		                  "      , birthyyyy, birthmm, birthdd, referral, point, registerday, pwdchangegap "+
		                  "      , NVL(lastlogingap, trunc(months_between(sysdate, registerday)) ) AS lastlogingap "+
		                  " FROM  "+
		                  " ( "+
		                  "    select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
		                  "         , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
		                  "         , referral, point, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
		                  "         , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap "+
		                  "    from tbl_member "+
		                  "    where status = 1 and userid = ? and pwd = ? "+
		                  " ) M "+
		                  " CROSS JOIN "+
		                  " ( "+
		                  "    select trunc( months_between(sysdate, max(logindate) ) ) AS lastlogingap "+
		                  "    from tbl_loginhistory "+
		                  "    where fk_userid = ? "+
		                  " ) H";
		         
		         pstmt = conn.prepareStatement(sql);
		         
		         pstmt.setString(1, paraMap.get("userid"));
		         pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) );
		         pstmt.setString(3, paraMap.get("userid"));
		         
		         rs = pstmt.executeQuery();
		         
		         if(rs.next()) {
		            member = new MemberVO();
		            
		            member.setUserid(rs.getString(1));
		            member.setName(rs.getString(2));
		            member.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화 
		            member.setMobile( aes.decrypt(rs.getString(4)) ); // 복호화 
		            member.setPostcode(rs.getString(5));
		            member.setAddress(rs.getString(6));
		            member.setDetailaddress(rs.getString(7));
		            member.setExtraaddress(rs.getString(8));
		            member.setGender(rs.getString(9));
		            member.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
		            member.setReferral(rs.getString(13));
		            member.setPoint(rs.getInt(14));
		            member.setRegisterday(rs.getString(15));
		            
		            if(rs.getInt(16) >= 3) {
		               // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
		               // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
		               
		               member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다.
		            }
		            
		            if(rs.getInt(17) >= 12) {
		               // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
		               member.setIdle(1);
		               
		               // === tbl_member 테이블의 idle 컬럼의 값을 1 로 변경 하기 === //
		               sql = " update tbl_member set idle = 1 "
		                  + " where userid = ? ";
		               
		               pstmt = conn.prepareStatement(sql);
		               pstmt.setString(1, paraMap.get("userid"));
		               
		               pstmt.executeUpdate();
		            }
		            
		            // === tbl_loginhistory(로그인기록) 테이블에 insert 하기 === //
		            if(member.getIdle() != 1) {
		               
		               sql = " insert into tbl_loginhistory(fk_userid, clientip) "
		                  + " values(?, ?) ";
		               
		               pstmt = conn.prepareStatement(sql);
		               pstmt.setString(1, paraMap.get("userid"));
		               pstmt.setString(2, paraMap.get("clientip"));
		               
		               pstmt.executeUpdate();
		            }
		            
		         }
		         
		      } catch(GeneralSecurityException | UnsupportedEncodingException e) {   
		         e.printStackTrace();
		      } finally {
		         close();
		      }
		      
		      return member;
		   }// end of public MemberVO selectOneMember(Map<String, String> paraMap)---------------------

		   
		// 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)   
		@Override
		public String findUserid(Map<String, String> paraMap) throws SQLException {
			
			String userid = null;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select userid "
						   + " from tbl_member "
						   + " where status = 1 and name = ? and email = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,paraMap.get("name") );
				pstmt.setString(2,aes.encrypt(paraMap.get("email")) );
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					userid = rs.getString(1);
				}
				
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
		         e.printStackTrace();	
			} finally {
				close();
			}
			
			return userid;
		}//end of public String findUserid(Map<String, String> paraMap)

		
		// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당 사용자의 비밀번호를 알려준다)
		@Override
		public boolean isUserExist(Map<String, String> paraMap) throws SQLException {
			
			boolean isUserExist = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select userid "
						   + " from tbl_member "
						   + " where status = 1 and userid = ? and email = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,paraMap.get("userid") );
				pstmt.setString(2,aes.encrypt(paraMap.get("email")) );
				
				rs = pstmt.executeQuery();
				
				isUserExist = rs.next(); // 존재하면 true 없으면 false
				
				
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
		         e.printStackTrace();	
			} finally {
				close();
			}
			
			
			return isUserExist;
		}// end of public boolean isUserExist(Map<String, String> paraMap)

		
		// 암호 변경하기
		@Override
		public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_member set pwd = ? "
						   + " 					   , lastpwdchangedate = sysdate "
						   + " where userid = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,Sha256.encrypt(paraMap.get("pwd"))); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
				pstmt.setString(2,paraMap.get("userid"));
				
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
		}// end of public int pwdUpdate(Map<String, String> paraMap) ------------------------------------------------

		
		// DB에 코인 및 포인트 증가하기
		@Override
		public int coinUpdate(Map<String, String> paraMap) throws SQLException {

			int n = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " update tbl_member set coin = coin + ? "
						   + " 					   , point = point + ? "
						   + " where userid = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,paraMap.get("coinmoney"));  
				pstmt.setInt(2, (int)(Integer.parseInt(paraMap.get("coinmoney"))  *0.01) );  
				pstmt.setString(3,paraMap.get("userid"));
				
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
		}// end of public int coinUpdate(Map<String, String> paraMap)==================================================

		
		// 전체회원을 조회한 후에 반복문으로 VO 객체를 생성해서 각각의 정보를 넣어서 가져옵니다. 
		@Override
		public List<MemberVO> selectAllUser() throws SQLException {


			List<MemberVO> mbrList = new ArrayList<>(); // 회원이 없다면 길이가 0인 리스트를 반환합니다.
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select userid "+
							 " , name "+
							 " , gender "+
							 " , registerday "+
							 " , status "+
							 " , idle "+
							 " from tbl_member "+
							 " order by registerday asc ";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					MemberVO member = new MemberVO();
					
					member.setUserid(rs.getString(1));
					member.setName(rs.getString(2));
					member.setGender(rs.getString(3));
					member.setRegisterday(rs.getString(4));
					member.setStatus(rs.getInt(5));
					member.setIdle(rs.getInt(6));
					
					
					mbrList.add(member);
					
				}// end of while()-----------------------
				
				
			} finally {
				close(); // 자원반납
			}
			
			return mbrList; // 회원이 없다면 길이가 0인 리스트를 반환합니다.
		}// end of public Map<String, MemberVO> selectAllUser()----------------------------------
		
		
		// 특정회원을 조회해옵니다.
		@Override
		public MemberVO selectOneUser(String userid) throws SQLException {
			
			MemberVO member = null;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select userid "+
							 " , name "+
							 " , email "+
							 " , mobile "+
							 " , postcode "+
							 " , address "+
							 " , detailaddress "+
							 " , extraaddress "+
							 " , case gender when '1' then '남자' else '여자' end as gender "+
							 " , birthday "+
							 " , nvl(referral, '추천인 없음') as referral "+
							 " , point "+
							 " , registerday "+
							 " , lastpwdchangedate "+
							 " , status "+
							 " , idle "+
							 " from tbl_member "+
							 " where userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					// System.out.println("멤버찾았다.");
					
					member = new MemberVO();
					
					member.setUserid(rs.getString(1));
					member.setName(rs.getString(2));
					member.setEmail(aes.decrypt(rs.getString(3)));
					member.setMobile(aes.decrypt(rs.getString(4)));
					member.setPostcode(rs.getString(5));
					member.setAddress(rs.getString(6));
					member.setDetailaddress(rs.getString(7));
					member.setExtraaddress(rs.getString(8));
					member.setGender(rs.getString(9));
					member.setBirthday(rs.getString(10));
					member.setReferral(rs.getString(11));
					member.setPoint(rs.getInt(12));
					member.setRegisterday(rs.getString(13));
					member.setLastpwdchangedate(rs.getString(14));
					member.setStatus(rs.getInt(15));
					member.setIdle(rs.getInt(16));
					
				}
				
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
				e.printStackTrace();
			} finally {
				close(); // 자원반납
			}
			
			return member;
		}
		
		// 회원의 개인정보 변경하기
				@Override
				public int updateMember(MemberVO member) throws SQLException {
					
					 int n  = 0;
				      
				      try {
				         conn = ds.getConnection();
				         
				         String sql = " update tbl_member set name  = ? "
				                  + "                     , pwd = ? "
				                  + "                     , email = ? "
				                  + "                     , mobile = ? "
				                  + "                     , postcode = ? "
				                  + "                     , address = ? "
				                  + "                     , detailAddress = ? "
				                  + "                     , extraAddress = ? "
				                  + "                     , lastpwdchangedate = sysdate "
				                      + " where userid = ? ";
				         
				         pstmt = conn.prepareStatement(sql);
				         
				         pstmt.setString(1, member.getName()); 
				           pstmt.setString(2, Sha256.encrypt(member.getPwd()) );
				           pstmt.setString(3, aes.encrypt(member.getEmail()) );
				           pstmt.setString(4, aes.encrypt(member.getMobile()) );
				           pstmt.setString(5, member.getPostcode() );
				           pstmt.setString(6, member.getAddress() );
				           pstmt.setString(7, member.getDetailaddress() );
				           pstmt.setString(8, member.getExtraaddress() );
				           pstmt.setString(9, member.getUserid() );
				         
				         n = pstmt.executeUpdate();
				      
				      } catch(GeneralSecurityException | UnsupportedEncodingException e) {    
				            e.printStackTrace();
				      } finally {
				         close();
				      }
				      
				      return n;
				}
		
		
}

package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;



public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 는 우리가 만든 비밀키이다. 
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}// end of MemberDAO(){}-------------------------------------
		
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}// end of close()--------------------------------------------
	
	
	
	// 전체회원을 조회한 후에 반복문으로 VO 객체를 생성해서 각각의 정보를 넣어서 가져옵니다. 
	@Override
	public List<MemberVO> selectAllUser() throws SQLException {


		List<MemberVO> mbrList = new ArrayList<>(); // 회원이 없다면 길이가 0인 리스트를 반환합니다.
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select userid "+
						 " , name "+
						 " , gender "+
						 " , to_char(registerday, 'yyyy-mm-dd') AS registerday "+
						 " , status "+
						 " , idle "+
						 " from tbl_member "+
						 " order by registerday desc ";
						 
			
						 
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
						 " , to_char(registerday, 'yyyy-mm-dd') AS registerday "+
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
	
	
	


}

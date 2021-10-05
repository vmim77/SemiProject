package comment.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import board.model.BoardVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class CommentDAO implements InterCommentDAO {
	private DataSource ds;// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public CommentDAO() {
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
		
	}// end of public BoardDAO()------------------------------
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}// end of private void close()--------------------------------

	
	
	// 특정 글번호에 대한 댓글들을 모두 가져옵니다.
	@Override
	public List<CommentVO> selectComment(int boardno) throws SQLException {
		
		List<CommentVO> commentList = new ArrayList<>();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_boardno, fk_commenter, comment_content, to_char(registerdate, 'yyyy-mm-dd hh24:mi') AS registerdate "
					+    " from tbl_notice_comment"
					+    " where fk_boardno = ?  "
					+    " order by registerdate asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CommentVO cvo = new CommentVO();
				
				cvo.setFk_boardno(rs.getInt(1));
				cvo.setFk_commenter(rs.getString(2));
				cvo.setComment_content(rs.getString(3));
				cvo.setRegisterdate(rs.getString(4));
				
				commentList.add(cvo);
				
			}
			
			
		} finally {
			close();
		}
		
		
		
		return commentList;
		
	}// end of public List<CommentVO> selectComment(int boardno)--------------------------------
	
	// 댓글쓰기
	@Override
	public int insertComment(Map<String, CommentVO> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)"
					+    " values(?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, paraMap.get("cvo").getFk_boardno());
			pstmt.setString(2, paraMap.get("cvo").getFk_commenter());
			pstmt.setString(3, paraMap.get("cvo").getComment_content());
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int insertComment(Map<String, CommentVO> paraMap)-------------------------------
	
}
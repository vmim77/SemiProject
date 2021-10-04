package board.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class BoardDAO implements InterBoardDAO {
	
	private DataSource ds;// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public BoardDAO() {
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

	
	// 처음으로 공지사항 게시판에 입장시 모든 글목록을 조회해주는 메소드
	@Override
	public List<BoardVO> selectAllNotice() throws SQLException {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_writer, title, content, writetime, viewcnt, CommentCnt "+
						 " from "+
						 " ( "+
						 "     select boardno, fk_writer, title, content, to_char(writetime, 'yyyy-mm-dd hh24:mi') as writetime, viewcnt "+
						 "     from tbl_notice_board "+
						 "     order by boardno desc "+
						 " ) A "+
						 " join "+
						 " (  "+
						 "     select fk_boardno, count(*) AS CommentCnt "+
						 "     from tbl_notice_comment "+
						 "     group by fk_boardno "+
						 " ) B "+
						 " on A.boardno = B.fk_boardno ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				BoardVO bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setContent(rs.getString(4));
				bvo.setWritetime(rs.getString(5));
				bvo.setViewcnt(rs.getInt(6));
				bvo.setCommentCnt(rs.getInt(7));
				
				list.add(bvo);
				
			}// end of while--------------------
			
			
		} finally {
			close();
		}
		
		return list;
	}// end of public List<BoardVO> selectAllNotice()-------------------------------------------
	
	
	// 특정 글을 조회해옵니다.
	@Override
	public BoardVO selectOneNotice(int boardno) throws SQLException {
		
		BoardVO bvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_writer, title, content, "
					+    " to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime "
					+    ", viewcnt "
					   + " from tbl_notice_board "
					   + " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				
				bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setContent(rs.getString(4));
				bvo.setWritetime(rs.getString(5));
				
				
			}// end of while--------------------
			
			
		} finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO selectOneNotice(int boardno)----------------------
	
	
}

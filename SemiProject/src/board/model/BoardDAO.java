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
						 "     select boardno, fk_writer, case when length(title) > 20 then substr(title, 1, 10) || '...' else title end AS title, content, to_char(writetime, 'yyyy-mm-dd hh24:mi') as writetime, viewcnt "+
						 "     from tbl_notice_board "+
						 "     order by boardno desc "+
						 " ) A "+
						 " LEFT JOIN "+
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
	public BoardVO selectOneNotice(String boardno) throws SQLException {
		
		BoardVO bvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_writer, title, content, "
					+    " to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime "
					+    ", viewcnt "
					   + " from tbl_notice_board "
					   + " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(boardno));
			
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				
				bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setContent(rs.getString(4).replace("\r\n","<br>")); // 엔터까지 적용시키기 위해서 개행문자를 <br>로 치환시킨다.
				bvo.setWritetime(rs.getString(5));
				bvo.setViewcnt(rs.getInt(6));
				
				
			}// end of while--------------------
			
			
		} finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO selectOneNotice(int boardno)----------------------
	
	// 공지사항 게시글쓰기
	@Override
	public int writeNotice(Map<String, BoardVO> paraMap) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_notice_board(boardno, fk_writer, title, content)"
					+    " values(seq_tbl_notice.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("bvo").getFk_writer());
			pstmt.setString(2, paraMap.get("bvo").getTitle());
			pstmt.setString(3, paraMap.get("bvo").getContent());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
	}// end of public int insertBoard(Map<String, BoardVO> paraMap)-----------------------------------
	
	
	// 공지사항 게시글 수정하기
	@Override
	public int editNotice(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_notice_board set fk_writer = ?, title = ?, content = ? "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getFk_writer());
			pstmt.setString(2, bvo.getTitle());
			pstmt.setString(3, bvo.getContent());
			pstmt.setInt(4, bvo.getBoardno());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
		
	}// end of public int editBoard(BoardVO bvo) throws SQLException-----------------------------------------------
	
	
	// 공지사항 게시글 삭제하기
	@Override
	public int deleteNotice(int boardno) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_notice_board "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
		
	}// end of public int deleteNotice(int boardno)-----------------------------------
	
	// 해당 글번호의 글을 이 유저가 조회한 적이 있나 없나 확인한다.
	@Override
	public int noticeViewCheck(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select viewcheck "
					+    " from tbl_notice_viewhistory "
					+    " where fk_boardno = ? and fk_userid = ? and to_char(viewdate, 'yy/mm/dd') = ?  ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("boardno"));
			pstmt.setString(2, paraMap.get("userid"));
			pstmt.setString(3, paraMap.get("now"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt(1);
			}
			
			
		} finally {
			close();
		}
		
		
		return n; // 1이면 오늘 보려는 글을 본적이 있는 것이다, 0이면 본적이 없는 것이다.
		
	}// end of public int noticeViewCheck(Map<String, String> paraMap)------------------

	// 오늘 하루동안 해당 공지글을 본 적이 없으니 조회수를 올려준다.
	@Override
	public int updateNoticeViewcnt(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_notice_board set viewcnt = viewcnt + 1 "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("boardno")));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int updateNoticeViewcnt(Map<String, String> paraMap) ------------------------------------
	
	
	// 조회수를 올렸으니, 조회수기록 테이블에 기록을 넣어준다.
	@Override
	public int insertNoticeViewHistory(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_notice_viewhistory(fk_boardno, fk_userid)  "
					+    " values(?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("boardno"));
			pstmt.setString(2, paraMap.get("userid"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int insertNoticeViewHistory(Map<String, String> paraMap)------------------------
	
	// 검색타입과 검색어를 가지고 해당되는 공지사항을 검색한다.
	@Override
	public List<BoardVO> searchNotice(Map<String, String> paraMap) throws SQLException {
		
		List<BoardVO> list = new ArrayList<>();
		
		String colname = paraMap.get("searchType");
		String searchWord = paraMap.get("searchWord");
		
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_writer, title, content, to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime, viewcnt "
					+    " from tbl_notice_board "
					+    " where "+ colname +" like '%' || ? || '%' ";
					
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchWord);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardVO bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setContent(rs.getString(4));
				bvo.setWritetime(rs.getString(5));
				bvo.setViewcnt(rs.getInt(6));
				
				list.add(bvo);
				
			}
			
			
			
			
		} finally {
			close();
		}
		
		
		return list;
	}// end of public List<BoardVO> searchNotice(Map<String, String> paraMap)-------------------------------------

	
	// 마이페이지 게시물 보기
	@Override
	public List<BoardVO> selectmyboard(String userid) throws SQLException {
		
		List<BoardVO> list = new ArrayList<>();
		
		
		 try {
			 conn = ds.getConnection();
			 
			 String sql = " select boardno, fk_writer, title, content,writetime,viewcnt "+
					 	  " from tbl_notice_board "+
					 	  " where fk_writer = ? "+
					 	  " order by boardno desc ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, userid);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 
					BoardVO bvo = new BoardVO();
					
					bvo.setBoardno(rs.getInt(1));
					bvo.setFk_writer(rs.getString(2));
					bvo.setTitle(rs.getString(3));
					bvo.setContent(rs.getString(4));
					bvo.setWritetime(rs.getString(5));
					bvo.setViewcnt(rs.getInt(6));
					
					list.add(bvo);
				 
			 }
			 
		 } finally {
			close();
		}
		 
		
		return list;
	}
	
	
}

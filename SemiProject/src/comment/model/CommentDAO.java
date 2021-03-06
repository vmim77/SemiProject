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
	public List<CommentVO> selectComment(String boardno) throws SQLException {
		
		List<CommentVO> commentList = new ArrayList<>();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select commentno, fk_boardno, fk_commenter, comment_content, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate "
					+    " from tbl_notice_comment"
					+    " where fk_boardno = ?  "
					+    " order by registerdate asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(boardno));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CommentVO cvo = new CommentVO();
				
				cvo.setCommentno(rs.getInt(1));
				cvo.setFk_boardno(rs.getInt(2));
				cvo.setFk_commenter(rs.getString(3));
				cvo.setComment_content(rs.getString(4));
				cvo.setRegisterdate(rs.getString(5));
				
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
			
			String sql = " insert into tbl_notice_comment(commentno, fk_boardno, fk_commenter, comment_content)"
					+    " values(seq_notice_comment.nextval,?, ?, ?) ";
			
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
	
	
	
	// 공지사항 댓글삭제하기
	@Override
	public int deleteNoticeComment(int commentno) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_notice_comment"
					+    " where commentno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, commentno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int deleteNoticeComment(int commentno)---------------------------------
	
	
	// 공지사항 댓글수정하기
	@Override
	public int editNoticeComment(CommentVO cvo) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_notice_comment set comment_content = ? "
					+    " where commentno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cvo.getComment_content());
			pstmt.setInt(2, cvo.getCommentno());
			
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int editNoticeComment(CommentVO cvo)
	
	
	// 문의사항에 답변을 모두 가져옵니다.
	@Override
	public List<CommentVO> selectQnaComment(String boardno) throws SQLException {
		
		List<CommentVO> commentList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select commentno, fk_commenter, comment_content, to_char(commentdate, 'yyyy-mm-dd hh24:mi') AS commentdate " + 
						 " from tbl_qna_comment " + 
						 " where fk_boardno = ? "
						 + "order by commentno desc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardno);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				CommentVO cvo = new CommentVO();
				
				cvo.setCommentno(rs.getInt(1));
				cvo.setFk_commenter(rs.getString(2));
				cvo.setComment_content(rs.getString(3));
				cvo.setRegisterdate(rs.getString(4));
				
				commentList.add(cvo);
			}// end of while------------------------------------
		} finally {
			close();
		}
		
		return commentList;
	}// end of public List<CommentVO> selectQnaComment(String boardno)---------------------------
	
	
	
	
	// 문의사항 답변달기, feedbackYN 바꿔주기
	@Override
	public int insertQnAComment(CommentVO cvo) throws SQLException {
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna_comment(commentno, fk_boardno, fk_commenter, comment_content) " + 
					     " values(seq_tbl_qna_comment.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cvo.getFk_boardno());
			pstmt.setString(2, cvo.getFk_commenter());
			pstmt.setString(3, cvo.getComment_content());
			
			n = pstmt.executeUpdate();
			
			if(n==1) { // insert 성공시 해당 글의 피드백여부도 업데이트
				
				sql = " update tbl_qna_board set feedbackYN = 1 "
				    + " where boardno = ?  ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cvo.getFk_boardno());
				
				n += pstmt.executeUpdate();
				
			}
			else {
				System.out.println("문의사항 피드백여부 SQL 오류!!");
			}
			
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int insertQnAComment(CommentVO cvo)--------------------------------
	
	// 문의사항 답변 수정하기
	@Override
	public int editQnAComment(CommentVO cvo) throws SQLException {
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_qna_comment set comment_content = ? "
					+    " where commentno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cvo.getComment_content());
			pstmt.setInt(2, cvo.getCommentno());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int editQnAComment(CommentVO cvo) -----------------------------------------
	
	// 문의사항 답변 삭제하기
	@Override
	public int deleteQnAComment(CommentVO cvo) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_qna_comment"
					+    " where commentno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cvo.getCommentno());
			
			n = pstmt.executeUpdate();
			
			if(n==1) {
				n = 0; // 트랜잭션 확인용으로 초기화
				sql = " update tbl_qna_board set feedbackYN = 0 "
				    + " where boardno = ?  ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cvo.getFk_boardno());
				
				n = pstmt.executeUpdate();
			}
			else {
				System.out.println("문의사항 피드백여부 SQL 오류!!");
			}
			
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int deleteQnAComment(int commentno)----------------------------------
	//===================================================================================
		// 댓글 작성한 내용 업데이트
		@Override
		public void UpdateDatgle(String review_text, String userid, String what_reviewno) throws SQLException{
			
			int review_no = Integer.parseInt(what_reviewno);
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " insert into tbl_review_comment(fk_reviewno, review_text, fk_userid) "
						   + " values(?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, review_no);
				pstmt.setString(2, review_text);
				pstmt.setString(3, userid);
				
				pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
		}//end of public void UpdateDatgle(String datgle, String userid) {---------------
	//===================================================================================	
		// 리뷰 번호에 맞게 댓글들 가져오기
		@Override
		public List<ReviewCommentVO> SelectAllComment(String what_reviewno) throws SQLException {

			int reviewno = Integer.parseInt(what_reviewno);
			
			List<ReviewCommentVO> commentList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select fk_reviewno, review_text, fk_userid "+
						     " from tbl_review_comment "+
						     " where fk_reviewno = ? ";       
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, reviewno);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ReviewCommentVO rcvo = new ReviewCommentVO();
					
					rcvo.setFk_reviewno(rs.getInt(1));
					rcvo.setReview_text(rs.getString(2));
					rcvo.setFk_userid(rs.getString(3));
					
					commentList.add(rcvo);
					
				}
				
			} finally {
				close();
			}
			
			return commentList;
			
		}//end of public List<ReviewCommentVO> SelectAllComment(String product_name) throws SQLException {
	//================================================================
}

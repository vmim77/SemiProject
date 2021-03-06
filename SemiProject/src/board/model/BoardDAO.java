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
			
			String sql = " select boardno, fk_writer, "
					+    " case when length(title) > 15 then substr(title, 0, 15) || '...' else title end AS title"
					+    " , content, writetime, viewcnt, CommentCnt "+
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
			
			String sql = " select boardno, fk_writer, "
					+    " title, content, "
					+    " to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime "
					+    ", viewcnt, imgfilename"
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
				bvo.setContent(rs.getString(4)); // 엔터까지 적용시키기 위해서 개행문자를 <br>로 치환시킨다.
				bvo.setWritetime(rs.getString(5));
				bvo.setViewcnt(rs.getInt(6));
				bvo.setImgfilename(rs.getString(7));
				
				
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
			
			String sql = " insert into tbl_notice_board(boardno, fk_writer, title, content, imgfilename)"
					+    " values(seq_tbl_notice.nextval, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("bvo").getFk_writer());
			pstmt.setString(2, paraMap.get("bvo").getTitle());
			pstmt.setString(3, paraMap.get("bvo").getContent());
			pstmt.setString(4, paraMap.get("bvo").getImgfilename()); // 이미지를 첨부했다면 null이 아닌 이미지파일명이다.
			
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
			
			String sql = " update tbl_notice_board set fk_writer = ?, title = ?, content = ?, imgfilename = ? "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getFk_writer());
			pstmt.setString(2, bvo.getTitle());
			pstmt.setString(3, bvo.getContent());
			pstmt.setString(4, bvo.getImgfilename());
			pstmt.setInt(5, bvo.getBoardno());
			
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
	}// end of public List<BoardVO> selectmyboard(String userid)---------------------------------
	
	
	
	
	/////////////////////////////////////////// QNA 게시판 ////////////////////////////////////////////
	
	
	// 모든 문의사항 게시글을 가져옵니다.
	@Override
	public List<BoardVO> selectAllQnA() throws SQLException {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select boardno, fk_writer"
					+    " , case when length(title) > 15 then substr(title, 0, 15) || '...' else title end AS title "
					+    " , to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime, feedbackYN " + 
						 " from tbl_qna_board "
						 + " order by boardno desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardVO bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setWritetime(rs.getString(4));
				bvo.setFeedbackYN(rs.getString(5));
				list.add(bvo);
				
			}
			
			
			
		} finally {
			close();
		}
		
		
		return list;
	}// end of public List<BoardVO> selectAllQnA()--------------------------
	
	
	// 문의게시판에 대한 자세한 글정보를 받아옵니다.
	@Override
	public BoardVO selectOneQnA(String boardno) throws SQLException {
		
		BoardVO bvo = null;
		
		try {
			
			conn = ds.getConnection();
			

			String sql = " select boardno, fk_writer, title, content, writetime, imgfilename, feedbackYN, fk_pnum, pname "+
						 " from "+
						 " ( "+
						 "     select boardno, fk_writer, title, content, "+
						 "     to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime, imgfilename, feedbackYN, fk_pnum "+
						 "     from tbl_qna_board "+
						 "     where boardno = ? "+
						 " ) Q "+
						 " join "+
						 " ( "+
						 "     select pnum, pname "+
						 "     from tbl_product "+
						 " ) P "+
						 " ON Q.fk_pnum = P.pnum";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, boardno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				bvo = new BoardVO();
				
				bvo.setBoardno(rs.getInt(1));
				bvo.setFk_writer(rs.getString(2));
				bvo.setTitle(rs.getString(3));
				bvo.setContent(rs.getString(4));
				bvo.setWritetime(rs.getString(5));
				bvo.setImgfilename(rs.getString(6));
				bvo.setFeedbackYN(rs.getString(7));
				bvo.setFk_pnum(rs.getInt(8));
				bvo.setPname(rs.getString(9));
				
			}
			
		} finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO selectOneQnA(String boardno) ------------------------
	
	
	// 문의사항 게시글 작성하기
	@Override
	public int writeQnA(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna_board(boardno, fk_writer, title, content, imgfilename, fk_pnum) " + 
					     " values(seq_tbl_qna_board.nextval, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bvo.getFk_writer());
			pstmt.setString(2, bvo.getTitle());
			pstmt.setString(3, bvo.getContent());
			pstmt.setString(4, bvo.getImgfilename());
			pstmt.setInt(5, bvo.getFk_pnum());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		
		return n;
	}// end of public int writeQnA(BoardVO bvo)---------------------------
	
	
	// 문의사항 게시글 수정하기
	@Override
	public int editQnA(BoardVO bvo) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_qna_board set fk_writer = ?, title = ?, content = ?, imgfilename = ?, fk_pnum = ? "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bvo.getFk_writer());
			pstmt.setString(2, bvo.getTitle());
			pstmt.setString(3, bvo.getContent());
			pstmt.setString(4, bvo.getImgfilename());
			pstmt.setInt(5, bvo.getFk_pnum());
			pstmt.setInt(6, bvo.getBoardno());
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
	}// end of public int editQnA(BoardVO bvo)------------------------
	
	
	// 문의사항 게시글 삭제하기
	@Override
	public int deleteQnA(int boardno) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_qna_board "
					+    " where boardno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return n;
	}// end of public int deleteQnA(int boardno)---------------------------------------------------------
	
	
	//========================================================================================
		// 내 리뷰 업데이트 하기
		@Override
		public void UpdateMyReview(String userid, String content, String whatstar, String insertpicture, String product_name)
				throws SQLException {
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " insert into tbl_review "+
						     " (reviewno "+
						     " ,fk_pnum "+
						     " ,fk_userid "+
						     " ,review_content "+
						     " ,review_picture "+
						     " ,review_star "+
						     " ,review_date "+
						     " ,review_info) "+
						     " values( "+
						     " seq_tbl_review.nextval "+
						     " ,(select pnum "+
						     "  from tbl_product "+
						     "  where pname = ?) "+
						     " ,? "+
						     " ,? "+
						     " ,? "+
						     " ,? "+
						     " ,to_char(sysdate, 'yyyy-mm-dd') "+
						     " ,(select buy_opt_info "+
						     "  from tbl_buy "+
						     "  where fk_userid = ? and fk_pnum = (select pnum "+
						     "                                     from tbl_product "+
						     "                                     where pname = ? ))) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, product_name);
				pstmt.setString(2, userid);
				pstmt.setString(3, content);
				pstmt.setString(4, insertpicture);
				pstmt.setString(5, whatstar);
				pstmt.setString(6, userid);
				pstmt.setString(7, product_name);
				
				pstmt.executeUpdate();
				
			} finally {
				close();
			}
		
		}//end of public void UpdateMyReview(String userid, String content, String whatstar, String insertpicture)
	//========================================================================================	
		// 페이지 로드시 모든 리뷰 가져오기
		@Override
		public List<ReviewVO> SelectAllReview(String product_name) throws SQLException {
			
			List<ReviewVO> reviewList = new ArrayList<>();
			
			try {
				
				conn = ds.getConnection();
				 
				String sql = " select reviewno,fk_pnum,fk_userid,review_content,review_picture,review_star,review_date,review_info "+
						     " from tbl_review "+
						     " where fk_pnum = (select pnum "+
						     "                  from tbl_product "+
						     "                  where pname = ?) "+
						     " order by reviewno ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				
				rs = pstmt.executeQuery();
									
				while(rs.next()) {
					
					ReviewVO rvo = new ReviewVO();
					
					rvo.setReviewno(rs.getInt(1));
					rvo.setFk_pnum(rs.getInt(2));
					rvo.setFk_userid(rs.getString(3));
					rvo.setReview_content(rs.getString(4));
					rvo.setReview_picture(rs.getString(5));
					rvo.setReview_star(rs.getString(6));
					rvo.setReview_date(rs.getString(7));
					rvo.setReview_info(rs.getString(8));
					
					reviewList.add(rvo);
					
				}
				
			} finally {
				close();
			}
			
			return reviewList;
			
		}//end of public ReviewVO SelectAllReview() throws SQLException {
	//========================================================================================
		//========================================================================================
		// 전체 리뷰 평점 가져오기
		@Override
		public Map<String, String> selectStar(String product_name) throws SQLException {

			Map<String, String> starMap = new HashMap<>();
			
			// 총 리뷰갯수
			double allstars = 0;
			// 평점 5점
			double fistars = 0;
			// 평점 4점
			double fostars = 0;
			// 평점 3점
			double thstars = 0;
			// 평점 2점
			double twstars = 0;
			// 평점 1점
			double wostars = 0;
			
			try {
				
				conn = ds.getConnection();

				// 우선 해당 리뷰의 총 개수
				String sql = " select review_star "+
						     " from tbl_review "+
						     " where fk_pnum = (select pnum "+
						     "                  from tbl_product "+
						     "                  where pname = ?) ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					allstars++;
				}
				///////////////////////////////////////////////////
				// 해당 리뷰의 5점 개수
				sql = " select review_star "+
				      " from tbl_review "+
				      " where fk_pnum = (select pnum "+
					  "                  from tbl_product "+
					  "                  where pname = ?) "+
					  "and review_star = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				pstmt.setInt(2, 5);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					fistars++;
				}
				///////////////////////////////////////////////////
				// 해당 리뷰의 4점 개수
				sql = " select review_star "+
					  " from tbl_review "+
					  " where fk_pnum = (select pnum "+
					  "                  from tbl_product "+
					  "                  where pname = ?) "+
					  " and review_star = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				pstmt.setInt(2, 4);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					fostars++;
				}
				///////////////////////////////////////////////////
				// 해당 리뷰의 3점 개수
				sql = " select review_star "+
					  " from tbl_review "+
				      " where fk_pnum = (select pnum "+
					  "                  from tbl_product "+
					  "                  where pname = ?) "+
					  " and review_star = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				pstmt.setInt(2, 3);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					thstars++;
				}
				///////////////////////////////////////////////////
				// 해당 리뷰의 2점 개수
				sql = " select review_star "+
					  " from tbl_review "+
					  " where fk_pnum = (select pnum "+
					  "                  from tbl_product "+
					  "                  where pname = ?) "+
					  " and review_star = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				pstmt.setInt(2, 2);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					twstars++;
				}
				///////////////////////////////////////////////////
				// 해당 리뷰의 1점 개수
				sql = " select review_star "+
					  " from tbl_review "+
					  " where fk_pnum = (select pnum "+
					  "                  from tbl_product "+
					  "                  where pname = ?) "+
					  " and review_star = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_name);
				pstmt.setInt(2, 1);
				rs = pstmt.executeQuery();			
				// 총 리뷰갯수
				while(rs.next()) {
					wostars++;
				}
				///////////////////////////////////////////////////
				
				// 별점
				String five_stars = Math.round(fistars/allstars*100) + "";
				String four_stars = Math.round(fostars/allstars*100) + "";
				String three_stars = Math.round(thstars/allstars*100) + "";
				String two_stars = Math.round(twstars/allstars*100) + "";
				String won_stars = Math.round(wostars/allstars*100) + "";

				// 별점 넘겨주기
				starMap.put("five_stars", five_stars);
				starMap.put("four_stars", four_stars);
				starMap.put("three_stars", three_stars);
				starMap.put("two_stars", two_stars);
				starMap.put("won_stars", won_stars);
				
			} finally {
				close();
			}
			
			return starMap;
			
		}//end of public Map<String, String> selectStar(String product_name) throws SQLException {
	//=============================================================================
		// 내 리뷰 업데이트 하기
		@Override
		public void UpdateMyReview(String userid, String content, String whatstar, String insertpicture, String product_name, String jumun_bunho)
				throws SQLException {
			
			try {
				
				conn = ds.getConnection();
				
				String sql = "insert into tbl_review "+
						" (reviewno "+
						" ,fk_pnum "+
						" ,fk_userid "+
						" ,review_content "+
						" ,review_picture "+
						" ,review_star "+
						" ,review_date "+
						" ,review_info) "+
						" values( "+
						" seq_tbl_review.nextval "+
						" ,(select pnum "+
						" from tbl_product "+
						" where pname = ?) "+
						" ,? "+
						" ,? "+
						" ,? "+
						" ,? "+
						" ,to_char(sysdate, 'yyyy-mm-dd') "+
						" ,(select buy_opt_info "+
						"   from tbl_buy "+
						"   where fk_userid = ? and fk_pnum = (select pnum "+
						"                                      from tbl_product "+
						"				                       where pname = ? )"+
						"						and jumun_bunho = ? )) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, product_name);
				pstmt.setString(2, userid);
				pstmt.setString(3, content);
				pstmt.setString(4, insertpicture);
				pstmt.setString(5, whatstar);
				pstmt.setString(6, userid);
				pstmt.setString(7, product_name);
				pstmt.setString(8, jumun_bunho);
				
				pstmt.executeUpdate();
				
			} finally {
				close();
			}
		
		}//end of public void UpdateMyReview(String userid, String content, String whatstar, String insertpicture)
}

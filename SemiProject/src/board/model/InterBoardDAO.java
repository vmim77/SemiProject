package board.model;

import java.sql.*;
import java.util.*;

public interface InterBoardDAO {
	
	/////////////////////////////////////////////////////////////////////////////////////////
	// 여기서부터는 공지사항 게시판!
	
	// 처음으로 공지사항 게시판에 입장시 모든 글목록을 조회해주는 메소드
	List<BoardVO> selectAllNotice() throws SQLException;
	
	// 특정 글을 조회해옵니다.
	BoardVO selectOneNotice(String boardno) throws SQLException;
	
	// 공지사항 게시글쓰기
	int writeNotice(Map<String, BoardVO> paraMap) throws SQLException;
	
	// 공지사항 게시글 수정하기
	int editNotice(BoardVO bvo) throws SQLException;
	
	// 공지사항 게시글 삭제하기
	int deleteNotice(int boardno) throws SQLException;
	
	// 해당 글번호의 글을 이 유저가 조회한 적이 있나 없나 확인한다.
	int noticeViewCheck(Map<String, String> paraMap) throws SQLException;
	
	// 오늘 하루동안 해당 공지글을 본 적이 없으니 조회수를 올려준다.
	int updateNoticeViewcnt(Map<String, String> paraMap) throws SQLException;
	
	// 조회수를 올렸으니, 조회수기록 테이블에 기록을 넣어준다.
	int insertNoticeViewHistory(Map<String, String> paraMap) throws SQLException;

	// 검색타입과 검색어를 가지고 해당되는 공지사항을 검색한다.
	List<BoardVO> searchNotice(Map<String, String> paraMap) throws SQLException;
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	// 마이페이지 게시물 보기
	List<BoardVO> selectmyboard(String userid) throws SQLException;
	
	///////////////////////////////////////////////////////////////////////////////////////////
	// 여기서부터는 문의사항 게시판!
	
	
	// 모든 문의사항 게시글을 가져옵니다.
	List<BoardVO> selectAllQnA() throws SQLException;
	
	 // 문의게시판에 대한 자세한 글정보를 받아옵니다.
	BoardVO selectOneQnA(String boardno) throws SQLException;
	
	// 문의사항 게시글 작성하기
	int writeQnA(BoardVO bvo) throws SQLException;
	
	// 문의사항 게시글 수정하기
	int editQnA(BoardVO bvo) throws SQLException;
	
	// 문의사항 게시글 삭제하기
	int deleteQnA(int boardno) throws SQLException;
	
	///////////////////////////////////////////////////////////////////////////////////////////
	// 여기서부터는 리뷰 게시판!
	
	// 내 리뷰 업데이트 하기
	void UpdateMyReview(String userid, String content, String whatstar, String insertpicture, String product_name) throws SQLException;

	// 페이지 로드시 모든 리뷰 가져오기
	List<ReviewVO> SelectAllReview(String product_name) throws SQLException;
	
	// 내 리뷰 업데이트 하기
	void UpdateMyReview(String userid, String content, String whatstar, String insertpicture, String product_name, String jumun_bunho) throws SQLException;

	// 전체 리뷰 평점 가져오기
	Map<String, String> selectStar(String product_name) throws SQLException;
	

}

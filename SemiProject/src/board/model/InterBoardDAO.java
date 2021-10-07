package board.model;

import java.sql.*;
import java.util.*;

public interface InterBoardDAO {

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

}
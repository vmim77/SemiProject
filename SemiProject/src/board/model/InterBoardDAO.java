package board.model;

import java.sql.*;
import java.util.*;

public interface InterBoardDAO {

	// 처음으로 공지사항 게시판에 입장시 모든 글목록을 조회해주는 메소드
	List<BoardVO> selectAllNotice() throws SQLException;
	
	// 특정 글을 조회해옵니다.
	BoardVO selectOneNotice(int boardno) throws SQLException;
	
	// 공지사항 게시글쓰기
	int writeNotice(Map<String, BoardVO> paraMap) throws SQLException;
	
	// 공지사항 게시글 수정하기
	int editNotice(BoardVO bvo) throws SQLException;
	
	// 공지사항 게시글 삭제하기
	int deleteNotice(int boardno) throws SQLException;

}

package comment.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterCommentDAO {
	
	// 특정 글번호에 대한 댓글들을 모두 가져옵니다.
	List<CommentVO> selectComment(String boardno) throws SQLException;
	
	// 댓글쓰기
	int insertComment(Map<String, CommentVO> paraMap) throws SQLException;
	
	// 댓글삭제하기
	int deleteNoticeComment(int commentno) throws SQLException;
	
	// 댓글수정하기
	int editNoticeComment(CommentVO cvo) throws SQLException;

}

package comment.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterCommentDAO {
	
	// 특정 글번호에 대한 댓글들을 모두 가져옵니다.
	List<CommentVO> selectComment(String boardno) throws SQLException;
	
	// 공지사항 댓글쓰기
	int insertComment(Map<String, CommentVO> paraMap) throws SQLException;
	
	// 공지사항 댓글삭제하기
	int deleteNoticeComment(int commentno) throws SQLException;
	
	// 공지사항 댓글수정하기
	int editNoticeComment(CommentVO cvo) throws SQLException;
	
	
	
	////////////////////////// 이 아래로는 문의사항
	
	 // 문의사항에 답변을 모두 가져옵니다.
	List<CommentVO> selectQnaComment(String boardno) throws SQLException;
	
	// 문의사항 답변달기, feedbackYN 바꿔주기
	int insertQnAComment(CommentVO cvo) throws SQLException;
	
	// 문의사항 답변 수정하기
	int editQnAComment(CommentVO cvo) throws SQLException;
	
	// 문의사항 답변 삭제하기
	int deleteQnAComment(CommentVO cvo) throws SQLException;

	// 댓글 작성한 내용 업데이트
	void UpdateDatgle(String review_text, String userid, String what_reviewno) throws SQLException;

	// 리뷰 번호에 맞게 댓글들 가져오기
	List<ReviewCommentVO> SelectAllComment(String what_reviewno) throws SQLException;
	
}

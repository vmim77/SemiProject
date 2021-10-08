package comment.model;

public class CommentVO {
	
	private int commentno; // 댓글번호
	private int fk_boardno; // 글번호 -- 반드시 게시글목록에 있는 글이여야함 
	private String fk_commenter; // 댓글작성자 -- 반드시 회원테이블에 있는 회원이여야함
	private String comment_content; // 댓글내용
	private String registerdate; // 댓글단 시간
	

	public int getCommentno() {
		return commentno;
	}

	public void setCommentno(int commentno) {
		this.commentno = commentno;
	}

	public int getFk_boardno() {
		return fk_boardno;
	}
	
	public void setFk_boardno(int fk_boardno) {
		this.fk_boardno = fk_boardno;
	}
	
	public String getFk_commenter() {
		return fk_commenter;
	}
	
	public void setFk_commenter(String fk_commenter) {
		this.fk_commenter = fk_commenter;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	
	
	
	
	

}

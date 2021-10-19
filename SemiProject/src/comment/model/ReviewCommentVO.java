package comment.model;

public class ReviewCommentVO {
//======================================================================================
	// 댓글 //
	private int review_commentno = 0;  		// 댓글번호
    private int fk_reviewno = 0;       		// 리뷰넘버
	private String fk_userid = "";     		// 올린아이디
	private String review_text = "";   		// 내용
//======================================================================================
	public int getReview_commentno() {
		return review_commentno;
	}
	public void setReview_commentno(int review_commentno) {
		this.review_commentno = review_commentno;
	}
	public int getFk_reviewno() {
		return fk_reviewno;
	}
	public void setFk_reviewno(int fk_reviewno) {
		this.fk_reviewno = fk_reviewno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getReview_text() {
		return review_text;
	}
	public void setReview_text(String review_text) {
		this.review_text = review_text;
	}
//=======================================================================================	
}

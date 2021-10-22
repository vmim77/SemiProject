package board.model;

public class ReviewVO {
//======================================================================================
	// 리뷰테이블 //							
	private int reviewno = 0;               // 리뷰 번호  
	private int fk_pnum = 0;                // 제품번호(Primary Key)
    private String fk_userid = "";      	// 유저아이디
	private String review_content = "";    	// 리뷰내용
	private String review_picture = ""; 	// 리뷰올린사진                                         
	private String review_star = "";    	// 별점
	private String review_date = "";    	// 올린날짜
	private String review_info = "";    	// 내가 구매한 정보
	private int review_cnt = 0;         	// 조회수   							
//======================================================================================
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public int getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_picture() {
		return review_picture;
	}
	public void setReview_picture(String review_picture) {
		this.review_picture = review_picture;
	}
	public String getReview_star() {
		return review_star;
	}
	public void setReview_star(String review_star) {
		this.review_star = review_star;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public String getReview_info() {
		return review_info;
	}
	public void setReview_info(String review_info) {
		this.review_info = review_info;
	}
	public int getReview_cnt() {
		return review_cnt;
	}
	public void setReview_cnt(int review_cnt) {
		this.review_cnt = review_cnt;
	}
//===============================================================================	
}

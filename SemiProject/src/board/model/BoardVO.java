package board.model;

public class BoardVO {
	
	private int boardno; // 게시글번호 시퀀스사용
	private String fk_writer; // 게시글작성자 - 반드시 회원테이블에 있는 유저아이디여야함
	private String title; // 글제목
	private String content; // 글내용
	private String writetime; // 글시간 - 기본값 sysdate
	private int viewcnt; // 조회수
	private String imgfilename; // 이미지파일 이름
	private String imgfilepath; // 이미지파일 경로
	
	
	// select 용 컬럼
	private int CommentCnt; // 해당 글의 댓글수
	
	// 문의게시판용 컬럼
	private String feedbackYN; // 문의사항 답변여부 0이면 미답변, 1이면 답변 //  CK 0 or 1
	
	
	
	
	public int getBoardno() {
		return boardno;
	}
	
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	
	public String getFk_writer() {
		return fk_writer;
	}
	
	public void setFk_writer(String fk_writer) {
		this.fk_writer = fk_writer;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getWritetime() {
		return writetime;
	}
	
	public void setWritetime(String writetime) {
		this.writetime = writetime;
	}
	
	public int getViewcnt() {
		return viewcnt;
	}
	
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public int getCommentCnt() {
		return CommentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		CommentCnt = commentCnt;
	}

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public String getFeedbackYN() {
		return feedbackYN;
	}

	public void setFeedbackYN(String feedbackYN) {
		this.feedbackYN = feedbackYN;
	}

	public String getImgfilepath() {
		return imgfilepath;
	}

	public void setImgfilepath(String imgfilepath) {
		this.imgfilepath = imgfilepath;
	}
	
	
	
	
	
	

}

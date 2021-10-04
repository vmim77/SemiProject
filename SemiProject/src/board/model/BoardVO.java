package board.model;

public class BoardVO {
	
	private int boardno; // 게시글번호 시퀀스사용
	private String fk_writer; // 게시글작성자 - 반드시 회원테이블에 있는 유저아이디여야함
	private String title; // 글제목
	private String content; // 글내용
	private String writetime; // 글시간 - 기본값 sysdate
	private int viewcnt; // 조회수
	
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
	
	

}

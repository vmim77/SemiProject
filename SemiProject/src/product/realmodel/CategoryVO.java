package product.realmodel;

public class CategoryVO {
	// 카테고리 테이블 //
	private int cnum = 0;       			// 카테고리 대분류 번호
	private String code = "";   			// 카테고리 코드
	private String cname = "";  			// 카테고리명
//==========================================================================	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
//=========================================================================	
}

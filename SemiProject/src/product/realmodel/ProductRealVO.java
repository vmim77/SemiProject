package product.realmodel;

public class ProductRealVO {
//======================================================================================
	// 제품 테이블 //
	private int pnum = 0;           		// 제품번호(Primary Key)
	private String pname = "";      		// 제품명
	private int fk_cnum = 0;        		// 카테고리코드(Foreign Key)의 시퀀스번호 참조
	private String pimage1 = "";    		// 호버 전    
	private String pimage2 = "";    		// 호버 후   
	private String pimage3 = "";    		// 제품사진   
	private String pimage4 = "";    		// 제품 긴사진   
	private int pqty = 0;           		// 제품 재고량
	private String price = "";      		// 제품 정가 (159,000 형식으로 저장 되어있음)
	private String saleprice = "";  		// 제품 판매가(159,000 형식으로 저장 되어있음)                                          
	private String pinputdate = "";	 		// 제품입고일자
//======================================================================================
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getFk_cnum() {
		return fk_cnum;
	}
	public void setFk_cnum(int fk_cnum) {
		this.fk_cnum = fk_cnum;
	}
	public String getPimage1() {
		return pimage1;
	}
	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}
	public String getPimage2() {
		return pimage2;
	}
	public void setPimage2(String pimage2) {
		this.pimage2 = pimage2;
	}
	public String getPimage3() {
		return pimage3;
	}
	public void setPimage3(String pimage3) {
		this.pimage3 = pimage3;
	}
	public String getPimage4() {
		return pimage4;
	}
	public void setPimage4(String pimage4) {
		this.pimage4 = pimage4;
	}
	public int getPqty() {
		return pqty;
	}
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(String saleprice) {
		this.saleprice = saleprice;
	}
	public String getPinputdate() {
		return pinputdate;
	}
	public void setPinputdate(String pinputdate) {
		this.pinputdate = pinputdate;
	}
	
//======================================================================================
}
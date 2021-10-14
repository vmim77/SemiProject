package product.realmodel;

public class ProductBuyVO {
//=====================================================================================	
	// 구매내역 테이블 //
    private int fk_pnum = 0;                // 제품번호(Primary Key)
    private String fk_userid = "";          // 유저아이디
	private String buy_opt_info = "";       // 옵션정보
	private int buy_qty = 0;                // 수량                                         
	private String buy_opt_price = "";      // 옵션가격
	private String buy_pro_price = "";      // 제품가격
	private String buy_jeokrib_money = "";  // 적립금
	private String buy_date = "";           // 구매날짜
	private int baesong_sangtae = 0;        // 배송상태
	private String buy_finish_date = "";    // 배송완료일자
//======================================================================================
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
	public String getBuy_opt_info() {
		return buy_opt_info;
	}
	public void setBuy_opt_info(String buy_opt_info) {
		this.buy_opt_info = buy_opt_info;
	}
	public int getBuy_qty() {
		return buy_qty;
	}
	public void setBuy_qty(int buy_qty) {
		this.buy_qty = buy_qty;
	}
	public String getBuy_opt_price() {
		return buy_opt_price;
	}
	public void setBuy_opt_price(String buy_opt_price) {
		this.buy_opt_price = buy_opt_price;
	}
	public String getBuy_pro_price() {
		return buy_pro_price;
	}
	public void setBuy_pro_price(String buy_pro_price) {
		this.buy_pro_price = buy_pro_price;
	}
	public String getBuy_jeokrib_money() {
		return buy_jeokrib_money;
	}
	public void setBuy_jeokrib_money(String buy_jeokrib_money) {
		this.buy_jeokrib_money = buy_jeokrib_money;
	}
	public String getBuy_date() {
		return buy_date;
	}
	public void setBuy_date(String buy_date) {
		this.buy_date = buy_date;
	}
	public int getBaesong_sangtae() {
		return baesong_sangtae;
	}
	public void setBaesong_sangtae(int baesong_sangtae) {
		this.baesong_sangtae = baesong_sangtae;
	}
	public String getBuy_finish_date() {
		return buy_finish_date;
	}
	public void setBuy_finish_date(String buy_finish_date) {
		this.buy_finish_date = buy_finish_date;
	}
//================================================================================================================
}

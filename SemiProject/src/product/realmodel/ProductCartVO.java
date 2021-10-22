package product.realmodel;

public class ProductCartVO {
//======================================================================================
   // 장바구니 테이블 //
   private int cartno;    
   private int fk_pnum = 0;                // 제품번호(Primary Key) 
   private String fk_userid = "";          // 유저아이디
   private String cart_opt_info = "";      // 옵션정보
   private int cart_qty = 0;               // 수량                                         
   private String cart_opt_price = "";     // 옵션가격
   private String cart_jukrib_money = "";  // 예정적립금
   private String cart_date = "";          // 담은날짜
   private int saleprice_optprice;         // 세일가격(판매가)와 옵션가격을 더한 가격
   private ProductRealVO prvo;             //제품정보를 담음 객체
   //======================================================================================
   public int getCartno() {
      return cartno;
   }
   public void setCartno(int cartno) {
      this.cartno = cartno;
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
   public String getCart_opt_info() {
      return cart_opt_info;
   }
   public void setCart_opt_info(String cart_opt_info) {
      this.cart_opt_info = cart_opt_info;
   }
   public int getCart_qty() {
      return cart_qty;
   }
   public void setCart_qty(int cart_qty) {
      this.cart_qty = cart_qty;
   }
   public String getCart_opt_price() {
      return cart_opt_price;
   }
   public void setCart_opt_price(String cart_opt_price) {
      this.cart_opt_price = cart_opt_price;
   }
   public String getCart_jukrib_money() {
      return cart_jukrib_money;
   }
   public void setCart_jukrib_money(String cart_jukrib_money) {
      this.cart_jukrib_money = cart_jukrib_money;
   }
   public String getCart_date() {
      return cart_date;
   }
   public void setCart_date(String cart_date) {
      this.cart_date = cart_date;
   }
   public int getSaleprice_optprice() {
      return saleprice_optprice;
   }
   public void setSaleprice_optprice(int saleprice_optprice) {
      this.saleprice_optprice = saleprice_optprice;
   }
   public ProductRealVO getPrvo() {
      return prvo;
   }
   public void setPrvo(ProductRealVO prvo) {
      this.prvo = prvo;
   }
//==============================================================================================================   
}
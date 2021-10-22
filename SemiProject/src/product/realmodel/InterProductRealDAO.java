package product.realmodel;

import java.sql.SQLException;
import java.util.*;

public interface InterProductRealDAO {	
//======================================================================================
	// 구매내역 메소드 //
	// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
	int SearchMyBuy(String userid, String product_name) throws SQLException;

	// 내 구매내역 업데이트 하기
	void UpdateMyBought(Map<String, String> paraMap) throws SQLException;

	// 리뷰를 작성안한 내 구매내역을 가져오기
	List<ProductBuyVO> SelectMyPageBought(String userid) throws SQLException;
	
	// 해당제품의 리뷰를 달았다는 것을 업데이트
	void updateMyReviewCheckUp(String jumun_bunho) throws SQLException;
	
	// 마이페이지에서 환불/교환 클릭시 제품정보 가져오기
	List<ProductBuyVO> Mychange(String jumun_bunho) throws SQLException;
	
	// 환불 클릭시 업데이트 하기
	int Change(String jumun_bunho, int th, String changeOpt) throws SQLException;
	
	// 배송조회
	List<ProductBuyVO> myorder(String userid) throws SQLException;

	// 마이페이지에서 구매금액 메소드
	int SelectMyBuyMoney(String userid) throws SQLException;

	// 주문번호 조회
	List<ProductBuyVO> SelectJumun(String jumun_bunho) throws SQLException;

	// 리뷰를 작성안한 내 구매내역을 가져오기
	List<ProductBuyVO> SelectMyBought(String userid, String product_name) throws SQLException;
//======================================================================================
	// 장바구니 메소드 //	
	// 장바구니 번호 채번해오기
	int getCartno() throws SQLException;
   
    //제품 번호 알아오기 VO를 잘못짜서 제품이름으로 알아와야 함.
    int getPnum(String cartname) throws SQLException;

    // 장바구니 테이블에 삽입하기
    int addCart(String userid, int pnum, String cart_opt_info, String cart_qty, String cart_opt_price) throws SQLException;

    // 로그인 아이디로 장바구니 목록 얻어오기
    List<ProductCartVO> getCartList(String userid) throws SQLException;

    // 모든 제품 총합 총적립금 구해오기
    HashMap<String, String> getTotal_totalprice(String userid) throws SQLException;

    // 장바구니 테이블에서 특정제품의 주문량 변경시키기
    int updateQty(String cartno, String qty) throws SQLException;

    // 삭제 버튼 클릭시 장바구니 목록에서 삭제
    int delCart(String cartno) throws SQLException;

    // 장바구니 내 모든 상품 삭제
    int allDelCart(String userid) throws SQLException;

    //구매내역에 넣어주기
    int orderAdd(HashMap<String, Object> paraMap) throws SQLException;

    //선택한 상품 삭제하기
    int selectDelCart(String cartnojoin) throws SQLException;
//======================================================================================
	// 운영자 //
	// 제품번호와 제품명을 가져온다.
	List<ProductRealVO> getProdInfo() throws SQLException;
	
	// 모든 회원들의 주문내역을 조회해온다.
	List<Map<String, String>> selectAllOrderList(int currentShowPageNo, int sizePerPage) throws SQLException;
	
	// 총 주문내역 건수 알아오기
	int getTotalCountOrder() throws SQLException;
	
	// 배송상태 변경시키기
	int changeBaesongStatus(String odrcode, String pnum, String changeStatus) throws SQLException;
//======================================================================================
}

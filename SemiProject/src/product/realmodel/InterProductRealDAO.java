package product.realmodel;

import java.sql.SQLException;
import java.util.*;

public interface InterProductRealDAO {

	
//======================================================================================
	// 제품 메소드 //

	
	
//======================================================================================
	// 구매내역 메소드 //
	// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
	int SearchMyBuy(String userid, String product_name) throws SQLException;

	// 내 구매내역 업데이트 하기
	void UpdateMyBought(Map<String, String> paraMap) throws SQLException;

	
	// 리뷰를 작성안한 내 구매내역을 가져오기
	List<ProductBuyVO> SelectMyPageBought(String userid) throws SQLException;
	
	// 마이페이지에서 환불/교환 클릭시 제품정보 가져오기
	List<ProductBuyVO> SelectMyBought(String jumun_bunho) throws SQLException;
	
	// 환불 클릭시 업데이트 하기
	int Change(String jumun_bunho, int th) throws SQLException;
	
	// 배송조회
	List<ProductBuyVO> myorder(String userid) throws SQLException;

	// 마이페이지에서 구매금액 메소드
	List<ProductBuyVO> SelectMyBuyMoney(String userid) throws SQLException;
	
	
//======================================================================================
	// 장바구니 메소드 //

	

	
	
//======================================================================================
	// 리뷰 메소드 //							
			
	
	
//======================================================================================
	// 댓글 메소드 //

	
	
//======================================================================================
	// 조회수 메소드 //

	
	
//======================================================================================
}

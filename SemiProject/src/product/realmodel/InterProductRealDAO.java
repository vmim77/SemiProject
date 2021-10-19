package product.realmodel;

import java.sql.SQLException;
import java.util.*;

public interface InterProductRealDAO {
	
	// 제품번호와 제품명을 가져온다.
	List<ProductRealVO> getProdInfo() throws SQLException;
	//======================================================================================
		// 제품 메소드 //

		
		
	//======================================================================================
		// 구매내역 메소드 //
		// 해당제품의 리뷰를 작성했는가 안했는가 알아오기
		int SearchMyBuy(String userid, String product_name) throws SQLException;

		// 내 구매내역 업데이트 하기
		void UpdateMyBought(Map<String, String> paraMap) throws SQLException;

		// 리뷰를 작성안한 내 구매내역을 가져오기
		List<ProductBuyVO> SelectMyBought(String userid, String product_name) throws SQLException;
		
		
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

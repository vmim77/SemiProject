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
		int Change(String jumun_bunho, int th, String changeOpt) throws SQLException;
		
		// 배송조회
		List<ProductBuyVO> myorder(String userid) throws SQLException;
	
		// 마이페이지에서 구매금액 메소드
		int SelectMyBuyMoney(String userid) throws SQLException;
	
		// 주문번호 조회
		List<ProductBuyVO> SelectJumun(String jumun_bunho) throws SQLException;




		
		
	//======================================================================================
		// 장바구니 메소드 //

		
		
	//======================================================================================
		// 리뷰 메소드 //							
				
		
		
	//======================================================================================
		// 댓글 메소드 //

		
		
	//======================================================================================
		// 조회수 메소드 //

		
		
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

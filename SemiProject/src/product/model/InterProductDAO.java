package product.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO {
	
	// 모든 제품 사진 가져오기
	List<ProductVO> allProductimgList() throws SQLException;
	
	//동그라미 사진 클릭하면 해당 상품 리스트 가져오기
	List<ProductVO> productimgList(String product_name) throws SQLException;

	//퀵뷰에 나타내기 위한 상품 한개 가져오기
	ProductVO quickViewProduct(String quickProductName) throws SQLException;

	// 제품 사진 눌렀을 때 제품 한개 정보 가져오기
	ProductVO getOneProduct(String product_name) throws SQLException;

	// 출석체크이벤트
	Map<String, String> choolcheckevent(String userid) throws SQLException;
	
	// 출석도장 저장
	void Savemycheck(String savemycheck, String userid) throws SQLException;

}

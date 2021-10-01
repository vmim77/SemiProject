package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO {
	
	//동그라미 사진 클릭하면 해당 상품 리스트 가져오기
	List<ProductVO> productimgList(String dubby) throws SQLException;

}

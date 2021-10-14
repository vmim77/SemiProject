package product.realmodel;

import java.sql.SQLException;
import java.util.*;

public interface InterProductRealDAO {
	
	// 제품번호와 제품명을 가져온다.
	List<ProductRealVO> getProdInfo() throws SQLException;

}

package product.model;

import java.sql.SQLException;
import java.util.*;

import product.realmodel.ProductRealVO;

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
	int Savemycheck(String savemycheck, String userid) throws SQLException;

	// ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //   
	List<Map<String, String>> getCategoryList() throws SQLException;
     
	// 제품번호 채번 해오기  
	int getPnumOfProduct() throws SQLException;   
   
	//tbl_product 테이블에 제품정보 insert 하기     
	int productInsert(ProductRealVO prvo) throws SQLException;
	
	//카테고리 이름 알아오기
	String getCname(String fk_cnum) throws SQLException;
	
	//나눠진 제품 테이블에서 insert 하기
	int selectproductInsert(ProductRealVO prvo, String cname) throws SQLException;
}

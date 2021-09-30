package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {
	// MemberDAO용 인터페이스
	
	
	// 전체회원을 조회한 후에 반복문으로 VO 객체를 생성해서 각각의 정보를 넣어서 가져옵니다. 
	List<MemberVO> selectAllUser() throws SQLException;

	
	
	
	

}

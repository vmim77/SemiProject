package admin.controller;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;

import common.controller.AbstractController;
import member.model.*;

public class MemberListAction extends AbstractController {
	
	InterMemberDAO mdao = new MemberDAO();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 추후에 로그인한 유저정보가 '운영자'인지 아닌지 확인하는 if절을 걸어서 걸러낼겁니다.
		
		
		String method = request.getMethod(); // GET OR POST
		
			
			
			List<MemberVO> mbrList =  mdao.selectAllUser(); // DAO에서 tbl_member의 모든 회원정보를 조회해주는 SQL문을 돌립니다. 리턴값은 회원들의 정보를 여러개 담아와야하니깐 List로 
			
			request.setAttribute("mbrList", mbrList); // View 페이지로 List를 전송시켜서 찍어주도록 합니다.
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");

		

		

		
		// if(loginuser.getUserid() == 'admin') { }
		
		
	}

}

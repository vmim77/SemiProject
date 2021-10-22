package delivery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductBuyVO;
import product.realmodel.ProductRealDAO;

public class OrderchangeAction extends AbstractController {
//===============================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductRealDAO prdao = new ProductRealDAO();
        
        String jumun_bunho = request.getParameter("jumun_bunho");
        
        List<ProductBuyVO> orderList = prdao.Mychange(jumun_bunho);
        
        request.setAttribute("jumun_bunho", jumun_bunho);        
        request.setAttribute("orderList", orderList);
        
        int th = 0;
        String can = request.getParameter("can");

        if( can != null ) {
        	
        	jumun_bunho = request.getParameter("retry_jumun_bunho");
        	String changeOpt = request.getParameter("chan");
	        
	        if("환불·취소".equals(can)) {
	        	th = 3;
	        	int ChangeList = prdao.Change(jumun_bunho,th, changeOpt);
	        	request.setAttribute("ChangeList", ChangeList);
	        }
	        else {
	        	th = 4;
	        	int ChangeList = prdao.Change(jumun_bunho,th, changeOpt);
	        	request.setAttribute("ChangeList", ChangeList);
	        	
	        	if(ChangeList==1) {
	        		System.out.println("sql 성공 ");
	        	}//end of if(ChangeList==1) {
	        	
	        }//end of if("환불·취소".equals(can)) {
	        
        }//end of if( can != null ) {
        	
		super.setViewPage("/WEB-INF/delivery/orderchange.jsp");
		
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//===============================================================================================
}

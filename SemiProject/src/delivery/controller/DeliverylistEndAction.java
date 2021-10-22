package delivery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.realmodel.InterProductRealDAO;
import product.realmodel.ProductBuyVO;
import product.realmodel.ProductRealDAO;

public class DeliverylistEndAction extends AbstractController {
//==================================================================================================
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductRealDAO prdao = new ProductRealDAO();
        
        String jumun_bunho = request.getParameter("jumun_bunho");
		
        List<ProductBuyVO> jumunList = prdao.SelectJumun(jumun_bunho);
		
        JSONArray jsonArr = new JSONArray();
        
        for(ProductBuyVO rcvo : jumunList) {
                 
           JSONObject jsobj = new JSONObject();          
                 
           jsobj.put("buy_date", rcvo.getBuy_date());          
           jsobj.put("fk_userid", rcvo.getFk_userid());
           jsobj.put("baesong_sangtae", rcvo.getBaesong_sangtae());
              
           jsonArr.put(jsobj);
              
        }// end of for----------------------------
           
        String json = jsonArr.toString();
        
        request.setAttribute("json", json);
        
        super.setViewPage("/WEB-INF/jsonview.jsp");
        
	}//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==================================================================================================
}

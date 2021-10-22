package admin.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.realmodel.ProductRealVO;

public class ProductRegisterAction extends AbstractController {
//==========================================================================================
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      /// 관리자 로그인 막기 처리
      HttpSession session = request.getSession();
      
      MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
      
      if(loginuser !=null && "admin".equals(loginuser.getUserid()) ){
         // 관리자(admin)로 로그인 했을 경우
         InterProductDAO pdao = new ProductDAO();
         
          String method = request.getMethod();
          
          if(!"post".equalsIgnoreCase(method)) {
                
             super.getCategoryList(request);      
             super.setViewPage("/WEB-INF/product/productRegister.jsp");
                  
          }
          else {// POST 이라면    
             
             // cos.jar 넣었으니 합칠때 체크!!!!!!!!!!!!!!
             MultipartRequest mtrequest = null;
             
             // 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
                ServletContext svlCtx = session.getServletContext();
                String uploadFileDir = svlCtx.getRealPath("/images");
                //*** C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SemiProject\images
                //*** 합쳤을 때 에러가 발생하면 탐색기 위 경로로 들어가서 productimages 파일을 만드세요.
                    
                // === 파일을 업로드 해준다 . ===                 
                try {                   
                   mtrequest = new MultipartRequest(request, uploadFileDir, 100*1024*1024, "UTF-8", new DefaultFileRenamePolicy());  // 생성자이다. !!!                     
                 } catch(IOException e) {
                    request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 100MB를 초과했으므로 파일업로드 실패함!!");
                     request.setAttribute("loc", request.getContextPath()+"/admin/productRegister.sh"); 
                    
                     super.setViewPage("/WEB-INF/msg.jsp");
                     return; // 종료
                       
                 }//end of try
                    
                 // === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
             
                 // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
               String fk_cnum = mtrequest.getParameter("fk_cnum");
          //     String cname = mtrequest.getParameter("cname");
          //     System.out.println(cname);
               String pname = mtrequest.getParameter("pname");
               /*
                * String filePath1 = uploadFileDir +
                * "\\"+ mtrequest.getFilesystemName("pimage1"); String filePath2 =
                * uploadFileDir + "\\"+ mtrequest.getFilesystemName("pimage1"); String
                * filePath3 = uploadFileDir + "\\"+ mtrequest.getFilesystemName("pimage1");
                * String filePath4 = uploadFileDir +
                * "\\"+ mtrequest.getFilesystemName("pimage1");
                */
               
               
               
             //  System.out.println(filePath);
               String pimage1 =  "/SemiProject/images/"+mtrequest.getFilesystemName("pimage1");
                String pimage2 =  "/SemiProject/images/"+mtrequest.getFilesystemName("pimage2");
                String pimage3 = "/SemiProject/images/"+ mtrequest.getFilesystemName("pimage3");
                String pimage4 =  "/SemiProject/images/"+mtrequest.getFilesystemName("pimage4");
                
                String pqty = mtrequest.getParameter("pqty");
                String price = mtrequest.getParameter("price");
                 String saleprice = mtrequest.getParameter("saleprice");
                 
                 
                 // 제품번호 채번 해오기                       제품번호는 유저가 화면에서 입력하지 않았다
                int pnum = pdao.getPnumOfProduct();
                
                // 카테고리 이름 알아오기
                String cname = pdao.getCname(fk_cnum);
                System.out.println(cname);
                
                ProductRealVO prvo = new ProductRealVO();
                prvo.setPnum(pnum);
                prvo.setFk_cnum(Integer.parseInt(fk_cnum));
                prvo.setPname(pname);
                prvo.setPimage1(pimage1);
                prvo.setPimage2(pimage2);
                prvo.setPimage3(pimage3);
                prvo.setPimage4(pimage4);
                prvo.setPqty(Integer.parseInt(pqty));
                prvo.setPrice(saleprice);
                prvo.setSaleprice(saleprice);
                
                String message = "";
                String loc = "";
                   
                   try {
                       //tbl_product 테이블에 제품정보 insert 하기    
                        pdao.productInsert(prvo);
                        
                        //나눠진 제품 테이블에서 insert 하기
                        pdao.selectproductInsert(prvo,cname);
                        
                        
                        message = "제품등록 성공!!";
                         loc = request.getContextPath()+"/index.sh"; 
                    
               } catch (SQLException e) {
                  e.printStackTrace();
                       
                       message = "제품등록 실패!!";
                       loc = request.getContextPath()+"/admin/productRegister.sh";
               }//end of try
                   
                request.setAttribute("message", message);
                 request.setAttribute("loc", loc);
                
                 super.setViewPage("/WEB-INF/msg.jsp");
         
          }//end of  if(!"post".equalsIgnoreCase(method)) {
          
      }
      else {
         
          // 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
            String message = "관리자만 접근이 가능합니다.";
            String loc = "javascript:history.back()";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
        
            super.setViewPage("/WEB-INF/msg.jsp");
      }//end of if(loginuser !=null && "admin".equals(loginuser.getUserid()) ){

   }//end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//==========================================================================================
}
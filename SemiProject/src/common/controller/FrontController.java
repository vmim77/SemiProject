package common.controller;

import java.io.*;
import java.lang.reflect.Constructor;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(
		description = "사용자가 웹에서 *.sh 을 했을 경우 이 서블릿이 먼저 응답을 해주도록 한다.", 
		urlPatterns = { "*.sh" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/NCS/workspace(jsp)/Subject/WebContent/WEB-INF/Command.properties", description = "*.sh 에 대한 클래스의 매핑파일")
		})
//================================================================================================
public class FrontController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	private Map<String, Object> cmdMap = new HashMap<>();
	
//================================================================================================
	public void init(ServletConfig config) throws ServletException {
	
		String props = config.getInitParameter("propertyConfig");

		FileInputStream fis = null;
		
		try {
			
			fis = new FileInputStream(props);
			Properties pr = new Properties();
			pr.load(fis);
			
			Enumeration<Object> en = pr.keys();
			
			while(en.hasMoreElements()) {
				
				String key = (String) en.nextElement();				
				
				String className = pr.getProperty(key);
				
				if(className != null) {
					
					className = className.trim();
		
					Class<?> cls = Class.forName(className);
	
					Constructor<?> constrt = cls.getDeclaredConstructor();
					
					Object obj = constrt.newInstance();
					
					cmdMap.put(key, obj);
					
				}//end of if------------------------------------------------
				 
			}//end of while-------------------------------------------------
			
		} catch (FileNotFoundException e) {
			System.out.println("Command.properties에 대한 클래스의 매핑파일 이 없습니다");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// 클래스가 없을 수 있기 때문에 exception 처리를 해야 함
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}//end of public void init(ServletConfig config) throws ServletException {--------------------
//================================================================================================
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String uri = request.getRequestURI();
		
		String key = uri.substring(request.getContextPath().length());  

		AbstractController action = (AbstractController) cmdMap.get(key);
		
		if(action == null) {
			System.out.println(">>> " + key + " 은 URI 패턴에 매핑된 클래스가 없습니다. <<<");
		}
		else {
			
			try {
				
				request.setCharacterEncoding("UTF-8");
				
				action.execute(request, response);

				boolean isRedirect = action.isRedirect();
				
				String viewPage = action.getViewPage();
				
				if(!isRedirect) {
					
					if(viewPage != null) {
						RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
	            		dispatcher.forward(request, response);
					}//end of if(viewPage != null) {-------------------------
					
				}
				else {

					if(viewPage != null) {
						response.sendRedirect(viewPage);
					}//end of if(viewPage != null) {-------------------------
					
				}//end of if----------------------------------------------------------------------
				
			} catch (Exception e) {
				e.printStackTrace();
			}		
			
		}//end of if------------------------------------------------------------------------------
		
	}//end of doGet-------------------------------------------------------------------------------
//================================================================================================
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}//end of doPost------------------------------------------------------------------------------
//================================================================================================
}
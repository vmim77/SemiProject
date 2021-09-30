package my.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/*
=== 필터란 ? ===
필터란 Servlet 2.3 버전에 추가된 것으로,
클라이언트의 요청을 서블릿이 받기 전에 가로채어 필터에 작성된 내용을 수행하는 것을 말한다. 
따라서 필터를 사용하면 클라이언트의 요청을 가로채서 서버 컴포넌트의 추가적인 다른 기능을 수행시킬 수 있다.

<< 필터 적용 순서 >>
1. Filter 인터페이스를 구현하는 자바 클래스를 생성.
2. /WEB-INF/web.xml 에 filter 엘리먼트를 사용하여 필터 클래스를 등록한다. 
   /WEB-INF/web.xml 에 filter 엘리먼트를 사용하여 필터 클래스를 등록하는데
        하지만 web.xml 을 사용하지 않고 @WebFilter 어노테이션을 많이 사용한다.

*/



@WebFilter("/*")
public class EncodeFilter implements Filter {
//========================================================================================
	public void destroy() {
		// 필터 인스턴스를 종료시키기 전에 호출되는 메소드 
	    // 지금은 여기에 기술할 것이 없다.
	}
//========================================================================================
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/* 
	    ====================== 필터의 로직을 작성 해주는 곳 ====================== 
    
        post 방식으로 넘어온 데이터중 영어는 글자가 안깨지지만,
                한글은 글자모양이 깨져나온다.
                그래서  post 방식에서 넘어온 한글 데이터가 글자가 안깨지게 하려면 
                아래처럼 request.setCharacterEncoding("UTF-8"); 을 해야 한다.
                주의할 것은 request.getParameter("변수명"); 보다 먼저 기술을 해주어야 한다는 것이다.
		*/
		
		request.setCharacterEncoding("UTF-8");
		
		chain.doFilter(request, response);
	}
//========================================================================================
	
	public void init(FilterConfig fConfig) throws ServletException {
		// 서블릿 컨테이너가 필터 인스턴스를 초기화하기 위해서 호출되는 메소드 
	    // 지금은 여기에 기술할 것이 없다.
	}
//========================================================================================
}

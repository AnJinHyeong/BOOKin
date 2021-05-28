package semi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
      "/qna/qnaInsert.jsp", "/qna/qnaDetail.jsp" ,
      "/qna/qnaMyList.jsp"
})
public class MemberFilter implements Filter{
   @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
         throws IOException, ServletException {
      //통과 = 로그인 상태 = HttpSession에 memberNo가 존재하는 상황
      //차단 = 로그아웃 상태 = HttpSession에 memberNo가 존재하지 않는 상황
      HttpServletRequest req = (HttpServletRequest) request;
      HttpServletResponse resp = (HttpServletResponse) response;
      
      boolean isLogin = req.getSession().getAttribute("member") != null;
      
      if(isLogin) {
         chain.doFilter(request, response);
      }
      else {
         resp.sendRedirect(req.getContextPath()+"/member/login.jsp");
      }
   }
}
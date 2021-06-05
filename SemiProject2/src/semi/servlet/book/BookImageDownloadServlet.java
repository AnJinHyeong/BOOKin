package semi.servlet.book;
 
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookDao;
import semi.beans.BookDto;


@WebServlet(urlPatterns = "/book/bookImage.kh")
public class BookImageDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			서버 입장에서 다운로드는 파일의 내용을 사용자에게 전송하는 것을 말한다.
//			= 파일의 내용만 보내면 이름 등을 알 수 없다.
//			= 파일의 이름을 알려줘야 한다.
//			= 파일의 크기를 알려주어 진행상황을 표시할 수 있도록 해야 한다.
//			= 파일의 유형을 알려줘야 한다.
//			= 편지봉투(파일이름,유형,크기) + 편지지(파일내용)
//			= 파일은 일반적인 전송형태가 아니기 때문에 위의 내용들을 "수동"으로 설정해야 한다.
			
//			1. 준비물을 수신한다(profileNo)
			int no = Integer.parseInt(req.getParameter("bookNo"));
			BookDao bookDao = new BookDao();
			BookDto bookDto = bookDao.get(no);
;//			2. profileNo를 이용하여 프로필 파일 정보를 불러온다.
			
//			3. studentProfileDto의 정보를 토대로 사용자에게 알려줄 내용들을 설정한다(HttpHeader설정)
//			= Content-Type : 사용자에게 보낼 데이터의 형태
//			= Content-Encoding : 사용자에게 보낼 데이터의 인코딩 방식
//			= Content-Length : 사용자에게 보낼 데이터의 크기
//			= Content-Disposition : 사용자에게 보낼 데이터의 이름(attachment가 붙으면 다운로드가 수행)
//			= 파일명에 유니코드나 특수문자가 있는 경우 정상적으로 전송되지 않는다
//			= java.net.URLEncoder라는 클래스의 encode 명령을 사용하여 분해 후 전송
			String fileName = URLEncoder.encode(bookDto.getBookImage(), "UTF-8");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"\"");
			
//			4. 파일 정보를 불러와서 사용자에게 전송(File 입력 후 네트워크 출력)
			File dir = new File("D:/upload");
//			File dir = new File("/Users/anjinhyeong/git/upload");
//			File dir = new File("C:/Users/Jeon/upload");
			File target = new File(dir, bookDto.getBookImage());
			
			byte[] buffer = new byte[1024];
			FileInputStream in = new FileInputStream(target);
			
			while(true) {
				int size = in.read(buffer);
				if(size == -1) break;
				resp.getOutputStream().write(buffer, 0, size);
			}
			
			in.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}

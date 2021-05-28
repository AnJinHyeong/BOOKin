package semi.beans;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// 데이터베이스 관련된 유용한 작업들을 수행
public class JdbcUtils {
	
//	연결기능
//	= 테이블 종류와 무관하게 전체적으로 이용해야 하므로 객체 생성없이 쉽게 접근하도록 정적(static) 등록
	private static DataSource ds;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracle");
		}
		catch(Exception e) {
			System.err.println("데이터 연결 실패");
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws Exception{
		return ds.getConnection();
	}
	
}

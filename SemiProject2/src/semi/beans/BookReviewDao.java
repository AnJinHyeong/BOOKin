package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookReviewDao {

//	해당 책 리뷰 목록
	public List<BookReviewDto> list(int bookNo,int startRow, int endRow) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from(\n"
				+ "select rownum rn, TMP.* from(\n"
				+ "		select * from review where review_book = ? order by review_time desc"
				+ "	)TMP\n"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookNo);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<BookReviewDto> list = new ArrayList<>();
		
		while(rs.next()) {
			BookReviewDto bookReviewDto = new BookReviewDto();
			
			bookReviewDto.setReviewNo(rs.getInt("review_no"));
			bookReviewDto.setReviewContent(rs.getString("review_content"));
			bookReviewDto.setReviewRate(rs.getInt("review_rate"));
			bookReviewDto.setReviewTime(rs.getDate("review_time"));			
			bookReviewDto.setReviewMember(rs.getInt("review_member"));
			bookReviewDto.setReviewBook(rs.getInt("review_book"));
			
			list.add(bookReviewDto);
			
		}
		
		con.close();
		return list;
	}
	
//	책 리뷰 개수 count
	public int count(int bookNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from review where review_book = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookNo);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int avg = rs.getInt("count(*)");
		
		con.close();
		return avg;
	}
	
//	책 리뷰 총 평점
	public int avg(int bookNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql ="select AVG(review_rate) from review where review_book = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookNo);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int avg = (int)rs.getDouble("AVG(review_rate)");
		
		con.close();
		return avg;
	}
	
}

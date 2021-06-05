package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewBookDao {

	
	//특정 멤버(본인)가 구매한 책리스트 출력
	public List<ReviewBookDto> memberList(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select \r\n"
				+ "    review_no,review_rate,review_content,review_time,review_purchase,\r\n"
				+ "    book_title,book_image\r\n"
				+ "from\r\n"
				+ "    purchase P \r\n"
				+ "        inner join review R on P.purchase_pk = R.review_purchase \r\n"
				+ "        inner join book B on p.purchase_book = B.book_no where purchase_member=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		
		
		List<ReviewBookDto> reviewMemberList=new ArrayList<>();
		while (rs.next()) {
			ReviewBookDto reviewBookDto = new ReviewBookDto(); 
			
			reviewBookDto.setReviewNo(rs.getInt("review_no"));
			reviewBookDto.setReviewContent(rs.getString("review_content"));
			reviewBookDto.setReviewRate(rs.getLong("review_rate"));
			reviewBookDto.setReviewTime(rs.getDate("review_time"));
			reviewBookDto.setReviewPurchase(rs.getInt("review_purchase"));
			
			reviewBookDto.setBookTitle(rs.getString("book_title"));
			reviewBookDto.setBookImage(rs.getString("book_image"));
			
			reviewMemberList.add(reviewBookDto);
			
						}
		con.close();
		
		return reviewMemberList;
	}
	
	//구매한 책 리스트 출력
	public List<ReviewBookDto> bookList(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select review_no,review_rate,review_content,review_time,review_purchase,book_title,book_image\r\n"
				+ "    from   \r\n"
				+ "        purchase P\r\n"
				+ "            left outer join review R on P.purchase_pk=R.review_purchase\r\n"
				+ "            left outer join book B on P.purchase_book = B.book_no";
		
	
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewBookDto> reviewBookList = new ArrayList<>();
		while(rs.next()) {
			ReviewBookDto reviewBookDto = new ReviewBookDto();
			reviewBookDto.setReviewNo(rs.getInt("review_no"));
			reviewBookDto.setReviewContent(rs.getString("review_content"));
			reviewBookDto.setReviewRate(rs.getLong("review_rate"));
			reviewBookDto.setReviewTime(rs.getDate("review_time"));
			reviewBookDto.setReviewPurchase(rs.getInt("review_purchase"));
			
			reviewBookDto.setBookTitle(rs.getString("book_title"));
			reviewBookDto.setBookImage(rs.getString("book_image"));
			
			reviewBookList.add(reviewBookDto);	
		}
con.close();

return reviewBookList;
			
		}
		
	
	
	
	
	
	
}

package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JdbcUtils;


public class ReviewDao {

		
	//리뷰 삭제
	public boolean delete(int reviewNo) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "delete review where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
//	리뷰 수정
	public boolean edit(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql ="update review set review_content=?,review_rate=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, reviewDto.getReviewContent());
		ps.setLong(2, reviewDto.getReviewRate());
		
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	
	
	
	//리뷰등록 
		public void registReview(ReviewDto reviewDto) throws Exception {
			Connection con = JdbcUtils.getConnection();

			String sql = "insert into review values(review_seq.nextval,?,?,sysdate,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			
			
			
			ps.setString(1, reviewDto.getReviewContent());
			ps.setLong(2, reviewDto.getReviewRate());
			ps.setInt(3, reviewDto.getReviewPurchase());
			ps.execute();

			con.close();
		}

		
		
	
	
	
	
	
	//리뷰 리스트
	public List<ReviewDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from review order by no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		//List로 변환
		List<ReviewDto> reviewList = new ArrayList<>();
		while(rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRate(rs.getLong("review_rate"));
			
			
			
			
			
			reviewList.add(reviewDto);
		}
		
		con.close();
		
		return reviewList;
	}
	
	public ReviewDto get(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from review where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();

		ReviewDto reviewDto;
		if (rs.next()) {
			reviewDto = new ReviewDto();

			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRate(rs.getLong("review_rate"));
			reviewDto.setReviewTime(rs.getDate("review_time"));

		} else {
			reviewDto = null;
		}

		con.close();

		return reviewDto;
		
		
	}
	
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
		
		
		List<ReviewBookDto> reviewList=new ArrayList<>();
		while (rs.next()) {
			ReviewBookDto reviewBookDto = new ReviewBookDto(); 
			
			reviewBookDto.setReviewNo(rs.getInt("review_no"));
			reviewBookDto.setReviewContent(rs.getString("review_content"));
			reviewBookDto.setReviewRate(rs.getLong("review_rate"));
			reviewBookDto.setReviewTime(rs.getDate("review_time"));
			reviewBookDto.setReviewPurchase(rs.getInt("review_purchase"));
			
			reviewBookDto.setBookTitle(rs.getString("book_title"));
			reviewBookDto.setBookImage(rs.getString("book_image"));
			
			reviewList.add(reviewBookDto);
			
						}
		con.close();
		
		return reviewList;
	}
	
	//디테일하단부 리뷰목록
	public List<ReviewMemberDto> bookList(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select \r\n"
				+ "    review_no,review_rate,review_content,review_time,review_purchase,\r\n"
				+ "    m.*\r\n"
				+ "from\r\n"
				+ "    purchase P \r\n"
				+ "        inner join review R on P.purchase_no = R.review_purchase \r\n"
				+ "        inner join member M on p.purchase_member = M.member_no where purchase_book=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		
		
		List<ReviewMemberDto> reviewList=new ArrayList<>();
		while (rs.next()) {
			ReviewMemberDto reviewMemberDto = new ReviewMemberDto(); 
			
			reviewMemberDto.setReviewNo(rs.getInt("review_no"));
			reviewMemberDto.setReviewContent(rs.getString("review_content"));
			reviewMemberDto.setReviewRate(rs.getLong("review_rate"));
			reviewMemberDto.setReviewTime(rs.getDate("review_time"));
			reviewMemberDto.setReviewPurchase(rs.getInt("review_purchase"));
			reviewMemberDto.setMemberId(rs.getString("member_id"));
		
			
			reviewList.add(reviewMemberDto);
			
						}
		con.close();
		
		return reviewList;
	}
	
}

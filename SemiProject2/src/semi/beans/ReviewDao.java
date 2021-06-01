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

			String sql = "insert into review values(review_seq.nextval,?,?,sysdate)";
			PreparedStatement ps = con.prepareStatement(sql);
			
			
			
			ps.setString(1, reviewDto.getReviewContent());
			ps.setLong(2, reviewDto.getReviewRate());
			
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
	
	
	
}

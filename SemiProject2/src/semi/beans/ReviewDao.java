package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDao {

	// 리뷰 삭제
	public boolean delete(int reviewNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		;

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

		String sql = "update review set review_content=?,review_rate=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, reviewDto.getReviewContent());
		ps.setLong(2, reviewDto.getReviewRate());

		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 리뷰등록
	public void registReview(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into review values(review_seq.nextval,?,?,sysdate,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, reviewDto.getReviewContent());
		ps.setLong(2, reviewDto.getReviewRate());
		ps.setInt(3, reviewDto.getReviewBook());
		ps.setInt(4, reviewDto.getReviewMember());
		ps.execute();

		con.close();
	}

//	리뷰 전체 리스트 조회
	public List<ReviewDto> list(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from(\r\n"
				+ "select rownum rn, TMP.* from(\r\n"
				+ "	SELECT * FROM review ORDER BY review_no desc \r\n"
				+ "	)TMP\r\n"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<ReviewDto> reviewList = new ArrayList<>();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRate(rs.getLong("review_rate"));
			reviewDto.setReviewTime(rs.getDate("review_time"));
			reviewDto.setReviewBook(rs.getInt("review_book"));
			reviewDto.setReviewMember(rs.getInt("review_member"));
			
			reviewList.add(reviewDto);
		}

		con.close();

		return reviewList;
	}

//	리뷰 개수 조회
	public int get() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "SELECT count(*) FROM review";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
	//  페이지블럭 계산을 위한 카운트 기능(1:1문의 확인)
	public int getCountMyList(int qnaBoardWriter) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from qna_board where qna_board_writer=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardWriter);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	public boolean isPurchase(int purchaseBook, int purchaseMember) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from purchase where purchase_book=? and purchase_member=?";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setInt(1, purchaseBook);
		ps.setInt(2, purchaseMember);
		ResultSet rs = ps.executeQuery();
				
		boolean count=rs.next();
		con.close();
		
		return count;
	}
	
	public boolean isReview(int purchaseBook, int purchaseMember) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from review where review_book=? and review_member=?";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setInt(1, purchaseBook);
		ps.setInt(2, purchaseMember);
		ResultSet rs = ps.executeQuery();
				
		boolean count=rs.next();
		con.close();
		
		return count;
	}
	

}

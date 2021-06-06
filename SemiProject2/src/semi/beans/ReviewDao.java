package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import semi.beans.JdbcUtils;


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


		String sql = "update review set review_content=?,review_rate=?,review_time=sysdate where review_member=? and review_book=? ";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, reviewDto.getReviewContent());
		ps.setLong(2, reviewDto.getReviewRate());

		ps.setInt(3, reviewDto.getReviewMember());
		ps.setInt(4, reviewDto.getReviewBook());

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

	// 리뷰작성된 리뷰 불러오기

	public List<ReviewBookDto> ReviewPurchaselist() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select R.* from purchase P left outer join review R on P.purchase_pk=R.review_purchase_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<ReviewBookDto> ReviewPurchaselist = new ArrayList<>();
		while (rs.next()) {
			ReviewBookDto reviewBookDto = new ReviewBookDto();
			reviewBookDto.setReviewNo(rs.getInt("R.review_no"));
			reviewBookDto.setReviewContent(rs.getString("R.review_content"));
			reviewBookDto.setReviewRate(rs.getInt("R.review_rate"));
			reviewBookDto.setBookNo(rs.getInt("purchase_book"));

			ReviewPurchaselist.add(reviewBookDto);
		}

		con.close();

		return ReviewPurchaselist;
	}

	// 리뷰 리스트
	public List<ReviewDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from review order by no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<ReviewDto> reviewList = new ArrayList<>();
		while (rs.next()) {
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
	// 디테일하단부 리뷰목록
		public List<ReviewMemberDto> bookList(int no) throws Exception {
			Connection con = JdbcUtils.getConnection();

			String sql = "select \r\n" + "    review_no,review_rate,review_content,review_time,review_purchase,\r\n"
					+ "    m.*\r\n" + "from\r\n" + "    purchase P \r\n"
					+ "        inner join review R on P.purchase_no = R.review_purchase \r\n"
					+ "        inner join member M on p.purchase_member = M.member_no where purchase_book=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();

			List<ReviewMemberDto> reviewList = new ArrayList<>();
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
	
//	특정 회원 리뷰 리스트 조회
	public List<BookReviewDto> memberNoList(int memberNo, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from(\r\n"
				+ "select rownum rn, TMP.* from(\r\n"
				+ "	SELECT R.*, b.book_image, b.book_title FROM review R"
				+ " inner join book B on R.review_book = B.book_no where review_member=? ORDER BY review_time desc \r\n"
				+ "	)TMP\r\n"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<BookReviewDto> reviewList = new ArrayList<>();
		while (rs.next()) {
			BookReviewDto reviewDto = new BookReviewDto();
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRate(rs.getInt("review_rate"));

			reviewDto.setReviewTime(rs.getDate("review_time"));
			reviewDto.setReviewBook(rs.getInt("review_book"));
			reviewDto.setReviewMember(rs.getInt("review_member"));
			reviewDto.setReviewBookUrl(rs.getString("book_image"));
			reviewDto.setReviewBookTitle(rs.getString("book_title"));

			reviewList.add(reviewDto);
		}

		con.close();

		return reviewList;
	}



//		리뷰 개수 조회
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
	
	//  페이지블럭 계산을 위한 카운트 기능
	public int getCountMyList(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from review where review_member=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

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

	
	public List<BookDto> isPurchaseNoReviewList(int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select p.purchase_book, r.review_no, B.*"
				+ "    from purchase P"
				+ "    left outer join review R"
				+ "        on p.purchase_book = r.review_book"
				+ "    left outer join book B"
				+ "        on p.purchase_book = b.book_no"
				+ "        where p.purchase_member = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		List<BookDto> list = new ArrayList<BookDto>();
		
		while(rs.next()) {
			if(rs.getInt("review_no") == 0) {
				BookDto bookDto = new BookDto();

				bookDto.setBookNo(rs.getInt("book_no"));
				bookDto.setBookTitle(rs.getString("book_title"));
				bookDto.setBookImage(rs.getString("book_image"));
				bookDto.setBookAuthor(rs.getString("book_author"));
				bookDto.setBookPrice(rs.getInt("book_price"));
				bookDto.setBookDiscount(rs.getInt("book_discount"));
				bookDto.setBookPublisher(rs.getString("book_publisher"));
				bookDto.setBookDescription(rs.getString("book_description"));
				bookDto.setBookPubDate(rs.getDate("book_pubdate"));
				bookDto.setBookGenreNo(rs.getLong("book_genre"));
				bookDto.setBookView(rs.getInt("book_view"));
				
				list.add(bookDto);				
			}
		}
		
		con.close();
		
		return list;
	}
	
	public int getTodayReview() throws Exception {
		int count=0;
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from review where review_time between TO_DATE(sysdate, 'yy-mm-dd') and  TO_DATE(sysdate+1, 'yy-mm-dd')";
		PreparedStatement ps =con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			count=rs.getInt(1);
		}	
		con.close();
		
		return count;
	}
}

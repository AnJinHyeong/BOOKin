package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import semi.beans.JdbcUtils;
import semi.beans.BookDto;

public class BookDao {

	// 등록 기능

	public BookDto get(Long no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from book where book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, no);
		ResultSet rs = ps.executeQuery();

		BookDto bookDto;
		if (rs.next()) {
			bookDto = new BookDto();

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

		} else {
			bookDto = null;
		}

		con.close();

		return bookDto;
	}

	public List<BookDto> genreList(Long genreNo, int num) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from (  " + "    select tmp.*,rownum rn from "
				+ "        (select * from book where book_genre like '"
				+ genreNo + "%' order by book_no desc" + "    )tmp"
				+ ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, num * 20 - 19);
		ps.setInt(2, num * 20);
		ResultSet rs = ps.executeQuery();
		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));
			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	public List<BookDto> list(int num) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from (  " + "    select tmp.*,rownum rn from "
				+ "        (select * from book order by book_no desc"
				+ "    )tmp" + ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, num * 20 - 19);
		ps.setInt(2, num * 20);
		ResultSet rs = ps.executeQuery();
		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));
			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	public List<BookDto> genreSearch(long no) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from book where book_genre=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, no);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));

			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	public boolean delete(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "delete book where book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	// 정보 수정 기능
	public boolean edit(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update book set book_title=?, book_image=?,book_author,book_price,"
				+ "book_discount,book_publisher=?,book_description=?,book_pubdate=?,book_genre=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookDto.getBookTitle());
		ps.setString(2, bookDto.getBookImage());
		ps.setString(3, bookDto.getBookAuthor());
		ps.setInt(4, bookDto.getBookPrice());
		ps.setInt(5, bookDto.getBookDiscount());
		ps.setString(6, bookDto.getBookPublisher());
		ps.setString(8, bookDto.getBookDescription());
		ps.setDate(9, bookDto.getBookPubDate());
		ps.setLong(10, bookDto.getBookGenreNo());
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	// 제목검색
	public List<BookDto> titleSearch(String keyword, int startRow, int endRow)
			throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select * from(" + "select rownum rn, TMP.* from("
				+ "select * from book where instr(book_title,?)>0 " + ")TMP"
				+ ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));

			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	// 저자 검색
	public List<BookDto> authorSearch(String keyword, int startRow, int endRow)
			throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select * from(" + "select rownum rn, TMP.* from("

				+ "select * from book where instr(book_author,?)>0 " + ")TMP"
				+ ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));

			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	// 출판사 검색
	public List<BookDto> publisherSearch(String keyword, int startRow,
			int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select * from(" + "select rownum rn, TMP.* from("

				+ "select * from book where instr(book_publisher,?)>0  "
				+ ")TMP" + ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));

			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	// 책등록
	public void registBook(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into book values(book_seq.nextval,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, bookDto.getBookTitle());
		ps.setString(2, bookDto.getBookImage());
		ps.setString(3, bookDto.getBookAuthor());
		ps.setInt(4, bookDto.getBookPrice());
		ps.setInt(5, bookDto.getBookDiscount());
		ps.setString(6, bookDto.getBookPublisher());
		ps.setString(7, bookDto.getBookDescription());
		ps.setDate(8, bookDto.getBookPubDate());
		ps.setLong(9, bookDto.getBookGenreNo());

		ps.execute();

		con.close();
	}

	// 책 목록

	public List<BookDto> bookList(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select * from(" + "select rownum rn, TMP.* from("

				+ "select * from book "

				+ "order by book_no asc " + ")TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		while (rs.next()) {
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(rs.getInt("book_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookPubDate(rs.getDate("book_date"));

			bookDto.setBookGenreNo(rs.getInt("book_genre"));

			bookList.add(bookDto);
		}
		con.close();
		return bookList;
	}

	// 페이지블럭 계산을 위한 카운트 기능(title)
	public int getTitleCount(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select count(*) from book where instr(book_title,?)>0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	// 페이지블럭 계산을 위한 카운트 기능(author)
	public int getAuthorCount(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select count(*) from book where instr(book_author,?)>0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	// 페이지블럭 계산을 위한 카운트 기능(publisher)
	public int getPublisherCount(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();;

		String sql = "select count(*) from book where instr(book_publisher,?)>0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

}

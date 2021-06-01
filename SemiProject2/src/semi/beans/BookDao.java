package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookDao {

	// 등록 기능

	public BookDto get(int no) throws Exception {
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
			bookDto.setBookView(rs.getInt("book_view"));

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
			bookDto.setBookView(rs.getInt("book_view"));
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
			bookDto.setBookView(rs.getInt("book_view"));
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
			bookDto.setBookView(rs.getInt("book_view"));

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

		String sql = "update book set book_title=?, book_image=?,book_author=?,book_price=?,"
				+ "book_discount=?,book_publisher=?,book_description=?,book_pubdate=?,book_genre=? where book_no=?";
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
		ps.setInt(10, bookDto.getBookNo());
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
			bookDto.setBookView(rs.getInt("book_view"));

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
			bookDto.setBookView(rs.getInt("book_view"));

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
			bookDto.setBookView(rs.getInt("book_view"));

			bookList.add(bookDto);
		}

		con.close();

		return bookList;
	}

	
	public int getSequence() throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select book_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int bookNo = rs.getInt(1);
		
		con.close();
		return bookNo;
	}
	
	// 책등록
	public void registBook(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into book values(book_seq.nextval,?,?,?,?,?,?,?,?,?,0)";
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
			bookDto.setBookView(rs.getInt("book_view"));

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
	
	public List<BookDto> adminSearch(String title,String author,String publisher,long genreNo) throws Exception{
		List<BookDto> bookList = new ArrayList<>();
		if(title.equals("")&&author.equals("")&&publisher.equals("")) {
			return bookList;
		}
		Connection con = JdbcUtils.getConnection();;
		Map<String,String> keywordMap = new HashMap<>();
		if(!title.equals(""))keywordMap.put("book_title",title);
		if(!author.equals(""))keywordMap.put("book_author",author);
		if(!publisher.equals(""))keywordMap.put("book_publisher",publisher);
		String sql = "select * from book ";
		int count=0;
		for ( String key : keywordMap.keySet() ) {
			if(count==0) {
				sql+="where instr("+key+",'"+keywordMap.get(key)+"')>0  ";
				count+=1;
			}else {
				sql+="and instr("+key+",'"+keywordMap.get(key)+"')>0 ";
			}
		}
		if(genreNo!=0) {
			if(count==0) {
				sql+="where book_genre="+genreNo;
			}else {
				sql+="and book_genre="+genreNo;
			}
		}
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		
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

	
//	조회수 증가 기능 : 책 상세 페이지 들어온 경우 조회수 증가
	public boolean bookView(int bookNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update book "
					+ "set book_view = book_view + 1 "
					+ "where book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
//	조회수 탑 10 인기 도서 
	public List<BookDto> bookViewTop(int startRow, int endRow) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from(\n"
				+ "select rownum rn, TMP.* from(\n"
						+ "	select * from book order by book_view desc \n"
					+ "	)TMP\n"
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
			bookDto.setBookImage(rs.getString("book_image"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPrice(rs.getInt("book_price"));
			bookDto.setBookDiscount(rs.getInt("book_discount"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDescription(rs.getString("book_description"));
			bookDto.setBookPubDate(rs.getDate("book_pubdate"));
			bookDto.setBookGenreNo(rs.getLong("book_genre"));
			bookDto.setBookView(rs.getInt("book_view"));

			bookList.add(bookDto);
		}
		con.close();
		return bookList;
	}
	
}

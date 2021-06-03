package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookLikeDao {	
	public List<BookLikeDto> list(int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from book_like where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		List<BookLikeDto> list = new ArrayList<BookLikeDto>();
		while(rs.next()) {
			BookLikeDto bookLikeDto = new BookLikeDto();
			bookLikeDto.setMemberNo(rs.getInt("member_no"));
			bookLikeDto.setBookOrigin(rs.getInt("book_origin"));
			list.add(bookLikeDto);
						
		}
		
		con.close();
		return list;
	}
	
	public List<BookLikeDto> list(int memberNo, int startRow, int endRow) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from( " + "	select rownum rn, TMP.* from( "
					+ "	select * from book_like where member_no=? order by like_time desc " 
					+ "	)TMP "
					+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<BookLikeDto> list = new ArrayList<BookLikeDto>();
		while(rs.next()) {
			BookLikeDto bookLikeDto = new BookLikeDto();
			bookLikeDto.setMemberNo(rs.getInt("member_no"));
			bookLikeDto.setBookOrigin(rs.getInt("book_origin"));
			list.add(bookLikeDto);						
		}
		
		con.close();
		return list;
	}
	
	public int getCount(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from book_like where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
	public boolean delete(BookLikeDto bookLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete book_like where member_no = ? and book_origin = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookLikeDto.getMemberNo());
		ps.setInt(2, bookLikeDto.getBookOrigin());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
	
	public void insert(BookLikeDto bookLikeDto) throws Exception {
        Connection con = JdbcUtils.getConnection();
        
        String sql = "insert into book_like values(?, ?, sysdate)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, bookLikeDto.getMemberNo());
		ps.setInt(2, bookLikeDto.getBookOrigin());
        ps.execute();
       
        con.close();
    }
}

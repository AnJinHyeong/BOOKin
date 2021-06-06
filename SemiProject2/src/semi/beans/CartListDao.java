package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartListDao {
	 public List<CartListDto> priceList (int memberNo) throws Exception {
		 Connection con = JdbcUtils.getConnection();
		 
		 String sql = "select book_price, book_discount, cart_amount, cart_no from cart_view where member_no = ?";
		 PreparedStatement ps = con.prepareStatement(sql);
		 ps.setInt(1, memberNo);
		 ResultSet rs = ps.executeQuery();
		 
		 List<CartListDto> priceList = new ArrayList<>();
         while(rs.next()) {
            CartListDto cartListDto = new CartListDto();
           
            cartListDto.setBookPrice(rs.getInt("book_price"));
            cartListDto.setBookDiscount(rs.getInt("book_discount"));
            cartListDto.setCartAmount(rs.getInt("cart_amount"));
            cartListDto.setCartNo(rs.getInt("cart_no"));
            
            priceList.add(cartListDto);
         }
         con.close();
         return priceList;
	 }
			 
	 
   // 목록기능
      public List<CartListDto> list(int memberNo, int startRow, int endRow) throws Exception {
         Connection con = JdbcUtils.getConnection();
         
         String sql = "select * from( " + "   select rownum rn, TMP.* from( "
               + "      select * from cart_view where member_no = ? order by cart_no desc " 
               + "   )TMP "
               + ") where rn between ? and ?";
         PreparedStatement ps = con.prepareStatement(sql);
         ps.setInt(1, memberNo);
         ps.setInt(2, startRow);
         ps.setInt(3, endRow);
         ResultSet rs = ps.executeQuery();
         
         // List
         List<CartListDto> cartList = new ArrayList<>();
         while(rs.next()) {
            CartListDto cartListDto = new CartListDto();
            cartListDto.setCartNo(rs.getInt("cart_no"));
            cartListDto.setMemberNo(rs.getInt("member_no"));
            cartListDto.setCartAmount(rs.getInt("cart_amount"));
            cartListDto.setCartTime(rs.getDate("cart_time"));
            
            cartListDto.setBookNo(rs.getInt("book_no"));
            cartListDto.setBookTitle(rs.getString("book_title"));
            cartListDto.setBookImage(rs.getString("book_image"));
            cartListDto.setBookAuthor(rs.getString("book_author"));
            cartListDto.setBookPrice(rs.getInt("book_price"));
            cartListDto.setBookDiscount(rs.getInt("book_discount"));
            
            cartList.add(cartListDto);
         }
         con.close();
         return cartList;
      }
      
//   	title 조회 목록 기능
  	public List<CartListDto> titleList(String bookTitle, int memberNo, int startRow, int endRow) throws Exception {
  		Connection con = JdbcUtils.getConnection();
  	
  		String sql = "select * from( " + "	select rownum rn, TMP.* from( "
  				+ "		select * from cart_view where book_title=? and member_no = ? order by cart_no desc " 
  				+ "	)TMP "
  				+ ") where rn between ? and ?";
  		PreparedStatement ps = con.prepareStatement(sql);
  		ps.setString(1, bookTitle);
  		ps.setInt(2, memberNo);
  		ps.setInt(3, startRow);
  		ps.setInt(4, endRow);
  		ResultSet rs = ps.executeQuery();
  		
  		 List<CartListDto> cartList = new ArrayList<>();
         while(rs.next()) {
            CartListDto cartListDto = new CartListDto();
            cartListDto.setCartNo(rs.getInt("cart_no"));
            cartListDto.setMemberNo(rs.getInt("member_no"));
            cartListDto.setCartAmount(rs.getInt("cart_amount"));
            cartListDto.setCartTime(rs.getDate("cart_time"));
            
            cartListDto.setBookNo(rs.getInt("book_no"));
            cartListDto.setBookTitle(rs.getString("book_title"));
            cartListDto.setBookImage(rs.getString("book_image"));
            cartListDto.setBookAuthor(rs.getString("book_author"));
            cartListDto.setBookPrice(rs.getInt("book_price"));
            cartListDto.setBookDiscount(rs.getInt("book_discount"));
            
            cartList.add(cartListDto);
         }
         con.close();
         return cartList;
  	}
  	
  //  전체목록 페이지블럭 계산을 위한 카운트 기능(목록/검색)
  	public int getCount(int memberNo) throws Exception {
  		Connection con = JdbcUtils.getConnection();

  		String sql = "select count(*) from cart_view where member_no = ?";
  		PreparedStatement ps = con.prepareStatement(sql);
  		ps.setInt(1, memberNo);

  		ResultSet rs = ps.executeQuery();
  		rs.next();
  		int count = rs.getInt(1);

  		con.close();

  		return count;
  	}
  	
  	public int getCountTitle(String bookTitle, int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from cart_view where book_title=? and member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookTitle);
		ps.setInt(2, memberNo);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
}
}
package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
	
	public int getSequence() throws Exception {
			Connection con = JdbcUtils.getConnection();

			String sql = "select cart_seq.nextval from dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int no = rs.getInt(1);

			con.close();
			return no;
	}
	
	// 장바구니 확인 기능
		public boolean check(CartDto cartDto)throws Exception {
			Connection con = JdbcUtils.getConnection();
			String sql = "select * from cart where book_no = ? and member_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cartDto.getBookNo());
			ps.setInt(2, cartDto.getMemberNo());
			ResultSet rs = ps.executeQuery();
			boolean result = rs.next();
			con.close();
			return result;
	}	

	// 장바구니 담기
	public void insert(CartDto cartDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
        
        String sql = "insert into cart values(cart_seq.nextval, ?, ?, ?, sysdate)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, cartDto.getMemberNo());
        ps.setInt(2, cartDto.getBookNo());
        ps.setInt(3, cartDto.getCartAmount());
        ps.execute();
        
        con.close();
	}
	
	// 수량변경
	public boolean edit(CartDto cartDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update cart set cart_amount=cart_amount + ? where book_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cartDto.getCartAmount());
		ps.setInt(2, cartDto.getBookNo());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	
	// 삭제 = 제거하거나 구매후
	public boolean delete(CartDto cartDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete cart where cart_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cartDto.getCartNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	// 구매 후 장바구니에서 삭제
		public boolean delete(int memberNo, int bookNo) throws Exception{
			Connection con = JdbcUtils.getConnection();
			
			String sql = "delete cart where member_no = ? and book_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			ps.setInt(2, bookNo	);
			int count = ps.executeUpdate();
			
			con.close();
			
			return count > 0;
		}
	
	public boolean deleteAll(int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete cart where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	
	 // 목록기능
	   public List<CartDto> list(int startRow, int endRow) throws Exception {
		   Connection con = JdbcUtils.getConnection();
		   
		   String sql = "select * from( " + "	select rownum rn, TMP.* from( "
					+ "		select * from cart order by cart_no desc " 
					+ "	)TMP "
					+ ") where rn between ? and ?";
		   PreparedStatement ps = con.prepareStatement(sql);
		   ps.setInt(1, startRow);
		   ps.setInt(2, endRow);
		   ResultSet rs = ps.executeQuery();
		   
		   // List
		   List<CartDto> cartList = new ArrayList<>();
		   while(rs.next()) {
			   CartDto cartDto = new CartDto();
			   cartDto.setCartNo(rs.getInt("cart_no"));
			   cartDto.setMemberNo(rs.getInt("member_no"));
			   cartDto.setBookNo(rs.getInt("book_no"));
			   cartDto.setCartAmount(rs.getInt("cart_amount"));
			   cartDto.setCartTime(rs.getDate("cart_time"));
			   
			   cartList.add(cartDto);
		   }
		   con.close();
		   return cartList;
	   }
	}
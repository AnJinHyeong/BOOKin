package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
		
		String sql = "update cart set cart_amount=? where cart_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cartDto.getCartAmount());
		ps.setInt(2, cartDto.getCartNo());
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
	
	
	
	
	
	
}

package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PurchaseBookMemberDao {

	//	마이페이지 구매 / 배송 리스트
		public List<PurchaseBookMemberDto> myList(int memberNo, int startRow, int endRow) throws Exception{
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from(\n"
					+ "select rownum rn, TMP.* from(\n"
						+ "	 select \n"
						+ "	P.*,\n"
						+ "	book_title,book_price,book_discount\n"
						+ "from purchase P\n"
						+ "    inner join book on book_no = purchase_book\n"
						+ "    inner join member on member_no = PURCHASE_MEMBER where purchase_member = ? ORDER BY purchase_pk desc\n"
					+ "	)TMP\n"
					+ ") where rn between ? and ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();
			
			List<PurchaseBookMemberDto> list = new ArrayList<>();
			while(rs.next()) {
				PurchaseBookMemberDto purchaseBookMemberDto = new PurchaseBookMemberDto();
				
				purchaseBookMemberDto.setPurchasePk(rs.getInt("purchase_pk"));
				purchaseBookMemberDto.setPurchaseNo(rs.getInt("purchase_no"));
				purchaseBookMemberDto.setPurchaseState(rs.getString("purchase_state"));
				purchaseBookMemberDto.setPurchaseBook(rs.getInt("purchase_book"));
				purchaseBookMemberDto.setPurchaseMember(rs.getInt("purchase_member"));
				purchaseBookMemberDto.setPurchaseDate(rs.getDate("purchase_date"));
				purchaseBookMemberDto.setPurchaseRecipient(rs.getString("purchase_recipient"));
				purchaseBookMemberDto.setPurchasePhone(rs.getString("purchase_phone"));
				purchaseBookMemberDto.setPurchaseAddress(rs.getString("purchase_address"));
				purchaseBookMemberDto.setPurchaseAmount(rs.getInt("purchase_amount"));
				
				purchaseBookMemberDto.setBookTitle(rs.getString("book_title"));
				purchaseBookMemberDto.setBookPrice(rs.getInt("book_price"));
				purchaseBookMemberDto.setBookDiscount(rs.getInt("book_discount"));
				
				list.add(purchaseBookMemberDto);
				
			}
			con.close();
			return list;
		}
		
	//  전체목록 페이지블럭 계산을 위한 카운트 기능(목록/검색)
		public int getCoun(int memberNo) throws Exception {
			Connection con = JdbcUtils.getConnection();

			String sql = "select \n"
					+ "	COUNT(*) \n"
					+ "from purchase P\n"
					+ "    inner join book on book_no = purchase_book\n"
					+ "    inner join member on member_no = PURCHASE_MEMBER where purchase_member = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);

			con.close();

			return count;
		}
	
	
//	구매기록 상태 업데이트
	public boolean stateUpdate(int purchaseNo, String purchaseState, int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "UPDATE purchase SET purchase_state = ? WHERE purchase_no = ? AND purchase_member = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, purchaseState);
		ps.setInt(2, purchaseNo);
		ps.setInt(3, memberNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
		

//	구매기록 상태 업데이트
	public boolean delete(int purchaseNo, int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete purchase where purchase_no = ? and purchase_member =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, purchaseNo);
		ps.setInt(2, memberNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
		
}

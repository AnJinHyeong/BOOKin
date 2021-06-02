package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PurchaseDao {
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "select purchase_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		
		con.close();
		return no;
	}
	
	public PurchaseDto get(int no) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from purchase where purchase_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();

		PurchaseDto purchaseDto;
		if (rs.next()) {
			purchaseDto = new PurchaseDto();

			purchaseDto.setPurchaseNo(rs.getInt("purchase_no"));
			purchaseDto.setPurchaseState(rs.getString("purchase_state"));
			purchaseDto.setPurchaseTracking(rs.getInt("purchase_tracking"));
			purchaseDto.setPurchaseBook(rs.getInt("purchase_book"));
			purchaseDto.setPurchaseDate(rs.getDate("purchase_date"));
			
		} else {
			purchaseDto = null;
		}

		con.close();

		return purchaseDto;
		
		
	}
	
	
}

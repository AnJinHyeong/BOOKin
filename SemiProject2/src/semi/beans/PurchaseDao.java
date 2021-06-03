

package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PurchaseDao {

	public int getNumber() throws Exception{
		Connection con=JdbcUtils.getConnection();
		String sql="select purchase_seq.nextval from dual";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count=rs.getInt(1);
		con.close();
		return count;
		
	}
	
	public PurchaseDto get(int no) throws Exception{
		Connection con=JdbcUtils.getConnection();
		String sql="select * from purchase where purchase_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		
		PurchaseDto purchaseDto;
		if(rs.next()) {
			purchaseDto=new PurchaseDto();
			purchaseDto.setPurchasePk(rs.getInt("purchase_pk"));
			purchaseDto.setPurchaseNo(rs.getInt("purchase_no"));
			purchaseDto.setPurchaseState(rs.getString("purchase_state"));
			purchaseDto.setPurchaseBook(rs.getInt("purchase_book"));
			purchaseDto.setPurchaseMember(rs.getInt("purchase_member"));
			purchaseDto.setPurchaseDate(rs.getDate("purchase_date"));
			purchaseDto.setPurchaseRecipient(rs.getString("purchase_recipient"));
			purchaseDto.setPurchasePhone(rs.getString("purchase_phone"));
			purchaseDto.setPurchaseAddress(rs.getString("purchase_address"));
			purchaseDto.setPurchaseAmount(rs.getInt("purchase_amount"));
		}else {
			purchaseDto=null;
		}
		con.close();
		return purchaseDto;

	}
	public void insert(PurchaseDto purchaseDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="insert into purchase values(purchase_pk_seq.nextval,?,'결제완료',?,?,sysdate,?,?,?,?)";
				
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, purchaseDto.getPurchaseNo());
		ps.setInt(2, purchaseDto.getPurchaseBook());
		ps.setInt(3, purchaseDto.getPurchaseMember());
		ps.setString(4,purchaseDto.getPurchaseRecipient());
		ps.setString(5, purchaseDto.getPurchasePhone());
		ps.setString(6, purchaseDto.getPurchaseAddress());
		ps.setInt(7, purchaseDto.getPurchaseAmount());

		ps.execute();
		con.close();
	}
	
}


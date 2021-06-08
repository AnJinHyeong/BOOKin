package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			
			purchaseDto.setPurchaseNo(rs.getInt("purchase_no"));
			purchaseDto.setPurchaseState(rs.getString("purchase_state"));
			purchaseDto.setPurchaseBook(rs.getInt("purchase_book"));
			purchaseDto.setPurchaseMember(rs.getInt("purchase_member"));
			purchaseDto.setPurchaseDate(rs.getDate("purchase_date"));
			purchaseDto.setPurchaseRecipient(rs.getString("purchase_recipient"));
			purchaseDto.setPurchasePhone(rs.getString("purchase_phone"));
			purchaseDto.setPurchaseAddress(rs.getString("purchase_address"));
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
	
	public List<List<String>> purchaseSearch(String startDate,String endDate,String type,String keyword,String dType) throws Exception{
		if(startDate==null) {
			return null;
		}
		Connection con = JdbcUtils.getConnection();
		String sql = "select purchase_no,book_no,purchase_amount,PURCHASE_STATE,PURCHASE_DATE,PURCHASE_RECIPIENT,PURCHASE_ADDRESS,PURCHASE_PHONE,book_price,book_discount from purchase "
				+ "    inner join book on book_no = purchase_book "
				+ "    inner join member on member_no = PURCHASE_MEMBER "
				+ "    where PURCHASE_DATE between ? and ? ";
		if(type!=null) {
			if(type.equals("purchaseNo")) {
				sql+=" and purchase_no="+keyword;
			}else if(type.equals("bookNo")) {
				sql+=" and book_no="+keyword;
			}else if(type.equals("purchaseRecipient")) {
				sql+=" and instr(PURCHASE_RECIPIENT,'"+keyword+"')>0";
			}else {
				
			}
		}
		System.out.println(type + "  " +keyword);
		if(dType.equals("전체")) {
			
		}else {
			sql+=" and PURCHASE_STATE='"+dType+"'";
		}
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, startDate);
		ps.setString(2, endDate);
		
		ResultSet rs = ps.executeQuery();
		List<List<String>> purList = new ArrayList<>();
		while(rs.next()) {
			List<String> temp = new ArrayList<>();
			temp.add(rs.getString(1));
			temp.add(rs.getString(2));
			temp.add(rs.getString(3));
			temp.add(rs.getString(4));
			temp.add(rs.getString(5));
			temp.add(rs.getString(6));
			temp.add(rs.getString(7));
			temp.add(rs.getString(8));
			temp.add(rs.getString(9));
			temp.add(rs.getString(10));
			purList.add(temp);
		}
		con.close();
		return purList;
	}
	public void editState(int no, String string) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="update purchase set purchase_state=? where purchase_no=?";
				
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, string);
		ps.setInt(2, no);
		
		ps.execute();
		con.close();
	}
	
	public Map<String,List<Integer>> getMemberPurchaseStateCount(int memberNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select purchase_no,purchase_state from purchase "
				+ "    where PURCHASE_MEMBER=? "
				+ "    GROUP BY purchase_no,purchase_state,PURCHASE_MEMBER";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		Map<String,List<Integer>> map = new HashMap<String, List<Integer>>();
		List<Integer> li1 = new ArrayList<>(); 
		List<Integer> li2 = new ArrayList<>(); 
		List<Integer> li3 = new ArrayList<>(); 
		List<Integer> li4 = new ArrayList<>();
		map.put("결제완료", li1);
		map.put("주문확인", li2);
		map.put("배송중", li3);
		map.put("배송완료", li4);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			map.get(rs.getString(2)).add(rs.getInt(1));
		}
		
		con.close();
		return map;
	}
	
	public List<List<String>> getChartData(String start,String end) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select tmp.pdate,tmp2.amount,tmp2.price from (SELECT TO_CHAR( TO_DATE('"+start+"', 'yy-mm-dd') + ROWNUM-1, 'yy-mm-dd') AS pdate "
				+ "FROM DUAL "
				+ "CONNECT BY level <= ROUND( TO_DATE('"+end+"', 'yy-mm-dd') - TO_DATE('"+start+"', 'yy-mm-dd') )) tmp "
				+ "    left outer join (select sum(amount) amount,pdate,sum(price) price from "
				+ "(select purchase_amount amount,TO_DATE(PURCHASE_DATE,'yy-mm-dd') pdate, "
				+ "case when book_discount = 0 then purchase_amount*book_price else purchase_amount*book_discount end as price "
				+ "from purchase "
				+ "    inner join book on book_no = purchase_book "
				+ "    where PURCHASE_DATE between '"+start+"' and '"+end+"' "
				+ "    order by PURCHASE_DATE) "
				+ "    group by pdate) tmp2 on tmp.pdate=tmp2.pdate "
				+ "    order by tmp.pdate ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<List<String>> returnList = new ArrayList<>();
		while(rs.next()) {
			List<String> tmpLi = new ArrayList<>();
			tmpLi.add(rs.getString(1));
			
			if(rs.getString(2)==null) {
				tmpLi.add("0");
			}else {
				tmpLi.add(rs.getString(2));
			}
			
			if(rs.getString(3)==null) {
				tmpLi.add("0");
			}else {
				tmpLi.add(rs.getString(3));
			}
			
			returnList.add(tmpLi);
		}
		con.close();
		return returnList;
	}
	
	public List<List<String>> getTableData(String start,String end) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select TO_DATE(PURCHASE_DATE,'yy-mm-dd') pdate,purchase_amount amount,purchase_no,purchase_book,book_price, "
				+ "case when book_discount = 0 then book_price else book_discount end as discount, "
				+ "case when book_discount = 0 then purchase_amount*book_price else purchase_amount*book_discount end as price "
				+ "from purchase "
				+ "    inner join book on book_no = purchase_book "
				+ "    where PURCHASE_DATE between '"+start+"' and '"+end+"' "
				+ "    order by PURCHASE_DATE";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<List<String>> returnList = new ArrayList<>();
		while(rs.next()) {
			List<String> tmpLi = new ArrayList<>();
			tmpLi.add(rs.getString(1));
			tmpLi.add(rs.getString(2));
			tmpLi.add(rs.getString(3));
			tmpLi.add(rs.getString(4));
			tmpLi.add(rs.getString(5));
			tmpLi.add(rs.getString(6));
			tmpLi.add(rs.getString(7));
			returnList.add(tmpLi);
		}
		con.close();
		return returnList;
	}
	public Map<String,Integer> getAllPurchaseState (String start,String end) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select PURCHASE_STATE,count(purchase_no) from (select purchase_no,PURCHASE_STATE from purchase  "
				+ "				inner join book on book_no = purchase_book "
				+ "				inner join member on member_no = PURCHASE_MEMBER  "
				+ "				where PURCHASE_DATE between ? and ? "
				+ "                group by purchase_no,purchase_state) "
				+ "                group by purchase_state";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, start);
		ps.setString(2, end);
		ResultSet rs = ps.executeQuery();
		Map<String,Integer> map = new HashMap<>();
		map.put("결제완료", 0);
		map.put("주문확인", 0);
		map.put("배송중", 0);
		map.put("배송완료", 0);
		while(rs.next()) {
			map.put(rs.getString(1), rs.getInt(2));
		}
		con.close();
		return map;
	}
	
	public boolean hasPurchaseByBookNo(int no) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql ="select * from purchase where purchase_book=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ResultSet rs = ps.executeQuery();
		int count=0;
		while(rs.next()) {
			count++;
		}
		con.close();
		return count>0;
	}
}


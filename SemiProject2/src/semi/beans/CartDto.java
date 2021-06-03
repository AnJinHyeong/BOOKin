package semi.beans;

import java.sql.Date;

public class CartDto {
	private int cartNo; // 장바구니 번호
	private int memberNo;
	private int bookNo;
	private int cartAmount;
	private Date cartTime;
	
	
	
	public CartDto() {
		super();
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public int getCartAmount() {
		return cartAmount;
	}

	public void setCartAmount(int cartAmount) {
		this.cartAmount = cartAmount;
	}

	public Date getCartTime() {
		return cartTime;
	}

	public void setCartTime(Date cartTime) {
		this.cartTime = cartTime;
	}
	
	
	
}
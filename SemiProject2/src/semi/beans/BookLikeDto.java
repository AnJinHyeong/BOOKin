package semi.beans;

import java.sql.Date;

public class BookLikeDto {
	private int memberNo;
	private int bookOrigin;
	private Date likeTime;
	
	public BookLikeDto() {
		super();
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getBookOrigin() {
		return bookOrigin;
	}

	public void setBookOrigin(int bookOrigin) {
		this.bookOrigin = bookOrigin;
	}

	public Date getLikeTime() {
		return likeTime;
	}

	public void setLikeTime(Date likeTime) {
		this.likeTime = likeTime;
	}
}

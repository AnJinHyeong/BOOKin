package semi.beans;

import java.sql.Date;

public class BookReviewDto {
	
	private int reviewNo;
	private String reviewContent;
	private int reviewRate;
	private Date reviewTime;
	private int reviewPurchase;
	
	private int memberNo;
	private String MemberId;
	
	public BookReviewDto() {
		super();
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getReviewRate() {
		return reviewRate;
	}

	public void setReviewRate(int reviewRate) {
		this.reviewRate = reviewRate;
	}

	public Date getReviewTime() {
		return reviewTime;
	}

	public void setReviewTime(Date reviewTime) {
		this.reviewTime = reviewTime;
	}

	public int getReviewPurchase() {
		return reviewPurchase;
	}

	public void setReviewPurchase(int reviewPurchase) {
		this.reviewPurchase = reviewPurchase;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return MemberId;
	}

	public void setMemberId(String memberId) {
		MemberId = memberId;
	}
	
	
	
}

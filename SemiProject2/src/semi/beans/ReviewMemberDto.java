package semi.beans;

import java.sql.Date;

public class ReviewMemberDto {
	private int reviewNo;
	private String reviewContent;
	private long reviewRate;
	private Date reviewTime;
	private int reviewPurchase;
	private String memberId;
	public ReviewMemberDto() {
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
	public long getReviewRate() {
		return reviewRate;
	}
	public void setReviewRate(long reviewRate) {
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
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

}

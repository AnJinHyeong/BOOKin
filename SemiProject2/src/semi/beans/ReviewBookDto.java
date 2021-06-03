package semi.beans;

import java.sql.Date;

public class ReviewBookDto {
	private int reviewNo;
	private String reviewContent;
	private long reviewRate;
	private Date reviewTime;
	private int reviewPurchase;
	private int bookNo;
	private String bookTitle;
	private String bookImage;
	public ReviewBookDto() {
		super();
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
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
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getBookImage() {
		return bookImage;
	}
	public void setBookImage(String bookImage) {
		this.bookImage = bookImage;
	}
	
}

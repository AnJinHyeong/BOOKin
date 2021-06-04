package semi.beans;

import java.sql.Date;

public class BookReviewDto {
	
	private int reviewNo;
	private String reviewContent;
	private int reviewRate;
	private Date reviewTime;
	private int reviewBook;
	private int reviewMember;
	
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

	public int getReviewBook() {
		return reviewBook;
	}

	public void setReviewBook(int reviewBook) {
		this.reviewBook = reviewBook;
	}

	public int getReviewMember() {
		return reviewMember;
	}

	public void setReviewMember(int reviewMember) {
		this.reviewMember = reviewMember;
	}

	
	
	
	
}

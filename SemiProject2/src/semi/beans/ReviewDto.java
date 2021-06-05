package semi.beans;

import java.sql.Date;


public class ReviewDto {

private int reviewNo;
private String reviewContent;
private long reviewRate;
private Date reviewTime;

private int reviewBook;
private int reviewMember;



public ReviewDto() {
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


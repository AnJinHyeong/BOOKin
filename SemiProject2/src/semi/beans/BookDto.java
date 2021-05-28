package semi.beans;

import java.sql.Date;

public class BookDto {
	private int bookNo;
	private String bookTitle;
	private String bookImage;
	private String bookAuthor;
	private int bookPrice;
	private int bookDiscount;
	private String bookPublisher;
	private String bookDescription;
	private Date bookPubDate;
	private long bookGenreNo;
	public BookDto() {
		super();
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
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
		if(bookImage==null) {
			this.bookImage="/SemiProject/image/nullbook.png";
			return;
		}
		this.bookImage = bookImage;
	}
	public String getBookAuthor() {
		return bookAuthor;
	}
	public void setBookAuthor(String bookAuthor) {
		if(bookAuthor==null) {
			this.bookAuthor="편집부";
			return;
		}
		this.bookAuthor = bookAuthor;
	}
	public int getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	public int getBookDiscount() {
		return bookDiscount;
	}
	public void setBookDiscount(int bookDiscount) {
		this.bookDiscount = bookDiscount;
	}
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public String getBookDescription() {
		return bookDescription;
	}
	public void setBookDescription(String bookDescription) {
		if(bookDescription==null) {
			this.bookDescription = "책 소개가 없습니다";
			return;
		}
		this.bookDescription = bookDescription;
	}
	public Date getBookPubDate() {
		return bookPubDate;
	}
	public void setBookPubDate(Date bookPubDate) {
		this.bookPubDate = bookPubDate;
	}
	public long getBookGenreNo() {
		return bookGenreNo;
	}
	public void setBookGenreNo(long genreNo) {
		this.bookGenreNo = genreNo;
	}
	
	
}

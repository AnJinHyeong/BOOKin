package semi.beans;

import java.sql.Date;

public class PurchaseBookMemberDto {
	
	private int purchasePk;
	private int purchaseNo;
	private String purchaseState;
	private int purchaseBook;
	private int purchaseMember;
	private Date purchaseDate;
	private String purchaseRecipient;
	private String purchasePhone;
	private String purchaseAddress;
	private int purchaseAmount;
	
	private String bookTitle;
	private int bookPrice;
	private int bookDiscount;
	
	public PurchaseBookMemberDto() {
		super();
	}

	public int getPurchasePk() {
		return purchasePk;
	}

	public void setPurchasePk(int purchasePk) {
		this.purchasePk = purchasePk;
	}

	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getPurchaseState() {
		return purchaseState;
	}

	public void setPurchaseState(String purchaseState) {
		this.purchaseState = purchaseState;
	}

	public int getPurchaseBook() {
		return purchaseBook;
	}

	public void setPurchaseBook(int purchaseBook) {
		this.purchaseBook = purchaseBook;
	}

	public int getPurchaseMember() {
		return purchaseMember;
	}

	public void setPurchaseMember(int purchaseMember) {
		this.purchaseMember = purchaseMember;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public String getPurchaseRecipient() {
		return purchaseRecipient;
	}

	public void setPurchaseRecipient(String purchaseRecipient) {
		this.purchaseRecipient = purchaseRecipient;
	}

	public String getPurchasePhone() {
		return purchasePhone;
	}

	public void setPurchasePhone(String purchasePhone) {
		this.purchasePhone = purchasePhone;
	}

	public String getPurchaseAddress() {
		return purchaseAddress;
	}

	public void setPurchaseAddress(String purchaseAddress) {
		this.purchaseAddress = purchaseAddress;
	}

	public int getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(int purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
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
	
	
	
}

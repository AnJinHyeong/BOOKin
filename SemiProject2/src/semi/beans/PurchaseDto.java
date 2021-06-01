package semi.beans;

import java.sql.Date;

public class PurchaseDto {

	private int purchaseNo;
	private String purchaseState;
	private int purchaseTracking;
	private int purchaseBook;
	private int purchaseMember;
	private Date purchaseDate;
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
	public int getPurchaseTracking() {
		return purchaseTracking;
	}
	public void setPurchaseTracking(int purchaseTracking) {
		this.purchaseTracking = purchaseTracking;
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
	public PurchaseDto() {
		super();
	}

	
	
}

package semi.beans;

import java.sql.Date;

public class PurchaseDto {
	
	private int purchaseNo;
	private String purchaseState;
	private int purchaseBook;
	private int purchaseMember;
	private Date purchaseDate;
	private String purchaseRecipient;
	private int purchasePhone;
	private String purchaseAddress;
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
	public int getPurchasePhone() {
		return purchasePhone;
	}
	public void setPurchasePhone(int purchasePhone) {
		this.purchasePhone = purchasePhone;
	}
	public String getPurchaseAddress() {
		return purchaseAddress;
	}
	public void setPurchaseAddress(String purchaseAddress) {
		this.purchaseAddress = purchaseAddress;
	}
	public PurchaseDto() {
		super();
	}
	@Override
	public String toString() {
		return "PurchaseDto [purchaseNo=" + purchaseNo + ", purchaseState=" + purchaseState + ", purchaseBook="
				+ purchaseBook + ", purchaseMember=" + purchaseMember + ", purchaseDate=" + purchaseDate
				+ ", purchaseRecipient=" + purchaseRecipient + ", purchasePhone=" + purchasePhone + ", purchaseAddress="
				+ purchaseAddress + "]";
	}
	
	
	
	
	
}

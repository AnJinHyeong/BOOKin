package semi.beans;

import java.sql.Date;

public class CartListDto {
      private int cartNo; // 장바구니 번호
      private int memberNo;
      private int cartAmount;
      private Date cartTime;
      
      // 책정보
      private int bookNo;
      private String bookTitle;
      private String bookImage;
      private String bookAuthor;
      private int bookPrice;
      private int bookDiscount;
      
      public CartListDto() {
         super();
      }

      public int getCartNo() {
         return cartNo;
      }

      public void setCartNo(int cartNo) {
         this.cartNo = cartNo;
      }

      public int getMemberNo() {
         return memberNo;
      }

      public void setMemberNo(int memberNo) {
         this.memberNo = memberNo;
      }

      public int getCartAmount() {
         return cartAmount;
      }

      public void setCartAmount(int cartAmount) {
         this.cartAmount = cartAmount;
      }

      public Date getCartTime() {
         return cartTime;
      }

      public void setCartTime(Date cartTime) {
         this.cartTime = cartTime;
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
         this.bookImage = bookImage;
      }

      public String getBookAuthor() {
         return bookAuthor;
      }

      public void setBookAuthor(String bookAuthor) {
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
      
      
}
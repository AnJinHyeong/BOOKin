package semi.beans;

import java.sql.Date;

public class NoticeBoardDto {
   private int noticeBoardNo;
   private String noticeBoardHeader;
   private String noticeBoardTitle;
   private String noticeBoardContent;
   private int noticeBoardWriter;
   private Date noticeBoardTime;
   private int noticeBoardRead;
   
   public NoticeBoardDto() {
      super();
   }

   public int getNoticeBoardNo() {
      return noticeBoardNo;
   }

   public void setNoticeBoardNo(int noticeBoardNo) {
      this.noticeBoardNo = noticeBoardNo;
   }

   public String getNoticeBoardHeader() {
      return noticeBoardHeader;
   }

   public void setNoticeBoardHeader(String noticeBoardHeader) {
      this.noticeBoardHeader = noticeBoardHeader;
   }

   public String getNoticeBoardTitle() {
      return noticeBoardTitle;
   }

   public void setNoticeBoardTitle(String noticeBoardTitle) {
      this.noticeBoardTitle = noticeBoardTitle;
   }

   public String getNoticeBoardContent() {
      return noticeBoardContent;
   }

   public void setNoticeBoardContent(String noticeBoardContent) {
      this.noticeBoardContent = noticeBoardContent;
   }

   public int getNoticeBoardWriter() {
      return noticeBoardWriter;
   }

   public void setNoticeBoardWriter(int noticeBoardWriter) {
      this.noticeBoardWriter = noticeBoardWriter;
   }

   public Date getNoticeBoardTime() {
      return noticeBoardTime;
   }

   public void setNoticeBoardTime(Date noticeBoardTime) {
      this.noticeBoardTime = noticeBoardTime;
   }

   public int getNoticeBoardRead() {
      return noticeBoardRead;
   }

   public void setNoticeBoardRead(int noticeBoardRead) {
      this.noticeBoardRead = noticeBoardRead;
   }   
}
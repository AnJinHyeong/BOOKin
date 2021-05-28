package semi.beans;

import java.sql.Date;

public class QnaBoardDto {
   private int qnaBoardNo;
   private String qnaBoardHeader;
   private String qnaBoardTitle;
   private String qnaBoardContent;
   private int qnaBoardWriter;
   private Date qnaBoardTime;
   private int qnaBoardReply;
      
   public int getQnaBoardReply() {
	return qnaBoardReply;
   }
   public void setQnaBoardReply(int qnaBoardReply) {
	this.qnaBoardReply = qnaBoardReply;
   }
   public QnaBoardDto() {
      super();
   }
   public int getQnaBoardNo() {
      return qnaBoardNo;
   }
   public void setQnaBoardNo(int qnaBoardNo) {
      this.qnaBoardNo = qnaBoardNo;
   }
   public String getQnaBoardHeader() {
      return qnaBoardHeader;
   }
   public void setQnaBoardHeader(String qnaBoardHeader) {
      this.qnaBoardHeader = qnaBoardHeader;
   }
   public String getQnaBoardTitle() {
      return qnaBoardTitle;
   }
   public void setQnaBoardTitle(String qnaBoardTitle) {
      this.qnaBoardTitle = qnaBoardTitle;
   }
   public String getQnaBoardContent() {
      return qnaBoardContent;
   }
   public void setQnaBoardContent(String qnaBoardContent) {
      this.qnaBoardContent = qnaBoardContent;
   }
   public int getQnaBoardWriter() {
      return qnaBoardWriter;
   }
   public void setQnaBoardWriter(int qnaBoardWriter) {
      this.qnaBoardWriter = qnaBoardWriter;
   }
   public Date getQnaBoardTime() {
      return qnaBoardTime;
   }
   public void setQnaBoardTime(Date qnaBoardTime) {
      this.qnaBoardTime = qnaBoardTime;
   }
   
}   
package semi.beans;

import java.sql.Date;

public class QnaReplyDto {
	
	private int qnaReplyNo;
	private String qnaReplyContent;
	private Date qnaReplyTime;
	private int qnaReplyWriter;
	private int qnaReplyOrigin;

	public QnaReplyDto() {
		super();
	}
	
	public int getQnaReplyNo() {
		return qnaReplyNo;
	}

	public void setQnaReplyNo(int qnaReplyNo) {
		this.qnaReplyNo = qnaReplyNo;
	}

	public String getQnaReplyContent() {
		return qnaReplyContent;
	}

	public void setQnaReplyContent(String qnaReplyContent) {
		this.qnaReplyContent = qnaReplyContent;
	}

	public Date getQnaReplyTime() {
		return qnaReplyTime;
	}

	public void setQnaReplyTime(Date qnaReplyTime) {
		this.qnaReplyTime = qnaReplyTime;
	}

	public int getQnaReplyWriter() {
		return qnaReplyWriter;
	}

	public void setQnaReplyWriter(int qnaReplyWriter) {
		this.qnaReplyWriter = qnaReplyWriter;
	}

	public int getQnaReplyOrigin() {
		return qnaReplyOrigin;
	}

	public void setQnaReplyOrigin(int qnaReplyOrigin) {
		this.qnaReplyOrigin = qnaReplyOrigin;
	}
	
	
	
	
}

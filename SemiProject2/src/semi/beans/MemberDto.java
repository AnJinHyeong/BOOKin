package semi.beans;

import java.sql.Date;

public class MemberDto {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberName;
	private Date memberBirth;
	private String memberGender;
	private String memberEmail;
	private String memberAddress;
	private int memberPoint;
	private String memberPhone;
	private String memberAdmin;
	private Date memberJoin;
	public MemberDto() {
		super();
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public Date getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(Date memberBirth) {
		this.memberBirth = memberBirth;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberAddress() {
		return memberAddress;
	}
	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}
	public int getMemberPoint() {
		return memberPoint;
	}
	public void setMemberPoint(int memberPoint) {
		this.memberPoint = memberPoint;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public String getMemberAdmin() {
		return memberAdmin;
	}
	public void setMemberAdmin(String member_admin) {
		this.memberAdmin = member_admin;
	}
	public Date getMemberJoin() {
		return memberJoin;
	}
	public void setMemberJoin(Date memberJoin) {
		this.memberJoin = memberJoin;
	}
	@Override
	public String toString() {
		return "MemberDto [memberNo=" + memberNo + ", memberId=" + memberId
				+ ", memberPw=" + memberPw + ", memberName=" + memberName
				+ ", memberBirth=" + memberBirth + ", memberGender="
				+ memberGender + ", memberEmail=" + memberEmail
				+ ", memberAddress=" + memberAddress + ", memberPoint="
				+ memberPoint + ", memberPhone=" + memberPhone
				+ ", memberAdmin=" + memberAdmin + ", memberJoin=" + memberJoin
				+ "]";
	}
	
}

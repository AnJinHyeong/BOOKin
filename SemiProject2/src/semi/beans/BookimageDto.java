package semi.beans;

public class BookimageDto {
private int imageFileNo;
private String imagefileUploadName;
private String imagefileSaveName;
private Long imagefileSize;
private int imagefileOrigin;
public int getImageFileNo() {
	return imageFileNo;
}
public void setImageFileNo(int imageFileNo) {
	this.imageFileNo = imageFileNo;
}
public String getImagefileUploadName() {
	return imagefileUploadName;
}
public void setImagefileUploadName(String imagefileUploadName) {
	this.imagefileUploadName = imagefileUploadName;
}
public String getImagefileSaveName() {
	return imagefileSaveName;
}
public void setImagefileSaveName(String imagefileSaveName) {
	this.imagefileSaveName = imagefileSaveName;
}
public Long getImagefileSize() {
	return imagefileSize;
}
public void setImagefileSize(Long imagefileSize) {
	this.imagefileSize = imagefileSize;
}
public int getImagefileOrigin() {
	return imagefileOrigin;
}
public void setImagefileOrigin(int imagefileOrigin) {
	this.imagefileOrigin = imagefileOrigin;
}
public BookimageDto() {
	super();
}


}

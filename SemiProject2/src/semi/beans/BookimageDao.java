package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookimageDao {
public void insert(BookimageDto bookimageDto)throws Exception{
	Connection con = JdbcUtils.getConnection();
	
	String sql="insert into book_imagefile values(book_imagefile_seq.nextval,?,?,?,?)";
	
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, bookimageDto.getImagefileUploadName());
	ps.setString(2, bookimageDto.getImagefileSaveName());
	ps.setLong(3,bookimageDto.getImagefileSize());
	ps.setInt(4, bookimageDto.getImagefileOrigin());
	ps.execute();
	
	con.close();
	
	}
}

package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GenreDao {
	
	//전체리스트 조회
	public List<GenreDto> list() throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre order by genre_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        List<GenreDto> genreList=new ArrayList<>();
        while(rs.next()) {
        	GenreDto genreDto=new GenreDto();
        	genreDto.setGenreNo(rs.getLong("genre_no"));
        	genreDto.setGenreName(rs.getString("genre_name"));
        	genreDto.setGenreParents(rs.getLong("genre_parents"));
        	
        	genreList.add(genreDto);
        }
        con.close();
        return genreList;
	}
	
	//검색 기능
	public List<GenreDto> search(int genreParents) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre where genre_parents=? order by genre_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1,genreParents);
		ResultSet rs = ps.executeQuery();
		
		List<GenreDto> genreList=new ArrayList<>();
		while(rs.next()) {
			GenreDto genreDto=new GenreDto();
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
			
			genreList.add(genreDto);
		}
		con.close();
		return genreList;
	}
	public List<GenreDto> topGenreList() throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre where genre_parents is null";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<GenreDto> genreList=new ArrayList<>();
		while(rs.next()) {
			GenreDto genreDto=new GenreDto();
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
			
			genreList.add(genreDto);
		}
		con.close();
		return genreList;
	}
	public List<GenreDto> childGenreList(long genreParents) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre where genre_parents=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, genreParents );
		ResultSet rs = ps.executeQuery();
		List<GenreDto> genreList=new ArrayList<>();
		while(rs.next()) {
			GenreDto genreDto=new GenreDto();
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
			
			genreList.add(genreDto);
		}
		con.close();
		return genreList;

	}
	public GenreDto get(Long no) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre where genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, no);
		ResultSet rs = ps.executeQuery();
		
		GenreDto genreDto;
		if(rs.next()) {
			genreDto=new GenreDto();
			
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
		}else {
			genreDto=null;
		}
		con.close();
		return genreDto;
	}
	public GenreDto getParents(Long no) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select genre_parents from genre where genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, no);
		ResultSet rs = ps.executeQuery();
		
		GenreDto genreDto;
		if(rs.next()) {
			genreDto=new GenreDto();
			
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
		}else {
			genreDto=null;
		}
		con.close();
		return genreDto;
	}
	public List<GenreDto> sameGenreList(Long no) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql="select * from genre where genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, no);
		ResultSet rs = ps.executeQuery();
		List<GenreDto> genreList=new ArrayList<>();
		while(rs.next()) {
			GenreDto genreDto=new GenreDto();
			genreDto.setGenreNo(rs.getLong("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			genreDto.setGenreParents(rs.getLong("genre_parents"));
			
			genreList.add(genreDto);
		}
		con.close();
		return genreList;
	}


}

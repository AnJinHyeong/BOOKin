package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QnaBoardDao {
// 사용자 계정
	public static final String USERNAME = "semiadmin", PASSWORD = "semiadmin";

	// 시퀀스 번호를 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select qna_board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);

		con.close();
		return no;
	}

	 // 등록
    public void write(QnaBoardDto qnaBoardDto) throws Exception {
        Connection con = JdbcUtils.getConnection();
        
        String sql = "insert into qna_board values(?, ?, ?, ?, ?, sysdate, 0)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, qnaBoardDto.getQnaBoardNo());
        ps.setString(2, qnaBoardDto.getQnaBoardHeader());
        ps.setString(3, qnaBoardDto.getQnaBoardTitle());
        ps.setString(4, qnaBoardDto.getQnaBoardContent());
        ps.setInt(5, qnaBoardDto.getQnaBoardWriter());
        ps.execute();
       
        con.close();
    }

//상세보기 기능
	public QnaBoardDto get(int qnaBoardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from qna_board where qna_board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardNo);
		ResultSet rs = ps.executeQuery();

		QnaBoardDto boardDto;
		if (rs.next()) {
			boardDto = new QnaBoardDto();

			boardDto.setQnaBoardNo(rs.getInt("qna_board_no"));
			boardDto.setQnaBoardHeader(rs.getString("qna_board_header"));
			boardDto.setQnaBoardTitle(rs.getString("qna_board_title"));
			boardDto.setQnaBoardContent(rs.getString("qna_board_content"));
			boardDto.setQnaBoardWriter(rs.getInt("qna_board_writer"));
			boardDto.setQnaBoardTime(rs.getDate("qna_board_time"));
			boardDto.setQnaBoardReply(rs.getInt("qna_board_reply"));

		} else {
			boardDto = null;
		}

		con.close();

		return boardDto;
	}

// 게시물 수정 기능
	public boolean edit(QnaBoardDto qnaBoardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update qna_board set qna_board_header=?, qna_board_title=?, qna_board_content=? where qna_board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaBoardDto.getQnaBoardHeader());
		ps.setString(2, qnaBoardDto.getQnaBoardTitle());
		ps.setString(3, qnaBoardDto.getQnaBoardContent());
		ps.setInt(4, qnaBoardDto.getQnaBoardNo());
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

// 삭제 기능
	public boolean delete(int qnaBoardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete qna_board where qna_board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

// 목록 기능
	public List<QnaBoardDto> list(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from( " + "	select rownum rn, TMP.* from( "
				+ "		select * from qna_board order by qna_board_no desc " 
				+ "	)TMP "
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<QnaBoardDto> boardList = new ArrayList<>();
		while (rs.next()) {
			QnaBoardDto boardDto = new QnaBoardDto();
			boardDto.setQnaBoardNo(rs.getInt("qna_board_no"));
			boardDto.setQnaBoardHeader(rs.getString("qna_board_header"));
			boardDto.setQnaBoardTitle(rs.getString("qna_board_title"));
			boardDto.setQnaBoardWriter(rs.getInt("qna_board_writer"));
			boardDto.setQnaBoardTime(rs.getDate("qna_board_time"));
			boardDto.setQnaBoardContent(rs.getString("qna_board_content"));
			boardDto.setQnaBoardReply(rs.getInt("qna_board_reply"));

			boardList.add(boardDto);
		}
		con.close();
		return boardList;
	}

// 내가 등록한 1:1 목록 보기
	public List<QnaBoardDto> mylist(int qnaBoardWriter, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from( " + "	select rownum rn, TMP.* from( "
				+ "		select * from qna_board where qna_board_writer=? order by qna_board_no desc " 
				+ "	)TMP "
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardWriter);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		// List로 변환
		List<QnaBoardDto> boardList = new ArrayList<>();
		while (rs.next()) {
			QnaBoardDto boardDto = new QnaBoardDto();
			boardDto.setQnaBoardNo(rs.getInt("qna_board_no"));
			boardDto.setQnaBoardHeader(rs.getString("qna_board_header"));
			boardDto.setQnaBoardTitle(rs.getString("qna_board_title"));
			boardDto.setQnaBoardWriter(rs.getInt("qna_board_writer"));
			boardDto.setQnaBoardTime(rs.getDate("qna_board_time"));
			boardDto.setQnaBoardContent(rs.getString("qna_board_content"));
			boardDto.setQnaBoardReply(rs.getInt("qna_board_reply"));
			
			boardList.add(boardDto);
		}
		con.close();
		return boardList;
	}

// 	title 조회 목록 기능
	public List<QnaBoardDto> titleList(String qnaBoardHeader, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
	
		String sql = "select * from( " + "	select rownum rn, TMP.* from( "
				+ "		select * from qna_board where qna_board_header=? order by qna_board_no desc " 
				+ "	)TMP "
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaBoardHeader);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		// List로 변환
		List<QnaBoardDto> boardList = new ArrayList<>();
		while (rs.next()) {
		QnaBoardDto boardDto = new QnaBoardDto();
		boardDto.setQnaBoardNo(rs.getInt("qna_board_no"));
		boardDto.setQnaBoardHeader(rs.getString("qna_board_header"));
		boardDto.setQnaBoardTitle(rs.getString("qna_board_title"));
		boardDto.setQnaBoardWriter(rs.getInt("qna_board_writer"));
		boardDto.setQnaBoardTime(rs.getDate("qna_board_time"));
		boardDto.setQnaBoardContent(rs.getString("qna_board_content"));
	
			boardList.add(boardDto);
		}
		con.close();
		return boardList;
	}
	
//  전체목록 페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from qna_board";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
//  페이지블럭 계산을 위한 카운트 기능(1:1문의 확인)
	public int getCountMyList(int qnaBoardWriter) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from qna_board where qna_board_writer=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardWriter);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
//  페이지블럭 계산을 위한 카운트 기능(header에 따라 달라지는 페이지 확인)
	public int getCountHeader(String qnaBoardHeader) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from qna_board where qna_board_header=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaBoardHeader);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

	public boolean refreshBoardReply(int qnaBoardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "update qna_board "
							+ "set qna_board_reply = ( select count(*) from qna_reply where qna_reply_origin = ? ) "
							+ "where qna_board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaBoardNo);
		ps.setInt(2, qnaBoardNo);
		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}
}
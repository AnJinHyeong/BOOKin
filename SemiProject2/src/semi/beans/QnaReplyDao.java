package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class QnaReplyDao {

//	댓글 등록 : 게시글내용, 원본글번호, 회원번호 --> 댓글정보
	public void insert(QnaReplyDto qnaReplyDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into qna_reply values(qna_reply_seq.nextval, ?, sysdate, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaReplyDto.getQnaReplyContent());
		ps.setInt(2, qnaReplyDto.getQnaReplyWriter());
		ps.setInt(3, qnaReplyDto.getQnaReplyOrigin());
		ps.execute();
		
		con.close();
	}
	
//	댓글 수정 : 댓글내용, 댓글번호
	public boolean edit(QnaReplyDto qnaReplyDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update qna_reply set qna_reply_content=?, qna_reply_time=sysdate where qna_reply_no=? and qna_reply_writer=? and qna_reply_origin=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, qnaReplyDto.getQnaReplyContent());
		ps.setInt(2, qnaReplyDto.getQnaReplyNo());
		ps.setInt(3, qnaReplyDto.getQnaReplyWriter());
		ps.setInt(4, qnaReplyDto.getQnaReplyOrigin());
		
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
//	댓글 삭제
	public boolean delete(QnaReplyDto qnaReplyDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete qna_reply where qna_reply_no=? and qna_reply_writer=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaReplyDto.getQnaReplyNo());
		ps.setInt(2, qnaReplyDto.getQnaReplyWriter());
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
//	댓글 리스트 : 원본글번호
	public List<QnaReplyDto> list(int qnaReplyOrigin) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from qna_reply where qna_reply_origin = ? order by qna_reply_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaReplyOrigin);
		ResultSet rs = ps.executeQuery();
		
		List<QnaReplyDto> list = new ArrayList<>();
		
		while(rs.next()) {
			QnaReplyDto qnaReplyDto = new QnaReplyDto();
			
			qnaReplyDto.setQnaReplyNo(rs.getInt("qna_reply_no"));
			qnaReplyDto.setQnaReplyContent(rs.getString("qna_reply_content"));
			qnaReplyDto.setQnaReplyTime(rs.getDate("qna_reply_time"));
			qnaReplyDto.setQnaReplyWriter(rs.getInt("qna_reply_writer"));
			qnaReplyDto.setQnaReplyOrigin(rs.getInt("qna_reply_origin"));
			
			list.add(qnaReplyDto);
		}
		
		con.close();
		return list;
	}
	
//	댓글 개수 확인
	public boolean check(int qnaReplyOrigin) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from qna_reply where qna_reply_origin=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaReplyOrigin);
		ResultSet rs = ps.executeQuery();
		
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	
	
}

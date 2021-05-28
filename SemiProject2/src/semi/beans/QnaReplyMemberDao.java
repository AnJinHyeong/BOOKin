package semi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QnaReplyMemberDao {
	
	public List<QnaReplyMemberDto> list(int qnaReplyOrigin) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from qna_reply_member where qna_reply_origin = ? order by qna_reply_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qnaReplyOrigin);
		ResultSet rs = ps.executeQuery();
		
		List<QnaReplyMemberDto> list = new ArrayList<>();
		if(rs.next()) {
			QnaReplyMemberDto qnaReplyMemberDto = new QnaReplyMemberDto();
			
			qnaReplyMemberDto.setQnaReplyNo(rs.getInt("qna_reply_no"));
			qnaReplyMemberDto.setQnaReplyContent(rs.getString("qna_reply_content"));
			qnaReplyMemberDto.setQnaReplyTime(rs.getDate("qna_reply_time"));
			qnaReplyMemberDto.setQnaReplyOrigin(rs.getInt("qna_reply_origin"));
			qnaReplyMemberDto.setQnaReplyWriter(rs.getInt("qna_reply_writer"));
			
			qnaReplyMemberDto.setMemberNo(rs.getInt("member_no"));
			qnaReplyMemberDto.setMemberId(rs.getString("member_id"));
			qnaReplyMemberDto.setMemberAdmin(rs.getString("member_admin"));
			
			list.add(qnaReplyMemberDto);
		}
		
		con.close();
		return list;
	}
	
	
	
}

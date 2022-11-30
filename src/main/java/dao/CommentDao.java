package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	// 입력 insertCommentAction.jsp
	public int insertComment(Comment comment) throws Exception {
		int isResult = 0;
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
					
		// 쿼리문
		String sql = "INSERT INTO comment (help_no, comment_memo, member_id, updatedate, createdate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		
		isResult = stmt.executeUpdate();
			
		dbUtil.close(null, stmt, conn);
		return isResult;
	}
	// 수정
	// updateCommentForm.jsp 답변내용 출력
	public Comment selectCommentOne(int commentNo) throws Exception {
		Comment comment = new Comment();
		String sql = "SELECT help_no helpNo, comment_memo commentMemo, updatedate, createdate FROM comment WHERE comment_no = ?";
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			comment.setHelpNo(rs.getInt("helpNo"));
			comment.setCommentMemo(rs.getString("commentMemo"));
			comment.setCommentNo(commentNo);
		}
		dbUtil.close(rs, stmt, conn);
		return comment;
	}
	// updateCommentAction.jsp
	public int updateComment(Comment comment) throws Exception {
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// deleteComment.jsp 삭제
	public int deleteComment(int commentNo) throws Exception {
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
}

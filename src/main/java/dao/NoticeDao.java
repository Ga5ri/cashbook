package dao;

import vo.*;
import util.*;
import java.util.*;
import java.sql.*;

public class NoticeDao {
	// 마지막 페이지를 구하려면 전체 행
	public int selectNoticeCount() throws Exception {
		int count = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String countsql = "SELECT COUNT(*) FROM notice";
		PreparedStatement countStmt = conn.prepareStatement(countsql);
		ResultSet countRs = countStmt.executeQuery();
		if(countRs.next()) {
			count = countRs.getInt("COUNT(*)");
			System.out.println(count+"<-전체행");
		}
		dbUtil.close(countRs, countStmt, conn);
		return count;
	}
	
	public int deleteNotice(int noticeNo) throws Exception {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;

	}
	
	// updateNoticeForm.jsp
	public Notice selectNoticeOne(int noticeNo) throws Exception {
		Notice notice = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo FROM notice WHERE notice_no = ?";
			  
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		  
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		rs = stmt.executeQuery();
	  
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeMemo(rs.getString("noticeMemo"));
	      }
		
		dbUtil.close(rs, stmt, conn);
  
		return notice;
	   }
	
	public int updateNotice(Notice notice) throws Exception {
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		
		return row;
	}
	
	// insertNoticeAction.jsp (공지사항 수정)
	public int insertNotice(Notice notice) throws Exception {
		int isResult = 0;
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+" VALUES(?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		
		isResult = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return isResult;
	}
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "SELECT notice_no noticeNo, Notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}	
		return list;		
	}
	
}

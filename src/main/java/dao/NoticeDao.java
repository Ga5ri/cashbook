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
	
	public int deleteNotcie(Notice notice) throws Exception {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		return 0;
	}
	
	public int updateNotice(Notice notice) throws Exception {
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		return 0;
	}
	
	public int insertNotice(Notice notice) throws Exception {
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+" VALUES(?, NOW(), NOW())";
		return 0;
	}
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoitceCount() {
		int count = 0;
		//
		return count;
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
			n.setNoticeno(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}	
		return list;		
	}
	
}

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
		// 과제
		dbUtil.close(countRs, countStmt, conn);
		return count;
	}
	
	
	// loginFrom.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
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

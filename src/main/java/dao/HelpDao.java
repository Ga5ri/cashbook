package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class HelpDao {
	// 문의내용 출력
	public HashMap<String, Object> selectHelpListByHelpNo(int helpNo) throws Exception{
		HashMap<String, Object> help = new HashMap<>();
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "SELECT help_no helpNo, member_id memberId, updatedate, createdate, help_memo helpMemo "
					+" FROM help WHERE help_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) { 
			help.put("helpNo", rs.getInt("helpNo"));
			help.put("memberId", rs.getString("memberId"));
			help.put("helpMemo", rs.getString("helpMemo"));
		}
		dbUtil.close(rs, stmt, conn);
		return help;
		}
	
	// 마지막 페이지를 구하려면 전체 행
	public int selectHelpCount() throws Exception {
		int count = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String countsql = "SELECT COUNT(*) FROM help";
		PreparedStatement countStmt = conn.prepareStatement(countsql);
		ResultSet countRs = countStmt.executeQuery();
		if(countRs.next()) {
			count = countRs.getInt("COUNT(*)");
			System.out.println(count+"<-전체행");
		}
		dbUtil.close(countRs, countStmt, conn);
		return count;
	}
	// 관리자
	// selectHelpList 오버로딩(메서드의 리턴값도 같고 이름도 같으나 매개변수가 다름)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+" 		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+"		, c.comment_no commentNo"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" ORDER BY h.createdate DESC"
					+" LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" WHERE h.member_id = ?"
					+" ORDER BY h.createdate DESC";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	public int insertHelp(String memberId, String helpMemo) throws Exception {
		int isResult = 0;
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 쿼리문
		String sql = "INSERT INTO help (member_id, help_memo, updatedate, createdate) VALUES(?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, helpMemo);
		
		isResult = stmt.executeUpdate();
			
		dbUtil.close(null, stmt, conn);
		return isResult;
	}
}
package dao;

import java.sql.*;
import java.util.*;
import util.*;


public class CashDao {
	// 호출 : cashList.jsp (월별)
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		//System.out.println(month+"cashlistmonth");
		
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs+"<-rs실행여부1");
		
		while(rs.next()) {// true일시 
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// 호출 : cashDateList.jsp (일별)
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.updatedate, c.createdate FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs+"<-rs실행여부");
		//System.out.println(rs.next()+"<-rsnext");
		
		while(rs.next()) { // true일시 
			HashMap<String, Object> m = new HashMap<String, Object>();
			//System.out.println(rs.getInt("cashNo")+"<-cashNo"); 
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			//System.out.println(rs.getString("cashDate")+"<-cashDate"); 
			m.put("cashPrice", rs.getLong("cashPrice"));
			//System.out.println(rs.getLong("cashPrice")+"<-cashPrice");
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("updatedate", rs.getString("updatedate"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : insertCashAction.jsp (가계부 입력)
	public int insertCash(String memberId, String cashMemo, String cashDate, int categoryNo, long cashPrice) throws Exception {
			
		int isResult = 0;
		
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "INSERT INTO cash (member_id, cash_memo, cash_date, category_no, cash_price, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, cashMemo);
		stmt.setString(3, cashDate); 
		stmt.setInt(4, categoryNo);
		stmt.setLong(5, cashPrice);
		
		isResult = stmt.executeUpdate();
			
		stmt.close();
		conn.close();
		return isResult;
		}

	// 호출 : updateCash.jsp (가계부 수정시 내역 출력)
	public HashMap<String, Object> selectCashListByCashNo(int cashNo) throws Exception{
		HashMap<String, Object> cash = new HashMap<>();
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "SELECT cash_no cashNo, cash_date cashDate, cash_price cashPrice, category_no categoryNo, cash_memo cashMemo FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) { 
			cash.put("cashNo", cashNo);
			cash.put("cashDate", rs.getString("cashDate"));
			cash.put("cashPrice", rs.getLong("cashPrice"));
			cash.put("categoryNo", rs.getInt("categoryNo"));
			cash.put("cashMemo", rs.getString("cashMemo"));
		}
		dbUtil.close(rs, stmt, conn);
		return cash;
		}
		
		// 호출 : updateCashAction.jsp (가계부 수정)
		public int updateCashList(int categoryNo, long cashPrice, String cashMemo, int cashNo, String memberId) throws Exception{
			int row = 0; 
			// DB연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리문
			String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ? AND member_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			stmt.setLong(2, cashPrice);
			stmt.setString(3, cashMemo);
			stmt.setInt(4, cashNo);
			stmt.setString(5, memberId);
			row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return row;
		}
		
		// 호출 : deleteCash.jsp (가계부 삭제)
		public int deleteCash(int cashNo) throws Exception{
			int row = 0;
			// DB연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리문
			String sql = "DELETE FROM cash WHERE cash_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return row;
		}
}
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {// select, insert, update, delete
	public HashMap<String, Object> selectMaxMinYear() {
		HashMap<String, Object> map = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT"
					+ " (SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
					+ " , (SELECT MAX(YEAR(cash_date)) FROM cash) maxYear"
					+ " FROM DUAL";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();
	        if(rs.next()) {
	        	map = new HashMap<String, Object>();
	        	map.put("minYear", rs.getInt("minYear"));
	        	map.put("maxYear", rs.getInt("maxYear"));
	        }
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
        return map;
	}
	
	// 월별 통계
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(
		String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();

		String sql = "SELECT MONTH(t2.cashDate) month"
					+ " , COUNT(t2.importCash) icCnt"
					+ " , IFNULL(SUM(t2.importCash), 0) icSum"
					+ " , IFNULL(ROUND(AVG(t2.importCash)), 0) icAvg"
					+ " , COUNT(t2.exportCash) ecCnt"
					+ " , IFNULL(SUM(t2.exportCash), 0) ecSum"
					+ " , IFNULL(ROUND(AVG(t2.exportCash)), 0) ecAvg"
					+ " FROM"
						+ " (SELECT"
						+ " memberId"
						+ " , cashNo"
						+ " , cashDate"
						+ " , IF(categoryKind = '수입', cashPrice, null) importCash"
						+ " , IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ " FROM (SELECT cs.cash_no cashNo"
							+ " , cs.cash_date cashDate"
							+ " , cs.cash_price cashPrice"
							+ " , cg.category_kind categoryKind"
							+ " , cs.member_id memberId"
						+ " FROM cash cs"
						+ " INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)"
					+ " ORDER BY MONTH(t2.cashDate) ASC";
		try {
			list = new ArrayList<HashMap<String, Object>>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("icCnt", rs.getInt("icCnt"));
				m.put("icSum", rs.getInt("icSum"));
				m.put("icAvg", rs.getInt("icAvg"));
				m.put("ecCnt", rs.getInt("ecCnt"));
				m.put("ecSum", rs.getInt("ecSum"));
				m.put("ecAvg", rs.getInt("ecAvg"));
				list.add(m);
				}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return list;      
	}
	// 년도별 통계
	public ArrayList<HashMap<String, Object>> selectCashListByYear(
			String memberId) {
			ArrayList<HashMap<String, Object>> list = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			DBUtil dbUtil = new DBUtil();

			String sql = "SELECT YEAR(t2.cashDate) year"
						+ " , COUNT(t2.importCash) icCnt"
						+ " , IFNULL(SUM(t2.importCash), 0) icSum"
						+ " , IFNULL(ROUND(AVG(t2.importCash)), 0) icAvg"
						+ " , COUNT(t2.exportCash) ecCnt"
						+ " , IFNULL(SUM(t2.exportCash), 0) ecSum"
						+ " , IFNULL(ROUND(AVG(t2.exportCash)), 0) ecAvg"
						+ " FROM"
							+ " (SELECT"
							+ " memberId"
							+ " , cashNo"
							+ " , cashDate"
							+ " , IF(categoryKind = '수입', cashPrice, null) importCash"
							+ " , IF(categoryKind = '지출', cashPrice, null) exportCash"
						+ " FROM (SELECT cs.cash_no cashNo"
								+ " , cs.cash_date cashDate"
								+ " , cs.cash_price cashPrice"
								+ " , cg.category_kind categoryKind"
								+ " , cs.member_id memberId"
							+ " FROM cash cs"
							+ " INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
						+ " WHERE t2.memberId = ?"
						+ " GROUP BY YEAR(t2.cashDate)"
						+ " ORDER BY YEAR(t2.cashDate) ASC";
			try {
				list = new ArrayList<HashMap<String, Object>>();
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, memberId);
				rs = stmt.executeQuery();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("year", rs.getInt("year"));
					m.put("icCnt", rs.getInt("icCnt"));
					m.put("icSum", rs.getInt("icSum"));
					m.put("icAvg", rs.getInt("icAvg"));
					m.put("ecCnt", rs.getInt("ecCnt"));
					m.put("ecSum", rs.getInt("ecSum"));
					m.put("ecAvg", rs.getInt("ecAvg"));
					list.add(m);
					}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;      
		}
	
	// 년도의 내림차순으로 수입/지출 년도별 합
	public ArrayList<HashMap<String, Object>> selectCashListByCategory (
		Connection conn, String category) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		String sql = "SELECT YEAR(cash_date) year, SUM(cash_price) price"
					+ " FROM cash WHERE category = ?"
					+ " GROUP BY YEAR(cash_date)"
					+ " ORDER BY YEAR(cash_date) ASC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, category);
        System.out.println(category+"<-category1");
        ResultSet rs = stmt.executeQuery();
        System.out.println(rs.next()+"<-rs실행여부");
        while(rs.next()) {
        	HashMap<String, Object> m = new HashMap<String, Object>();
        	m.put("year", rs.getInt("year"));
        	m.put("price", rs.getInt("price"));
        	list.add(m);
        }
        stmt.close();
        rs.close();
        return list;
		}

}

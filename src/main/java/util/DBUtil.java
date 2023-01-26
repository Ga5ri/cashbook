package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://52.78.217.205:3306/cashbook", "root", "java1234");
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		if(rs != null) {
			rs.close();
		}
		if(rs != null) {
			stmt.close();
		}
		if(rs != null) {
			conn.close();
		}
	}
}

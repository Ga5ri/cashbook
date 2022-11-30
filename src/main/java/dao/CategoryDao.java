package dao;

import java.util.*;
import java.sql.Connection;
import java.sql.*;
import util.DBUtil;
import vo.*;


public class CategoryDao {
	
	// admin -> 수정폼에서 보여줄 카테고리목록 updateCategoryForm
	public Category selectCategoryOne(Category category) throws Exception{
		Category paramCategory = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName "
				+" FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn =  null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryNo());
		rs = stmt.executeQuery();
		if(rs.next()) {
			paramCategory = new Category();
			paramCategory.setCategoryNo(rs.getInt("categoryNo"));
			paramCategory.setCategoryName(rs.getString("categoryName"));
			paramCategory.setCategoryKind(rs.getString("categoryKind"));			
		}
		dbUtil.close(rs, stmt, conn);
		return paramCategory;
	}
	
	// admin -> 카테고리 수정 updateCategoryAction.jsp 
	public int updateCategory(Category category) throws Exception{
		int row = 0;
		
		String sql = "UPDATE category SET "
				+" category_kind = ?"
				+" , category_name = ?"
				+" , updatedate = CURDATE()"
				+" WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn =  null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setInt(3 , category.getCategoryNo());
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("category 수정 성공");
		} else {
			System.out.println("category 수정 실패");
		}
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// admin -> 카테고리 삭제 deleteCategoryAction.jsp
	public int deleteCategory(int categoryNo) throws Exception{
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn =  null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);		
		return row;
	}
	
	
	// admin -> 카테고리추가 insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception{
		int row = 0;
		
		String sql = "INSERT INTO category ("
				+ " category_kind"
				+ " , category_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?,?, CURDATE(),CURDATE())";
		DBUtil dbUtil = new DBUtil();
		Connection conn =  null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	//admin -> 카테고리관리 -> 카테고리목록 
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = null;
		list = new ArrayList<Category>();
		
		String sql = "SELECT "
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category";
		
		DBUtil dbUtil = new DBUtil();
		
		// db자원(jdbc api자원) 초기화
		Connection conn =  null;
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		// executeQuery는 보통 셀렉트쿼리문에서 사용 update로 사용해도되긴하지만 거의 안사용
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery(); // 쿼리로 받으면 resultSet을 반환 (보이는테이블형식), 업데이트로 받으면 행을 반환함
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		
		// db자원(jdbc) 반납 
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	public ArrayList<Category> selectCategoryList() throws Exception {
		//  DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();		
		//  list에 추가
		ArrayList<Category> list = new ArrayList<Category>();		
		while(rsSelect.next())
		{
			Category category = new Category();
			category.setCategoryNo(rsSelect.getInt("categoryNo"));
			category.setCategoryKind(rsSelect.getString("categoryKind"));
			category.setCategoryName(rsSelect.getString("categoryName"));
			
			list.add(category);
		}		
		return list;	
	}
}
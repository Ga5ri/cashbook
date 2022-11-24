package dao;

import vo.Member;

import java.sql.*;

import util.DBUtil;

public class MemberDao {
	// login
	public Member login(Member paramMember) throws Exception {
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// resultMember 초기화
		Member resultMember = null;
		
		// 쿼리문 (memberLevel추가)
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		System.out.println("param.get실행여부Id"+paramMember.getMemberId());
		System.out.println("param.get실행여부Pw"+paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
	
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			System.out.println("rs실행여부");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		System.out.println("resultgetMenam"+resultMember.getMemberId());
		System.out.println("resultgetMenam"+resultMember.getMemberName());
		return resultMember;
	}
	
	// 회원가입 1) id중복확인 2) 회원가입 -> 쿼리 1개당 1개의 메서드가 좋다
	
	// 반환값 true:존재하는ID, false:사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean result = false;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	public int insertMember(Member member) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// 닉네임 변경
	public int updateMember(Member paramMember, String loginMemberId) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "UPDATE member SET member_name = ? WHERE member_pw = PASSWORD(?) AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberId());
		row = stmt.executeUpdate();		
	
		dbUtil.close(null, stmt, conn);
		return row;
	}
}

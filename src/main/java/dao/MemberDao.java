package dao;
import java.util.*;
import vo.*;
import java.sql.*;
import util.DBUtil;

public class MemberDao {
	// 관리자 : 멤버레벨수정
		public int updateMemberLevel(Member member) throws Exception {
			// DB 연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리문
			String sql = "UPDATE MEMBER SET member_level = ?, updatedate = CURDATE() WHERE member_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setString(2, member.getMemberId());
			int row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return row;
		}
		
		// 관리자 : 멤버수
		public int selectMemberCount() throws Exception {
			int count = 0;
			// DB 연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리문
			String countsql = "SELECT COUNT(*) FROM member";
			PreparedStatement countStmt = conn.prepareStatement(countsql);
			ResultSet countRs = countStmt.executeQuery();
			if(countRs.next()) {
				count = countRs.getInt("COUNT(*)");
				System.out.println(count+"<-전체행");
			}
			dbUtil.close(countRs, countStmt, conn);
			return count;
		}
		// 관리자 : 멤버 리스트
		public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Member> list = new ArrayList<Member>();
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate"
					+" 		FROM member ORDER BY createdate DESC LIMIT ?,?";
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
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
				list.add(m);
			}
			dbUtil.close(rs, stmt, conn);
			return list;
		}
		// 관리자 : 멤버 강퇴
		public int deleteMemberByAdmin(Member member) throws Exception {
			// DB 연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 쿼리문
			String sql = "DELETE FROM member WHERE member_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			int row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return row;
			
		}
		
		// 회원탈퇴
		public int deleteMember(Member member) {
			return 0;
		}
	
	// login
	public Member login(Member paramMember) throws Exception {
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// resultMember 초기화
		Member resultMember = null;
		
		// 쿼리문 (memberLevel추가)
		String sql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
	
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}
	
	// 회원가입 1) id중복확인 2) 회원가입 -> 쿼리 1개당 1개의 메서드가 좋다
	
	// id 중복확인
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
	
	// 회원가입
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
	public Member updateMember(Member paramMember) throws Exception {
		Member loginMember = new Member();
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "UPDATE member SET member_name = ?, updatedate=CURDATE() WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		int row = stmt.executeUpdate();
		System.out.println("updateRow->"+row);
		if(row == 1) {
			System.out.println("name 수정성공");
			dbUtil.close(null, stmt, conn);
			return loginMember;
		} else {
			System.out.println("name 수정실패");
			dbUtil.close(null, stmt, conn);
			return null;
		}
	}
	
	// 비밀번호 변경
	public int updatePw(Member paramMember, String paramMemberupdatePw) throws Exception {
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMemberupdatePw);
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		int row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
}

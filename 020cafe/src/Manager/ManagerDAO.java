package Manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class ManagerDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Manager> list = new ArrayList<Manager>();

	/**
	 * 매니저 회원가입
	 * */
	public boolean addManager(Manager manager) {
		conn = DBUtil.connection();
		String sql = "insert into CAFE_MANAGER (cafe_unique_key, manager_id, manager_pw, manager_name) values(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, manager.getCafeUniqueKey());
			pstmt.setString(2, manager.getManagerId());
			pstmt.setString(3, manager.getManagerPW());
			pstmt.setString(4, manager.getManagerName());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 매니저 로그인
	 * */
	public boolean login(String managerId, String managerPW) {
		conn = DBUtil.connection();
		String sql = "select * from CAFE_MANAGER where MANAGER_ID = ?";
		boolean result = false;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			if (rs.getString("MANAGER_PW").equals(managerPW))
				result = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 아이디 중복확인
	 * */
	public boolean checkId(String managerId) {
		conn = DBUtil.connection();
		String sql = "select MANAGER_ID from CAFE_MANAGER where MANAGER_ID = ?";
		boolean result = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			if (rs.getString("MANAGER_ID").equals(managerId))
				result = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 회원가입 카페 목록
	 * */
	public ArrayList<Manager> cafeList() {
		conn = DBUtil.connection();
		String sql = "SELECT CAFE_UNIQUE_KEY, CAFE_NAME FROM CAFE";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int cafeUniqueKey = rs.getInt("CAFE_UNIQUE_KEY");
				String cafeName = rs.getString("CAFE_NAME");

				Manager manager = new Manager(
						cafeUniqueKey, cafeName);

				list.add(manager);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
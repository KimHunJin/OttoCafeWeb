package Merchandise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class MerchandiseDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Merchandise> list = new ArrayList<Merchandise>();

	/**
	 * 총 레코드 수
	 * */
	public int totalRecord(String managerId) {
		conn = DBUtil.connection();
		String sql1 = "SELECT COUNT(MERCHANDISE_UNIQUE_KEY) AS TOTAL_RECORD FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?);";
		int totalRecord = 0;
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
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
		return totalRecord;
	}
	
	/**
	 * 마이페이지 상품 리스트
	 * */
	public ArrayList<Merchandise> merchandiseList(String managerId, int pageno) {
		conn = DBUtil.connection();
		if(pageno == 1) {
			pageno -= 1;
		} else {
			pageno = (pageno - 1)*5;
		}
		String sql = "SELECT MERCHANDISE_UNIQUE_KEY, MERCHANDISE_NAME, PRICE, MERCHANDISE_IMAGE FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) LIMIT ?, 5;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setInt(2, pageno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int merchandiseUniqueKey = rs.getInt("MERCHANDISE_UNIQUE_KEY");
				String merchandiseName = rs.getString("MERCHANDISE_NAME");
				int price = rs.getInt("PRICE");
				String image = rs.getString("MERCHANDISE_IMAGE");

				Merchandise merchandises = new Merchandise(
						merchandiseUniqueKey, merchandiseName, price, image);

				list.add(merchandises);
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

	/**
	 * 마이페이지 상품 등록
	 * */
	public boolean addMerchandise(String merchandiseName, int price, String image, String managerId) {
		conn = DBUtil.connection();
		String sql = "insert into MERCHANDISE (CAFE_UNIQUE_KEY, MERCHANDISE_NAME, PRICE, MERCHANDISE_IMAGE) values((SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?),?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, merchandiseName);
			pstmt.setInt(3, price);
			pstmt.setString(4, image);
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
	
	/*
	 * 상품 삭제
	 * */
	public boolean merchandiseDelete(String managerId, String[] merchandiseUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND MERCHANDISE_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i<merchandiseUniqueKey.length; i++) {
				pstmt.setString(1, managerId);
				pstmt.setInt(2, Integer.parseInt(merchandiseUniqueKey[i]));
				pstmt.executeUpdate();
			}
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
}
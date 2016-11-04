package util;

import java.sql.*;

public class DBUtil {
	
	public static Connection connection() {
		Connection conn = null;

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://14.63.196.255:3306/020cafe?useUnicode=true&characterEncoding=utf8";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "user", "020cafe");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}

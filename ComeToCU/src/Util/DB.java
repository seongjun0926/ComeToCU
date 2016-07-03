package Util;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(Throwable e) {
			throw new ExceptionInInitializerError(e);
		}
	}
	
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/seongjun0926",
				"seongjun0926",
				"tjdwns3721"
			);
		
	}
}
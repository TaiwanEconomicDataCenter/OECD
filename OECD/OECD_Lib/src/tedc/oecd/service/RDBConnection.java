package tedc.oecd.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import tedc.oecd.exception.TEDCException;

class RDBConnection {
	
	private static final String driver = "com.mysql.cj.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/";
	private static final String userId = "tedc";
	private static final String pwd = "aremos2021";
	
	static Connection getConnection(String bank) throws TEDCException {
		try {
			Class.forName(driver); //1.載入JDBC Driver
			try {
				Connection connection = DriverManager.getConnection(url+bank.toLowerCase(), userId, pwd); //2.建立連線
				//System.out.println(connection.getClass().getName()); //for test
				return connection;
			} catch (SQLException e) {
				throw new TEDCException("建立連線失敗", e); //錯誤訊息與錯誤原因需分開回傳，避免e被壓成字串
			}
		} catch (ClassNotFoundException e) {
			throw new TEDCException("載入MySQL JDBC Driver失敗: " + driver);
		}
	}
	
	
}

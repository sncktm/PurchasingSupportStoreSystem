package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.StoreBeans;

public class LoginConnectionDao {
	
	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql";

	public boolean StoreLoginSearch(String store_no, String store_password) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		// JDBCドライバを読み込む
		//	    try {
		//	        Class.forName("org.h2.Driver");
		//	    } catch (ClassNotFoundException e) {
		//	        throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		//	    }
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			String sql = "SELECT * FROM Store_Login WHERE Store_No = ? AND Store_Password = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, store_no);
			pStmt.setString(2, store_password);

			ResultSet rs = pStmt.executeQuery();

			if(rs.next()) {
				return true;
					
			} else {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
	}

	public StoreBeans StoreLoginFingd(String store_no) {

		StoreBeans store = new StoreBeans();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}

		// ①データベースへの接続（コネクション）
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			
			String sql = "SELECT Store_No, Store_Name FROM Store WHERE Store_No = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, store_no);

			ResultSet rs = pStmt.executeQuery();

			if(rs.next()) {
				store.setStore_no(rs.getString("STORE_NO"));
				store.setStore_name(rs.getString("STORE_NAME"));
			}
			else {
				store = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return store;
	}

}

package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.GoodsInfoBeans;

public class GoodsDao {

	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql";

	public ArrayList<GoodsInfoBeans> findAll(String store_no) {
		ArrayList<GoodsInfoBeans> GoodsInfoArray = new ArrayList<GoodsInfoBeans>();
		
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

			// SELECT文の準備
			String sql = "SELECT Sales_Flag, Update_Date, Goods.JAN_Code, Goods_Name, Goods_Maker, Classification, Sales_Price "
					+ "FROM Goods, Sales "
					+ "WHERE Goods.JAN_Code = Sales. JAN_Code AND Store_No = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, store_no);

			// SELECTを実行
			ResultSet rs = pStmt.executeQuery();

			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				String sales_flag = rs.getString("Sales_Flag");
				Date update_date = rs.getDate("Update_Date");
				String jan_code = rs.getString("JAN_Code");
				String goods_name = rs.getString("Goods_Name");
				String goods_marker = rs.getString("Goods_Maker");
				String classification = rs.getString("Classification");
				int sales_price = rs.getInt("Sales_Price");
				GoodsInfoBeans infoBean = new GoodsInfoBeans(sales_flag, update_date, jan_code, goods_name, goods_marker, classification, sales_price);
				GoodsInfoArray.add(infoBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return GoodsInfoArray;
	}
}

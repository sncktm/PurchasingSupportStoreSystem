package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.AdgoodsBeans;
import model.AdvertisementManagementBeans;

public class ProductDAO {

	// データベース接続情報
	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql"; // パスワード

	/**
	 * 商品情報を取得するメソッド
	 * 
	 * @param advertisementNo 広告番号
	 * @return 商品情報 (通常価格とセール価格を含む)
	 * @throws Exception データベース接続エラーやクエリ実行エラー
	 */


	public ArrayList<AdvertisementManagementBeans> findAll(String Advertisement_No) {

		ArrayList<AdvertisementManagementBeans> ProductArray = new ArrayList<AdvertisementManagementBeans>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){

			String sql = "SELECT goods.Goods_Name, goods.Goods_Maker, goods.Classification,sales.Sales_Price FROM advertisement INNER JOIN advertisement_goods ON advertisement.Advertisement_No = advertisement_goods.Advertisement_No INNER JOIN sales ON advertisement_goods.Sales_No = sales.Sales_No INNER JOIN goods ON sales.JAN_code = goods.JAN_code WHERE advertisement.Advertisement_No = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1,Advertisement_No);

			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				String Goods_Name = rs.getString("Goods_Name");
				String Goods_Maker = rs.getString("Goods_Maker");
				String Classification = rs.getString("Classification");
				int Sales_Price = rs.getInt("Sales_Price");

				AdvertisementManagementBeans infobean = new AdvertisementManagementBeans(
						Goods_Name,
						Goods_Maker, Classification, 
						Sales_Price);

				ProductArray.add(infobean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ProductArray;

	}
	
	
	public ArrayList<AdgoodsBeans> Adgoods(String Store_No) {

		ArrayList<AdgoodsBeans> ProductArray = new ArrayList<AdgoodsBeans>();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){

			// SELECT文の準備
			//        	
			String sql = "SELECT sales.Sales_No,goods.Goods_Name, goods.Goods_Maker,goods.Classification,sales.Sales_Price FROM sales INNER JOIN goods ON sales.JAN_Code = goods.JAN_Code WHERE sales.Store_No = ?";



			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1,Store_No);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String Sales_No = rs.getString("Sales_No");
				String Goods_Name = rs.getString("Goods_Name");
				String Goods_Maker = rs.getString("Goods_Maker");
				String Classification = rs.getString("Classification");
				int Sales_Price = rs.getInt("Sales_Price");
				System.out.println(Sales_No);

				AdgoodsBeans infobean = new AdgoodsBeans(
						Sales_No,
						Goods_Name,
						Goods_Maker, Classification, 
						Sales_Price);

				ProductArray.add(infobean);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return ProductArray;

	}
	


}

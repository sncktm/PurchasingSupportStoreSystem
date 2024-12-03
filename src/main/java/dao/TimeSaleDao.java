package dao;
 
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.TimeSaleBeans;
import model.TimeSaleGoodsBeans;

 
public class TimeSaleDao {
 
	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql";
 
	//タイムセール一覧
	public ArrayList<TimeSaleBeans> TsInfo(String store_no) {
		ArrayList<TimeSaleBeans> TimeSaleListArray = new ArrayList<TimeSaleBeans>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
 
			// SELECT文の準備
			String sql = "SELECT time_sale.Time_Sale_No, Time_Sale_Name, year, month, day, day_Of_Week, start_Time, end_Time, Timesale_Application_Flag, count(*) as goods_Count FROM time_sale_goods, time_sale WHERE time_sale_goods.time_Sale_No = time_sale.time_Sale_No AND store_no = ? GROUP BY time_sale.time_Sale_No, time_Sale_Name, year, month, day, day_Of_Week, start_Time, end_Time, Timesale_Application_Flag";
					
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, store_no);
 
			// SELECTを実行
			ResultSet rs = pStmt.executeQuery();
 
			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				System.out.println("1");
				String time_Sale_No = rs.getString("time_Sale_No");
				String time_Sale_Name = rs.getString("time_Sale_Name");
				String year = rs.getString("year");
				String month = rs.getString("month");
				String day = rs.getString("day");
				String day_Of_Week = rs.getString("day_Of_Week");
				Date  start_Time = rs.getDate("start_Time");
				Date  end_Time = rs.getDate("end_Time");
				String Timesale_Application_Flag = rs.getString("Timesale_Application_Flag");
				int  goods_Count = rs.getInt("goods_Count");
				TimeSaleBeans infoBean = new TimeSaleBeans(time_Sale_No,time_Sale_Name,year,month,day,day_Of_Week,start_Time,end_Time,Timesale_Application_Flag,goods_Count);
				TimeSaleListArray.add(infoBean);
			}
		} catch (SQLException e) {
			System.out.println("2");
			e.printStackTrace();
			return null;
		}
		return TimeSaleListArray;
	}
	
	
	//タイムセール登録
	public ArrayList<TimeSaleGoodsBeans > TsDetail(String time_Sale_No) {
		ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeans  = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		
		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
 
			// SELECT文の準備
			String sql = "SELECT goods.JAN_code,goods.Goods_Name,Goods_Maker,Classification,image,sales.Sales_Price,time_sale_goods.Time_Sales_Prise,Timesale_goods_Application_Flag FROM Sales,Time_Sale_Goods,Time_sale,goods WHERE time_sale_goods.time_sale_no = ? and Time_sale.time_Sale_No = Time_sale_goods.time_sale_no and goods.jan_code = sales.jan_code and sales.sales_no = time_sale_goods.Sales_No Group by jan_code,goods_Name,Goods_maker,classification,time_sale_goods.sales_no,image,sales.Sales_Price,time_sale_goods.Time_Sales_Prise";
					
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, time_Sale_No);
 
			// SELECTを実行
			ResultSet rs = pStmt.executeQuery();
 
			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				System.out.println("1");
				String jan_code = rs.getString("jan_code");
				String goods_Name = rs.getString("goods_Name");
				String goods_Maker = rs.getString("goods_Maker");
				String classification = rs.getString("classification");
				String image = rs.getString("image");
				int  sales_Price = rs.getInt("sales_price");
				int  time_Sales_Prise = rs.getInt("time_sales_prise");
				String Timesale_goods_Application_Flag = rs.getString("Timesale_goods_Application_Flag");
				
				TimeSaleGoodsBeans goodsArray = new TimeSaleGoodsBeans(jan_code,goods_Name,goods_Maker,classification,image,time_Sales_Prise,sales_Price,Timesale_goods_Application_Flag);
				TimeSaleGoodsBeans.add(goodsArray);
				
			}
		} catch (SQLException e) {
			System.out.println("2");
			e.printStackTrace();
			return null;
		}
		return TimeSaleGoodsBeans;
	}
}
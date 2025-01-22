package dao;
 
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

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
			String sql = "SELECT time_sale.Time_Sale_No, Time_Sale_Name, Start_Date, Start_Time, End_Date, End_Time, Repeat_Pattern, Repeat_Value, Timesale_Application_Flag, count(*) as goods_Count FROM time_sale_goods, time_sale WHERE time_sale_goods.time_Sale_No = time_sale.time_Sale_No AND store_no = ? GROUP BY time_sale.Time_Sale_No, Time_Sale_Name, Start_Date, Start_Time, End_Date, End_Time, Repeat_Pattern, Repeat_Value, Timesale_Application_Flag";
					
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, store_no);
 
			// SELECTを実行
			ResultSet rs = pStmt.executeQuery();
 
			// SELECT文の結果をArrayListに格納
			while (rs.next()) {
				System.out.println("1");
				String time_Sale_No = rs.getString("time_Sale_No");
				String time_Sale_Name = rs.getString("time_Sale_Name");
				Date start_Date = rs.getDate("Start_Date");
				Time  startTime = rs.getTime("Start_Time");
				Date end_Date  = rs.getDate("End_Date");
				Time  end_Time = rs.getTime("End_Time");
				String  repeat_Pattern = rs.getString("Repeat_Pattern");
				String  repeat_Value = rs.getString("Repeat_Value");
				String Timesale_Application_Flag = rs.getString("Timesale_Application_Flag");
				int  goods_Count = rs.getInt("goods_Count");
				
				TimeSaleBeans infoBean = new TimeSaleBeans(time_Sale_No,time_Sale_Name, start_Date, startTime, end_Date, end_Time, repeat_Pattern, repeat_Value, Timesale_Application_Flag, goods_Count);
				TimeSaleListArray.add(infoBean);
			}
		} catch (SQLException e) {
			System.out.println("2");
			e.printStackTrace();
			return null;
		}
		return TimeSaleListArray;
	}
	
	
	//タイムセール詳細
	public ArrayList<TimeSaleGoodsBeans> TsDetail(String time_Sale_No) {
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
	
	
	
	//タイムセール登録
	public int AddTimesales(TimeSaleBeans  TimeSaleBeans) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		
		int time_sale_No = 0; // 自動採番されたキーを格納する変数
		
		//データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			//SELECT文の準備
			// INSERT文の準備（自動採番キーを取得するためにStatement.RETURN_GENERATED_KEYSを指定）
			String sql = "INSERT INTO Time_Sale (time_sale_name, Start_Date, Start_Time, End_Date, End_Time, Repeat_Pattern, Repeat_Value, Store_No, Timesale_Application_Flag) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 修正
			
	        
			// INSERT文中の?に使用する値を設定
			pStmt.setString(1, TimeSaleBeans.getTime_Sale_Name());
			pStmt.setDate(2, TimeSaleBeans.getStartDate());
			pStmt.setTime(3, TimeSaleBeans.getStartTime());
			pStmt.setDate(4, TimeSaleBeans.getEndDate());
			pStmt.setTime(5, TimeSaleBeans.getEndTime());
			pStmt.setString(6, TimeSaleBeans.getRepeatPattern());
			pStmt.setString(7, TimeSaleBeans.getRepeatValue());
			pStmt.setString(8, TimeSaleBeans.getStore_No());
			pStmt.setString(9, TimeSaleBeans.getTimesale_Application_Flag());
			
			
			

			// INSERT文を実行
			int result = pStmt.executeUpdate();
			if (result != 1) {
			    return 0;
			}

			// 自動採番されたキーを取得
			try (ResultSet generatedKeys = pStmt.getGeneratedKeys()) {
			    if (generatedKeys.next()) {
			        time_sale_No = generatedKeys.getInt(1); // 自動採番キーを取得
			        System.out.println("生成されたキー: " + time_sale_No);
			    } else {
			        throw new SQLException("自動採番キーの取得に失敗しました。");
			    }
			}

			
		} catch (SQLException e) {
			System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示
			e.printStackTrace();
			return 0;
		}
		System.out.println("登録完了");
		return time_sale_No;
		
	}
	
	
	//タイムセールスケジュール登録
	public boolean AddTimeSaleSchedule(int time_Sale_No, LocalTime localStartTime, LocalTime localEndTime, List<LocalDate> dates) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
		//データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			//SELECT文の準備
			String sql = "INSERT INTO Time_Sale_Schedule (time_Sale_No, Scheduled_Date, Start_Time, End_Time) VALUES (?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			
			Time startTime = Time.valueOf(localStartTime);
			Time endTime = Time.valueOf(localEndTime);
 
			//INSERT文中の?に使用する値を設定してsqlを完成
			for (LocalDate localDate : dates) {
				Date sqlDate = Date.valueOf(localDate);
				
				System.out.println("time_Sale_No: " + time_Sale_No);
				System.out.println("sqlDate: " + sqlDate);
				System.out.println("startTime: " + startTime);
				System.out.println("endTime: " + endTime);

				
				pStmt.setInt(1, time_Sale_No);
				pStmt.setDate(2, sqlDate);
				pStmt.setTime(3, startTime);
				pStmt.setTime(4, endTime);
				
				//INSERT文を実行(resultには追加された行数が代入される)
				int result = pStmt.executeUpdate();
				
				if (result != 1) {
					return false;
				}
			}
			
		} catch (SQLException e) {
			System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示
			e.printStackTrace();
			return false;
		}
		System.out.println("登録完了");
		return true;
		
	}
	
 
	//タイムセール商品登録
	 public boolean AddTimesalesgoods(ArrayList<TimeSaleGoodsBeans> timeSaleGoodsBeans, int time_Sale_No) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch(ClassNotFoundException e) {
				throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
			}
			//データベース接続
			try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
				//SELECT文の準備
				String sql = "INSERT INTO Time_Sale_Goods VALUES (?, ?, ?, ?)";
				PreparedStatement pStmt = conn.prepareStatement(sql);
	 
				//INSERT文中の?に使用する値を設定してsqlを完成
				for (TimeSaleGoodsBeans bean : timeSaleGoodsBeans) {
					pStmt.setInt(1, time_Sale_No);
					pStmt.setString(2, bean.getSales_No());
					pStmt.setInt(3, bean.getTime_Sales_Prise());
					pStmt.setString(4, bean.getTimesale_goods_Application_Flag());
					//INSERT文を実行(resultには追加された行数が代入される)
					int result = pStmt.executeUpdate();
					
					if (result != 1) {
						return false;
					}

				}
			} catch (SQLException e) {
				System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示
				e.printStackTrace();
				return false;
			}
			System.out.println("登録完了");
			return true;
			
		}
}
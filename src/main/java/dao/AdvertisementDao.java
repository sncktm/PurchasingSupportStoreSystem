package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.AdCommodityBeans;

public class AdvertisementDao {
	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql"; // MySQLのパスワードに変更してください

    
    public ArrayList<AdCommodityBeans> findAll(String Store_No) {
    	
    	ArrayList<AdCommodityBeans> commodityInfoArray = new ArrayList<AdCommodityBeans>();
    	    	
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
        	
        	// SELECT文の準備
        	String sql = "SELECT * FROM Advertisement WHERE Store_No = ?"; 
 
        	PreparedStatement stmt = conn.prepareStatement(sql);
        	stmt.setString(1, Store_No);
        	
        	ResultSet rs = stmt.executeQuery();
        	
 
        	while (rs.next()) {
                String Advertisement_No = rs.getString("Advertisement_No");
                String Store_No1 = rs.getString("Store_No");
                String Advertisement_type = rs.getString("Advertisement_type");
                String Advertisement_Image = rs.getString("Advertisement_Image");
                String Advertisement_Explanation = rs.getString("Advertisement_Explanation");
                String Advertisement_title = rs.getString("Advertisement_title");

                AdCommodityBeans infobean = new AdCommodityBeans(
                    Advertisement_No, 
                    Store_No1,
                    Advertisement_type, 
                    Advertisement_Image, 
                    Advertisement_Explanation, 
                    Advertisement_title
                );

                commodityInfoArray.add(infobean);
            }

            
            System.out.println("0");
        } catch (SQLException e) {
            System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示

            e.printStackTrace();
            System.out.println("2");
        }
        return commodityInfoArray;
        
        
    
	}

    public int adMax(String store_No) {
    	int advertisementMax = 0;

    	
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
        	
            String sql = "SELECT Advertisement_Max FROM advertisement_max WHERE Store_No = ?";  // 実際のテーブル名に置き換え
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, store_No); // プレースホルダにStore_Noをセット
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        advertisementMax = rs.getInt("Advertisement_Max"); // Advertisement_Maxを取得
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return advertisementMax;
    }
        
        
        public String adType(String Advertisement_No) {
        	
        	String advertisementType = null;

        	
        	try {
    			Class.forName("com.mysql.cj.jdbc.Driver");
    		} catch(ClassNotFoundException e) {
    			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
    		}
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
            	
                String sql = "SELECT Advertisement_type FROM advertisement_type WHERE Advertisement_No = ?";  // 実際のテーブル名に置き換え
                
            	PreparedStatement stmt = conn.prepareStatement(sql);
            	stmt.setString(1, Advertisement_No);
            	ResultSet rs = stmt.executeQuery();
            	
            	if (rs.next()) {
                    // Advertisement_typeを取得
                    advertisementType = rs.getString("Advertisement_type");
                }
            	
               
            	
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return advertisementType;
        }
        public int getDataCount(String Store_No) {
            int count = 0;

        	
        	try {
    			Class.forName("com.mysql.cj.jdbc.Driver");
    		} catch(ClassNotFoundException e) {
    			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
    		}
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
            	
                String sql = "SELECT COUNT(*) FROM Advertisement WHERE Store_No = ? GROUP BY Store_No";  // 実際のテーブル名に置き換え
                
            	PreparedStatement stmt = conn.prepareStatement(sql);
            	stmt.setString(1, Store_No);
            	ResultSet rs = stmt.executeQuery();
            	
                if (rs.next()) {
                    count = rs.getInt(1); // COUNT(*) の結果を取得
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return count;
        }
        
        public AdCommodityBeans adStore(String Advertisement_No) {
        	
        	AdCommodityBeans infobean = null;
        	
        	try {
    			Class.forName("com.mysql.cj.jdbc.Driver");
    		} catch(ClassNotFoundException e) {
    			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
    		}
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
            	
            	// SELECT文の準備
            	String sql = "SELECT * FROM advertisement WHERE Advertisement_No = ? ";
     
            	PreparedStatement stmt = conn.prepareStatement(sql);
            	stmt.setString(1, Advertisement_No);
            	

            	ResultSet rs = stmt.executeQuery();
            	
            	 
            	if (rs.next()) {
            		String Advertisement_No1 = rs.getString("Advertisement_No");
                    
                    String Store_No = rs.getString("Store_No");
                    String Advertisement_type = rs.getString("Advertisement_type");
                    String Advertisement_Image = rs.getString("Advertisement_Image");
                    String Advertisement_Explanation = rs.getString("Advertisement_Explanation");
                    String Advertisement_title = rs.getString("Advertisement_title");
                    

                   infobean = new AdCommodityBeans(Advertisement_No1,Store_No,Advertisement_type,Advertisement_Image,Advertisement_Explanation,Advertisement_title);
                    
                }

               
            } catch (SQLException e) {
                System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示

                e.printStackTrace();
                System.out.println("2");
            }
            
            return infobean;
        
    	}
        
        

    
}


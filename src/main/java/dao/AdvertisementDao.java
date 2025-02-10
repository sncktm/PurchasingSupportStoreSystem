package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
                String Advertisement_priority = rs.getString("Advertisement_priority");
                

                AdCommodityBeans infobean = new AdCommodityBeans(
                    Advertisement_No, 
                    Store_No1,
                    Advertisement_type, 
                    Advertisement_Image, 
                    Advertisement_Explanation, 
                    Advertisement_title,
                    Advertisement_priority
                );

                commodityInfoArray.add(infobean);
            }

            
        } catch (SQLException e) {
            System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示

            e.printStackTrace();
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
            System.out.println("max" + advertisementMax);

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
                    String Advertisement_priority = rs.getString("Advertisement_priority");
                    

                   infobean = new AdCommodityBeans(Advertisement_No1,Store_No,Advertisement_type,Advertisement_Image,Advertisement_Explanation,Advertisement_title,Advertisement_priority);
                    
                }

               
            } catch (SQLException e) {
                System.err.println("SQLエラー発生: " + e.getMessage()); // 詳細なエラーメッセージを表示

                e.printStackTrace();
            }
            
            return infobean;
            
        
    	}
        
        public boolean sdRegist(String Store_No, String Advertisement_type, String Advertisement_Image, String Advertisement_Explanation, String Advertisement_title, String Advertisement_priority, String Sales_No) { 
            boolean isSuccess = false;
            Connection conn = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
                conn.setAutoCommit(false); // トランザクション開始

                // 1. Advertiseテーブルに登録
                String sql = "INSERT INTO advertisement (Store_No, Advertisement_type, Advertisement_Image, Advertisement_Explanation, Advertisement_title,Advertisement_priority) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                statement.setString(1, Store_No);
                statement.setString(2, Advertisement_type);
                statement.setString(3, Advertisement_Image);
                statement.setString(4, Advertisement_Explanation);
                statement.setString(5, Advertisement_title);
                statement.setString(6, Advertisement_priority);
                statement.executeUpdate();

                // 2. 自動生成された Advertisement_No を取得
                ResultSet rs = statement.getGeneratedKeys();
                if (!rs.next()) throw new SQLException("Advertisement_No の取得に失敗しました。");
                int advertisementNo = rs.getInt(1);
                
                if ("2".equals(Advertisement_type) || "3".equals(Advertisement_type)) {
                	// 3. Advertisement_goods に登録
                	String insertAdGoodsSQL = "INSERT INTO Advertisement_goods (Advertisement_No, Sales_No) VALUES (?, ?)";
                	PreparedStatement pstmt = conn.prepareStatement(insertAdGoodsSQL);
                	pstmt.setInt(1, advertisementNo);
                	pstmt.setString(2, Sales_No);
                	pstmt.executeUpdate();
                	pstmt.close();
                }
                conn.commit(); // トランザクション確定
                isSuccess = true;
                
                // リソース解放
                rs.close();
                statement.close();
            } catch (Exception e) {
                try { if (conn != null) conn.rollback(); } catch (SQLException rollbackEx) { rollbackEx.printStackTrace(); }
                e.printStackTrace();
            } finally {
                try { if (conn != null) conn.close(); } catch (SQLException closeEx) { closeEx.printStackTrace(); }
            }

            return isSuccess;
        }
        
        
        public int deleteAdvertisement(int Advertisement_No, String Advertisement_type) {
            int result = 0; // 削除件数を保持

            try {
                // JDBCドライバのロード
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new IllegalStateException("JDBCドライバを読み込めませんでした");
            }

            // データベース接続と削除処理
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            	            	
            	if ("2".equals(Advertisement_type) || "3".equals(Advertisement_type)) {
                    String deleteAdGoodsSQL = "DELETE FROM advertisement_goods WHERE Advertisement_No = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(deleteAdGoodsSQL)) {
                        stmt.setInt(1, Advertisement_No);
                        stmt.executeUpdate(); 
                    }
                }
            	
            	String deleteAdvertisementSQL = "DELETE FROM advertisement WHERE Advertisement_No = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteAdvertisementSQL)) {
                    stmt.setInt(1, Advertisement_No);
                    result = stmt.executeUpdate(); // 実行し、削除件数を取得
                }
                
                // 2. ad
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return result; // 削除成功なら 1（または削除された件数）、失敗なら 0
        }

        
        public boolean adupdate(String Advertisement_No, String Advertisement_type, String Advertisement_Image, 
        		String Advertisement_Explanation, String Advertisement_title, String Advertisement_priority, String Sales_No) {
        	Connection conn = null;  // 明示的に管理
        	String oldAdvertisementType = null; 

        	try {
        		conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
        		conn.setAutoCommit(false);  // トランザクション開始

        		// 1. 現在の広告タイプを取得
        		String selectSQL = "SELECT Advertisement_type FROM advertisement WHERE Advertisement_No = ?";
        		try (PreparedStatement psSelect = conn.prepareStatement(selectSQL)) {
        			psSelect.setString(1, Advertisement_No);
        			try (ResultSet rs = psSelect.executeQuery()) {
        				if (rs.next()) {
        					oldAdvertisementType = rs.getString("Advertisement_type");
        					System.out.println(oldAdvertisementType);
        				} else {
        					return false;
        				}
        			}
        		}

        		// 2. advertisement テーブルを更新
        		String sql1 = "UPDATE advertisement SET Advertisement_type = ?, Advertisement_Image = ?, Advertisement_Explanation = ?, Advertisement_title = ? ,Advertisement_priority = ? WHERE Advertisement_No = ?";
        		try (PreparedStatement ps1 = conn.prepareStatement(sql1)) {
        			ps1.setString(1, Advertisement_type);
        			ps1.setString(2, Advertisement_Image);
        			ps1.setString(3, Advertisement_Explanation);
        			ps1.setString(4, Advertisement_title);
        			ps1.setString(5, Advertisement_priority);
        			
        			ps1.setString(6, Advertisement_No);
        			ps1.executeUpdate();
        		}

        		// 3. Advertisement_type に応じた処理
        		if ("1".equals(oldAdvertisementType) && ("2".equals(Advertisement_type) || "3".equals(Advertisement_type))) {
        			String sql2 = "INSERT INTO advertisement_goods (Advertisement_No, Sales_No) VALUES (?, ?)";
        			try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
        				ps2.setString(1, Advertisement_No);
        				ps2.setString(2, Sales_No);
        				ps2.executeUpdate();
        			}
        		} else if (("2".equals(oldAdvertisementType) || "3".equals(oldAdvertisementType)) && "1".equals(Advertisement_type)) {
        			String sql3 = "DELETE FROM advertisement_goods WHERE Advertisement_No = ?";
        			try (PreparedStatement ps3 = conn.prepareStatement(sql3)) {
        				ps3.setString(1, Advertisement_No);
        				ps3.executeUpdate();
        			}
        		}

        		conn.commit();
        		return true;

        	} catch (SQLException e) {
        		e.printStackTrace();
        		if (conn != null) {
        			try {
        				conn.rollback();
        			} catch (SQLException ex) {
        				ex.printStackTrace();
        			}
        		}
        		return false;
        	} finally {
        		// ✅ Connection を明示的に閉じる
        		if (conn != null) {
        			try {
        				conn.close();
        			} catch (SQLException ex) {
        				ex.printStackTrace();
        			}
        		}
        	}
        }        

}


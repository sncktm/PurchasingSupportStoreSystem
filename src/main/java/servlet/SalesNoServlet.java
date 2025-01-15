package servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/SalesNoServlet")
public class SalesNoServlet extends HttpServlet {
	
	private final String JDBC_URL = "jdbc:mysql://localhost:3306/purchasing_support_system_DB";
	private final String DB_USER = "root";
	private final String DB_PASS = "mysql";
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        String jan_Code = request.getParameter("jan_Code");
        JSONObject json = new JSONObject();
     
    	
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			throw new IllegalStateException ("JDBCドライバを読み込めませんでした");
		}
	
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			// SELECT文の準備
			String sql = "SELECT Goods_Name, Goods_Maker, Classification, Sales_Price, Sales_No FROM sales, goods WHERE sales.Jan_Code = goods.Jan_Code AND goods.Jan_Code = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, jan_Code);
            ResultSet rs = pStmt.executeQuery();
			// SELECT文の結果をArrayListに格納
            if (rs.next()) {
            	System.out.println("sss");
                json.put("Goods_Name", rs.getString("Goods_Name"));
                json.put("Goods_Maker", rs.getString("Goods_Maker"));
                json.put("Classification", rs.getString("Classification"));
                json.put("Sales_Price", rs.getString("Sales_Price"));
                json.put("sales_No", rs.getString("sales_No"));
            } else {
                json.put("Goods_Name", "該当商品なし");
            }

            rs.close();
            pStmt.close();
            conn.close();
        } catch (Exception e) {
            json.put("Goods_Name", "エラーが発生しました");
            e.printStackTrace();
        }
    	

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}

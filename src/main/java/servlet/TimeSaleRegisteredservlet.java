package servlet;


import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TimeSaleDao;
import model.StoreBeans;
import model.TimeSaleBeans;
import model.TimeSaleGoodsBeans;



/**
 * Servlet implementation class TimeSaleRegisteredservlet
 */
@WebServlet("/TimeSaleRegisteredservlet")
public class TimeSaleRegisteredservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	

    }
       


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // UTF-8 エンコーディング設定
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    String store_no = store.getStore_no();
        
        
        System.out.println("doPost メソッドが呼び出されました");
        ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeansArray  = new ArrayList<TimeSaleGoodsBeans>();
        TimeSaleDao TsRDao = new TimeSaleDao();
        
        System.out.println("1");


        // タイムセールデータを取得
        String time_Sale_Name = request.getParameter("time_Sale_Name");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String day = request.getParameter("day");
        String day_Of_Week = request.getParameter("day_Of_Week");
        String t_Time = request.getParameter("t_Time");
        String e_Time = request.getParameter("e_Time");
        System.out.println("2");
        Date start_Time = Date.valueOf("2024-11-20");
        System.out.println("3");
        Date end_Time  = Date.valueOf("2024-11-27");
        System.out.println("4");
        String timesale_Application_Flag = request.getParameter("timesale_Application_Flag");
        
        if(timesale_Application_Flag == null) {
        	timesale_Application_Flag = "a";
        }
        TimeSaleBeans timeSaleBeans = new TimeSaleBeans(time_Sale_Name,year,month,day,day_Of_Week,start_Time,end_Time,store_no, timesale_Application_Flag);
        
        int time_Sale_No = TsRDao.AddTimesales(timeSaleBeans);
        
        
        
        //タイムセール商品を取得
        for(int i = 0; i < 6; i++) {
            // JANコード取得
            String sales_No = request.getParameter("sales_No" + i);
            System.out.println(sales_No);
            String time_Sales_Prise_Str = request.getParameter("time_Sales_Prise" + i);
            
            // JANコードが未入力の場合はスキップ
            if (sales_No == null || sales_No.isEmpty()) {
                System.out.println("sales_No" + i + " が空またはnullです");
                continue;
            }

            // セール価格が未入力または不正な場合はスキップ
            int time_Sales_Prise = 0;
            try {
                if (time_Sales_Prise_Str == null || time_Sales_Prise_Str.isEmpty()) {
                    System.out.println("time_Sales_Prise" + i + " が空です");
                    continue; // スキップ
                }
                time_Sales_Prise = Integer.parseInt(time_Sales_Prise_Str);
            } catch (NumberFormatException e) {
                System.out.println("数値変換エラー: time_Sales_Prise" + i + " の値が不正です: " + time_Sales_Prise_Str);
                continue; // 不正なデータの場合もスキップ
            }

            // チェックボックス（運用フラグ）の取得
            String timesale_goods_Application_Flag = request.getParameter("timesale_goods_Application_Flag" + i);
            if (timesale_goods_Application_Flag == null) {
                timesale_goods_Application_Flag = "b"; // デフォルト値
            }

            // Beansに格納してArrayListに追加
            TimeSaleGoodsBeans timeSaleGoodsBeans = new TimeSaleGoodsBeans(
                time_Sale_No, sales_No, time_Sales_Prise, timesale_goods_Application_Flag
            );
            TimeSaleGoodsBeansArray.add(timeSaleGoodsBeans);
        }


        boolean success2 = TsRDao.AddTimesalesgoods(TimeSaleGoodsBeansArray);
        
        System.out.println("5");
        
        if(success2) {
			 RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleRegisteredcompletion.jsp");
		        dispatcher.forward(request, response);
		}else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("TimeSaleRegistered.jsp");
	        dispatcher.forward(request, response);
		}


       // JSPページにフォワード
	}

}

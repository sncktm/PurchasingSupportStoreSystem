package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.StoreBeans;
import model.TimeSaleBeans;
import model.TimeSaleGoodsBeans;

@WebServlet("/TimeSaleRegisteredConfirmServlet")
public class TimeSaleRegisteredConfirmServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // UTF-8 エンコーディング設定
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        StoreBeans store = (StoreBeans) session.getAttribute("loginStore");
        if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
        String store_no = store.getStore_no();

        System.out.println("doPost メソッドが呼び出されました");
        ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeansArray = new ArrayList<>();

        // フォームデータを取得
        String time_Sale_Name = request.getParameter("name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String repeatPattern = request.getParameter("repeat");
        String timesale_Application_Flag = request.getParameter("timesale_Application_Flag");
        
        
        LocalDate localStartDate = LocalDate.parse(startDate);
        LocalDate localEndDate = LocalDate.parse(endDate);
        // Time型のデータ (HH:mm:ss 形式)
        LocalTime localStartTime = LocalTime.parse(startTime);
        LocalTime localEndTime = LocalTime.parse(endTime);
        
        Date sqlStartDate = Date.valueOf(localStartDate);
        Date sqlEndDate = Date.valueOf(localEndDate);
        
        Time sqlStartTime = Time.valueOf(localStartTime);
        Time sqlEndTime = Time.valueOf(localEndTime);


        // 曜日の取得（複数選択のため配列で取得）
        String[] daysArray = request.getParameterValues("days");

        System.out.println("タイムセール名: " + time_Sale_Name);
        System.out.println("開始日: " + startDate);
        System.out.println("終了日: " + endDate);
        System.out.println("開始時間: " + startTime);
        System.out.println("終了時間: " + endTime);
        System.out.println("繰り返しパターン: " + repeatPattern);
//        if (daysArray != null) {
//            for (String day : daysArray) {
//                System.out.println(day);
//            }
//        }

        
        String repeatValue = null;
        if ("weekly".equals(repeatPattern) && daysArray != null) {
            repeatValue = String.join(",", daysArray);
        } else if ("monthly".equals(repeatPattern)) {
            repeatValue = request.getParameter("day_of_month");
        }

        if (timesale_Application_Flag == null) {
            timesale_Application_Flag = "off";
        }

        TimeSaleBeans timeSaleBeans = new TimeSaleBeans(store_no, time_Sale_Name, sqlStartDate, sqlStartTime, sqlEndDate, sqlEndTime, repeatPattern, repeatValue, timesale_Application_Flag);
        session.setAttribute("timeSaleConfirmBeans", timeSaleBeans);

        for (int i = 0; i < 5; i++) {
            String jan_Code = request.getParameter("jan_Code" + i);
            String goods_Name = request.getParameter("Goods_Name" + i);
            String goods_Maker = request.getParameter("Goods_Maker" + i);
            String classification = request.getParameter("Classification" + i);
            System.out.println("メーカー" + goods_Maker);

            // セール価格とタイムセール価格の取得とチェック
            String sales_Price_Str = request.getParameter("Sales_Price" + i);
            int sales_Price = 0; // デフォルト値
            if (sales_Price_Str != null && !sales_Price_Str.isEmpty()) {
                try {
                    sales_Price = Integer.parseInt(sales_Price_Str);
                } catch (NumberFormatException e) {
                    System.out.println("数値変換エラー: Sales_Price" + i + " の値が不正です: " + sales_Price_Str);
                    continue; // 不正なデータの場合はスキップ
                }
            }

            String time_Sales_Prise_Str = request.getParameter("time_Sales_Prise" + i);
            int time_Sales_Prise = 0; // デフォルト値
            if (time_Sales_Prise_Str != null && !time_Sales_Prise_Str.isEmpty()) {
                try {
                    time_Sales_Prise = Integer.parseInt(time_Sales_Prise_Str);
                } catch (NumberFormatException e) {
                    System.out.println("数値変換エラー: time_Sales_Prise" + i + " の値が不正です: " + time_Sales_Prise_Str);
                    continue; // 不正なデータの場合はスキップ
                }
            }

            String sales_No = request.getParameter("sales_No" + i);
            if (sales_No == null || sales_No.isEmpty()) {
                System.out.println("sales_No" + i + " が空またはnullです");
                continue;
            }

            String timesale_goods_Application_Flag = request.getParameter("timesale_goods_Application_Flag" + i);
            if (timesale_goods_Application_Flag == null) {
                timesale_goods_Application_Flag = "off";
            }

            TimeSaleGoodsBeans timeSaleGoodsBeans = new TimeSaleGoodsBeans(jan_Code, sales_No, goods_Name, goods_Maker, classification, timesale_goods_Application_Flag, sales_Price, time_Sales_Prise);
            TimeSaleGoodsBeansArray.add(timeSaleGoodsBeans);
        }

        session.setAttribute("TimeSaleGoodsConfirmBeansArray", TimeSaleGoodsBeansArray);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleRegisteredConfirm.jsp");
        dispatcher.forward(request, response);
    }
}

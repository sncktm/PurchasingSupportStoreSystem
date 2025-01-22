package servlet;


import java.io.IOException;
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
public class TimeSaleRegisteredServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // UTF-8 エンコーディング設定
        request.setCharacterEncoding("UTF-8");
        System.out.println("確認servlet");
        
        HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    String store_no = store.getStore_no();
        
        ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeansArray  = new ArrayList<TimeSaleGoodsBeans>();
        TimeSaleDao TsRDao = new TimeSaleDao();
        
        TimeSaleBeans timeSaleConfirmBeans = (TimeSaleBeans)session.getAttribute("timeSaleConfirmBeans");
        TimeSaleGoodsBeansArray = (ArrayList<TimeSaleGoodsBeans>)session.getAttribute("TimeSaleGoodsConfirmBeansArray");
        
        for (TimeSaleGoodsBeans TimeSaleGoodsBeans : TimeSaleGoodsBeansArray) {
            System.out.println(TimeSaleGoodsBeans.getGoods_Name());
            System.out.println(TimeSaleGoodsBeans.getSales_No());
        }
        
        
        
        //タイムセール登録
        int time_Sale_No = TsRDao.AddTimesales(timeSaleConfirmBeans);
        
        
        
        //スケジュール
//        List<LocalDate> dates = new ArrayList<>();
//        // Date型のデータ (yyyy-MM-dd 形式)
//        LocalDate startDate = LocalDate.parse(timeSaleConfirmBeans.getStartDate());
//        LocalDate endDate = LocalDate.parse(timeSaleConfirmBeans.getEndDate());
//
//        // Time型のデータ (HH:mm:ss 形式)
//        LocalTime startTime = LocalTime.parse(timeSaleConfirmBeans.getStartTime());
//        LocalTime endTime = LocalTime.parse(timeSaleConfirmBeans.getEndTime());
//        
//
//        String repeat = timeSaleConfirmBeans.getRepeatPattern();
//        
//        switch (repeat) {
//        case "daily":
//            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
//                dates.add(date);
//            }
//            break;
//        case "weekly":
//        	//文字列の曜日を配列に分割
//            String[] daysArray = timeSaleConfirmBeans.getRepeatValue().split(",");
//            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
//                DayOfWeek dayOfWeek = date.getDayOfWeek();
//                for(String day: daysArray) {
//                	
//                	System.out.println("日" + day);
//                	System.out.println(day.equals(dayOfWeek.name().toLowerCase()));
//                	if (day.equals(dayOfWeek.name().toLowerCase())) {
//	                    dates.add(date);
//	                    System.out.println("追加された日付" + date);
//                	}
//                }  
//            }
//            break;
//        case "monthly":
//            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusMonths(1)) {
//                dates.add(date);
//            }
//            break;
//        default:
//            dates.add(startDate); // 繰り返しなしの場合
//        }
//        
//        boolean success1 = TsRDao.AddTimeSaleSchedule(time_Sale_No, startTime, endTime, dates);
        
        //ここまで
        
        
        
        
        //タイムセール商品登録
        boolean success2 = TsRDao.AddTimesalesgoods(TimeSaleGoodsBeansArray, time_Sale_No);
        
        System.out.println("5");
        System.out.println("success:" + success2);
        
        if(success2) {
			 RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleRegisteredcompletion.jsp");
		        dispatcher.forward(request, response);
		}else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("TimeSaleRegistered.jsp");
	        dispatcher.forward(request, response);
		}
	}

}

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
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
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
        
    
        //タイムセール商品登録
        boolean success2 = TsRDao.AddTimesalesgoods(TimeSaleGoodsBeansArray, time_Sale_No);
        
        System.out.println("5");
        System.out.println("success:" + success2);
        
        if(success2) {
        	session.setAttribute("successMessage", "登録が完了しました");
			 RequestDispatcher dispatcher = request.getRequestDispatcher("TimeSaleListServlet");
		        dispatcher.forward(request, response);
		}else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("TimeSaleRegistered.jsp");
	        dispatcher.forward(request, response);
		}
	}

}

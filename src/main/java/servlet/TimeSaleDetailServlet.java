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
* Servlet implementation class GoodsInfomationViewServlet
*/
@WebServlet("/TimeSaleDetailServlet")
public class TimeSaleDetailServlet  extends HttpServlet {
	private static final long serialVersionUID = 1L;
 	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String time_sale_no = request.getParameter("time-sale-No");
	    System.out.println(time_sale_no);
	    HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
	    ArrayList<TimeSaleBeans> TimeSaleListArray = (ArrayList<TimeSaleBeans>)session.getAttribute("TimeSaleListArray");	    
	    
	  
	    // 結果を格納する変数
	    TimeSaleBeans matchedBean = null;

	    // 配列をループして検索
	    for (TimeSaleBeans bean : TimeSaleListArray) {
	        if (bean.getTime_Sale_No().equals(time_sale_no)) { // 条件に一致する場合
	            matchedBean = bean;
	            break; // 見つけたらループを終了
	        }
	    }
	    // 結果の確認
	    if (matchedBean != null) {
	        System.out.println("該当のタイムセール: " + matchedBean);
	    } else {
	        System.out.println("該当するタイムセール番号は見つかりませんでした。");
	    }
	    session.setAttribute("TimeSaleBean", matchedBean);
	    
	    
		TimeSaleDao  timeSale_dao = new TimeSaleDao();
		ArrayList<TimeSaleGoodsBeans> TimeSaleGoodsBeans = timeSale_dao.TsDetail(time_sale_no);

	    session.setAttribute("TimeSaleGoodsBeans", TimeSaleGoodsBeans);
//	    TSGoods_ListArrayBeans  = timeSaleDetail_dao.TsDetail(time_sale_no);
//	    
//	    ArrayList<TSGoods_ListArrayBeans> TimeSaleDetailArray = new ArrayList<TSGoods_ListArrayBeans>();
//	    TimeSaleDetaiDao  timeSaleDetail_daoo = new TimeSaleDetaiDao();
//	    
//	    TimeSaleDetailArray  = timeSaleDetail_daoo.TsDetail(time_sale_no);
//	    
//	    session.setAttribute("TimeSaleDetailArray",TimeSaleDetailArray);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleDetail.jsp");
	    dispatcher.forward(request, response);
	}
 
}


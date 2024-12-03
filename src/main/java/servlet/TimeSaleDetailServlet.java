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
import model.TimeSaleBeans;
import model.TimeSaleGoodsBeans;


 
/**
* Servlet implementation class GoodsInfomationViewServlet
*/
@WebServlet("/TimeSaleDetailServlet")
public class TimeSaleDetailServlet  extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		ArrayList<TimeSaleDetailBeans> TSGoods_ListArrayBeans = new ArrayList<TimeSaleDetailBeans>();
//		TimeSaleListDao  timeSaleDetail_dao = new TimeSaleListDao();
//		
//	    HttpSession session = request.getSession();
//	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
//	    String store_no = store.getStore_no();
//	    
//	    
//	    
//	    session.setAttribute("TimeSaleListArray",TSGoods_ListArrayBeans);
//	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleList.jsp");
//	    dispatcher.forward(request, response);
	}
 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String time_sale_no = request.getParameter("time-sale-No");
	    System.out.println(time_sale_no);
	    HttpSession session = request.getSession();
	    ArrayList<TimeSaleBeans> store = (ArrayList<TimeSaleBeans>)session.getAttribute("TimeSaleListArray");
	    
	    
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


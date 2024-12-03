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


 
/**
* Servlet implementation class GoodsInfomationViewServlet
*/
@WebServlet("/TimeSaleListServlet")
public class TimeSaleListServlet  extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<TimeSaleBeans> TimeSaleListArray = new ArrayList<TimeSaleBeans>();
		TimeSaleDao  timeSale_dao = new TimeSaleDao();
		
	    HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    String store_no = store.getStore_no();
	    
	    TimeSaleListArray  = timeSale_dao.TsInfo(store_no);
	    
	    session.setAttribute("TimeSaleListArray",TimeSaleListArray);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleList.jsp");
	    dispatcher.forward(request, response);
	}
 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<TimeSaleBeans> TimeSaleListArray = new ArrayList<TimeSaleBeans>();
		TimeSaleDao  timeSale_dao = new TimeSaleDao();
		
	    HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    String store_no = store.getStore_no();
	    
	    TimeSaleListArray  = timeSale_dao.TsInfo(store_no);
	    
	    session.setAttribute("TimeSaleListArray",TimeSaleListArray);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/TimeSaleList.jsp");
	    dispatcher.forward(request, response);
	}
 
}

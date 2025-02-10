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

import dao.AdvertisementDao;
import model.AdCommodityBeans;
import model.StoreBeans;


/**
 * Servlet implementation class AdvertisementViewServlet
 */
//広告閲覧
@WebServlet("/AdvertisementViewServlet")
public class AdvertisementViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
		
		String Store_No = store.getStore_no();
		
		AdvertisementDao dao = new AdvertisementDao();
		
		ArrayList<AdCommodityBeans> advertise = dao.findAll(Store_No);
		
		session.setAttribute("advertise", advertise);
		
		// データ件数を取得
		

        int dataCount = dao.getDataCount(Store_No);
        
        int advertisementMax = dao.adMax(Store_No);
        
        session.setAttribute("dataCount", dataCount);
        
        dataCount = advertisementMax - dataCount;
        
        System.out.print(advertisementMax);
//
        // 件数をリクエスト属性にセット
        request.setAttribute("dataCount", dataCount);
        
        
		
		
		RequestDispatcher dispatcher1 = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementView.jsp");
		dispatcher1.forward(request, response);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdvertisementDao;
import dao.ProductDAO;
import model.AdCommodityBeans;
import model.AdvertisementManagementBeans;


/**
 * Servlet implementation class test
 */
@WebServlet("/AdvertisementDetailViewServlet")
public class AdvertisementDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	HttpSession session = request.getSession();
		
		AdvertisementDao dao = new AdvertisementDao();
        
        String Advertisement_type = request.getParameter("Advertisement_type");

        String Advertisement_No = request.getParameter("Advertisement_No");
        
    	if(Advertisement_type.equals("1")) {
    		
    		

    		AdCommodityBeans store = dao.adStore(Advertisement_No);
    		
    		session.setAttribute("Store", store);
    		
    		RequestDispatcher dispatcher1 = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementDetailStore.jsp");
    		dispatcher1.forward(request, response);
    		
    	}else if(Advertisement_type.equals("2")){
    		
    		ProductDAO dao2 = new ProductDAO();
    		
    		List<AdvertisementManagementBeans> Product = dao2.findAll(Advertisement_No);
    		
    		request.setAttribute("ProductArray", Product);
    		
    		RequestDispatcher dispatcher2 = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementDetailProduct.jsp");
    		
    		dispatcher2.forward(request, response);
    	}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

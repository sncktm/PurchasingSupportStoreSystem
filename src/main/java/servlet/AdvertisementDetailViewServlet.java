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
import model.AdgoodsBeans;
import model.AdvertisementManagementBeans;
import model.StoreBeans;


/**
 * Servlet implementation class test
 */
@WebServlet("/AdvertisementDetailViewServlet")
public class AdvertisementDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	//広告の詳細表示、編集、削除の処理
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	HttpSession session = request.getSession();
		AdvertisementDao dao = new AdvertisementDao();
        String Advertisement_type = request.getParameter("Advertisement_type");
        String Advertisement_No = request.getParameter("Advertisement_No");
        session.setAttribute("Advertisement_No", Advertisement_No);
        String action = request.getParameter("action");
        
	    StoreBeans storeBeans = (StoreBeans)session.getAttribute("loginStore");
	    if (storeBeans == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
	    String store_No = storeBeans.getStore_no();     
        
        //詳細
        if("details".equals(action)) {
        	
        	if(Advertisement_type.equals("1")) {
        		AdCommodityBeans store = dao.adStore(Advertisement_No);
        		session.setAttribute("Store", store);
        		RequestDispatcher dispatcher1 = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementDetailStore.jsp");
        		dispatcher1.forward(request, response);
        		
        	}else if(Advertisement_type.equals("2") || Advertisement_type.equals("3")){
        		AdCommodityBeans store = dao.adStore(Advertisement_No);
        		session.setAttribute("Store", store);
        		ProductDAO dao2 = new ProductDAO();
        		List<AdvertisementManagementBeans> Product = dao2.findAll(Advertisement_No);
        		request.setAttribute("ProductArray", Product);
        		RequestDispatcher dispatcher2 = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementDetailProduct.jsp");
        		dispatcher2.forward(request, response);
        		
        	}
        
        //変更
        }else if ("edit".equals(action)){

        	AdCommodityBeans store = dao.adStore(Advertisement_No);
        	session.setAttribute("Store", store);

        	ProductDAO dao2 = new ProductDAO();

        	List<AdgoodsBeans> Product = dao2.Adgoods(store_No);

        	request.setAttribute("goods", Product);
        	RequestDispatcher dispatcher2 = request.getRequestDispatcher("/WEB-INF/jsp/AdUpdata.jsp");
        	dispatcher2.forward(request, response);


        //削除
        }else if ("delete".equals(action)) {

        	if(Advertisement_type.equals("1")) {
        		AdCommodityBeans store = dao.adStore(Advertisement_No);
        		session.setAttribute("Store", store);
        		RequestDispatcher dispatcher1 = request.getRequestDispatcher("/WEB-INF/jsp/AdStoreDelete.jsp");
        		dispatcher1.forward(request, response);

        	}else if(Advertisement_type.equals("2") || Advertisement_type.equals("3")){
        		AdCommodityBeans store = dao.adStore(Advertisement_No);
        		session.setAttribute("Store", store);
        		ProductDAO dao2 = new ProductDAO();
        		List<AdvertisementManagementBeans> Product = dao2.findAll(Advertisement_No);
        		request.setAttribute("ProductArray", Product);
        		RequestDispatcher dispatcher2 = request.getRequestDispatcher("/WEB-INF/jsp/AdProductDelete.jsp");
        		dispatcher2.forward(request, response);
        		
        	}

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

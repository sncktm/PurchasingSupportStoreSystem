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

import dao.GoodsDao;
import model.GoodsInfoBeans;
import model.StoreBeans;

/**
 * Servlet implementation class GoodsInfomationViewServlet
 */
@WebServlet("/GoodsInfomationViewServlet")
public class GoodsInfomationViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<GoodsInfoBeans> goodsInfoArrayBeans = new ArrayList<GoodsInfoBeans>();
		GoodsDao goods_dao = new GoodsDao();
	    HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
	    String store_no = store.getStore_no();
	    
	    goodsInfoArrayBeans = goods_dao.findAll(store_no);
	    session.setAttribute("goodsInfoArrayBeans", goodsInfoArrayBeans);
	    
	    if(goodsInfoArrayBeans == null) {
	    	goodsInfoArrayBeans = new ArrayList<>();
	    	session.setAttribute("goodsInfoArrayBeans", goodsInfoArrayBeans);
	    }
	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/GoodsInfomationView.jsp");
	    dispatcher.forward(request, response);
	}

}

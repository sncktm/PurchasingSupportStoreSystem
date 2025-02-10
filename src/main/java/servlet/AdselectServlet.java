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

import dao.ProductDAO;
import model.AdgoodsBeans;
import model.StoreBeans;

/**
 * Servlet implementation class AdselectServlet
 */
//広告登録遷移
@WebServlet("/AdselectServlet")
public class AdselectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		 
		// セッションを取得
		HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
	    String store_No = store.getStore_no();

		ProductDAO dao2 = new ProductDAO();

		List<AdgoodsBeans> Product = dao2.Adgoods(store_No);

		request.setAttribute("goods", Product);

		// 必要に応じて商品一覧用ページにフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AdvertisementRegistered.jsp");
		dispatcher.forward(request, response);


		
	}

}

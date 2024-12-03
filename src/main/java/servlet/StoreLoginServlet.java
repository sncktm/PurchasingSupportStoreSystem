package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginConnectionDao;
import model.StoreBeans;

/**
 * Servlet implementation class StoreLoginServlet
 */
@WebServlet("/StoreLoginServlet")
public class StoreLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String store_no = request.getParameter("no");
		String store_password = request.getParameter("pass");
		
		LoginConnectionDao login_connection_dao = new LoginConnectionDao();
		boolean isLogin = login_connection_dao.StoreLoginSearch(store_no,store_password);
		
		if(isLogin) {
			StoreBeans store = new StoreBeans();
			store = login_connection_dao.StoreLoginFingd(store_no);
			
			HttpSession session = request.getSession();
			session.setAttribute("loginStore", store);
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/LoginCompletion.jsp");
			dispatcher.forward(request, response);
		}else {
			request.setAttribute("errorMsg", "店舗番号またはパスワードが異なります。");
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/LoginMismatch.jsp");
			dispatcher.forward(request, response);
		}
	}

}

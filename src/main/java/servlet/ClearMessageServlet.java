package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.StoreBeans;

@WebServlet("/clearMessageServlet")
public class ClearMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("successMessage"); // セッションから削除
        
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}

        // URL パラメータ "redirectPage" からリダイレクト先を決定
        String redirectPage = request.getParameter("redirectPage");
        if (redirectPage == null || redirectPage.isEmpty()) {
            redirectPage = "StoreLogin.jsp"; // デフォルトのリダイレクト先
        }

        response.sendRedirect(redirectPage);
    }
}

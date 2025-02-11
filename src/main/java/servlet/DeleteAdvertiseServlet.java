package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdvertisementDao;
import model.StoreBeans;

/**
 * Servlet implementation class DeleteAdvertiseServlet
 */
@WebServlet("/DeleteAdvertiseServlet")
public class DeleteAdvertiseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            int advertisementNo = Integer.parseInt(request.getParameter("advertisementNo"));
            String advertisementType = request.getParameter("ad-type"); 
            
            
            HttpSession session = request.getSession();
    	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
    	    if (store == null) {
    	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
    	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
    		    return;
    		}
            
            AdvertisementDao dao = new AdvertisementDao();
            int deletedCount = dao.deleteAdvertisement(advertisementNo,advertisementType);

            if (deletedCount > 0) {
            	session.setAttribute("successMessage", "削除しました");
                response.sendRedirect("AdvertisementViewServlet"); // 削除成功ページへ
            } else {
                response.sendRedirect("/WEB-INF/jsp/AdStoreDelete.jsp"); // 削除失敗ページへ
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("NC.jsp"); // 異常なパラメータの場合
        }
		
		
	}

}

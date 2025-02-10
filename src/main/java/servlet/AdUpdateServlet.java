package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.AdvertisementDao;
import model.StoreBeans;

@WebServlet("/AdupdateServlet")
@MultipartConfig
public class AdUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // POSTリクエストを処理するメソッド
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}

        String Advertisement_type = request.getParameter("ad-type");
        String Advertisement_Explanation = request.getParameter("ad-text");
        String Advertisement_title = request.getParameter("ad-title");
        String Advertisement_priority = request.getParameter("ad-priority");
        String Sales_No = request.getParameter("salesNo");
        String Advertisement_No = (String) session.getAttribute("Advertisement_No");
        System.out.println("safdsa"+Advertisement_No);
        if ("1".equals(request.getParameter("ad-type"))) {
	    	// 広告種別が「店舗」の場合はSales_Noをnullに設定
	    	Sales_No = "1";
	    }

        // 画像の処理
        Part filePart = request.getPart("image");
        String Advertisement_Image = null;

        if (filePart != null ) {
            // ファイル名取得
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // ファイルを保存するパsu
            
            String uploadPath = getServletContext().getRealPath("/images/");
            //String uploadPath = "C:/Users/st20224112/Desktop/work/Advertisement/src/main/webapp/images/";
            
            session.setAttribute("uploadPath", uploadPath);
            
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // ファイル名をUUIDで重複しないように変更
            String uniqueFileName = UUID.randomUUID().toString() + "-" + fileName;
            String filePath = uploadPath + uniqueFileName;

            // ファイル保存
            filePart.write(filePath);
            Advertisement_Image = uniqueFileName; // 保存されたファイルパス
        }else {
        	request.setAttribute("errorMessage", "画像を選択してください。");
            request.getRequestDispatcher("test.jsp").forward(request, response);
        }
	    
        // AdvertisementDao の呼び出し
        AdvertisementDao dao = new AdvertisementDao();
        boolean updateResult = dao.adupdate(Advertisement_No, Advertisement_type, Advertisement_Image, Advertisement_Explanation, Advertisement_title, Advertisement_priority,Sales_No);

        // レスポンスの設定
        if (updateResult) {
        	RequestDispatcher dispatcher1 = request.getRequestDispatcher("AdvertisementViewServlet");
			dispatcher1.forward(request, response);
        } else {
            response.getWriter().append("Error occurred while updating the advertisement.");
        }
    }
}

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

import config.EnvConfig;  // EnvConfig をインポート
import dao.AdvertisementDao;
import model.StoreBeans;

/**
 * Servlet implementation class AdCreationServlet
 */
//広告登録
@WebServlet("/AdCreationServlet")
@MultipartConfig(
		maxFileSize=10000000,
		maxRequestSize=10000000,
		fileSizeThreshold=10000000
	)

public class AdCreationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		request.setCharacterEncoding("UTF-8");
		 
		// セッションを取得
		HttpSession session = request.getSession();
	    StoreBeans store = (StoreBeans)session.getAttribute("loginStore");
	    if (store == null) {
	    	request.setAttribute("errorMsg", "セッションの有効期限が切れました。再度ログインしてください。");
	    	response.sendRedirect(request.getContextPath() + "/StoreLogin.jsp");
		    return;
		}
	    String Store_No = store.getStore_no();
    
	    String Advertisement_type = request.getParameter("ad-type");
	    String Advertisement_Explanation = request.getParameter("ad-text");
	    String Advertisement_title = request.getParameter("ad-title");
	    String Advertisement_priority = request.getParameter("ad-priority");
	    String Sales_No = request.getParameter("salesNo");
	    
	    if ("1".equals(request.getParameter("ad-type"))) {
	    	// 広告種別が「店舗」の場合はSales_Noをnullに設定
	    	Sales_No = "1";
	    }

	    
	 // ファイルアップロードの処理
        Part filePart = request.getPart("image");
        String Advertisement_Image = null;
        
        if (filePart != null ) {
            // ファイル名だけ取得
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // ファイルを保存するパsu
            
//            String uploadPath = getServletContext().getRealPath("/") + "../webapp/images/advertisement";
            String uploadPath = EnvConfig.get("ADVERTISEMENT_IMG_PATH");
            //String uploadPath = "C:/Users/st20224112/Desktop/work/Advertisement/src/main/webapp/images/";

            session.setAttribute("uploadPath", uploadPath);           
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
         // ファイル名を安全なものに変更（UUIDを使用）
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String safeFileName = UUID.randomUUID().toString() + extension;
            

            Advertisement_Image = safeFileName; // 保存されたファイルパス
            System.out.println("保存先のパス" + uploadPath + File.separator + safeFileName);
        }else {
        	request.setAttribute("errorMessage", "画像を選択してください。");
            request.getRequestDispatcher("test.jsp").forward(request, response);
        }
	    
	    AdvertisementDao dao = new AdvertisementDao();
	    
	    boolean ans = dao.sdRegist(Store_No, Advertisement_type, Advertisement_Image, Advertisement_Explanation, Advertisement_title, Advertisement_priority, Sales_No);
	    
	    if(ans == true) {
	    	session.setAttribute("successMessage", "登録が完了しました");
	    	RequestDispatcher dispatcher1 = request.getRequestDispatcher("AdvertisementViewServlet");
			dispatcher1.forward(request, response);
	    }else {
	    	request.setAttribute("errorMessage", "登録できませんでした");
            request.getRequestDispatcher("test.jsp").forward(request, response);
	    	
	    }

	
	}

}

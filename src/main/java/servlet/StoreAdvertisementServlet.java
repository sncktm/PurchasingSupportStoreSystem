package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.EnvConfig;

//User側に画像の提供
@WebServlet("/store-advertisement")
public class StoreAdvertisementServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 画像のファイル名を取得
        String imageName = request.getParameter("file");
        if (imageName == null || imageName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ファイル名が指定されていません");
            return;
        }

        // 画像のパスを設定
        String imagePath = EnvConfig.get("ADVERTISEMENT_IMG_PATH") + "/" + imageName;
        File file = new File(imagePath);

        // ファイルが存在しない場合は 404 を返す
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "画像が見つかりません");
            return;
        }

        // 画像の MIME タイプを設定
        response.setContentType(getServletContext().getMimeType(file.getName()));
        response.setContentLength((int) file.length());

        // 画像データをレスポンスに書き込む
        Files.copy(file.toPath(), response.getOutputStream());
    }
}

package c_detail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class C_detailReceiveAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try {
            // JSPからpostidを取得
            String postid = request.getParameter("postid");
            System.out.println("Received postid: " + postid); // 確認用ログ出力

            // postid をリクエストスコープに保存
            request.setAttribute("postid", postid);

            // form.jsp にフォワード
            request.getRequestDispatcher("../c_detail/form.jsp").forward(request, response);

        } catch (Exception e) {
            // 例外発生時の処理
            e.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        return null;
    }
}

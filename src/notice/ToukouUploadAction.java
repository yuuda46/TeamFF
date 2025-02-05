package notice;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class ToukouUploadAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try {
            // セッションからユーザー名を取得
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");

            // フォームからタイトルとコンテンツを取得
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // タイトルが21文字以上ならエラー
            if (title != null && title.length() > 20) {
                request.setAttribute("errorMessage", "タイトルは20文字以内で入力してください。");
                return "toukou_form.jsp";  // フォーム画面に戻る
            }

            // 現在の日付を取得
            LocalDate localDate = LocalDate.now();
            java.sql.Date post_day = java.sql.Date.valueOf(localDate);

            // 投稿オブジェクトを作成
            Post p = new Post();
            p.setTitle(title);
            p.setContent(content);
            p.setName(user_name);
            p.setPostDay(post_day);

            // 投稿をデータベースに保存
            PostDAO dao2 = new PostDAO();
            int line = dao2.insert2(p);  // 投稿を保存

            // 改行コードを <br> タグに置換
            String indent_content = content.replace("\n", "<br>");

            // フォームデータをリクエストにセット
            request.setAttribute("title", title);
            request.setAttribute("name", user_name);
            request.setAttribute("content", indent_content);

        } catch (Exception e) {
            // エラー発生時にフォーム画面に戻す
            e.printStackTrace();
            request.setAttribute("errorMessage", "投稿の処理中にエラーが発生しました。");
            return "toukou_form.jsp";
        }

        // 投稿成功時、結果ページに遷移
        return "toukou_result.jsp";
    }
}

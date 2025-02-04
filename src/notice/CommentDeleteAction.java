package notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import dao.Postdao2;


@WebServlet("/notice/CommentDelete.action")
public class CommentDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
        	String id = request.getParameter("items");
        	//System.out.println("comment!" + id);
        	HttpSession session = request.getSession();
            Boolean isAdmin = (Boolean) session.getAttribute("admin");

            if (isAdmin == null || !isAdmin) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "権限がありません");
                return;
            }

            // コメントIDを取得 (String型で取得されるので、intに変換)
            String commentIdParam = request.getParameter("commentId");
            String postId = request.getParameter("postId");

            // commentIdが空の場合はエラー
            if (commentIdParam == null || commentIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "コメントIDが指定されていません");
                return;
            }


            // commentId を int 型に変換
            int commentId = Integer.parseInt(commentIdParam);
            // コメント削除処理（display を false にする）
            Postdao2 dao = new Postdao2();
//            dao.deleteComment(commentId);

         // コメントを削除対象として取得
            List<Comment> comment = dao.comment_detail(commentId);
            if (comment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "指定されたコメントが見つかりません");
                return;
            }

            // コメント情報をリクエスト属性にセット
            request.setAttribute("Commentdel", comment);
            request.setAttribute("items", id);

            // 削除確認画面にフォワード
            request.getRequestDispatcher("/notice/commentdelete.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "コメント削除に失敗しました");
        }
    }
}

package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Collection;
import dao.CollectionDAO;
import tool.Action;

public class CollectionConfirmAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // CollectionDAOのインスタンス化
            CollectionDAO dao = new CollectionDAO();
            // リクエストからPostIDを取得
            String postID = request.getParameter("postID");

            // デバッグ出力
            System.out.println("postID: " + postID);

            // Completed_searchメソッドの呼び出し
            List<Collection> list = dao.Completed_search(postID);

            // デバッグ出力
            System.out.println("List size in Action: " + list.size());

            // テストメッセージ
            System.out.println("Debug: Action executed successfully");

            // データをJSPへ渡す
            request.setAttribute("Confirm", list);

        } catch (Exception e) {
            e.printStackTrace(out);
            e.printStackTrace(System.out); // スタックトレースをコンソールに出力
        }
        return "Collection_Confirm.jsp";
    }

}
//ここからプルダウンを採用して投稿毎に表示できるようにした方がいいかもしれないが時間がない。
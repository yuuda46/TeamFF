package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Collection;
import bean.Post;
import bean.Signup;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String Sign_id = request.getParameter("signid");

            // デバッグ用にリクエストパラメータを出力
            System.out.println("Received Sign_id: " + Sign_id);

            if (Sign_id != null && !Sign_id.isEmpty()) {
                // 本体
                Collection p = new Collection();
                p.setSignID(Sign_id);

                CollectionDAO search = new CollectionDAO();
                List<Post> list = search.searchBySignId(p.getSignID());

                // 名前部分
                // n を初期化し、Sign_id を設定
                Signup n = new Signup();
                n.setName(Sign_id);

                CollectionDAO Name = new CollectionDAO();
                List<Signup> list2 = Name.nameget(n.getName());

                // 出力

                // デバッグ用に検索結果を出力
                System.out.println("Search results: " + list);
                System.out.println("Name :" + list2);

                request.setAttribute("Post", list);
                request.setAttribute("Signup", list2 );
            } else {
                // Sign_idがnullまたは空の場合の処理
                request.setAttribute("error", "Sign_idが見つからないか、空です");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
            request.setAttribute("error", "エラーが発生しました: " + e.getMessage());
        }
        return "Collection_Deposit.jsp";
    }
}
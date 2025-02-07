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
        	String Post_id = request.getParameter("postid");

        	// デバッグ用にリクエストパラメータを出力
            System.out.println("Received Sign_id: " + Post_id);

//            内容
            Collection p = new Collection();
            p.setPostID(Post_id);

            CollectionDAO search = new CollectionDAO();
            List<Collection> list = search.Completed_search(p.getPostID());

//            postのタイトル部分
            Collection E = new Collection();
            E.setPostID(Post_id);

            CollectionDAO Element = new CollectionDAO();
            List<Collection> list3 = Element.Completed_search_Post(E.getPostID());

            System.out.println("Search results: " + list);
            System.out.println("Search results postElement: " + list3);

            // データをJSPへ渡す
            request.setAttribute("Confirm", list);
            request.setAttribute("Element", list3);

        } catch (Exception e) {
            e.printStackTrace(out);
            e.printStackTrace(System.out); // スタックトレースをコンソールに出力
        }
        return "Collection_Confirm.jsp";
    }

}
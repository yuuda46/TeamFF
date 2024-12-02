package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositAction extends Action {


	public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // postIdを取得
            String postId = request.getParameter("no");

            // postIdを使ってタイトル、説明を持ってきて何に入金するのかを確認する
            CollectionDAO dao = new CollectionDAO();
            List<Post> list = dao.retrieval(postId);

            // データをjspへ
            request.setAttribute("Post", list);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "Collection_Deposit.jsp";
    }
}
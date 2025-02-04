package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import bean.Signup;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositCheckAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // postIdを取得
            String postId = request.getParameter("no");
            // signidも取得
            String signId = request.getParameter("signid");

            // postIdを使ってタイトル、説明を持ってきて何に入金するのかを確認する
            CollectionDAO dao = new CollectionDAO();
            List<Post> list = dao.retrieval(postId);

            // 名前も確認するためにやる
            CollectionDAO Name = new CollectionDAO();
            List<Signup> list2 = Name.nameget(signId);

            // データをjspへ
            request.setAttribute("Post", list);
            request.setAttribute("Signup", list2);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "Collection_Deposit_Check.jsp";
    }
}
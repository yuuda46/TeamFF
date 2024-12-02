package servlet;

import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import dao.Postdao2;



@WebServlet("/notice/commentSubmit")
public class CommentSubmitServlet extends HttpServlet {


    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String proposal = request.getParameter("proposalContent"); // テキストエリアの内容
        Date time = new Date(); // 現在の日時
        try {
            Postdao2 dao = new Postdao2();
            int id = Integer.parseInt(request.getParameter("items"));
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");

         // Postdaoクラスのインスタンスを生成して、id_searchメソッドを呼び出す
            Postdao2 comment = new Postdao2();
            List<Comment> userList = comment.id_search(user_name, password);

            if (!userList.isEmpty()) {
                int user_id = userList.get(0).getUser_id();  // user_idを取得

            dao.insertComment(id, user_id, proposal, time);
            request.setAttribute("items", id);
        	//�Bgetparameteでヒドゥンを取得
            //System.out.println("しらたき");
            // コメント挿入後、投稿詳細ページにリダイレクト
            request.getRequestDispatcher("toukou3.jsp")
            	.forward(request, response);
        }} catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データの保存に失敗しました");
        }
    }

}

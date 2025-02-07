package servlet;

import java.io.IOException;
import java.net.URLEncoder;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.util.Date;
import java.util.List;
import java.sql.Timestamp; // Timestampをインポート
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Comment;
import bean.Post2;
import dao.Postdao2;



@WebServlet("/notice/commentSubmit")
public class CommentSubmitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String proposal = request.getParameter("proposalContent"); // テキストエリアの内容
//        Date time = new Date(); // 現在の日時
        Timestamp time = new Timestamp(System.currentTimeMillis());

        // コメントが空でないか確認
        if (proposal == null || proposal.trim().isEmpty()) {
            String errorMessage = "コメント内容が空です。コメントを入力してください。";
            System.out.println("エラーメッセージ: " + errorMessage); // デバッグ用
            // エラーメッセージをrequestにセットし、リダイレクト
            request.setAttribute("errorMessage", errorMessage);
            String id = request.getParameter("items");
            request.getRequestDispatcher("/teee/notice/ToukouNotice.action?items=" + id).forward(request, response);
            return;
        }

        try {

        	//toukou.jspからデータを取得する
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されていません");
                return;
            }

            // 指定IDのデータを取得
			Postdao2 dao1=new Postdao2();
			List<Post2> list=dao1.notice_detail(id);
			request.setAttribute("list2", list);

            Postdao2 dao = new Postdao2();
            HttpSession session = request.getSession();
            String user_name = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");

         // Postdaoクラスのインスタンスを生成して、id_searchメソッドを呼び出す
            Postdao2 comment = new Postdao2();
            List<Comment> userList = comment.id_search(user_name, password);

            if (userList.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ユーザー情報が正しくありません");
                return;
            }

//          if (!userList.isEmpty()) {
            String user_id = userList.get(0).getUser_id();  // user_idを取得
            dao.insertComment(id, user_id, proposal, time);
            request.setAttribute("items", id);
        	//③getparameteでヒドゥンを取得
            //System.out.println("しらたき");
            // コメント挿入後、投稿詳細ページにリダイレクト
//            request.getRequestDispatcher("toukou3.jsp")
//            	.forward(request, response);
         // コメント挿入後、ToukouNoticeActionにリダイレクト
            response.sendRedirect("/teee/notice/ToukouNotice.action?items=" + id);
//        }
            } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データの保存に失敗しました");
        }
    }

}

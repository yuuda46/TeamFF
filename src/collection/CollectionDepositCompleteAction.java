package collection;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Payment;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositCompleteAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // セッションからIDを取得
            HttpSession session = request.getSession();
            String sessionId = (String) session.getAttribute("sessionId");

            // デバッグメッセージ
            System.out.println("Session ID: " + sessionId);

            // セッションIDがnullでないことを確認
            if (sessionId == null) {
                System.out.println("Session ID is null");
                response.sendRedirect("ErrorPage1.jsp");
                return null;
            }

            // フォームからpostIdを取得
            String postId = request.getParameter("postId");

            // デバッグメッセージ
            System.out.println("Post ID: " + postId);

            // Paymentオブジェクトを作成
            Payment payment = new Payment();
            payment.setPostID(postId);
            payment.setSignID(sessionId);

            // DAOを使用してデータを挿入
            CollectionDAO dao = new CollectionDAO();
            int result = dao.insert(payment);

            // デバッグメッセージ
            System.out.println("Insert result: " + result);

            // 挿入結果を確認
            if (result <= 0) {
                // 挿入失敗
                System.out.println("Insert failed, redirecting to ErrorPage1.jsp");
                response.sendRedirect("ErrorPage1.jsp");
                return null;
            }
            // 挿入成功
            System.out.println("Insert successful, redirecting to Collection_Deposit_Done.jsp");
            response.sendRedirect("Collection_Deposit_Done.jsp");
            return null;

        } catch (Exception e) {
            // ログにエラーを記録
            e.printStackTrace();
            response.sendRedirect("ErrorPage2.jsp");
            return null;
        } finally {
            // PrintWriterを閉じる
            if (out != null) {
                out.close();
            }
        }
    }
}
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

            // フォームからpostIdを取得
            String postId = request.getParameter("postId");

            // Paymentオブジェクトを作成
            Payment payment = new Payment();
            payment.setPostID(postId);
            payment.setSignID(sessionId);

            // DAOを使用してデータを挿入
            CollectionDAO dao = new CollectionDAO();
            int result = dao.insert(payment);

            // 挿入結果を確認
            if (result > 0) {
                // 挿入成功
                return "SuccessPage.jsp";
            } else {
                // 挿入失敗
                return "ErrorPage.jsp";
            }

        } catch (Exception e) {
            e.printStackTrace(out);
            return "ErrorPage.jsp";
        }
    }
}
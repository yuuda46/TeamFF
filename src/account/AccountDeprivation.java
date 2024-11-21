package account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Account;
import dao.AccountDAO;

@WebServlet(urlPatterns={"/account/Deprivation"})
public class AccountDeprivation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        try {
            String email = request.getParameter("email");

            // アカウント情報取得
            AccountDAO dao = new AccountDAO();
            Account account = dao.findByEmail(email);

            if (account != null && "true".equals(account.getAdmini())) {
                // 権限が付与されている場合、剥奪確認ページにフォワード
                request.setAttribute("account", account);
                request.getRequestDispatcher("deprivationConfirm.jsp").forward(request, response);
            } else {
                response.getWriter().println("このアカウントはすでに管理者権限がありません。");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        String email = request.getParameter("email");

        try {
            AccountDAO dao = new AccountDAO();
            int result = dao.RevokeAuthority(email);

            if (result > 0) {
                response.sendRedirect("AccountList.action");
            } else {
                response.getWriter().println("権限剥奪に失敗しました。");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}

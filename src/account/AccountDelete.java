package account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Account;
import dao.AccountDAO;

@WebServlet(urlPatterns={"/account/AccountDelete"})
public class AccountDelete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        try {
            String email = request.getParameter("email");

            // アカウント情報取得
            AccountDAO dao = new AccountDAO();
            Account account = dao.findByEmail(email);
            if (account != null) {
                request.setAttribute("account", account);
                request.getRequestDispatcher("delete.jsp").forward(request, response);
            } else {
                response.getWriter().println("アカウントが見つかりませんでした。");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        try {
            String email = request.getParameter("email");

            // アカウント削除
            AccountDAO dao = new AccountDAO();
            Account signup = new Account();
            signup.setEmail(email);
            int result = dao.delete(signup);

            if (result > 0) {
                request.getRequestDispatcher("delete_done.jsp").forward(request, response);
            } else {
                response.getWriter().println("削除に失敗しました。");
            }
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}

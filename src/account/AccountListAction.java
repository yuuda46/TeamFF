package account;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Account;
import dao.AccountDAO;
import tool.Action;

public class AccountListAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // サインアップDAOを使用してDBからアカウント情報を取得
            AccountDAO dao = new AccountDAO();
            List<Account> accountList = dao.all();
            // DAOのallメソッドで全てのアカウントを取得
            System.out.println(accountList);
            //System.out.println("ooo");

            // アトリビュートにアカウントリストをセット
            request.setAttribute("accountList", accountList);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "list.jsp"; // JSPページへフォワード
    }
}

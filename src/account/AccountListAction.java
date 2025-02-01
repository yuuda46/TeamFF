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
    private static final int PAGE_SIZE = 10; // 1ページあたりの表示数

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            AccountDAO dao = new AccountDAO();
            List<Account> accountList = dao.all();

            // ページ番号を取得（デフォルトは1）
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // リストの開始・終了インデックス
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, accountList.size());

            // 指定範囲のリストを取得
            List<Account> paginatedList = accountList.subList(startIndex, endIndex);

            // JSPへデータを渡す
            request.setAttribute("accountList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", (int) Math.ceil((double) accountList.size() / PAGE_SIZE));

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "list.jsp";
    }
}

package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Post;
import dao.CollectionDAO;
import tool.Action;

public class CollectionListAction extends Action {

    private static final int ITEMS_PER_PAGE = 10; // 1ページあたりの件数

    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            String sessionId = (String) session.getAttribute("sessionId");

            CollectionDAO dao = new CollectionDAO();
            List<Post> allPosts = dao.search(sessionId); // 全件取得

            int totalItems = allPosts.size(); // 全件数
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE); // 総ページ数計算

            // クエリパラメータからページ番号を取得（デフォルト1）
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            // ページ範囲のデータを取得
            int start = (currentPage - 1) * ITEMS_PER_PAGE;
            int end = Math.min(start + ITEMS_PER_PAGE, totalItems);
            List<Post> paginatedList = allPosts.subList(start, end);

            request.setAttribute("Post", paginatedList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "Collection_List.jsp";
    }
}

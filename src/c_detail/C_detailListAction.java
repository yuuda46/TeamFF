package c_detail;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Post;
import dao.C_detailDAO;
import tool.Action;

public class C_detailListAction extends Action {
	 private static final int ITEMS_PER_PAGE = 10; // 1ページあたりの件数

	public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // セッションからIDを取得
            HttpSession session = request.getSession();
            String sessionId = (String) session.getAttribute("sessionId");

            // セッションIDを使用してPOSTのリストを取得
            C_detailDAO dao = new C_detailDAO();
            List<Post> allPosts = dao.search(sessionId);

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
        return "c_detail_List.jsp";
    }
}
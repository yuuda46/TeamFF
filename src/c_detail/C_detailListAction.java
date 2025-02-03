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
            List<Post> list = dao.search(sessionId);

            // データをjspへ
            request.setAttribute("Post", list);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
        return "c_detail_List.jsp";
    }
}
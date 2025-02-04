package c_detail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.C_detail;
import dao.C_detailDAO;
import tool.Action;

public class C_detailEditAction extends Action {
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postid = request.getParameter("postid");

        if (postid == null || postid.isEmpty()) {
            request.setAttribute("error", "投稿IDが見つかりません。");
            return "error.jsp"; // エラーページへ遷移
        }

        try {
            C_detailDAO dao = new C_detailDAO();
            C_detail detail = dao.findByPostId(postid);

            if (detail != null) {
                request.setAttribute("postid", detail.getPostid());
                request.setAttribute("monetary", detail.getMonetary());
                request.setAttribute("deadline", detail.getDeadline());
                request.setAttribute("transferee", detail.getTransferee());
            } else {
                request.setAttribute("error", "編集対象のデータが見つかりません。");
                return "error.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "データ取得中にエラーが発生しました。");
            return "error.jsp";
        }

        return "edit.jsp";
    }
}


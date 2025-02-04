package c_detail;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.C_detail;
import dao.C_detailDAO;
import tool.Action;

public class C_detailUpdateAction extends Action {
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String postid = request.getParameter("postid");
            int monetary = Integer.parseInt(request.getParameter("monetary"));
            Date deadline = Date.valueOf(request.getParameter("deadline"));
            String transferee = request.getParameter("transferee");

            C_detailDAO dao = new C_detailDAO();
            C_detail detail = new C_detail();
            detail.setPostid(postid);
            detail.setMonetary(monetary);
            detail.setDeadline(deadline);
            detail.setTransferee(transferee);

            int result = dao.update(detail);

            if (result > 0) {
                request.setAttribute("message", "更新が成功しました。");
            } else {
                request.setAttribute("error", "更新に失敗しました。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "データ更新中にエラーが発生しました。");
        }
        return "c_detail_edit_done.jsp";
    }
}

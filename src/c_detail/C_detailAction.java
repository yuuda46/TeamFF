package c_detail;

import java.io.IOException;
import java.sql.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.C_detail;
import dao.C_detailDAO;
import tool.Action;

public class C_detailAction extends Action {
    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try {
            // JSPから受け取る情報
            String postid = request.getParameter("postid");
            System.out.println("Received postid: " + postid);  // 受け取った値をログに出力
            String monetaryStr = request.getParameter("monetary");
            String deadlineStr = request.getParameter("deadline");
            String transferee = request.getParameter("transferee");

            // フィールドの変換と設定
            Integer monetary = null;
            if (monetaryStr != null && !monetaryStr.isEmpty()) {
                if (monetaryStr.length() > 10) {
                    request.setAttribute("errorMonetary", "金額は10桁までしか入力できません。");
                    request.getRequestDispatcher("form.jsp").forward(request, response);
                    return null;
                }
                monetary = Integer.parseInt(monetaryStr);
            }

            Date deadline = (deadlineStr != null && !deadlineStr.isEmpty()) ? Date.valueOf(deadlineStr) : null;

            // C_detailオブジェクトを作成
            C_detail detail = new C_detail();
            detail.setDetailid(UUID.randomUUID().toString());
            detail.setPostid(postid);
            detail.setMonetary(monetary);
            detail.setDeadline(deadline);
            detail.setTransferee(transferee);

            // DAOを使用してデータを挿入
            C_detailDAO dao = new C_detailDAO();
            int result = dao.insert(detail);

            if (result > 0) {
                // 挿入成功時の処理 (例: 成功画面へリダイレクト)
                request.getRequestDispatcher("c_detail_done.jsp").forward(request, response);
            } else {
                // 挿入失敗時の処理 (例: エラー画面へリダイレクト)
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // 例外発生時の処理
            e.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        return null;
    }
}

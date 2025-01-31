package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.RequestDispatcher;
//import javax.servlet.http.HttpSession;

import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class TokouAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try {
			// 削除対象の投稿IDを取得
            String id = request.getParameter("items");
            System.out.println("ikiteru?" +id);
            if (id != null && !id.isEmpty()) {
                // 削除処理
                Postdao2 dao = new Postdao2();
                List<Post2> list = dao.delete(id); // deleteメソッドをPostdao2で実装していると仮定

                // 削除後の投稿情報をリクエスト属性にセット
                request.setAttribute("list2", list);

                // 削除が成功した場合、投稿一覧ページにリダイレクト
                response.sendRedirect("../notice/Tokou.action"); // 例えば、投稿一覧ページへのリダイレクト
                return null; // リダイレクト後は処理を終了
            }

			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.tokou();



			// JSP
			request.setAttribute("list2", list);

		} catch (Exception e) {
	 		e.printStackTrace(out);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "エラーが起きました");
		}
		return "../common/index.jsp";
	}
}

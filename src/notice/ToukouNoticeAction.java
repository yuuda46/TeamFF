package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import bean.Comment;
import bean.Post2;
import dao.Postdao2;
import tool.Action;

public class ToukouNoticeAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{
			//toukou.jspからデータを取得する
			String id = request.getParameter("items");

			if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されていません");
                return null;
            }

            // 指定IDのデータを取得
			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.notice_detail(id);

			Postdao2 com=new Postdao2();
			//System.out.println("w");
			List<Comment> list4=com.come();
			request.setAttribute("comment", list4);
			// コメント用リスト
			//System.out.println("o-");
			// JSPにリストを渡す
			request.setAttribute("list2", list);

			// データをリクエスト属性に設定
            request.setAttribute("content", list);
			request.setAttribute("items", id);//①ヒドゥン

			//System.out.println(id);
		}catch (Exception e) {
			e.printStackTrace(out);
			 response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データの取得中にエラーが発生しました");
		}
		//toukou2.jspにデータを送信
		return "toukou2.jsp";
	}
}


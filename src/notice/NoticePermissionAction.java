package notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class NoticePermissionAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			String post_id = request.getParameter("post_id");
			String title = request.getParameter("title");
			String name = request.getParameter("name");
			Integer category_id = Integer.parseInt(request.getParameter("num"));

//			アトリビュートの中に入れるやつ
			request.setAttribute("post_id", post_id);
			request.setAttribute("title", title);
			request.setAttribute("name", name);
			request.setAttribute("category_id", category_id);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_permission.jsp";
	}
}

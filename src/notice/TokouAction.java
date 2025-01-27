package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

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

			Postdao2 dao=new Postdao2();
			List<Post2> list=dao.tokou();

//			セッションからユーザーネームを取得
			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");

			// JSP
			request.setAttribute("list2", list);

		} catch (Exception e) {
	 		e.printStackTrace(out);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "エラーが起きました");
		}
		return "../common/index.jsp";
	}
}

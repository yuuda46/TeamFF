package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Account;
import bean.Category;
import dao.AccountDAO;
import dao.CategoryDAO;
import tool.Action;

public class NoticePermissionAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			セッションからユーザーネームを取得
			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");

//			データベースから投稿者氏名を取得
			AccountDAO dao1=new AccountDAO();
			List<Account> list1=dao1.upload_name(user_name);

			String post_id = request.getParameter("post_id");
			String title = request.getParameter("title");
			Integer category_id = Integer.parseInt(request.getParameter("num"));

			CategoryDAO dao2=new CategoryDAO();
			List<Category> list2=dao2.category_upload(category_id);

//			アトリビュートの中に入れるやつ
			request.setAttribute("post_id", post_id);
			request.setAttribute("title", title);
			request.setAttribute("name", list1);
			request.setAttribute("category_id", category_id);
			request.setAttribute("category", list2);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_permission.jsp";
	}
}

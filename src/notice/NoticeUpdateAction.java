package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Post;
import dao.CategoryDAO;
import dao.PostDAO;
import tool.Action;

public class NoticeUpdateAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			String post_id=request.getParameter("post_id");

//			h2コンソールからカテゴリーを取得
			CategoryDAO dao=new CategoryDAO();
			List<Category> list=dao.all();

//			h2コンソールから投稿内容を取得
			PostDAO dao1=new PostDAO();
			List<Post> list1=dao1.notice_detail(post_id);

			System.out.println(list1.get(0).getTitle());
			System.out.println(list1.get(0).getName());

//			アトリビュートの中に入れるやつ
			request.setAttribute("select_list", list);
			request.setAttribute("notice_content", list1.get(0));
			request.setAttribute("post_id", post_id);
		}
		catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_update.jsp";
	}
}

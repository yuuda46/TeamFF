package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class NoticeDetailAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{
			System.out.println("asdf");
//			notice.jspからデータを取得する
			String id = request.getParameter("id");

//			h2コンソールから投稿内容を取得
			PostDAO dao=new PostDAO();
			List<Post> list=dao.notice_detail(id);

//			System.out.println("aaa");
//			System.out.println(list);

			request.setAttribute("content", list);

			Integer category = Integer.parseInt(request.getParameter("category_id"));

//			if (id != null){
//				System.out.println("abc");
//			}

			if (category != null){
				request.setAttribute("category", category);
			}

		}catch (Exception e) {
			e.printStackTrace(out);
		}
//		notice_detail.jspにデータを送信
		return "notice_detail.jsp";
	}
}

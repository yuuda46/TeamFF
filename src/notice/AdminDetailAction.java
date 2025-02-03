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

public class AdminDetailAction extends Action {
	public String execute(
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();

			try{
//				notice_admin.jspからデータを取得する
				String id = request.getParameter("post_id");

//				if (id != null){
//					System.out.println("abc");
//				}

//				h2コンソールから投稿内容を取得
				PostDAO dao=new PostDAO();
				List<Post> list=dao.notice_detail(id);

//				System.out.println("aaa");
//				System.out.println(list);

				request.setAttribute("content", list);

				Integer category_id = Integer.parseInt(request.getParameter("category_id"));

				if (category_id != null) {
					request.setAttribute("category_id", category_id);
				}

			}catch (Exception e) {
				e.printStackTrace(out);
			}
//			admin_detail.jspにデータを送信
			return "admin_detail.jsp";
		}
	}

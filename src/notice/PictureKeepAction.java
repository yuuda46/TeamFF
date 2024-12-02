package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class PictureKeepAction extends Action {
	public String execute (
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			try{
				String post_id = request.getParameter("post_id");
//				LocalDate型の日付を取得
				LocalDate localDate = LocalDate.now();

//				LocalDate型からsql.Date型に変換
				java.sql.Date post_day= java.sql.Date.valueOf(localDate);

				String filename = request.getParameter("filename");

//				h2コンソールに書き込み
				Post p = new Post();
				p.setPostId(post_id);
				p.setContent(filename);
				p.setPostDay(post_day);

				PostDAO dao=new PostDAO();
				int line=dao.picture_update(p);

			}catch (Exception e) {
				e.printStackTrace(out);
			}
			return "picture_update_done.jsp";
		}
}

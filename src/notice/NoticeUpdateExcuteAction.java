package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class NoticeUpdateExcuteAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			String post_id = request.getParameter("post_id");
			System.out.println(post_id);

//			LocalDate型の日付を取得
			LocalDateTime localDate = LocalDateTime.now();
			String string_date = localDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"));
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");
			LocalDateTime date_time = LocalDateTime.parse(string_date, formatter);

			Timestamp post_day = Timestamp.valueOf(date_time);
			System.out.println(post_day);

			String title = request.getParameter("title");
			System.out.println(title);
			String name = request.getParameter("name");
			System.out.println(name);
			Integer category_id = Integer.parseInt(request.getParameter("category_id"));
			System.out.println(category_id);

			Post p = new Post();
			p.setPostId(post_id);
			p.setTitle(title);
			p.setName(name);
			p.setCategoryId(category_id);
			p.setPostDay(post_day);

			PostDAO dao=new PostDAO();
			int line=dao.notice_update(p);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_update_done.jsp";
	}
}

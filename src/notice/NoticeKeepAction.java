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

public class NoticeKeepAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

			String title = request.getParameter("title");
			System.out.println(title);
			String name = request.getParameter("name");
			System.out.println(name);

//			LocalDateTime型の日付を取得
			LocalDateTime localDate = LocalDateTime.now();
			String string_date = localDate.format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"));
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");
			LocalDateTime date_time = LocalDateTime.parse(string_date, formatter);

			Timestamp post_day = Timestamp.valueOf(date_time);
			System.out.println(post_day);

//			LocalDate型からsql.Date型に変換
//			java.sql.Date post_day= java.sql.Date.valueOf(localDate);

//			なぜか動かなかったコード
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
//			Date post_day = (Date) simpleDateFormat.parse(localDate.toString());

			Integer num = Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			String filename = request.getParameter("filename");
			System.out.println(filename);

			// dbに登録
			PostDAO dao=new PostDAO();
			Post p = new Post();
			p.setTitle(title);
			p.setContent(filename);
			p.setName(name);
			p.setPostDay(post_day);
			p.setCategoryId(num);

			int line =dao.insert(p);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "keep_done.jsp";
	}
}

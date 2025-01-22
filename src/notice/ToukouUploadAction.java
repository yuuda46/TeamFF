package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.util.UUID;
import dao.PostDAO;
import tool.Action;

public class ToukouUploadAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException,IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{
			PostDAO dao2 = new PostDAO();
//			絶対に重複しないであろうID(36桁)
			String id = UUID.randomUUID().toString();

			System.out.println("id:"+id);
			String title=request.getParameter("title");
			System.out.println("title:"+title);
			String name=request.getParameter("name");
			System.out.println("name:"+name);
			String content=request.getParameter("content");
			System.out.println("content:"+content);

//			LocalDate型の日付を取得
			LocalDate localDate = LocalDate.now();
//			LocalDate型からsql.Date型に変換
			java.sql.Date post_day= java.sql.Date.valueOf(localDate);


			dao2.insertPost(id, title, content, name, post_day);
	//		テキストエリアの入力内容を取得
			String content1 = request.getParameter("content");

	//		改行をHTML用に変換
			String indent_content = content1.replace("\n", "<br>");


			request.setAttribute("title", title);
			request.setAttribute("name", name);
			request.setAttribute("content", indent_content);

			} catch (Exception e) {
				e.printStackTrace(out);
		}
			return "toukou_result.jsp";
		}

}

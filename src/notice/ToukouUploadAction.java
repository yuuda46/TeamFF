package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Post;
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

			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");
			//System.out.println("id:"+id);
			String title=request.getParameter("title");
			//System.out.println("title:"+title);
			//String name=request.getParameter("name");
			//System.out.println("name:"+name);
			String content=request.getParameter("content");
			//System.out.println("content:"+content);





			LocalDate localDate = LocalDate.now();

			java.sql.Date post_day= java.sql.Date.valueOf(localDate);


			Post p = new Post();
			p.setTitle(title);
			p.setContent(content);
			p.setName(user_name);
			p.setPostDay(post_day);

			int line = dao2.insert2(p);
//			dao2.insertPost(title, content, user_name,  post_day);


			String content1 = request.getParameter("content");


			String indent_content = content1.replace("\n", "<br>");


			request.setAttribute("title", title);
			request.setAttribute("name", user_name);
			request.setAttribute("content", indent_content);

//		} catch (IllegalArgumentException e) {
//			request.setAttribute("errorMessage", e.getMessage());
//            e.printStackTrace(out);
//            return "toukou_form.jsp";
		} catch (Exception e) {

	            return "toukou_form.jsp";
		}
		return "toukou_result.jsp";
	}
}

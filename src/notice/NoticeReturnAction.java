package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import dao.CategoryDAO;
import tool.Action;

public class NoticeReturnAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			データベースからカテゴリーを取得
			CategoryDAO dao=new CategoryDAO();
			List<Category> list=dao.all();

			String title = request.getParameter("title");
			String name = request.getParameter("name");
			Integer num = Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			String path = request.getParameter("path");
			String filename = request.getParameter("filename");

//			渡されたファイル名のファイルを削除
			Path delete_path = Paths.get(path+"/"+ filename);
			Files.deleteIfExists(delete_path);

			request.setAttribute("title", title);
			request.setAttribute("name", name);
			request.setAttribute("category", num);
			request.setAttribute("select_list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/form.jsp");
			rd.forward(request,response);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "form.jsp";
	}
}

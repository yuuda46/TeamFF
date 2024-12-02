package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import dao.CategoryDAO;
import tool.Action;

public class NoticeFormAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException,IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			h2コンソールからカテゴリーを取得
			CategoryDAO dao=new CategoryDAO();
			List<Category> list=dao.all();

//			System.out.println(list1);

//			アトリビュートの中に入れるやつ
			request.setAttribute("select_list", list);

		} catch (Exception e) {
			e.printStackTrace(out);
	}
		return "form.jsp";
	}
}

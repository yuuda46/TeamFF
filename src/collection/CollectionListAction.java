package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Post;
import dao.CollectionDAO;
import tool.Action;

public class CollectionListAction extends Action {


	public String execute (
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();

			try{

			    // h2コンソールからリストを取得、この際、ログインしている人のidを取得して表示する。
				CollectionDAO dao=new CollectionDAO();
				List<Post> list=dao.search(Payment);

				// アトリビュート
				request.setAttribute("Post", list);



			} catch (Exception e) {
				e.printStackTrace(out);
		}
			return "Collection_List.jsp";
	}

}
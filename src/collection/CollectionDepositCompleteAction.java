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

public class CollectionDepositCompleteAction extends Action {

	public String execute (
			HttpServletRequest request, HttpServletResponse response
			) throws ServletException, IOException {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();

			try{

			    // h2コンソールにデータを入れる
				CollectionDAO dao=new CollectionDAO();
				List<Post> list=dao.insert();

				// アトリビュート
				request.setAttribute("Post", list);


//				↑のやつは個人ごとのidで抽出するために書き換えが必要

			} catch (Exception e) {
				e.printStackTrace(out);
		}
//			完了したことを示すページへ
			return "Collection_List.jsp";
	}

}

package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Post;
import dao.CategoryDAO;
import dao.PostDAO;
import tool.Action;

public class NoticeAdminAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			h2コンソールからカテゴリーを取得
			CategoryDAO dao=new CategoryDAO();
			List<Category> list=dao.all();

//			h2コンソールから投稿内容のリストを取得
			PostDAO dao1=new PostDAO();
			List<Post> list1=dao1.notice_all();

//			アトリビュートの中に入れるやつ
			request.setAttribute("select_list", list);
			request.setAttribute("notice_content", list1);

			Integer boot = Integer.parseInt(request.getParameter("f1"));

//			bootがnullでない時次の処理へ
			if (boot != null){
//				bootが0の時
				if (boot == 0){
//					h2コンソールから投稿内容のリストを取得
					PostDAO dao3=new PostDAO();
					List<Post> list3=dao3.notice_all();
					System.out.println("True");

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list3);
				}else {
//					h2コンソールからカテゴリーIDがbootの中の数値と一致する投稿内容のリストを取得
					PostDAO dao2=new PostDAO();
					List<Post> list2=dao2.admin_search(boot);

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list2);
				}
			}

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_admin.jsp";
	}
}

package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Post;
import dao.CategoryDAO;
import dao.PostDAO;
import tool.Action;

public class NoticeAction extends Action {

	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException,IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			h2コンソールからカテゴリーを取得
			CategoryDAO dao=new CategoryDAO();
			List<Category> list=dao.all();

//			h2コンソールから投稿内容のリストを取得
			PostDAO dao1=new PostDAO();
			List<Post> list1=dao1.notice();

//			System.out.println(list1);
//			絶対に重複しないであろうID(36桁)
			String uuid = UUID.randomUUID().toString();
			System.out.println(uuid);
			System.out.println(UUID.randomUUID().toString());

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
					List<Post> list3=dao3.notice();
					System.out.println("True");

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list3);
					request.setAttribute("category", boot);
				}else {
//					h2コンソールからカテゴリーIDがbootの中の数値と一致する投稿内容のリストを取得
					PostDAO dao2=new PostDAO();
					List<Post> list2=dao2.notice_search(boot);

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list2);
					request.setAttribute("category", boot);
				}
			}
		} catch (Exception e) {
			e.printStackTrace(out);
	}
		return "notice.jsp";
	}
}

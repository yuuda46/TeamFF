package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Account;
import bean.Category;
import bean.Post;
import dao.AccountDAO;
import dao.CategoryDAO;
import dao.PostDAO;
import tool.Action;

public class NoticePermissionAction extends Action {
	public String execute (
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		try{

//			セッションからユーザーネームを取得
			HttpSession session = request.getSession();
			String user_name = (String) session.getAttribute("username");

//			データベースから投稿者氏名を取得
			AccountDAO dao1=new AccountDAO();
			List<Account> list1=dao1.upload_name(user_name);

			String post_id = request.getParameter("post_id");
			String title = request.getParameter("title");
			Integer category_id = Integer.parseInt(request.getParameter("num"));

			CategoryDAO dao2=new CategoryDAO();
			List<Category> list2=dao2.category_upload(category_id);

			// エラーメッセージの文字列
			String error_message_title = "";
			String error_message_num = "";

//			タイトルのnull判定
			if (title == null || title.isEmpty()){
				System.out.println("error");
				error_message_title = "タイトルを入力してください";
			}

//			タイトルの文字数を調べる
			int count_title = title.length();
			if (count_title > 20){
				System.out.println("error");
				error_message_title = "タイトルが20文字以上です";
			}

			if (category_id == 0){
				System.out.println("error");
				error_message_num = "カテゴリーを選択してください";
			}

			if (error_message_title != "" || error_message_num != ""){

				System.out.println("True");
//				h2コンソールからカテゴリーを取得
				CategoryDAO dao=new CategoryDAO();
				List<Category> list=dao.all();

//				h2コンソールから投稿内容を取得
				PostDAO dao3=new PostDAO();
				List<Post> list3=dao3.notice_detail(post_id);

				request.setAttribute("select_list", list);
				request.setAttribute("notice_content", list3.get(0));
				request.setAttribute("post_id", post_id);
				request.setAttribute("error_message_title", error_message_title);
				request.setAttribute("error_message_num", error_message_num);
				RequestDispatcher rd = request.getRequestDispatcher("/notice/notice_update.jsp");
				rd.forward(request,response);

			}

//			アトリビュートの中に入れるやつ
			request.setAttribute("post_id", post_id);
			request.setAttribute("title", title);
			request.setAttribute("name", list1);
			request.setAttribute("category_id", category_id);
			request.setAttribute("category", list2);

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_permission.jsp";
	}
}

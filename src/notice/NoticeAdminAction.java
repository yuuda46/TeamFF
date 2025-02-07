package notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

//			list1のサイズを取得
			int loop = list1.size();

//			リストを作成
			List<String> string_times = new ArrayList<String>();

			for (int i = 0; i < loop; i++) {

//				beenからpost_dayを取得
				Timestamp timestamp = list1.get(i).getPost_day();
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//		        Timestamp型からString型に変換
		        String string_time = sdf.format(timestamp);
		        System.out.println(string_time);

//		        リストに入れる
		        string_times.add(string_time);
			}

//			アトリビュートの中に入れるやつ
			request.setAttribute("select_list", list);
			request.setAttribute("notice_content", list1);
			request.setAttribute("post_day", string_times);

			Integer boot = Integer.parseInt(request.getParameter("f1"));

//			bootがnullでない時次の処理へ
			if (boot != null){
//				bootが0の時
				if (boot == 0){
//					h2コンソールから投稿内容のリストを取得
					PostDAO dao3=new PostDAO();
					List<Post> list3=dao3.notice_all();
					System.out.println("True");

//					list3のサイズを取得
					int loop2 = list3.size();

					for (int i = 0; i < loop2; i++) {

//						beenからpost_dayを取得
						Timestamp timestamp = list3.get(i).getPost_day();
				        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//				        Timestamp型からString型に変換
				        String string_time = sdf.format(timestamp);
				        System.out.println(string_time);

//				        リストに入れる
				        string_times.add(string_time);
					}

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list3);
					request.setAttribute("category", boot);
					request.setAttribute("post_day", string_times);
				}else {
//					h2コンソールからカテゴリーIDがbootの中の数値と一致する投稿内容のリストを取得
					PostDAO dao2=new PostDAO();
					List<Post> list2=dao2.admin_search(boot);

//					list2のサイズを取得
					int loop2 = list2.size();

					for (int i = 0; i < loop2; i++) {

//						beenからpost_dayを取得
						Timestamp timestamp = list2.get(i).getPost_day();
				        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//				        Timestamp型からString型に変換
				        String string_time = sdf.format(timestamp);
				        System.out.println(string_time);

//				        リストに入れる
				        string_times.add(string_time);
					}

//					アトリビュートの中に入れるやつ
					request.setAttribute("notice_content", list2);
					request.setAttribute("category", boot);
					request.setAttribute("post_day", string_times);
				}
			}

		}catch (Exception e) {
			e.printStackTrace(out);
		}
		return "notice_admin.jsp";
	}
}

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

import bean.Post;
import dao.PostDAO;
import tool.Action;

public class NoticeDetailAction extends Action {
	public String execute(
		HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();

		try{
			System.out.println("asdf");
//			notice.jspからデータを取得する
			String id = request.getParameter("id");

//			h2コンソールから投稿内容を取得
			PostDAO dao=new PostDAO();
			List<Post> list=dao.notice_detail(id);

//			list1のサイズを取得
			int loop = list.size();

//			リストを作成
			List<String> string_times = new ArrayList<String>();

			for (int i = 0; i < loop; i++) {

//				beenからpost_dayを取得
				Timestamp timestamp = list.get(i).getPost_day();
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//		        Timestamp型からString型に変換
		        String string_time = sdf.format(timestamp);
		        System.out.println(string_time);

//		        リストに入れる
		        string_times.add(string_time);
			}

//			System.out.println("aaa");
//			System.out.println(list);

			request.setAttribute("content", list);
			request.setAttribute("post_day", string_times);

			Integer category = Integer.parseInt(request.getParameter("category"));

//			if (id != null){
//				System.out.println("abc");
//			}

			if (category != null){
				System.out.println(category);
				request.setAttribute("category", category);
			}

		}catch (Exception e) {
			e.printStackTrace(out);
		}
//		notice_detail.jspにデータを送信
		return "notice_detail.jsp";
	}
}

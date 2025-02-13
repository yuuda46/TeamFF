package collection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Collection;
import bean.Post;
import dao.CollectionDAO;
import dao.PostDAO;
import tool.Action;

public class CollectionConfirmAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
        	String Post_id = request.getParameter("postid");

        	// デバッグ用にリクエストパラメータを出力
            System.out.println("Received Sign_id: " + Post_id);

            PostDAO dao1=new PostDAO();
			List<Post> list1=dao1.collection_search();

			request.setAttribute("select_id", list1);

//			Post_idがnullでない時次の処理へ
			if (Post_id != null){
//	            内容
	            Collection p = new Collection();
	            p.setPostID(Post_id);

	            CollectionDAO search = new CollectionDAO();
	            List<Collection> list = search.Completed_search(p.getPostID());

//	            postのタイトル部分
	            Collection E = new Collection();
	            E.setPostID(Post_id);

	            CollectionDAO Element = new CollectionDAO();
	            List<Collection> list3 = Element.Completed_search_Post(E.getPostID());

//				list1のサイズを取得
				int loop = list3.size();

//				リストを作成
				List<String> string_times = new ArrayList<String>();

				for (int i = 0; i < loop; i++) {

//					beenからpost_dayを取得
					Timestamp timestamp = list3.get(i).getPost_day();
			        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			        Timestamp型からString型に変換
			        String string_time = sdf.format(timestamp);
			        System.out.println(string_time);

//			        リストに入れる
			        string_times.add(string_time);
				}

	            System.out.println("Search results: " + list);
	            System.out.println("Search results postElement: " + list3);

	            // データをJSPへ渡す
	            request.setAttribute("Confirm", list);
	            request.setAttribute("Element", list3);
	            request.setAttribute("post_day", string_times);
	            request.setAttribute("post_id", Post_id);
			}

        } catch (Exception e) {
            e.printStackTrace(out);
            e.printStackTrace(System.out); // スタックトレースをコンソールに出力
        }
        return "Collection_Confirm.jsp";
    }

}
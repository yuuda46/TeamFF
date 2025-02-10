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
import bean.Signup;
import dao.CollectionDAO;
import tool.Action;

public class CollectionDepositAction extends Action {

    public String execute(
            HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String Sign_id = request.getParameter("signid");

            // デバッグ用にリクエストパラメータを出力
            System.out.println("Received Sign_id: " + Sign_id);

            if (Sign_id != null && !Sign_id.isEmpty()) {
                Collection p = new Collection();
                p.setSignID(Sign_id);

                CollectionDAO search = new CollectionDAO();
                List<Post> list = search.searchBySignId(p.getSignID());

//    			list1のサイズを取得
    			int loop = list.size();

//    			リストを作成
    			List<String> string_times = new ArrayList<String>();

    			for (int i = 0; i < loop; i++) {

//    				beenからpost_dayを取得
    				Timestamp timestamp = list.get(i).getPost_day();
    		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//    		        Timestamp型からString型に変換
    		        String string_time = sdf.format(timestamp);
    		        System.out.println(string_time);

//    		        リストに入れる
    		        string_times.add(string_time);
    			}

                // n を初期化し、Sign_id を設定
                Signup n = new Signup();
                n.setName(Sign_id);

                CollectionDAO Name = new CollectionDAO();
                List<Signup> list2 = Name.nameget(n.getName());

                // デバッグ用に検索結果を出力
                System.out.println("Search results: " + list);
                System.out.println("Name :" + list2);

                request.setAttribute("Post", list);
                request.setAttribute("Signup", list2 );
                request.setAttribute("post_day", string_times);

            } else {
                // Sign_idがnullまたは空の場合の処理
                request.setAttribute("error", "Sign_idが見つからないか、空です");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
            request.setAttribute("error", "エラーが発生しました: " + e.getMessage());
        }
        return "Collection_Deposit.jsp";
    }
}